import { createClient } from "@/services/supabase/server";
import { createServiceRoleClient } from "@/services/supabase/admin";
import { refillQuestionCacheForSubject } from "@/services/questions/aloc-cache";
import { getClientIp, rateLimit } from "@/lib/rate-limit";
import {
  hasTrustedOrigin,
  noStoreJson,
  readSafeJson,
} from "@/lib/api-security";

const MAX_SESSION_QUESTIONS = 180;

type SessionRequest = {
  subjectId?: string;
  examType?: "jamb" | "waec";
  limit?: number;
  year?: number;
};

type StoredQuestion = {
  id: string;
  prompt: string;
  options: Record<string, string>;
  correct_answer: string;
  explanation: string;
  topic: string;
  year: number | null;
  subject_id: string;
  exam_type: "jamb" | "waec";
};

function isRenderableQuestion(question: StoredQuestion): boolean {
  const prompt = question.prompt?.trim();
  if (!prompt || /^solution\s*:/i.test(prompt)) return false;

  // Raw MathML is provider markup, not a learner-facing question. Exclude it
  // from sessions rather than showing a solution/XML blob in the question card.
  if (/<\/?(?:math|mrow|mi|mn|mo|mfrac|msup)\b/i.test(prompt)) return false;

  return (
    Object.keys(question.options ?? {}).length >= 2 &&
    Boolean(question.options?.[question.correct_answer])
  );
}

function shuffle<T>(items: T[]) {
  return [...items].sort(() => Math.random() - 0.5);
}

/**
 * Rearranges the options only in a learner session response. The stored
 * question, its provider-imported options, and its answer key are never
 * modified. Keeping the display labels while moving their values also keeps
 * existing answer selection and result saving behaviour intact.
 */
function randomizeOptionOrder(question: StoredQuestion): StoredQuestion {
  const entries = Object.entries(question.options);
  const shuffledEntries = [...entries];

  // Fisher-Yates avoids the distribution bias of sorting with Math.random().
  for (let index = shuffledEntries.length - 1; index > 0; index -= 1) {
    const swapIndex = Math.floor(Math.random() * (index + 1));
    [shuffledEntries[index], shuffledEntries[swapIndex]] = [
      shuffledEntries[swapIndex],
      shuffledEntries[index],
    ];
  }

  const displayKeys = entries.map(([key]) => key);
  const options = Object.fromEntries(
    displayKeys.map((displayKey, index) => [
      displayKey,
      shuffledEntries[index][1],
    ]),
  );
  const correctIndex = shuffledEntries.findIndex(
    ([sourceKey]) => sourceKey === question.correct_answer,
  );

  return {
    ...question,
    options,
    correct_answer:
      correctIndex >= 0 ? displayKeys[correctIndex] : question.correct_answer,
  };
}


async function isProUser(userId: string) {
  const supabase = createServiceRoleClient();
  const now = new Date().toISOString();
  const { data } = await supabase
    .from("subscriptions")
    .select("plan, status, current_period_end")
    .eq("user_id", userId)
    .maybeSingle();
  const hasIndividualPro = Boolean(
    data &&
    data.plan === "pro" &&
    data.status === "active" &&
    (!data.current_period_end || data.current_period_end > now),
  );
  if (hasIndividualPro) return true;

  const { data: referral } = await supabase
    .from("user_referrals")
    .select("partner_id")
    .eq("user_id", userId)
    .maybeSingle();
  if (!referral) return false;

  const { data: partner } = await supabase
    .from("partners")
    .select("is_active, bulk_pro_active, bulk_pro_expires_at")
    .eq("id", (referral as { partner_id: string }).partner_id)
    .maybeSingle();
  return Boolean(
    partner &&
    partner.is_active &&
    partner.bulk_pro_active &&
    (!partner.bulk_pro_expires_at || partner.bulk_pro_expires_at > now),
  );
}

export async function POST(request: Request) {
  try {
    return await handlePost(request);
  } catch (error) {
    // Always provide a JSON response to the browser, even if an upstream
    // provider or unexpected database error fails during the request.
    console.error(
      "Question session route failed unexpectedly",
      error instanceof Error ? error.name : String(error),
    );
    return noStoreJson(
      { error: "Question service is temporarily unavailable. Please try again." },
      { status: 500 },
    );
  }
}

async function handlePost(request: Request) {
  if (!hasTrustedOrigin(request))
    return noStoreJson({ error: "Invalid request origin." }, { status: 403 });
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return noStoreJson({ error: "Unauthorized" }, { status: 401 });
  const limitResult = rateLimit({
    key: `questions:session:${user.id}:${getClientIp(request)}`,
    limit: 30,
    windowMs: 10 * 60 * 1000,
  });
  if (!limitResult.allowed)
    return noStoreJson(
      { error: "Too many question requests. Please wait and try again." },
      {
        status: 429,
        headers: { "Retry-After": String(limitResult.retryAfterSeconds) },
      },
    );

  const body = await readSafeJson<SessionRequest>(request);
  const subjectId = body?.subjectId;
  const examType = body?.examType;
  const requestedYear = body?.year;
  const year = Number.isInteger(requestedYear) ? requestedYear : undefined;
  const limit = Math.min(
    Math.max(Number(body?.limit) || 25, 1),
    MAX_SESSION_QUESTIONS,
  );
  if (!subjectId || (examType !== "jamb" && examType !== "waec")) {
    return noStoreJson({ error: "Invalid question request" }, { status: 400 });
  }

  const admin = createServiceRoleClient();
  const { data: subject } = await admin
    .from("subjects")
    .select("id, name")
    .eq("id", subjectId)
    .maybeSingle();
  if (!subject)
    return noStoreJson({ error: "Unknown subject" }, { status: 404 });

  const isPro = await isProUser(user.id);

  // Imported provider questions are a Pro entitlement. Preserve the existing
  // free-plan behavior by reading only the local Supabase question bank.
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const baseQuery = (admin.from("questions") as any)
    .select(
      "id, prompt, options, correct_answer, explanation, topic, year, subject_id, exam_type",
    )
    .eq("subject_id", subjectId)
    .eq("exam_type", examType);
  if (year) baseQuery.eq("year", year);
  if (!isPro) baseQuery.eq("source", "supabase");

  if (!isPro) {
    const { data, error } = await baseQuery.limit(Math.max(limit * 4, limit));
    if (error)
      return noStoreJson(
        { error: "Could not load questions" },
        { status: 500 },
      );
    return noStoreJson({
      questions: shuffle((data ?? []) as StoredQuestion[])
        .filter(isRenderableQuestion)
        .map(randomizeOptionOrder)
        .slice(0, limit),
      isPro,
    });
  }

  // Refill only an underfilled subject. This writes a validated WAEC/JAMB page
  // to Supabase, then the query below serves the combined database bank.
  const { count: cachedCount, error: cachedCountError } = await admin
    .from("questions")
    .select("id", { count: "exact", head: true })
    .eq("subject_id", subjectId)
    .eq("exam_type", examType);
  if (cachedCountError) {
    return noStoreJson({ error: "Could not load questions" }, { status: 500 });
  }
  if ((cachedCount ?? 0) < limit) {
    try {
      await refillQuestionCacheForSubject(examType, subjectId);
    } catch (error) {
      // Existing cached rows remain usable when the provider is unavailable.
      console.warn("question_cache_refill_failed", {
        subjectId,
        examType,
        error: error instanceof Error ? error.message : String(error),
      });
    }
  }

  const query = admin
    .from("questions")
    .select(
      "id, prompt, options, correct_answer, explanation, topic, year, subject_id, exam_type",
    )
    .eq("subject_id", subjectId)
    .eq("exam_type", examType)
    .limit(limit * 4);
  if (year) query.eq("year", year);
  const { data: questions, error: questionsError } = await query;
  if (questionsError) {
    return noStoreJson({ error: "Could not load questions" }, { status: 500 });
  }

  return noStoreJson({
    questions: shuffle((questions ?? []) as StoredQuestion[])
      .filter(isRenderableQuestion)
      .map(randomizeOptionOrder)
      .slice(0, limit),
    isPro,
  });
}
