import type { createClient } from "@/services/supabase/client";
import {
  DAILY_QUESTION_CARD_COUNT,
  getDailyStartIndex,
} from "@/features/flashcards/daily-deck";

type AppSupabaseClient = ReturnType<typeof createClient>;

type OriginalQuestion = {
  id: string;
  prompt: string;
  options: unknown;
  correct_answer: string;
  explanation: string | null;
  exam_type: string;
};

export type QuestionFlashcard = {
  id: string;
  front: string;
  back: string;
  label: string;
};

function toFlashcard(question: OriginalQuestion): QuestionFlashcard | null {
  if (
    !question.options ||
    typeof question.options !== "object" ||
    Array.isArray(question.options)
  ) {
    return null;
  }

  const options = question.options as Record<string, unknown>;
  const answerKey = question.correct_answer.trim().toUpperCase();
  const answer = options[answerKey];
  const choices = Object.entries(options)
    .filter((entry): entry is [string, string] => typeof entry[1] === "string")
    .sort(([left], [right]) => left.localeCompare(right));

  if (
    !question.prompt.trim() ||
    typeof answer !== "string" ||
    !answer.trim() ||
    choices.length < 2
  ) {
    return null;
  }

  const explanation = question.explanation?.trim();

  return {
    id: `question:${question.id}`,
    front: `${question.prompt.trim()}\n\n${choices.map(([key, value]) => `${key}. ${value}`).join("\n")}`,
    back: `${answerKey}. ${answer.trim()}${explanation ? `\n\n${explanation}` : ""}`,
    label: `${question.exam_type.toUpperCase()} question`,
  };
}

export async function getDailyQuestionFlashcards(
  supabase: AppSupabaseClient,
  dayNumber: number,
): Promise<{ cards: QuestionFlashcard[]; total: number }> {
  // Only original, self-authored questions are used; provider-cached material
  // can have separate redistribution terms.
  const { count, error: countError } = await supabase
    .from("questions")
    .select("id", { count: "exact", head: true })
    .eq("source", "original");

  if (countError) throw countError;
  const total = count ?? 0;
  if (total === 0) return { cards: [], total };

  const start = getDailyStartIndex(total, dayNumber, DAILY_QUESTION_CARD_COUNT);
  const requested = Math.min(DAILY_QUESTION_CARD_COUNT, total);

  async function loadRange(from: number, to: number) {
    const { data, error } = await supabase
      .from("questions")
      .select("id, prompt, options, correct_answer, explanation, exam_type")
      .eq("source", "original")
      // UUID order mixes subjects while remaining stable across visits.
      .order("id")
      .range(from, to);

    if (error) throw error;
    return (data ?? []) as OriginalQuestion[];
  }

  const first = await loadRange(start, Math.min(start + requested, total) - 1);
  const remaining = requested - first.length;
  const rows =
    remaining > 0 ? [...first, ...(await loadRange(0, remaining - 1))] : first;

  return {
    cards: rows
      .map(toFlashcard)
      .filter((card): card is QuestionFlashcard => card !== null),
    total,
  };
}
