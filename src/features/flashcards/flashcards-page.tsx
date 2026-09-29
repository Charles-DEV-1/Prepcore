"use client";

import { useEffect, useMemo, useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { RotateCcw, Lock, ChevronRight, Sparkles } from "lucide-react";
import Link from "next/link";
import { createClient } from "@/services/supabase/client";
import { useUserPlan } from "@/hooks/use-user-plan";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { PageSkeleton } from "@/components/layout/page-skeleton";
import {
  getDailyFlashcards,
  getLagosDayNumber,
} from "@/features/flashcards/daily-deck";
import {
  getDailyQuestionFlashcards,
  type QuestionFlashcard,
} from "@/services/api/flashcard-questions";

type Flashcard = {
  id: string;
  front: string;
  back: string;
  label?: string;
};

export function FlashcardsPage() {
  const supabase = useMemo(() => createClient(), []);
  const { isPro, isLoading } = useUserPlan();

  const [index, setIndex] = useState(0);
  const [flipped, setFlipped] = useState(false);
  const [loading, setLoading] = useState(true);
  const [flashcards, setFlashcards] = useState<Flashcard[]>([]);
  const [questionCards, setQuestionCards] = useState<QuestionFlashcard[]>([]);
  const [questionCount, setQuestionCount] = useState(0);
  const [loadError, setLoadError] = useState<string | null>(null);
  const [dayNumber, setDayNumber] = useState(() =>
    getLagosDayNumber(new Date()),
  );

  const dailyCards = useMemo(() => {
    const manualCards = getDailyFlashcards(flashcards, dayNumber);
    const combined: Flashcard[] = [];

    for (
      let index = 0;
      index < Math.max(manualCards.length, questionCards.length);
      index++
    ) {
      if (questionCards[index]) combined.push(questionCards[index]);
      if (manualCards[index]) combined.push(manualCards[index]);
    }

    return combined;
  }, [flashcards, questionCards, dayNumber]);
  const card = dailyCards[index];

  useEffect(() => {
    function refreshDay() {
      const today = getLagosDayNumber(new Date());
      if (today !== dayNumber) {
        setDayNumber(today);
        setIndex(0);
        setFlipped(false);
      }
    }

    const interval = window.setInterval(refreshDay, 60_000);
    window.addEventListener("focus", refreshDay);
    document.addEventListener("visibilitychange", refreshDay);

    return () => {
      window.clearInterval(interval);
      window.removeEventListener("focus", refreshDay);
      document.removeEventListener("visibilitychange", refreshDay);
    };
  }, [dayNumber]);

  useEffect(() => {
    if (isLoading) return;
    if (!isPro) {
      setLoading(false);
      return;
    }

    let cancelled = false;

    async function loadFlashcards() {
      setLoading(true);
      const [manualResult, questionResult] = await Promise.allSettled([
        supabase.rpc("get_pro_flashcards"),
        getDailyQuestionFlashcards(supabase, dayNumber),
      ]);
      if (cancelled) return;

      if (manualResult.status === "fulfilled" && !manualResult.value.error) {
        setFlashcards(manualResult.value.data ?? []);
      } else {
        setFlashcards([]);
      }
      if (questionResult.status === "fulfilled") {
        setQuestionCards(questionResult.value.cards);
        setQuestionCount(questionResult.value.total);
      } else {
        setQuestionCards([]);
        setQuestionCount(0);
      }
      setLoadError(
        manualResult.status === "rejected" ||
          (manualResult.status === "fulfilled" && manualResult.value.error) ||
          questionResult.status === "rejected"
          ? "Some flashcards could not be loaded. Please refresh to try again."
          : null,
      );
      setLoading(false);
    }

    void loadFlashcards();
    return () => {
      cancelled = true;
    };
  }, [isPro, isLoading, supabase, dayNumber]);

  function nextCard() {
    setFlipped(false);
    setTimeout(() => {
      setIndex((prev) => (prev + 1 >= dailyCards.length ? 0 : prev + 1));
    }, 200);
  }

  function prevCard() {
    setFlipped(false);
    setTimeout(() => {
      setIndex((prev) => (prev === 0 ? dailyCards.length - 1 : prev - 1));
    }, 200);
  }

  // Plan still loading
  if (isLoading) {
    return <PageSkeleton variant="practice" />;
  }

  // Not pro — show full gate
  if (!isPro) {
    return (
      <div className="space-y-6">
        <div className="flex items-start justify-between gap-4">
          <div>
            <h1 className="text-3xl font-bold text-navy">Flashcards</h1>
            <p className="mt-2 text-sm text-slate-600">
              Swipe, flip, and memorize concepts faster.
            </p>
          </div>
          <Badge className="border-amber-200 bg-amber-50 text-amber-700">
            <Sparkles className="mr-1 h-3 w-3" />
            PRO FEATURE
          </Badge>
        </div>

        {/* Blurred preview */}
        <div className="relative overflow-hidden rounded-3xl">
          <div className="pointer-events-none select-none blur-md opacity-30">
            <div className="mx-auto max-w-2xl">
              <div className="relative h-[440px] w-full">
                <div className="absolute inset-0 translate-y-4 scale-95 rounded-3xl bg-primary/5" />
                <div className="absolute inset-0 translate-y-2 scale-[0.97] rounded-3xl bg-primary/10" />
                <Card className="h-full rounded-3xl border-border bg-white shadow-xl">
                  <CardContent className="flex h-full flex-col justify-between p-8">
                    <Badge className="bg-primary/10 text-primary w-fit">
                      Flashcard
                    </Badge>
                    <div className="flex flex-1 items-center justify-center">
                      <h2 className="text-center text-3xl font-bold text-navy">
                        What is Avogadro&apos;s Number?
                      </h2>
                    </div>
                    <p className="text-center text-sm text-slate-500">
                      Tap to reveal answer
                    </p>
                  </CardContent>
                </Card>
              </div>
            </div>
          </div>

          {/* Lock overlay */}
          <div className="absolute inset-0 flex flex-col items-center justify-center gap-5 bg-white/70 backdrop-blur-sm">
            <div className="flex h-16 w-16 items-center justify-center rounded-full bg-softblue">
              <Lock className="h-7 w-7 text-primary" />
            </div>
            <div className="text-center px-4">
              <p className="text-xl font-bold text-navy">
                Flashcards are Pro only
              </p>
              <p className="mt-2 text-sm text-slate-500 max-w-sm">
                Flip through a fresh daily mix of concept cards and original
                exam questions across your subjects.
              </p>
            </div>
            <Button asChild size="lg">
              <Link href="/upgrade">
                <Sparkles className="h-4 w-4" />
                Upgrade to Pro — ₦3,000
              </Link>
            </Button>
            <p className="text-xs text-slate-500">
              One-time payment · Access until after JAMB
            </p>
          </div>
        </div>
      </div>
    );
  }

  // Pro user — loading cards
  if (loading) {
    return <PageSkeleton variant="practice" />;
  }

  if (!card) {
    return (
      <div className="flex min-h-[60vh] items-center justify-center">
        <p className="text-slate-500">
          {loadError ?? "No flashcards found. Check your database."}
        </p>
      </div>
    );
  }

  // Pro user — full flashcard experience
  return (
    <div className="space-y-8">
      <div className="flex items-start justify-between gap-4">
        <div>
          <h1 className="text-3xl font-bold text-navy">Flashcards</h1>
          <p className="mt-2 text-sm text-slate-600">
            Swipe, flip, and memorize concepts faster.
          </p>
        </div>
        <Badge className="border-green-200 bg-green-50 text-green-700">
          <Sparkles className="mr-1 h-3 w-3" />
          PRO — {dailyCards.length} today
        </Badge>
      </div>
      {loadError && (
        <p
          role="alert"
          className="rounded-xl border border-amber-200 bg-amber-50 px-4 py-3 text-sm text-amber-800"
        >
          {loadError}
        </p>
      )}

      <div className="mx-auto flex max-w-2xl flex-col items-center">
        <AnimatePresence mode="wait">
          <motion.div
            key={card.id}
            drag="x"
            dragConstraints={{ left: 0, right: 0 }}
            onDragEnd={(_, info) => {
              if (info.offset.x < -100) nextCard();
              if (info.offset.x > 100) prevCard();
            }}
            initial={{ opacity: 0, scale: 0.92, y: 40 }}
            animate={{ opacity: 1, scale: 1, y: 0 }}
            exit={{ opacity: 0, scale: 0.9, y: -30 }}
            transition={{ duration: 0.35 }}
            className="relative h-[440px] w-full cursor-pointer"
            style={{ perspective: "1000px" }}
            onClick={() => setFlipped(!flipped)}
          >
            <div className="absolute inset-0 translate-y-4 scale-95 rounded-3xl bg-primary/5" />
            <div className="absolute inset-0 translate-y-2 scale-[0.97] rounded-3xl bg-primary/10" />

            <motion.div
              animate={{ rotateY: flipped ? 180 : 0 }}
              transition={{ duration: 0.6 }}
              className="relative h-full w-full"
              style={{ transformStyle: "preserve-3d" }}
            >
              {/* Front */}
              <div
                className="absolute inset-0"
                style={{ backfaceVisibility: "hidden" }}
              >
                <Card className="h-full rounded-3xl border-border bg-white shadow-xl">
                  <CardContent className="flex h-full flex-col justify-between p-8">
                    <div className="flex items-center justify-between">
                      <Badge className="bg-primary/10 text-primary">
                        {index + 1} / {dailyCards.length}
                      </Badge>
                      <span className="flex items-center gap-2 text-xs text-slate-500">
                        {card.label ?? "Concept card"}
                        <RotateCcw className="h-5 w-5" />
                      </span>
                    </div>
                    <div className="flex min-h-0 flex-1 items-center justify-center overflow-y-auto py-4">
                      <h2 className="whitespace-pre-line text-center text-lg font-bold leading-relaxed text-navy sm:text-2xl">
                        {card.front}
                      </h2>
                    </div>
                    <p className="text-center text-sm text-slate-500">
                      Tap to reveal answer
                    </p>
                  </CardContent>
                </Card>
              </div>

              {/* Back */}
              <div
                className="absolute inset-0"
                style={{
                  backfaceVisibility: "hidden",
                  transform: "rotateY(180deg)",
                }}
              >
                <Card className="h-full rounded-3xl border-primary/20 bg-primary shadow-2xl">
                  <CardContent className="flex h-full flex-col justify-between p-8 text-white">
                    <Badge className="w-fit bg-white/20 text-white">
                      Answer
                    </Badge>
                    <div className="flex min-h-0 flex-1 items-center justify-center overflow-y-auto py-4">
                      <p className="whitespace-pre-line text-center text-lg leading-relaxed sm:text-xl">
                        {card.back}
                      </p>
                    </div>
                    <p className="text-center text-sm text-blue-100">
                      Tap again to flip back
                    </p>
                  </CardContent>
                </Card>
              </div>
            </motion.div>
          </motion.div>
        </AnimatePresence>

        <div className="mt-6 flex flex-wrap items-center justify-center gap-3">
          <Button variant="outline" onClick={prevCard}>
            Previous
          </Button>
          <Button variant="outline" onClick={nextCard}>
            Review Again
          </Button>
          <Button onClick={nextCard} className="gap-2">
            Got It <ChevronRight className="h-4 w-4" />
          </Button>
        </div>
        <p className="mt-4 text-sm text-slate-500">
          Swipe left or right to navigate · {index + 1} of {dailyCards.length}{" "}
          today
        </p>
        <p className="mt-1 text-center text-xs text-slate-500">
          Today&apos;s set draws from {questionCount} original questions and{" "}
          {flashcards.length} concept cards. It changes at midnight Nigeria
          time; cards repeat after their bank is covered.
        </p>
      </div>
    </div>
  );
}
