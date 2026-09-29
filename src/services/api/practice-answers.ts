import type { createClient } from "@/services/supabase/client";
import type { ExamType } from "@/types/app";

type AppSupabaseClient = ReturnType<typeof createClient>;

export async function recordPracticeAnswer(
  supabase: AppSupabaseClient,
  input: {
    sessionId: string | null;
    questionId: string;
    selectedAnswer: string;
    isCorrect: boolean;
    examType: ExamType;
  },
): Promise<string> {
  const { data, error } = await supabase.rpc("record_practice_answer", {
    p_session_id: input.sessionId,
    p_question_id: input.questionId,
    p_selected_answer: input.selectedAnswer,
    p_is_correct: input.isCorrect,
    p_exam_type: input.examType,
  });
  if (error) throw new Error("Could not save your answer. Please try again.");
  const sessionId = data?.session_id;
  if (typeof sessionId !== "string") {
    throw new Error("Could not confirm your saved answer. Please try again.");
  }
  return sessionId;
}
