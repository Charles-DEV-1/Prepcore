import { createServiceRoleClient } from "@/services/supabase/admin";
import type { ExamType } from "@/types/app";

const ALOC_QUESTIONS_URL = "https://dev.aloc.com.ng/api/v1/questions";
const PROVIDER_BATCH_SIZE = 10;
const TARGET_QUESTIONS_PER_SUBJECT = 200;
const MAX_FETCH_ATTEMPTS_PER_SUBJECT = 30;

type AlocQuestion = {
  id?: string;
  text?: string;
  options?: unknown;
  correctAnswer?: string;
  examType?: string;
  year?: number | null;
  section?: string | null;
  category?: string | null;
  imageUrl?: string | null;
  questionNumber?: number | null;
  explanation?: string | null;
  solution?: string | null;
};

type AlocResponse = {
  data?: AlocQuestion[];
  pagination?: { nextCursor?: string | null; hasMore?: boolean };
};

type CacheSubject = { id: string; name: string };

export type QuestionCacheResult = {
  examType: ExamType;
  subjects: number;
  fetched: number;
  inserted: number;
  skipped: number;
};

function toAlocSubjectSlug(name: string) {
  return name
    .toLowerCase()
    .trim()
    .replace(/&/g, "and")
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-|-$/g, "");
}

function isOptionMap(value: unknown): value is Record<string, string> {
  return (
    typeof value === "object" &&
    value !== null &&
    !Array.isArray(value) &&
    Object.values(value).every(
      (option) => typeof option === "string" && option.trim().length > 0,
    )
  );
}

function normalizeQuestion(
  question: AlocQuestion,
  subjectId: string,
  examType: ExamType,
) {
  const prompt = question.text?.trim();
  const correctAnswer = question.correctAnswer?.trim();
  if (
    !question.id ||
    !prompt ||
    !isOptionMap(question.options) ||
    Object.keys(question.options).length < 2 ||
    !correctAnswer ||
    !question.options[correctAnswer] ||
    question.examType?.toLowerCase() !== examType
  ) {
    return null;
  }

  return {
    subject_id: subjectId,
    exam_type: examType,
    year: typeof question.year === "number" ? question.year : null,
    topic: question.section?.trim() || question.category?.trim() || null,
    prompt,
    options: question.options,
    correct_answer: correctAnswer,
    explanation: question.explanation?.trim() || question.solution?.trim() || null,
    source: "aloc",
    source_question_id: question.id,
    source_question_order:
      typeof question.questionNumber === "number" ? question.questionNumber : null,
    media_url: question.imageUrl?.trim() || null,
  };
}

async function fetchAlocQuestions(
  examType: ExamType,
  subjectSlug: string,
  cursor?: string,
) {
  const apiKey = process.env.ALOC_API_KEY || process.env.ALOC_ACCESS_TOKEN;
  if (!apiKey) throw new Error("ALOC_API_KEY is not configured.");

  const url = new URL(ALOC_QUESTIONS_URL);
  url.searchParams.set("subject", subjectSlug);
  url.searchParams.set("examType", examType);
  url.searchParams.set("limit", String(PROVIDER_BATCH_SIZE));
  if (cursor) url.searchParams.set("cursor", cursor);
  const response = await fetch(url, {
    headers: { "X-API-Key": apiKey, Accept: "application/json" },
    cache: "no-store",
    signal: AbortSignal.timeout(12_000),
  });
  if (response.status === 404) return { questions: [], nextCursor: null };
  if (!response.ok) throw new Error(`ALOC request failed with HTTP ${response.status}.`);

  const payload = (await response.json()) as AlocResponse;
  return {
    questions: Array.isArray(payload.data) ? payload.data : [],
    nextCursor: payload.pagination?.hasMore
      ? payload.pagination.nextCursor ?? null
      : null,
  };
}

/**
 * Refill the server-side ALOC cache. Learner question requests never call the
 * provider directly, keeping provider latency and the API key out of the UI.
 */
export async function refreshQuestionCache(
  examType: ExamType,
): Promise<QuestionCacheResult> {
  const admin = createServiceRoleClient();
  const { data: subjects, error: subjectsError } = await admin
    .from("subjects")
    .select("id, name")
    .eq("exam_type", examType)
    .order("name", { ascending: true });
  if (subjectsError) throw subjectsError;

  const result: QuestionCacheResult = {
    examType,
    subjects: subjects?.length ?? 0,
    fetched: 0,
    inserted: 0,
    skipped: 0,
  };

  for (const subject of (subjects ?? []) as CacheSubject[]) {
    const { count, error: countError } = await admin
      .from("questions")
      .select("id", { count: "exact", head: true })
      .eq("subject_id", subject.id)
      .eq("exam_type", examType)
      .eq("source", "aloc");
    if (countError) throw countError;

    let cachedCount = count ?? 0;
    let attempts = 0;
    let cursor: string | undefined;
    while (
      cachedCount < TARGET_QUESTIONS_PER_SUBJECT &&
      attempts < MAX_FETCH_ATTEMPTS_PER_SUBJECT
    ) {
      attempts += 1;
      const { questions: providerQuestions, nextCursor } = await fetchAlocQuestions(
        examType,
        toAlocSubjectSlug(subject.name),
        cursor,
      );
      result.fetched += providerQuestions.length;
      if (providerQuestions.length === 0) break;

      const rows = providerQuestions
        .map((question) => normalizeQuestion(question, subject.id, examType))
        .filter((question): question is NonNullable<typeof question> => question !== null);
      if (!rows.length) {
        result.skipped += providerQuestions.length;
        if (!nextCursor) break;
        cursor = nextCursor;
        continue;
      }

      const providerIds = rows.map((row) => row.source_question_id);
      const { data: existing, error: existingError } = await admin
        .from("questions")
        .select("source_question_id")
        .eq("source", "aloc")
        .in("source_question_id", providerIds);
      if (existingError) throw existingError;
      const existingIds = new Set(
        (existing ?? []).map((row) => row.source_question_id).filter(Boolean),
      );
      const newRows = rows.filter((row) => !existingIds.has(row.source_question_id));
      result.skipped += rows.length - newRows.length;
      if (!newRows.length) {
        if (!nextCursor) break;
        cursor = nextCursor;
        continue;
      }

      const { error: insertError } = await admin.from("questions").insert(newRows as never);
      if (insertError) {
        // A concurrent refresh may win the unique provider-ID race. Do not
        // hide other database errors, which require operator attention.
        if (insertError.code === "23505") {
          result.skipped += newRows.length;
          if (!nextCursor) break;
          cursor = nextCursor;
          continue;
        }
        throw insertError;
      }
      result.inserted += newRows.length;
      cachedCount += newRows.length;
      if (!nextCursor) break;
      cursor = nextCursor;
    }
  }

  return result;
}
