"use client";

import { useCallback, useState } from "react";
import Link from "next/link";
import Image from "next/image";
import {
  ArrowRight,
  BookOpenCheck,
  CalendarDays,
  Flame,
  Sparkles,
  Target,
  TrendingUp,
} from "lucide-react";
import { RankBadge } from "@/components/ui/rank-badge";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";
import { useExamStore } from "@/store/examStore";
import { FeedbackPrompt } from "@/components/feedback/feedback-prompt";
import { ProLaunchAnnouncement } from "@/components/announcements/pro-launch-announcement";
import { BuddyNote } from "@/components/buddy/study-buddy";
import { useStudyBuddyVisible } from "@/hooks/use-study-buddy-visible";
import type { ExamGoal, ExamType } from "@/types/app";
import {
  cleanTopicLabel,
  type StudyRecommendation,
} from "@/lib/study-recommendations";

type DashboardData = {
  averageScore: number;
  totalQuestionsAnswered: number;
  streak: number;
  daysUntilExam: number | null;
  examType: string;
  targetScore: number | null;
  recentSessions: {
    id: string;
    type: string;
    score: number;
    totalQuestions: number;
    date: string;
  }[];
  recommendations: StudyRecommendation[];
  recommendationUnavailable: boolean;
  hasSessions: boolean;
  totalPoints: number;
  currentRank: string;
  examGoals?: ExamGoal;
} | null;

export function DashboardPage({
  userName = "Student",
  data,
  dataByExam,
}: {
  userName?: string;
  data?: DashboardData;
  dataByExam?: Record<ExamType, DashboardData>;
}) {
  const {
    visible: buddyVisible,
    ready: buddyVisibilityReady,
    setVisible: setBuddyVisible,
  } = useStudyBuddyVisible();
  const [announcementStatus, setAnnouncementStatus] = useState<
    "checking" | "shown" | "none"
  >("checking");
  const handleAnnouncementChecked = useCallback((shown: boolean) => {
    setAnnouncementStatus(shown ? "shown" : "none");
  }, []);
  const { activeExamType, setActiveExamType } = useExamStore();
  const examGoals = data?.examGoals ?? ["jamb"];
  const currentExamType = examGoals.includes(activeExamType)
    ? activeExamType
    : (examGoals[0] ?? "jamb");
  const activeData = dataByExam?.[currentExamType] ?? data;
  const examLabel = currentExamType.toUpperCase();
  const metrics = [
    {
      label: "Study streak",
      value: `${data?.streak ?? 0} days`,
      icon: Flame,
      tone: "text-amber",
    },
    {
      label: "Average score",
      value: activeData?.hasSessions ? `${activeData.averageScore}%` : "—",
      icon: TrendingUp,
      tone: "text-success",
    },
    {
      label: "Questions answered",
      value: activeData?.totalQuestionsAnswered
        ? activeData.totalQuestionsAnswered.toLocaleString()
        : "0",
      icon: BookOpenCheck,
      tone: "text-primary",
    },
    {
      label: "Days until exam",
      value:
        activeData?.daysUntilExam != null
          ? `${activeData.daysUntilExam} days`
          : "Not set",
      icon: CalendarDays,
      tone: "text-primary",
    },
  ];

  const hour = new Date().getHours();
  const greeting =
    hour < 12 ? "Good morning" : hour < 17 ? "Good afternoon" : "Good evening";

  return (
    <div className="space-y-6">
      {announcementStatus === "none" && <FeedbackPrompt />}
      <ProLaunchAnnouncement onChecked={handleAnnouncementChecked} />
      {examGoals.length > 1 && (
        <div className="inline-flex rounded-xl border border-border bg-white p-1">
          {(["jamb", "waec"] as const).map((examType) => (
            <Button
              key={examType}
              size="sm"
              variant={currentExamType === examType ? "default" : "ghost"}
              onClick={() => setActiveExamType(examType)}
            >
              {examType.toUpperCase()}
            </Button>
          ))}
        </div>
      )}
      {/* Welcome banner */}
      <section className="soft-blue-gradient relative overflow-hidden rounded-[2rem] border border-border p-6 shadow-soft md:p-8">
        <div className="pointer-events-none absolute -right-16 -top-20 h-72 w-72 rounded-full bg-blue-200/40 blur-3xl" />
        <div
          data-buddy-zone="dashboard"
          data-buddy-mood="neutral"
          className="pointer-events-none absolute right-6 top-3 hidden h-48 w-72 xl:block"
        />
        <div className="relative flex items-center gap-3">
          <Image
            src="/favicons/android-chrome-512x512.png"
            alt="Prepcore logo"
            width={64}
            height={64}
            className="rounded-full shadow-sm"
            priority
          />
          <Badge className="border-blue-200 bg-white text-primary">
            {examLabel} preparation
          </Badge>
        </div>
        <div className="relative mt-5 flex flex-col gap-6 md:flex-row md:items-end md:justify-between">
          <div>
            <h1 className="text-3xl font-bold tracking-normal text-navy md:text-4xl">
              {greeting}, {userName}.
            </h1>
            {!activeData?.hasSessions ? (
              <p className="mt-3 max-w-2xl text-sm leading-7 text-slate-600">
                Welcome to Prepcore! Start your first practice session to see
                your personalised stats here.
              </p>
            ) : activeData.recommendations.length > 0 ? (
              <p className="mt-3 max-w-2xl text-sm leading-7 text-slate-600">
                Your average score is{" "}
                <span className="font-semibold text-navy">
                  {activeData.averageScore}%
                </span>
                . Your next suggested topic is{" "}
                <span className="font-semibold text-navy">
                  {cleanTopicLabel(activeData.recommendations[0]?.topic)}
                </span>{" "}
                in {activeData.recommendations[0]?.subject}.
              </p>
            ) : (
              <p className="mt-3 max-w-2xl text-sm leading-7 text-slate-600">
                No topic needs extra attention from your recent answers. Average
                score:{" "}
                <span className="font-semibold text-navy">
                  {activeData.averageScore}%
                </span>
                . Keep up the momentum.
              </p>
            )}
            {activeData?.totalPoints !== undefined && (
              <div className="mt-2">
                <RankBadge
                  points={activeData.totalPoints}
                  showProgress
                  size="md"
                />
              </div>
            )}
          </div>
          <Button asChild>
            <Link href="/practice">
              Start practice <ArrowRight className="h-4 w-4" />
            </Link>
          </Button>
        </div>
      </section>

      {buddyVisibilityReady && !buddyVisible ? (
        <section
          aria-label="Booky visibility"
          className="flex flex-wrap items-center justify-between gap-3 rounded-2xl border border-blue-200 bg-blue-50/80 p-4 dark:border-blue-500/30 dark:bg-slate-800/80"
        >
          <div>
            <p className="font-semibold text-slate-900 dark:text-slate-100">
              Booky is hidden
            </p>
            <p className="mt-1 text-sm text-slate-700 dark:text-slate-300">
              Want your study companion back on supported pages?
            </p>
          </div>
          <Button
            type="button"
            variant="outline"
            onClick={() => setBuddyVisible(true)}
          >
            <Sparkles className="h-4 w-4" /> Show Booky
          </Button>
        </section>
      ) : (
        <BuddyNote
          zone="dashboard"
          pose={
            activeData?.recommendations.length
              ? "thinking"
              : activeData?.hasSessions
                ? "big-smile"
                : "wave"
          }
          message={
            !activeData?.hasSessions
              ? "Let’s start with a few practice questions. Each answer helps build useful suggestions for you."
              : activeData.recommendations.length > 0
                ? `Let’s revisit ${cleanTopicLabel(activeData.recommendations[0].topic)} in ${activeData.recommendations[0].subject}. Your recent answers point there.`
                : "You’re building momentum. Another short practice set will help keep it going."
          }
        />
      )}

      {/* Stats row */}
      <section className="grid gap-4 sm:grid-cols-2 xl:grid-cols-4">
        {metrics.map((metric) => (
          <Card
            key={metric.label}
            className="border-border bg-white shadow-[0_14px_36px_rgba(15,23,42,0.05)]"
          >
            <CardContent className="flex items-center justify-between p-5">
              <div>
                <p className="text-sm font-medium text-slate-500">
                  {metric.label}
                </p>
                <p className="mt-2 text-2xl font-bold text-navy">
                  {metric.value}
                </p>
              </div>
              <div className="flex h-12 w-12 items-center justify-center rounded-2xl bg-softblue">
                <metric.icon className={`h-6 w-6 ${metric.tone}`} />
              </div>
            </CardContent>
          </Card>
        ))}
      </section>

      {/* Weak topics + Recent sessions */}
      <section className="grid gap-4 xl:grid-cols-[1.15fr_0.85fr]">
        {/* Weak topics */}
        <Card className="border-border bg-white shadow-sm">
          <CardHeader>
            <CardTitle className="flex items-center gap-2 text-lg">
              <Sparkles className="h-5 w-5 text-primary" />
              {activeData?.hasSessions
                ? "Recommended practice"
                : "Start practising"}
            </CardTitle>
            <CardDescription>
              {activeData?.hasSessions
                ? "Based on your latest answers to distinct questions from the last 60 days. No AI guesswork."
                : "Answer a few practice questions to see evidence-based suggestions."}
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            {!activeData?.hasSessions ||
            activeData.recommendations.length === 0 ? (
              <div className="rounded-2xl border border-border bg-[#F8FAFC] p-6 text-center dark:bg-slate-800/70">
                <p className="text-sm text-slate-500">
                  {activeData?.hasSessions
                    ? activeData.recommendationUnavailable
                      ? "We couldn't analyse your recent answers right now. Please try again later."
                      : "No clear focus topic right now. Keep practising to build more evidence."
                    : "Your suggestions will appear as you answer questions."}
                </p>
                <Button asChild className="mt-4" size="sm">
                  <Link href="/practice">Start practice</Link>
                </Button>
              </div>
            ) : (
              activeData.recommendations.map((topic) => (
                <div
                  key={`${topic.subjectId}:${topic.topic}`}
                  className="rounded-2xl border border-border bg-[#F8FAFC] p-4 dark:bg-slate-800/70"
                >
                  <div className="flex flex-wrap items-start justify-between gap-4">
                    <div>
                      <p className="font-semibold text-navy">{topic.subject}</p>
                      <p className="text-sm text-slate-600 dark:text-slate-300">
                        {cleanTopicLabel(topic.topic)}
                      </p>
                    </div>
                    <Badge className="text-main">
                      {topic.kind === "focus"
                        ? "Focus now"
                        : topic.kind === "check"
                          ? "Check this topic"
                          : "Refresh"}
                    </Badge>
                  </div>
                  <p className="mt-3 text-sm text-slate-600 dark:text-slate-300">
                    {topic.reason}
                  </p>
                  <p className="mt-1 text-xs text-slate-500 dark:text-slate-400">
                    {topic.accuracy}% correct across {topic.answered} distinct{" "}
                    {topic.answered === 1 ? "question" : "questions"}.
                  </p>
                  <Progress value={topic.accuracy} className="mt-4" />
                  <Button asChild size="sm" className="mt-4">
                    <Link
                      href={`/practice?${new URLSearchParams({ exam: currentExamType, subject: topic.subjectId, topic: topic.topic })}`}
                    >
                      Practise this topic <ArrowRight className="h-4 w-4" />
                    </Link>
                  </Button>
                </div>
              ))
            )}
          </CardContent>
        </Card>

        {/* Recent sessions */}
        <Card className="border-border bg-white shadow-sm">
          <CardHeader>
            <CardTitle className="text-lg">Recent sessions</CardTitle>
            <CardDescription>
              Your last practice and exam activity.
            </CardDescription>
          </CardHeader>
          <CardContent className="space-y-4">
            {!activeData?.hasSessions ||
            activeData.recentSessions.length === 0 ? (
              <div className="rounded-2xl bg-softblue p-5 text-center">
                <p className="text-sm text-slate-600">
                  No sessions yet. Take your first practice or mock exam.
                </p>
              </div>
            ) : (
              <>
                <div className="rounded-2xl bg-softblue p-5">
                  <div className="mb-3 flex justify-between text-sm font-medium text-slate-600">
                    <span>Average score</span>
                    <span>{activeData.averageScore}%</span>
                  </div>
                  <Progress value={activeData.averageScore} />
                </div>
                {activeData.recentSessions.map((session) => (
                  <div
                    key={session.id}
                    className="flex items-center justify-between rounded-2xl border border-border p-3"
                  >
                    <div>
                      <p className="text-sm font-semibold text-navy">
                        {session.type}
                      </p>
                      <p className="text-xs text-slate-500">
                        {session.totalQuestions} questions · {session.date}
                      </p>
                    </div>
                    <p className="text-sm font-bold text-primary">
                      {session.score}%
                    </p>
                  </div>
                ))}
              </>
            )}
          </CardContent>
        </Card>
      </section>

      {/* Quick actions */}
      <section className="grid gap-4 md:grid-cols-3">
        {[
          [
            "Practice",
            "/practice",
            "Answer targeted questions with instant feedback.",
          ],
          ["Mock exam", "/exam", "Simulate exam day with a full timed exam."],
          [
            "Progress",
            "/progress",
            "Review your score trends and weak topics.",
          ],
        ].map(([title, href, body]) => (
          <Card key={title} className="border-border bg-white shadow-sm">
            <CardContent className="p-5">
              <div className="flex h-11 w-11 items-center justify-center rounded-2xl bg-softblue">
                <Target className="h-5 w-5 text-primary" />
              </div>
              <h3 className="mt-4 font-bold text-navy">{title}</h3>
              <p className="mt-2 text-sm leading-6 text-slate-600">{body}</p>
              <Button asChild variant="outline" className="mt-5 w-full">
                <Link href={href as string}>Open</Link>
              </Button>
            </CardContent>
          </Card>
        ))}
      </section>
    </div>
  );
}
