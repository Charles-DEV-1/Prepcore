"use client";

import { useEffect, useMemo, useState } from "react";
import dynamic from "next/dynamic";
import { Activity, BarChart3, Flame, Target } from "lucide-react";

import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Skeleton } from "@/components/ui/skeleton";

import { createClient } from "@/services/supabase/client";
import { getProgressData } from "@/services/api/progress";
import { getCurrentStreak } from "@/services/api/streak";
import { useExamStore } from "@/store/examStore";

type Session = {
  id: string;
  score: number | null;
  total_questions: number;
  created_at: string;
};

const ProgressChart = dynamic(
  () => import("./progress-chart").then((module) => module.ProgressChart),
  {
    ssr: false,
    loading: () => <Skeleton className="h-full w-full" />,
  },
);

export function ProgressPage() {
  const { activeExamType, setActiveExamType } = useExamStore();
  const [sessions, setSessions] = useState<Session[]>([]);
  const [streak, setStreak] = useState(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    async function loadData() {
      try {
        setLoading(true);
        setError(null);
        const supabase = createClient();
        const {
          data: { session },
        } = await supabase.auth.getSession();
        const user = session?.user;
        if (!user) throw new Error("Please sign in to view progress.");

        const [progressData, currentStreak] = await Promise.all([
          getProgressData(user.id, activeExamType),
          getCurrentStreak(supabase, user.id),
        ]);

        setSessions(progressData);
        setStreak(currentStreak);
      } catch (loadError) {
        setError(
          loadError instanceof Error
            ? loadError.message
            : "Could not load progress.",
        );
      } finally {
        setLoading(false);
      }
    }

    void loadData();
  }, [activeExamType]);

  const chartData = useMemo(() => {
    return sessions.map((session, index) => ({
      name: `S${index + 1}`,
      score: session.score,
    }));
  }, [sessions]);

  const bestScore = useMemo(() => {
    if (!sessions.length) return 0;

    return Math.max(...sessions.map((s) => s.score || 0));
  }, [sessions]);

  const averageScore = useMemo(() => {
    if (!sessions.length) return 0;

    const total = sessions.reduce((acc, curr) => {
      return acc + (curr.score || 0);
    }, 0);

    return Math.round(total / sessions.length);
  }, [sessions]);

  const totalQuestions = useMemo(() => {
    return sessions.reduce((acc, curr) => {
      return acc + curr.total_questions;
    }, 0);
  }, [sessions]);

  const stats = [
    {
      label: "Total sessions",
      value: sessions.length,
      icon: Activity,
    },
    {
      label: "Best score",
      value: `${bestScore}%`,
      icon: Target,
    },
    {
      label: "Current streak",
      value: streak,
      icon: Flame,
    },
    {
      label: "Average score",
      value: `${averageScore}%`,
      icon: BarChart3,
    },
  ];

  if (loading) {
    return (
      <div
        className="space-y-6"
        aria-label="Loading progress analytics"
        role="status"
      >
        <div className="space-y-3">
          <Skeleton className="h-9 w-28" />
          <Skeleton className="h-8 w-52" />
          <Skeleton className="h-4 w-80" />
        </div>
        <div className="grid gap-4 md:grid-cols-4">
          {[0, 1, 2, 3].map((item) => (
            <Skeleton key={item} className="h-28" />
          ))}
        </div>
        <Skeleton className="h-80 w-full" />
        <Skeleton className="h-52 w-full" />
      </div>
    );
  }

  if (error) {
    return (
      <Card className="mx-auto max-w-xl">
        <CardContent className="p-8 text-center text-sm text-destructive">
          {error}
        </CardContent>
      </Card>
    );
  }

  return (
    <div className="space-y-6">
      <div>
        <div className="mb-4 inline-flex rounded-xl border border-border bg-white p-1">
          {(["jamb", "waec"] as const).map((examType) => (
            <button
              key={examType}
              className={`rounded-lg px-3 py-1.5 text-sm font-medium ${
                activeExamType === examType
                  ? "bg-primary text-white"
                  : "text-slate-600"
              }`}
              onClick={() => setActiveExamType(examType)}
            >
              {examType.toUpperCase()}
            </button>
          ))}
        </div>
        <h1 className="text-3xl font-bold text-navy">Progress analytics</h1>

        <p className="mt-2 text-sm text-slate-600">
          Real performance insights from your practice sessions and mock exams.
        </p>
      </div>

      <section className="grid gap-4 md:grid-cols-4">
        {stats.map(({ label, value, icon: Icon }) => (
          <Card key={label} className="border-border bg-white shadow-sm">
            <CardContent className="flex items-center justify-between p-5">
              <div>
                <p className="text-sm text-slate-600">{label}</p>

                <p className="mt-2 text-2xl font-bold text-navy">{value}</p>
              </div>

              <Icon className="h-5 w-5 text-primary" />
            </CardContent>
          </Card>
        ))}
      </section>

      <Card className="border-border bg-white shadow-sm">
        <CardHeader>
          <CardTitle>Score trend</CardTitle>
        </CardHeader>

        <CardContent className="h-[320px]">
          <ProgressChart data={chartData} />
        </CardContent>
      </Card>

      <Card className="border-border bg-white shadow-sm">
        <CardHeader>
          <CardTitle>Study activity</CardTitle>
        </CardHeader>

        <CardContent>
          <div className="grid grid-cols-10 gap-2 md:grid-cols-14">
            {Array.from({ length: 70 }, (_, index) => (
              <div
                key={index}
                className={`aspect-square rounded-[4px] ${
                  index < streak ? "bg-primary" : "bg-primary/10"
                }`}
              />
            ))}
          </div>

          <p className="mt-4 text-sm text-slate-600">
            You have studied for{" "}
            <span className="font-semibold text-navy">
              {streak} consecutive days
            </span>
            .
          </p>
        </CardContent>
      </Card>

      <Card className="border-border bg-white shadow-sm">
        <CardHeader>
          <CardTitle>Total statistics</CardTitle>
        </CardHeader>

        <CardContent className="grid gap-4 md:grid-cols-3">
          <div className="rounded-2xl border p-4">
            <p className="text-sm text-slate-500">Questions answered</p>

            <p className="mt-2 text-3xl font-bold text-navy">
              {totalQuestions}
            </p>
          </div>

          <div className="rounded-2xl border p-4">
            <p className="text-sm text-slate-500">Sessions completed</p>

            <p className="mt-2 text-3xl font-bold text-navy">
              {sessions.length}
            </p>
          </div>

          <div className="rounded-2xl border p-4">
            <p className="text-sm text-slate-500">Best score</p>

            <p className="mt-2 text-3xl font-bold text-navy">{bestScore}%</p>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
