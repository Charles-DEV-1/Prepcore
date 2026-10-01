"use client";

import { awardPoints } from "@/services/api/points";
import { ReportQuestion } from "@/components/ui/report-question";
import { AIExplanation } from "@/components/ui/ai-explanation";
import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { AnimatePresence, motion, useReducedMotion } from "framer-motion";
import { CheckCircle2, XCircle } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";
import { createClient } from "@/services/supabase/client";
import { updateStreak } from "@/services/api/streak";
import {
  getAvailableYears,
  getYearSessionQuestions,
  getSessionQuestions,
  getSubjectsByExamType,
  type QuestionForSession,
  type SubjectForExam,
} from "@/services/api/questions";
import { recordPracticeAnswer } from "@/services/api/practice-answers";
import { useExamStore } from "@/store/examStore";
import { cn } from "@/lib/utils";
import { AnswerFeedback, Stagger, StaggerItem } from "@/components/ui/motion";
import { PageSkeleton } from "@/components/layout/page-skeleton";
import type { ExamGoal } from "@/types/app";
import type { ExamType } from "@/types/app";
import { cleanTopicLabel } from "@/lib/study-recommendations";
import { PracticeResultInvitation } from "@/components/announcements/practice-result-invitation";

// Prepcore — Dark Mode
const SUBJECTS = [
  { label: "English", id: "11111111-1111-1111-1111-111111111111" },
  { label: "Mathematics", id: "22222222-2222-2222-2222-222222222222" },
  { label: "Physics", id: "33333333-3333-3333-3333-333333333333" },
  { label: "Chemistry", id: "44444444-4444-4444-4444-444444444444" },
  { label: "Biology", id: "55555555-5555-5555-5555-555555555555" },
  { label: "Economics", id: "66666666-6666-6666-6666-666666666666" },
  { label: "Government", id: "77777777-7777-7777-7777-777777777777" },
  { label: "Literature", id: "88888888-8888-8888-8888-888888888888" },
  { label: "CRS", id: "99999999-9999-9999-9999-999999999999" },
  { label: "Geography", id: "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa" },
];

type PointsSupabaseClient = Parameters<typeof awardPoints>[0];
type PracticeSubject = { label: string; id: string };

export function PracticePage({
  recommendation = null,
}: {
  recommendation?: { exam: ExamType; subjectId: string; topic: string } | null;
}) {
  const { activeExamType, setActiveExamType } = useExamStore();
  const [selectedSubject, setSelectedSubject] = useState<PracticeSubject>(
    SUBJECTS[0],
  );
  const [waecSubjects, setWaecSubjects] = useState<SubjectForExam[]>([]);
  const [waecSubjectsLoaded, setWaecSubjectsLoaded] = useState(false);
  const [availableYears, setAvailableYears] = useState<number[]>([]);
  const [selectedYear, setSelectedYear] = useState<number | null>(null);
  const [selectedSource, setSelectedSource] = useState<"all" | "original">(
    "all",
  );
  const [examGoals, setExamGoals] = useState<ExamGoal>(["jamb"]);
  const [questions, setQuestions] = useState<QuestionForSession[]>([]);
  const [questionIndex, setQuestionIndex] = useState(0);
  const [selected, setSelected] = useState<string | null>(null);
  const [submitted, setSubmitted] = useState(false);
  const [loading, setLoading] = useState(true);
  const [score, setScore] = useState(0);
  const [answered, setAnswered] = useState(0);
  const [selectedAnswers, setSelectedAnswers] = useState<
    Record<string, string>
  >({});
  const [sessionSaved, setSessionSaved] = useState(false);
  const [savingAnswer, setSavingAnswer] = useState(false);
  const [saveError, setSaveError] = useState<string | null>(null);
  const [reviewPage, setReviewPage] = useState(1);
  const [selectedTopic, setSelectedTopic] = useState<string | null>(
    recommendation?.topic ?? null,
  );
  const [loadError, setLoadError] = useState<string | null>(null);
  const [questionDirection, setQuestionDirection] = useState<1 | -1>(1);
  const reducedMotion = useReducedMotion();
  const requestIdRef = useRef(0);
  const sessionIdRef = useRef<string | null>(null);
  const attemptedAnswerRef = useRef<string | null>(null);
  const reviewTopRef = useRef<HTMLHeadingElement | null>(null);
  const recommendationAppliedRef = useRef(false);

  const supabase = useMemo(() => createClient(), []);
  const canUseActiveExam = examGoals.includes(activeExamType);
  const subjectsForActiveExam: PracticeSubject[] =
    activeExamType === "jamb"
      ? SUBJECTS
      : waecSubjects.map((subject) => ({
          id: subject.id,
          label: subject.name,
        }));

  useEffect(() => {
    async function loadExamContext() {
      const {
        data: { user },
      } = await supabase.auth.getUser();

      if (user) {
        const { data } = await supabase
          .from("users")
          .select("exam_goals")
          .eq("id", user.id)
          .maybeSingle();
        const goals = ((data as { exam_goals?: ExamGoal | null } | null)
          ?.exam_goals ?? ["jamb"]) as ExamGoal;
        setExamGoals(goals);
        if (
          recommendation &&
          !recommendationAppliedRef.current &&
          goals.includes(recommendation.exam)
        ) {
          recommendationAppliedRef.current = true;
          setActiveExamType(recommendation.exam);
        } else if (!goals.includes(activeExamType)) setActiveExamType(goals[0]);
      }

      setWaecSubjects(await getSubjectsByExamType(supabase, "waec"));
      setWaecSubjectsLoaded(true);
    }

    void loadExamContext();
  }, [activeExamType, recommendation, setActiveExamType, supabase]);

  useEffect(() => {
    if (activeExamType === "jamb") {
      setSelectedSubject(
        SUBJECTS.find(
          (item) =>
            recommendation?.exam === "jamb" &&
            item.id === recommendation.subjectId,
        ) ?? SUBJECTS[0],
      );
      setSelectedTopic(
        recommendation?.exam === "jamb" ? recommendation.topic : null,
      );
      setSelectedYear(null);
      setSelectedSource("all");
      setAvailableYears([]);
      return;
    }

    const firstWaecSubject = waecSubjects[0];
    if (firstWaecSubject) {
      const subject =
        waecSubjects.find(
          (item) =>
            recommendation?.exam === "waec" &&
            item.id === recommendation.subjectId,
        ) ?? firstWaecSubject;
      setSelectedSubject({ id: subject.id, label: subject.name });
      setSelectedTopic(
        recommendation?.exam === "waec" &&
          subject.id === recommendation.subjectId
          ? recommendation.topic
          : null,
      );
    }
  }, [activeExamType, waecSubjects, recommendation]);

  useEffect(() => {
    if (activeExamType !== "waec" || !selectedSubject.id) return;
    let cancelled = false;

    async function loadYears() {
      const years = await getAvailableYears(
        supabase,
        selectedSubject.id,
        "waec",
      );
      if (!cancelled) setAvailableYears(years);
    }

    void loadYears();
    return () => {
      cancelled = true;
    };
  }, [activeExamType, selectedSubject.id, supabase]);

  const loadQuestions = useCallback(async () => {
    const requestId = ++requestIdRef.current;
    if (!canUseActiveExam) {
      setQuestions([]);
      setLoading(false);
      return;
    }
    if (
      activeExamType === "waec" &&
      !waecSubjects.some((subject) => subject.id === selectedSubject.id)
    ) {
      setQuestions([]);
      setLoading(!waecSubjectsLoaded);
      return;
    }

    setLoading(true);
    setQuestionIndex(0);
    setSelected(null);
    setSubmitted(false);
    setScore(0);
    setAnswered(0);
    setSelectedAnswers({});
    setSessionSaved(false);
    sessionIdRef.current = null;
    attemptedAnswerRef.current = null;
    setSaveError(null);
    setReviewPage(1);
    setLoadError(null);

    try {
      const nextQuestions =
        activeExamType === "waec" &&
        selectedYear &&
        selectedSource === "all" &&
        !selectedTopic
          ? await getYearSessionQuestions(
              selectedSubject.id,
              25,
              activeExamType,
              selectedYear,
            )
          : await getSessionQuestions(
              selectedSubject.id,
              25,
              activeExamType,
              selectedSource === "original" ? "original" : undefined,
              selectedTopic ?? undefined,
            );
      if (requestId !== requestIdRef.current) return;
      setQuestions(nextQuestions);
    } catch (error) {
      if (requestId !== requestIdRef.current) return;
      setQuestions([]);
      setLoadError(
        error instanceof Error
          ? error.message
          : "Could not load questions. Please try again.",
      );
    } finally {
      if (requestId === requestIdRef.current) setLoading(false);
    }
  }, [
    activeExamType,
    canUseActiveExam,
    selectedSubject.id,
    selectedYear,
    selectedSource,
    selectedTopic,
    waecSubjects,
    waecSubjectsLoaded,
  ]);

  useEffect(() => {
    void loadQuestions();
  }, [loadQuestions]);

  function handleSelect(optionKey: string) {
    if (!submitted && !savingAnswer && !attemptedAnswerRef.current)
      setSelected(optionKey);
  }

  async function handleSubmit() {
    if (!selected || !question || savingAnswer || submitted) return;
    setSavingAnswer(true);
    setSaveError(null);
    attemptedAnswerRef.current = selected;
    sessionIdRef.current ??= crypto.randomUUID();
    let savedSessionId: string;
    try {
      savedSessionId = await recordPracticeAnswer(supabase, {
        sessionId: sessionIdRef.current,
        questionId: question.id,
        selectedAnswer: selected,
        isCorrect: selected === question.correct_answer,
        examType: activeExamType,
      });
    } catch (error) {
      setSaveError(
        error instanceof Error
          ? error.message
          : "Could not save your answer. Please try again.",
      );
      setSavingAnswer(false);
      return;
    }
    sessionIdRef.current = savedSessionId;
    attemptedAnswerRef.current = null;
    const updatedAnswers = { ...selectedAnswers, [question.id]: selected };
    const nextAnswered = answered + 1;
    const nextScore = score + (selected === question.correct_answer ? 1 : 0);
    const nextAccuracy = Math.round((nextScore / nextAnswered) * 100);

    setSubmitted(true);
    setAnswered(nextAnswered);
    setSelectedAnswers(updatedAnswers);
    if (selected === question.correct_answer) setScore(nextScore);

    if (questionIndex === questions.length - 1) {
      void finishPracticeSession(nextAccuracy);
    }
    setSavingAnswer(false);
  }

  async function finishPracticeSession(finalAccuracy: number) {
    if (sessionSaved) return;
    setSessionSaved(true);

    const {
      data: { user },
    } = await supabase.auth.getUser();
    if (!user) {
      setSessionSaved(false);
      return;
    }

    await updateStreak(supabase, user.id);
    await awardPoints(
      supabase as PointsSupabaseClient,
      user.id,
      "practice",
      finalAccuracy,
    );
  }

  function changeQuestion(nextIndex: number, direction: 1 | -1) {
    setQuestionDirection(direction);
    setQuestionIndex(nextIndex);
    const nextQuestion = questions[nextIndex];
    const existingAnswer = nextQuestion
      ? selectedAnswers[nextQuestion.id]
      : undefined;
    setSelected(existingAnswer ?? null);
    setSubmitted(Boolean(existingAnswer));
  }

  function nextQuestion() {
    changeQuestion(questionIndex + 1, 1);
  }

  function previousQuestion() {
    if (questionIndex > 0) changeQuestion(questionIndex - 1, -1);
  }

  function goToReviewPage(page: number) {
    setReviewPage(Math.max(1, Math.min(page, reviewPageCount)));
    window.requestAnimationFrame(() => reviewTopRef.current?.scrollIntoView({
      behavior: reducedMotion ? "instant" : "smooth",
      block: "start",
    }));
  }

  const question = questions[questionIndex];
  const progress =
    questions.length > 0
      ? Math.round((questionIndex / questions.length) * 100)
      : 0;
  const accuracy = answered > 0 ? Math.round((score / answered) * 100) : 0;
  const wrongQuestions = questions.filter((item) => {
    const answer = selectedAnswers[item.id];
    return answer && answer !== item.correct_answer;
  });
  const reviewsPerPage = 5;
  const reviewPageCount = Math.max(1, Math.ceil(wrongQuestions.length / reviewsPerPage));
  const currentReviewPage = Math.min(reviewPage, reviewPageCount);
  const visibleWrongQuestions = wrongQuestions.slice(
    (currentReviewPage - 1) * reviewsPerPage,
    currentReviewPage * reviewsPerPage,
  );
  const resultYear =
    questions.length > 0 &&
    questions[0].year !== null &&
    questions.every((item) => item.year === questions[0].year)
      ? questions[0].year
      : null;
  const examLabel = activeExamType.toUpperCase();
  const noWaecSubjects =
    activeExamType === "waec" &&
    waecSubjectsLoaded &&
    waecSubjects.length === 0;

  return (
    <div className="space-y-4">
      <div className="inline-flex rounded-xl border border-border bg-white p-1 dark:border-border-card dark:bg-card-surface">
        {(["jamb", "waec"] as const).map((examType) => (
          <Button
            key={examType}
            size="sm"
            disabled={savingAnswer}
            variant={activeExamType === examType ? "default" : "ghost"}
            onClick={() => setActiveExamType(examType)}
          >
            {examType.toUpperCase()}
          </Button>
        ))}
      </div>

      {!canUseActiveExam ? (
        <Card>
          <CardContent className="p-8 text-center">
            <p className="font-semibold text-navy">
              {examLabel} is not in your exam goals yet.
            </p>
            <p className="mt-2 text-sm text-slate-500">
              Switch exam goals in settings to unlock this practice mode.
            </p>
          </CardContent>
        </Card>
      ) : noWaecSubjects ? (
        <Card>
          <CardContent className="p-8 text-center">
            <p className="font-semibold text-navy">
              No WAEC subjects are available yet.
            </p>
            <p className="mt-2 text-sm text-slate-500">
              Please try again later or contact support if this continues.
            </p>
          </CardContent>
        </Card>
      ) : (
        <div className="grid gap-6 xl:grid-cols-[0.85fr_1.15fr]">
          <Card>
            <CardHeader>
              <CardTitle>Choose subject</CardTitle>
            </CardHeader>
            <CardContent className="space-y-5">
              <div className="grid grid-cols-2 gap-2">
                {subjectsForActiveExam.map((subject) => (
                  <Button
                    key={subject.id}
                    disabled={savingAnswer}
                    variant={
                      selectedSubject.id === subject.id ? "default" : "outline"
                    }
                    onClick={() => {
                      setSelectedSubject(subject);
                      setSelectedTopic(null);
                      setSelectedYear(null);
                    }}
                  >
                    {subject.label}
                  </Button>
                ))}
              </div>

              {activeExamType === "waec" && (
                <div className="space-y-2">
                  <label
                    className="block text-sm font-semibold text-navy"
                    htmlFor="question-source"
                  >
                    Question set
                  </label>
                  <select
                    id="question-source"
                    className="w-full rounded-lg border border-border bg-white px-3 py-2 text-sm dark:border-border-card dark:bg-card-surface dark:text-main"
                    value={selectedSource}
                    disabled={savingAnswer}
                    onChange={(event) => {
                      setSelectedSource(
                        event.target.value as "all" | "original",
                      );
                      setSelectedYear(null);
                      setSelectedTopic(null);
                    }}
                  >
                    <option value="all">All available questions</option>
                    <option value="original">
                      Original syllabus questions only
                    </option>
                  </select>
                </div>
              )}

              {activeExamType === "waec" && selectedSource === "all" && (
                <div className="space-y-2">
                  <label
                    className="block text-sm font-semibold text-navy"
                    htmlFor="practice-year"
                  >
                    Year
                  </label>
                  <select
                    id="practice-year"
                    className="w-full rounded-lg border border-border bg-white px-3 py-2 text-sm dark:border-border-card dark:bg-card-surface dark:text-main"
                    value={selectedYear ?? ""}
                    disabled={savingAnswer}
                    onChange={(event) => {
                      setSelectedTopic(null);
                      setSelectedYear(
                        event.target.value ? Number(event.target.value) : null,
                      );
                    }}
                  >
                    <option value="">
                      All years, including original questions
                    </option>
                    {availableYears.map((year) => (
                      <option key={year} value={year}>
                        {year}
                      </option>
                    ))}
                  </select>
                </div>
              )}

              <div className="rounded-2xl border border-border bg-[#F8FAFC] p-4 space-y-3 dark:border-border-card dark:bg-card-surface">
                <p className="text-sm font-semibold text-navy">
                  Session summary
                </p>
                <div className="flex justify-between text-sm text-slate-600">
                  <span>Questions answered</span>
                  <span className="font-medium">{answered}</span>
                </div>
                <div className="flex justify-between text-sm text-slate-600">
                  <span>Correct</span>
                  <span className="font-medium text-green-600">{score}</span>
                </div>
                <div className="flex justify-between text-sm text-slate-600">
                  <span>Accuracy</span>
                  <span
                    className={cn(
                      "font-medium",
                      accuracy >= 60
                        ? "text-green-600"
                        : accuracy >= 40
                          ? "text-amber-500"
                          : "text-red-500",
                    )}
                  >
                    {answered > 0 ? `${accuracy}%` : "-"}
                  </span>
                </div>
              </div>
            </CardContent>
          </Card>

          <Card>
            <CardHeader>
              <div className="flex items-center justify-between gap-3">
                <CardTitle>{selectedSubject.label} practice</CardTitle>
                <Badge className="border-blue-200 bg-softblue text-primary">
                  {questionIndex + 1} / {questions.length || "-"}
                </Badge>
              </div>
              {selectedTopic && (
                <div className="mt-3 flex flex-wrap items-center justify-between gap-3 rounded-xl border border-blue-200 bg-softblue p-3 text-sm dark:border-blue-500/40 dark:bg-blue-500/10">
                  <span className="font-medium text-main">
                    Focused topic: {cleanTopicLabel(selectedTopic)}
                  </span>
                  <Button
                    size="sm"
                    variant="outline"
                    disabled={savingAnswer}
                    onClick={() => setSelectedTopic(null)}
                  >
                    Show all topics
                  </Button>
                </div>
              )}
              <Progress value={progress} />
            </CardHeader>

            <CardContent className="p-6 pt-0">
              {loading ? (
                <PageSkeleton variant="practice" />
              ) : loadError ? (
                <div className="py-20 text-center space-y-4">
                  <p className="text-lg font-semibold text-navy">
                    Questions could not load
                  </p>
                  <p className="text-sm text-slate-500">{loadError}</p>
                  <Button onClick={loadQuestions}>Try again</Button>
                </div>
              ) : !question ? questions.length === 0 ? (
                <div className="space-y-4 py-20 text-center">
                  <p className="text-lg font-semibold text-navy dark:text-slate-100">
                    {selectedTopic
                      ? `No questions are available for ${cleanTopicLabel(selectedTopic)} right now. Try all topics instead.`
                      : selectedSource === "original" && activeExamType === "waec"
                        ? `No original ${examLabel} questions are available for this subject yet.`
                        : `No ${examLabel} questions are available for this subject${selectedYear ? ` in ${selectedYear}` : ""} yet.`}
                  </p>
                  <Button onClick={loadQuestions}>Try again</Button>
                </div>
              ) : (
                <div className="space-y-6 py-4">
                  <div className="rounded-2xl border border-blue-200 bg-blue-50 p-6 dark:border-blue-500/35 dark:bg-slate-800">
                    <p className="text-xs font-semibold uppercase tracking-wide text-blue-800 dark:text-blue-300">
                      Practice complete · {examLabel}
                    </p>
                    <h2 className="mt-2 text-2xl font-bold text-slate-900 dark:text-slate-100">
                      {selectedSubject.label}{resultYear ? ` · ${resultYear}` : ""}
                    </h2>
                    <div className="mt-5 flex flex-wrap gap-5 text-slate-900 dark:text-slate-100">
                      <div><span className="block text-3xl font-bold">{score}/{answered}</span><span className="text-sm text-slate-700 dark:text-slate-300">Correct answers</span></div>
                      <div><span className="block text-3xl font-bold">{accuracy}%</span><span className="text-sm text-slate-700 dark:text-slate-300">Accuracy</span></div>
                    </div>
                  </div>

                  <section aria-labelledby="practice-review-heading" className="space-y-4">
                    <div>
                      <h3 ref={reviewTopRef} id="practice-review-heading" className="scroll-mt-24 text-xl font-bold text-slate-900 dark:text-slate-100">
                        {wrongQuestions.length === 0 ? "Excellent work — no missed questions" : `You missed ${wrongQuestions.length} question${wrongQuestions.length === 1 ? "" : "s"}`}
                      </h3>
                      <p className="mt-1 text-sm text-slate-700 dark:text-slate-300">
                        {wrongQuestions.length === 0
                          ? "Keep practising to make this knowledge stick."
                          : "Review your answers below to understand what you missed."}
                      </p>
                    </div>
                    {visibleWrongQuestions.map((item, index) => (
                      <div key={item.id} className="rounded-2xl border border-border bg-white p-5 dark:border-border-card dark:bg-card-surface">
                        <p className="text-xs font-semibold text-slate-600 dark:text-slate-300">Missed question {(currentReviewPage - 1) * reviewsPerPage + index + 1}</p>
                        <p className="mt-2 font-semibold text-slate-900 dark:text-slate-100">{item.prompt}</p>
                        <p className="mt-3 text-sm text-red-800 dark:text-red-300">Your answer: {item.options[selectedAnswers[item.id]] ?? selectedAnswers[item.id]}</p>
                        <p className="mt-1 text-sm text-green-800 dark:text-green-300">Correct answer: {item.options[item.correct_answer]}</p>
                        <p className="mt-3 text-sm leading-6 text-slate-700 dark:text-slate-300">{item.explanation}</p>
                        <div className="mt-3"><AIExplanation question={item.prompt} options={item.options} correctAnswer={item.correct_answer} explanation={item.explanation} subject={selectedSubject.label} /></div>
                      </div>
                    ))}
                    {reviewPageCount > 1 && (
                      <nav aria-label="Missed question review pages" className="flex flex-wrap items-center justify-center gap-2">
                        <Button variant="outline" size="sm" aria-label="First review page" disabled={currentReviewPage === 1} onClick={() => goToReviewPage(1)}>«</Button>
                        <Button variant="outline" size="sm" aria-label="Previous review page" disabled={currentReviewPage === 1} onClick={() => goToReviewPage(currentReviewPage - 1)}>‹</Button>
                        {Array.from({ length: reviewPageCount }, (_, index) => index + 1).filter((page) => Math.abs(page - currentReviewPage) <= 2 || page === 1 || page === reviewPageCount).map((page) => (
                          <Button key={page} variant={page === currentReviewPage ? "default" : "outline"} size="sm" aria-label={`Review page ${page}`} aria-current={page === currentReviewPage ? "page" : undefined} onClick={() => goToReviewPage(page)}>{page}</Button>
                        ))}
                        <Button variant="outline" size="sm" aria-label="Next review page" disabled={currentReviewPage === reviewPageCount} onClick={() => goToReviewPage(currentReviewPage + 1)}>›</Button>
                        <Button variant="outline" size="sm" aria-label="Last review page" disabled={currentReviewPage === reviewPageCount} onClick={() => goToReviewPage(reviewPageCount)}>»</Button>
                      </nav>
                    )}
                  </section>

                  {wrongQuestions.length > 0 && <PracticeResultInvitation />}
                  <Button variant="outline" onClick={loadQuestions}>Practice another set</Button>
                </div>
              ) : (
                <AnimatePresence mode="wait" initial={false}>
                  <motion.div
                    key={question.id}
                    initial={
                      reducedMotion
                        ? { opacity: 0 }
                        : { opacity: 0, x: questionDirection * 18 }
                    }
                    animate={{ opacity: 1, x: 0 }}
                    exit={
                      reducedMotion
                        ? { opacity: 0 }
                        : { opacity: 0, x: questionDirection * -18 }
                    }
                    transition={{
                      duration: reducedMotion ? 0.12 : 0.22,
                      ease: [0.22, 1, 0.36, 1],
                    }}
                  >
                    <div className="mb-4 flex gap-2">
                      {question.year && (
                        <Badge className="text-xs">
                          {examLabel} {question.year}
                        </Badge>
                      )}
                      {question.topic && (
                        <Badge className="text-xs">{question.topic}</Badge>
                      )}
                    </div>

                    <p className="text-lg font-semibold leading-8 text-navy md:text-xl">
                      {question.prompt}
                    </p>

                    <Stagger className="mt-6 space-y-3" delay={0.04}>
                      {Object.entries(question.options).map(([key, value]) => (
                        <StaggerItem key={key}>
                          <button
                            className={cn(
                              "flex w-full items-center justify-between rounded-2xl border border-border p-4 text-left text-base font-medium transition hover:border-primary hover:bg-softblue dark:border-border-card dark:bg-card-surface dark:text-main dark:hover:border-blue-500 dark:hover:bg-blue-600/20",
                              selected === key &&
                                !submitted &&
                                "border-primary bg-softblue dark:border-blue-500 dark:bg-blue-600/20",
                              submitted &&
                                key === question.correct_answer &&
                                "border-green-500 bg-green-50 dark:border-green-400 dark:bg-green-500/10",
                              submitted &&
                                selected === key &&
                                key !== question.correct_answer &&
                                "border-red-400 bg-red-50 dark:border-red-400 dark:bg-red-500/10",
                            )}
                            onClick={() => handleSelect(key)}
                          >
                            <span>
                              <span className="mr-3 font-bold text-primary">
                                {key}.
                              </span>
                              {value}
                            </span>
                            {submitted && key === question.correct_answer && (
                              <CheckCircle2 className="h-5 w-5 flex-shrink-0 text-green-500" />
                            )}
                            {submitted &&
                              selected === key &&
                              key !== question.correct_answer && (
                                <XCircle className="h-5 w-5 flex-shrink-0 text-red-500" />
                              )}
                          </button>
                        </StaggerItem>
                      ))}
                    </Stagger>

                    {submitted && (
                      <AnswerFeedback
                        correct={selected === question.correct_answer}
                        className={cn(
                          "mt-5 border p-4",
                          selected === question.correct_answer
                            ? "border-green-200 bg-green-50"
                            : "border-red-200 bg-red-50",
                        )}
                      >
                        <div>
                          <p
                            className={cn(
                              "font-semibold mb-2",
                              selected === question.correct_answer
                                ? "text-green-700"
                                : "text-red-600",
                            )}
                          >
                            {selected === question.correct_answer
                              ? "Correct"
                              : `Incorrect - Answer is ${question.correct_answer}`}
                          </p>
                          <p className="text-sm leading-6 text-slate-600">
                            {question.explanation}
                          </p>
                        </div>
                      </AnswerFeedback>
                    )}

                    {submitted && (
                      <AIExplanation
                        question={question.prompt}
                        options={question.options}
                        correctAnswer={question.correct_answer}
                        explanation={question.explanation}
                        subject={selectedSubject.label}
                      />
                    )}

                    {submitted && <ReportQuestion questionId={question.id} />}

                    <div className="mt-6 flex justify-between gap-3">
                      <Button
                        variant="outline"
                        onClick={previousQuestion}
                        disabled={questionIndex === 0 || savingAnswer}
                      >
                        Previous question
                      </Button>
                      {!submitted ? (
                        <Button
                          disabled={!selected || savingAnswer}
                          onClick={handleSubmit}
                        >
                          {savingAnswer ? "Saving answer..." : "Submit answer"}
                        </Button>
                      ) : (
                        <Button onClick={nextQuestion}>{questionIndex === questions.length - 1 ? "See practice results" : "Next question"}</Button>
                      )}
                    </div>
                    {saveError && (
                      <p
                        role="alert"
                        className="mt-3 text-sm text-red-600 dark:text-red-400"
                      >
                        {saveError}
                      </p>
                    )}
                  </motion.div>
                </AnimatePresence>
              )}
            </CardContent>
          </Card>
        </div>
      )}
    </div>
  );
}
