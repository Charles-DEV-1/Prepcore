import { getCurrentStreak } from "@/services/api/streak";
import type { createClient } from "@/services/supabase/client";
import type { ExamType } from "@/types/app";
import {
  buildStudyRecommendations,
  type RecommendationEvidence,
} from "@/lib/study-recommendations";

type AppSupabaseClient = ReturnType<typeof createClient>;

export async function getDashboardData(
  supabase: AppSupabaseClient,
  userId: string,
  examType: ExamType = "jamb",
) {
  // Run all queries in parallel for speed
  const [sessionsResult, profileResult, pointsResult, currentStreak] =
    await Promise.all([
      // All completed sessions
      supabase
        .from("sessions")
        .select("id, score, total_questions, mode, created_at, exam_type")
        .eq("user_id", userId)
        .eq("exam_type", examType)
        .order("created_at", { ascending: false }),

      // User profile (exam date, target score)
      supabase
        .from("users")
        .select("exam_date, target_score, exam_type, exam_goals")
        .eq("id", userId)
        .single(),

      supabase
        .from("user_points")
        .select("total_points, rank")
        .eq("user_id", userId)
        .maybeSingle(),

      getCurrentStreak(supabase, userId),
    ]);

  const sessions = (sessionsResult.data ?? []).filter(
    (session) => session.total_questions > 0,
  );
  const profile = profileResult.data;

  // Calculate stats
  const totalQuestionsAnswered = sessions.reduce(
    (sum, s) => sum + (s.total_questions ?? 0),
    0,
  );

  const completedSessions = sessions.filter((s) => s.score !== null);
  const averageScore =
    completedSessions.length > 0
      ? Math.round(
          completedSessions.reduce((sum, s) => sum + (s.score ?? 0), 0) /
            completedSessions.length,
        )
      : 0;

  // Days until exam
  let daysUntilExam = null;
  if (profile?.exam_date) {
    const examDate = new Date(profile.exam_date);
    const today = new Date();
    const diff = Math.ceil(
      (examDate.getTime() - today.getTime()) / (1000 * 60 * 60 * 24),
    );
    daysUntilExam = diff > 0 ? diff : 0;
  }

  // Recent sessions (last 3)
  const recentSessions = sessions.slice(0, 3).map((s) => ({
    id: s.id,
    type: s.mode === "mock" ? "Mock exam" : "Practice",
    score: s.score ?? 0,
    totalQuestions: s.total_questions ?? 0,
    date: new Date(s.created_at).toLocaleDateString("en-NG", {
      day: "numeric",
      month: "short",
    }),
  }));

  // Recent evidence only. One latest answer per question is counted by the
  // pure ranking function, so repeating a familiar item cannot dominate it.
  const recentIds = sessions
    .filter(
      (session) =>
        new Date(session.created_at).getTime() >= Date.now() - 60 * 86_400_000,
    )
    .slice(0, 100)
    .map((session) => session.id);
  const { data: answerData, error: recommendationError } = recentIds.length
    ? await supabase
        .from("answers")
        .select(
          "question_id, is_correct, created_at, question:questions(topic, subject_id, subject:subjects(name))",
        )
        .in("session_id", recentIds)
        .order("created_at", { ascending: false })
        .limit(1000)
    : { data: [], error: null };
  const evidence: RecommendationEvidence[] = (answerData ?? []).flatMap(
    (answer) => {
      const question = Array.isArray(answer.question)
        ? answer.question[0]
        : answer.question;
      const subject = Array.isArray(question?.subject)
        ? question.subject[0]
        : question?.subject;
      if (!question?.topic || !question.subject_id || !subject?.name) return [];
      return [
        {
          questionId: answer.question_id,
          subjectId: question.subject_id,
          subject: subject.name,
          topic: question.topic,
          correct: answer.is_correct,
          answeredAt: answer.created_at,
        },
      ];
    },
  );
  const recommendations = buildStudyRecommendations(evidence);

  return {
    averageScore,
    totalQuestionsAnswered,
    streak: currentStreak,
    daysUntilExam,
    examType,
    examGoals: profile?.exam_goals ?? [profile?.exam_type ?? "jamb"],
    targetScore: profile?.target_score ?? 200,
    recentSessions,
    recommendations,
    recommendationUnavailable: Boolean(recommendationError),
    hasSessions: sessions.length > 0,
    totalPoints: pointsResult.data?.total_points ?? 0,
    currentRank: pointsResult.data?.rank ?? "Beginner",
  };
}
