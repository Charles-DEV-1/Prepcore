import { getCurrentStreak } from "@/services/api/streak";
import type { createClient } from "@/services/supabase/client";
import type { ExamType } from "@/types/app";

type AppSupabaseClient = ReturnType<typeof createClient>;

const MINIMUM_RECOMMENDATION_ANSWERS = 3;
const MAXIMUM_TOPIC_LABEL_LENGTH = 80;

function cleanTopicLabel(value: string | null | undefined) {
  if (!value) return null;
  const normalized = value
    .replace(/<[^>]*>/g, " ")
    .replace(/&nbsp;/gi, " ")
    .replace(/&amp;/gi, "&")
    .replace(/\s+/g, " ")
    .trim();

  // Older imports sometimes put the full question prompt in `topic`. Do not
  // turn that raw content into a misleading recommendation label.
  if (
    !normalized ||
    normalized.length > MAXIMUM_TOPIC_LABEL_LENGTH ||
    /<|>|\bthese questions\b|\bif our thoughts\b/i.test(value)
  ) {
    return null;
  }

  return normalized;
}

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

  const sessions = sessionsResult.data ?? [];
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

  // Get weak topics from answers
  const { data: weakData } = await supabase
    .from("answers")
    .select(
      `
      is_correct,
      question:questions (
        topic,
        subject:subjects ( name )
      )
    `,
    )
    .in(
      "session_id",
      sessions.slice(0, 10).map((s) => s.id),
    );

  // Calculate accuracy per topic
  const topicMap: Record<string, { correct: number; total: number; subject: string; topic: string }> = {};
  const subjectMap: Record<string, { correct: number; total: number }> = {};

  if (weakData) {
    weakData.forEach((answer) => {
      const question = Array.isArray(answer.question)
        ? answer.question[0]
        : answer.question;
      const subjectRow = Array.isArray(question?.subject)
        ? question?.subject[0]
        : question?.subject;
      const topic = cleanTopicLabel(question?.topic);
      const subject = subjectRow?.name;
      const isCorrect = answer.is_correct;
      if (!subject) return;

      if (!subjectMap[subject]) subjectMap[subject] = { correct: 0, total: 0 };
      subjectMap[subject].total++;
      if (isCorrect) subjectMap[subject].correct++;

      if (!topic) return;
      const key = `${subject}:${topic.toLowerCase()}`;
      if (!topicMap[key]) topicMap[key] = { correct: 0, total: 0, subject, topic };
      topicMap[key].total++;
      if (isCorrect) topicMap[key].correct++;
    });
  }

  const weakTopics = Object.values(topicMap)
    .filter(({ total }) => total >= MINIMUM_RECOMMENDATION_ANSWERS)
    .map(({ topic, correct, total, subject }) => ({
      topic,
      subject,
      accuracy: Math.round((correct / total) * 100),
      answered: total,
    }))
    .filter((t) => t.accuracy < 70)
    .sort((a, b) => a.accuracy - b.accuracy)
    .slice(0, 3);

  // When imported question data has no safe topic labels, retain a useful
  // recommendation from the student's actual subject-level answer history.
  if (weakTopics.length === 0) {
    weakTopics.push(
      ...Object.entries(subjectMap)
        .filter(([, value]) => value.total >= MINIMUM_RECOMMENDATION_ANSWERS)
        .map(([subject, { correct, total }]) => ({
          subject,
          topic: "Subject review",
          accuracy: Math.round((correct / total) * 100),
          answered: total,
        }))
        .filter((topic) => topic.accuracy < 70)
        .sort((a, b) => a.accuracy - b.accuracy)
        .slice(0, 3),
    );
  }

  return {
    averageScore,
    totalQuestionsAnswered,
    streak: currentStreak,
    daysUntilExam,
    examType,
    examGoals: profile?.exam_goals ?? [profile?.exam_type ?? "jamb"],
    targetScore: profile?.target_score ?? 200,
    recentSessions,
    weakTopics,
    hasSessions: sessions.length > 0,
    totalPoints: pointsResult.data?.total_points ?? 0,
    currentRank: pointsResult.data?.rank ?? "Beginner",
  };
}
