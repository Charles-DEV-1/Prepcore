import { createServiceRoleClient } from "@/services/supabase/admin";
import type { ExamType } from "@/types/app";

const ALOC_QUESTIONS_URL = "https://dev.aloc.com.ng/api/v1/questions";
const PROVIDER_BATCH_SIZE = 10;
export const TARGET_QUESTIONS_PER_SUBJECT = 200;

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

type CacheState = { next_cursor: string | null; exhausted: boolean };
type CacheSubject = { id: string; name: string };

export type QuestionCacheResult = {
  examType: ExamType;
  subjectId?: string;
  subjects: number;
  fetched: number;
  inserted: number;
  skipped: number;
  totalCached: number;
  complete: boolean;
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

function normalizeQuestion(question: AlocQuestion, subjectId: string, examType: ExamType) {
  const prompt = question.text?.trim();
  const correctAnswer = question.correctAnswer?.trim();
  if (
    !question.id || !prompt || !isOptionMap(question.options) ||
    Object.keys(question.options).length < 2 || !correctAnswer ||
    !question.options[correctAnswer] || question.examType?.toLowerCase() !== examType
  ) return null;

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
    source_question_order: typeof question.questionNumber === "number" ? question.questionNumber : null,
    media_url: question.imageUrl?.trim() || null,
  };
}

async function fetchAlocPage(examType: ExamType, subjectSlug: string, cursor?: string) {
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
    signal: AbortSignal.timeout(8_000),
  });
  if (response.status === 404) return { questions: [], nextCursor: null };
  if (!response.ok) throw new Error(`ALOC request failed with HTTP ${response.status}.`);
  const payload = (await response.json()) as AlocResponse;
  return {
    questions: Array.isArray(payload.data) ? payload.data : [],
    nextCursor: payload.pagination?.hasMore ? payload.pagination.nextCursor ?? null : null,
  };
}

async function getQuestionCount(subjectId: string, examType: ExamType) {
  const admin = createServiceRoleClient();
  const { count, error } = await admin
    .from("questions").select("id", { count: "exact", head: true })
    .eq("subject_id", subjectId).eq("exam_type", examType);
  if (error) throw error;
  return count ?? 0;
}

/** Stores one provider page, then advances its cursor. It stops at 200 combined rows. */
export async function refillQuestionCacheForSubject(examType: ExamType, subjectId: string): Promise<QuestionCacheResult> {
  const admin = createServiceRoleClient();
  const { data: subject, error: subjectError } = await admin
    .from("subjects").select("id, name").eq("id", subjectId).eq("exam_type", examType).maybeSingle();
  if (subjectError) throw subjectError;
  if (!subject) throw new Error("Unknown exam subject.");

  const totalBefore = await getQuestionCount(subjectId, examType);
  const result: QuestionCacheResult = { examType, subjectId, subjects: 1, fetched: 0, inserted: 0, skipped: 0, totalCached: totalBefore, complete: totalBefore >= TARGET_QUESTIONS_PER_SUBJECT };
  if (result.complete) return result;

  const { data: state, error: stateError } = await admin
    .from("question_cache_state").select("next_cursor, exhausted").eq("subject_id", subjectId).maybeSingle();
  if (stateError) throw stateError;
  const cacheState = state as CacheState | null;
  if (cacheState?.exhausted) return { ...result, complete: true };

  const { questions, nextCursor } = await fetchAlocPage(
    examType, toAlocSubjectSlug((subject as CacheSubject).name), cacheState?.next_cursor ?? undefined,
  );
  result.fetched = questions.length;
  const now = new Date().toISOString();
  if (!questions.length) {
    await admin.from("question_cache_state").upsert({ subject_id: subjectId, exam_type: examType, next_cursor: null, exhausted: true, last_attempt_at: now, updated_at: now } as never);
    return { ...result, complete: true };
  }

  const rows = questions.map((question) => normalizeQuestion(question, subjectId, examType)).filter((question): question is NonNullable<typeof question> => question !== null);
  result.skipped = questions.length - rows.length;
  const providerIds = rows.map((row) => row.source_question_id);
  const { data: existing, error: existingError } = await admin
    .from("questions").select("source_question_id").eq("source", "aloc").in("source_question_id", providerIds);
  if (existingError) throw existingError;
  const existingIds = new Set((existing ?? []).map((row) => row.source_question_id).filter(Boolean));
  const newRows = rows.filter((row) => !existingIds.has(row.source_question_id));
  result.skipped += rows.length - newRows.length;
  if (newRows.length) {
    const { error: insertError } = await admin.from("questions").insert(newRows as never);
    if (insertError && insertError.code !== "23505") throw insertError;
    if (insertError?.code === "23505") result.skipped += newRows.length;
    else result.inserted = newRows.length;
  }

  result.totalCached = await getQuestionCount(subjectId, examType);
  result.complete = result.totalCached >= TARGET_QUESTIONS_PER_SUBJECT || !nextCursor;
  await admin.from("question_cache_state").upsert({
    subject_id: subjectId, exam_type: examType, next_cursor: result.complete ? null : nextCursor,
    exhausted: !nextCursor, last_attempt_at: now, last_success_at: now, updated_at: now,
  } as never);
  return result;
}

/** Scheduled work is one page only; practice refills its own underfilled subject. */
export async function refreshQuestionCache(examType: ExamType) {
  const admin = createServiceRoleClient();
  const { data: subjects, error } = await admin
    .from("subjects").select("id").eq("exam_type", examType).order("name", { ascending: true });
  if (error) throw error;
  for (const subject of subjects ?? []) {
    const total = await getQuestionCount(subject.id, examType);
    if (total >= TARGET_QUESTIONS_PER_SUBJECT) continue;
    const result = await refillQuestionCacheForSubject(examType, subject.id);
    if (!result.complete || result.inserted > 0 || result.fetched > 0) return result;
  }
  return { examType, subjects: 0, fetched: 0, inserted: 0, skipped: 0, totalCached: 0, complete: true } satisfies QuestionCacheResult;
}
