"use client";

import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { useRouter } from "next/navigation";
import { useMutation } from "@tanstack/react-query";
import { zodResolver } from "@hookform/resolvers/zod";
import { AnimatePresence, motion, useReducedMotion } from "framer-motion";
import { ArrowRight, Check, ChevronLeft, Loader2 } from "lucide-react";
import { useForm, useWatch } from "react-hook-form";
import {
  OnboardingBuddy,
  type OnboardingBuddyPose,
} from "@/components/buddy/onboarding-buddy";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { getReferralCookie } from "@/lib/referral";
import { isJambEnglishSubject } from "@/lib/subject-catalogue";
import { clearUserReferralCode } from "@/lib/user-referral-storage";
import { onboardingSchema, type OnboardingValues } from "@/lib/validations";
import { completeOnboarding } from "@/services/api/profile";
import {
  getOnboardingSubjects,
  type OnboardingSubject,
} from "@/services/api/onboarding-subjects";
import { getSubjectsByExamType } from "@/services/api/questions";
import {
  clearLocalOnboardingDraft,
  loadLocalOnboardingDraft,
  parseOnboardingDraft,
  saveLocalOnboardingDraft,
  saveRemoteOnboardingDraft,
  type Confidence,
  type OnboardingDraft,
} from "@/services/api/onboarding-draft";
import {
  applyAnyReferralCode,
  applyReferralFromCookie,
  getMyReferral,
  referralErrorMessage,
  type UserReferral,
} from "@/services/api/referral";
import { createClient } from "@/services/supabase/client";
import type { ExamGoal, ExamType } from "@/types/app";

type Step = 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8;
type BuddyLine = { message: string; pose: OnboardingBuddyPose };

const initialValues: OnboardingValues = {
  fullName: "",
  examType: "jamb",
  examGoals: [],
  subjects: [],
  targetScore: null,
  examDate: "",
  referralCode: "",
};
const noSubjects: string[] = [];

const examOptions: {
  label: string;
  goals: ExamGoal;
  primary: ExamType;
  subtitle: string;
}[] = [
  {
    label: "JAMB",
    goals: ["jamb"],
    primary: "jamb",
    subtitle: "CBT-style practice",
  },
  {
    label: "WAEC",
    goals: ["waec"],
    primary: "waec",
    subtitle: "Past-question review",
  },
  {
    label: "Both",
    goals: ["jamb", "waec"],
    primary: "jamb",
    subtitle: "One plan for both exams",
  },
];

const stepTitles: Record<Step, string> = {
  1: "Your name",
  2: "Your exam",
  3: "Your exam date",
  4: "Your course",
  5: "Your subjects",
  6: "Your confidence",
  7: "Your study time",
  8: "Your plan",
};

function lagosDate(timestamp: number) {
  return new Date(timestamp + 60 * 60 * 1000).toISOString().slice(0, 10);
}

function nextStep(step: Step, hasJamb: boolean): Step {
  if (step === 3 && !hasJamb) return 5;
  return Math.min(step + 1, 8) as Step;
}

function previousStep(step: Step, hasJamb: boolean): Step {
  if (step === 5 && !hasJamb) return 3;
  return Math.max(step - 1, 1) as Step;
}

function defaultLine(step: Step, name: string, returning: boolean): BuddyLine {
  const firstName = name.trim().split(/\s+/)[0] || "friend";
  const lines: Record<Step, BuddyLine> = {
    1: {
      message: returning
        ? `Welcome back! I'll help you finish your plan.`
        : "Hey, I'm Booky! I'll set up your study plan. What should I call you?",
      pose: "wave",
    },
    2: {
      message: `Which exam are you preparing for, ${firstName}?`,
      pose: "thinking",
    },
    3: {
      message: "When is your exam? It's okay if you don't know yet.",
      pose: "thinking",
    },
    4: {
      message: "What course are you aiming for? You can skip this for now.",
      pose: "thinking",
    },
    5: {
      message: "Which subjects should I put in your study plan?",
      pose: "thinking",
    },
    6: {
      message:
        "How do you feel about these subjects? This helps me pick a starting point.",
      pose: "thinking",
    },
    7: {
      message: "How much study time can you manage on a typical day?",
      pose: "thinking",
    },
    8: {
      message: `Your plan is ready, ${firstName}! Let's try five real questions.`,
      pose: "celebrating",
    },
  };
  return lines[step];
}

export function OnboardingForm() {
  const router = useRouter();
  const reducedMotion = Boolean(useReducedMotion());
  const [step, setStep] = useState<Step>(1);
  const [ready, setReady] = useState(false);
  const [userId, setUserId] = useState<string | null>(null);
  const [returning, setReturning] = useState(false);
  const [catalogue, setCatalogue] = useState<OnboardingSubject[]>([]);
  const [catalogueStatus, setCatalogueStatus] = useState<
    "loading" | "loaded" | "error"
  >("loading");
  const [existingReferral, setExistingReferral] = useState<UserReferral | null>(
    null,
  );
  const [course, setCourse] = useState("");
  const [confidence, setConfidence] = useState<Record<string, Confidence>>({});
  const [dailyMinutes, setDailyMinutes] = useState<30 | 60 | 120 | null>(null);
  const [line, setLine] = useState<BuddyLine | null>(null);
  const [transitioning, setTransitioning] = useState(false);
  const [syncWarning, setSyncWarning] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [subjectSearch, setSubjectSearch] = useState("");
  const [todayMs, setTodayMs] = useState<number | null>(null);
  const saveQueue = useRef<Promise<void>>(Promise.resolve());
  const headingRef = useRef<HTMLHeadingElement>(null);
  const transitionTimer = useRef<ReturnType<typeof setTimeout> | null>(null);

  const form = useForm<OnboardingValues>({
    resolver: zodResolver(onboardingSchema),
    defaultValues: initialValues,
  });
  const selectedGoals =
    useWatch({ control: form.control, name: "examGoals" }) ?? [];
  const selectedSubjects =
    useWatch({ control: form.control, name: "subjects" }) ?? noSubjects;
  const selectedGoalsKey = JSON.stringify(selectedGoals);
  const selectedSubjectsKey = JSON.stringify(selectedSubjects);
  const fullName = useWatch({ control: form.control, name: "fullName" }) ?? "";
  const examDate = useWatch({ control: form.control, name: "examDate" }) ?? "";
  const hasJamb = selectedGoals.includes("jamb");
  const activeSteps = useMemo<Step[]>(
    () => (hasJamb ? [1, 2, 3, 4, 5, 6, 7, 8] : [1, 2, 3, 5, 6, 7, 8]),
    [hasJamb],
  );
  const englishSubject = catalogue.find(
    (item) => item.exams.includes("jamb") && isJambEnglishSubject(item.name),
  );
  useEffect(() => {
    if (
      hasJamb &&
      englishSubject &&
      !selectedSubjects.includes(englishSubject.name)
    ) {
      form.setValue(
        "subjects",
        [
          englishSubject.name,
          ...selectedSubjects.filter((name) => !isJambEnglishSubject(name)),
        ].slice(0, 4),
        { shouldDirty: true },
      );
    }
  }, [englishSubject, form, hasJamb, selectedSubjects]);
  const availableSubjects = catalogue.filter((item) =>
    item.exams.includes(hasJamb ? "jamb" : "waec"),
  );
  const visibleSubjects = availableSubjects.filter((item) =>
    item.name
      .toLocaleLowerCase()
      .includes(subjectSearch.trim().toLocaleLowerCase()),
  );
  const maxSubjects = hasJamb ? 4 : 9;
  const subjectCountIsValid = hasJamb
    ? selectedSubjects.length === 4 &&
      Boolean(englishSubject && selectedSubjects.includes(englishSubject.name))
    : selectedSubjects.length >= 1 && selectedSubjects.length <= 9;

  const loadSubjects = useCallback(async () => {
    setCatalogueStatus("loading");
    try {
      setCatalogue(await getOnboardingSubjects());
      setCatalogueStatus("loaded");
    } catch {
      setCatalogueStatus("error");
    }
  }, []);

  useEffect(() => {
    void loadSubjects();
  }, [loadSubjects]);
  useEffect(() => {
    setTodayMs(Date.now());
  }, []);
  useEffect(() => {
    let active = true;
    void (async () => {
      const client = createClient();
      const {
        data: { user: verifiedUser },
      } = await client.auth.getUser();
      const user =
        verifiedUser ?? (await client.auth.getSession()).data.session?.user;
      if (!active) return;
      if (!user) {
        router.replace("/login");
        return;
      }
      setUserId(user.id);
      const remote = parseOnboardingDraft(
        user.user_metadata?.prepcore_onboarding_draft,
      );
      const local = loadLocalOnboardingDraft(user.id);
      const draft =
        local && (!remote || local.updatedAt >= remote.updatedAt)
          ? local
          : remote;
      if (draft) {
        form.reset(draft.values);
        setCourse(draft.course);
        setConfidence(draft.confidence);
        setDailyMinutes(draft.dailyMinutes);
        setStep(
          draft.step === 4 && !draft.values.examGoals.includes("jamb")
            ? 5
            : (draft.step as Step),
        );
        setReturning(draft.step > 1);
      } else {
        const name = user.user_metadata?.full_name;
        if (typeof name === "string")
          form.setValue("fullName", name.slice(0, 30));
      }
      setReady(true);
    })();
    return () => {
      active = false;
    };
  }, [form, router]);

  useEffect(() => {
    void (async () => {
      try {
        await applyReferralFromCookie();
        const referral = await getMyReferral();
        if (referral) {
          setExistingReferral(referral);
          return;
        }
      } catch {
        /* An optional code can still be entered at the end. */
      }
      const cookieCode = getReferralCookie();
      if (cookieCode && !form.getValues("referralCode"))
        form.setValue("referralCode", cookieCode);
    })();
  }, [form]);

  useEffect(() => {
    headingRef.current?.focus();
  }, [step]);
  useEffect(
    () => () => {
      if (transitionTimer.current) clearTimeout(transitionTimer.current);
    },
    [],
  );
  useEffect(() => {
    function retry() {
      if (!userId) return;
      const draft = loadLocalOnboardingDraft(userId);
      if (draft)
        saveQueue.current = saveQueue.current
          .catch(() => {})
          .then(() =>
            saveRemoteOnboardingDraft(draft)
              .then(() => setSyncWarning(false))
              .catch(() => setSyncWarning(true)),
          );
    }
    window.addEventListener("online", retry);
    return () => window.removeEventListener("online", retry);
  }, [userId]);

  const persist = useCallback(
    (
      next: Step,
      changes?: Partial<
        Pick<OnboardingDraft, "course" | "confidence" | "dailyMinutes">
      >,
    ) => {
      if (!userId) return;
      const draft: OnboardingDraft = {
        version: 1,
        updatedAt: Date.now(),
        step: next,
        values: form.getValues(),
        course: changes?.course ?? course,
        confidence: changes?.confidence ?? confidence,
        dailyMinutes: changes?.dailyMinutes ?? dailyMinutes,
      };
      saveLocalOnboardingDraft(userId, draft);
      saveQueue.current = saveQueue.current
        .catch(() => {})
        .then(async () => {
          try {
            await saveRemoteOnboardingDraft(draft);
            setSyncWarning(false);
          } catch {
            setSyncWarning(true);
          }
        });
    },
    [userId, form, course, confidence, dailyMinutes],
  );

  useEffect(() => {
    if (!ready || !userId || transitioning || step === 8) return;
    const timer = window.setTimeout(() => persist(step), 500);
    return () => window.clearTimeout(timer);
  }, [
    ready,
    userId,
    transitioning,
    step,
    persist,
    fullName,
    examDate,
    selectedGoalsKey,
    selectedSubjectsKey,
  ]);

  function advance(
    reaction: BuddyLine,
    changes?: Partial<
      Pick<OnboardingDraft, "course" | "confidence" | "dailyMinutes">
    >,
  ) {
    if (transitioning) return;
    const next = nextStep(step, hasJamb);
    setError(null);
    setLine(reaction);
    setTransitioning(true);
    persist(next, changes);
    transitionTimer.current = setTimeout(
      () => {
        setStep(next);
        setLine(null);
        setTransitioning(false);
      },
      reducedMotion ? 850 : 1550,
    );
  }

  function back() {
    if (transitioning || step === 1) return;
    setError(null);
    setLine(null);
    const previous = previousStep(step, hasJamb);
    setStep(previous);
    persist(previous);
  }

  function chooseExam(goals: ExamGoal, primary: ExamType) {
    if (selectedGoals.join(",") !== goals.join(",")) {
      const english = catalogue.find(
        (item) =>
          item.exams.includes("jamb") && isJambEnglishSubject(item.name),
      );
      form.setValue(
        "subjects",
        goals.includes("jamb") && english ? [english.name] : [],
        { shouldDirty: true },
      );
      setConfidence({});
    }
    form.setValue("examGoals", goals, {
      shouldValidate: true,
      shouldDirty: true,
    });
    form.setValue("examType", primary, {
      shouldValidate: true,
      shouldDirty: true,
    });
    if (!goals.includes("jamb")) form.setValue("targetScore", null);
  }

  function toggleSubject(name: string) {
    if (hasJamb && isJambEnglishSubject(name)) return;
    const next = selectedSubjects.includes(name)
      ? selectedSubjects.filter((item) => item !== name)
      : [...selectedSubjects, name];
    if (next.length > maxSubjects) return;
    form.setValue("subjects", next, {
      shouldDirty: true,
      shouldValidate: true,
    });
    if (!next.includes(name))
      setConfidence((current) => {
        const copy = { ...current };
        delete copy[name];
        return copy;
      });
  }

  async function continueStep() {
    if (transitioning) return;
    const name = fullName.trim().split(/\s+/)[0] || "friend";
    if (step === 1) {
      if (!(await form.trigger("fullName"))) return;
      advance({ message: `Nice to meet you, ${name}!`, pose: "cheering" });
    } else if (step === 2) {
      if (!(await form.trigger(["examGoals", "examType"]))) return;
      advance({
        message: `${selectedGoals.map((goal) => goal.toUpperCase()).join(" and ")} it is. Let's get started.`,
        pose: "cheering",
      });
    } else if (step === 3) {
      if (
        examDate &&
        (!(await form.trigger("examDate")) || examDate < lagosDate(Date.now()))
      ) {
        setError(
          "That date has passed or is invalid. Pick a future date, or choose 'I'm not sure yet'.",
        );
        return;
      }
      const days = examDate
        ? Math.max(
            0,
            Math.ceil(
              (new Date(`${examDate}T00:00:00Z`).getTime() - Date.now()) /
                86400000,
            ),
          )
        : null;
      advance({
        message:
          days === null
            ? "No problem. I'll keep your plan flexible."
            : days < 14
              ? "Not long to go. Let's focus on practice."
              : `About ${Math.ceil(days / 7)} weeks to go. We'll take it step by step.`,
        pose: "encouraging",
      });
    } else if (step === 4) {
      if (course.trim().length > 100) {
        setError("Keep the course name under 100 characters.");
        return;
      }
      advance({
        message: course.trim()
          ? `${course.trim()} sounds like a goal worth working toward.`
          : "That's fine. You can decide on a course later.",
        pose: "encouraging",
      });
    } else if (step === 5) {
      if (
        catalogueStatus !== "loaded" ||
        !subjectCountIsValid ||
        !(await form.trigger("subjects"))
      ) {
        setError(
          hasJamb
            ? "Choose English and exactly three other JAMB subjects."
            : "Choose between one and nine WAEC subjects.",
        );
        return;
      }
      advance({
        message: "Locked in. I know where to start now.",
        pose: "cheering",
      });
    } else if (step === 6) {
      const weak = selectedSubjects.find(
        (subject) => confidence[subject] === "weak",
      );
      advance({
        message: weak
          ? `Got it. We'll begin with ${weak}, one question at a time.`
          : "Great. Your first answers will tell me what to revisit.",
        pose: "encouraging",
      });
    } else if (step === 7) {
      if (dailyMinutes === null) setDailyMinutes(60);
      advance(
        {
          message:
            dailyMinutes === 30
              ? "Small and steady works. Let's make every minute count."
              : dailyMinutes === null
                ? "I'll start with one hour a day. You can change that later."
                : "That sounds doable. Consistency matters most.",
          pose: "cheering",
        },
        dailyMinutes === null ? { dailyMinutes: 60 } : undefined,
      );
    }
  }

  const finishMutation = useMutation({
    mutationFn: async (destination: "practice" | "dashboard") => {
      setError(null);
      if (!userId || !subjectCountIsValid || !(await form.trigger()))
        throw new Error("Please check your plan before finishing.");
      const values = form.getValues();
      const allowed = new Set(availableSubjects.map((subject) => subject.name));
      if (
        catalogueStatus !== "loaded" ||
        !values.subjects.every((subject) => allowed.has(subject))
      )
        throw new Error(
          "Your subjects are no longer available. Go back and choose again.",
        );
      if (!existingReferral && values.referralCode.trim()) {
        const result = await applyAnyReferralCode(values.referralCode);
        if (!result.success)
          throw new Error(referralErrorMessage(result.error));
      }
      await saveQueue.current;
      let practicePath = "/dashboard";
      if (destination === "practice") {
        const candidates = await getSubjectsByExamType(
          createClient(),
          values.examType,
        );
        const ranked = [...values.subjects].sort(
          (a, b) =>
            Number(confidence[b] === "weak") - Number(confidence[a] === "weak"),
        );
        const subject =
          ranked
            .map((name) =>
              candidates.find(
                (item) =>
                  item.name.toLocaleLowerCase() === name.toLocaleLowerCase() &&
                  item.question_count >= 5,
              ),
            )
            .find(Boolean) ??
          ranked
            .map((name) =>
              candidates.find(
                (item) =>
                  item.name.toLocaleLowerCase() === name.toLocaleLowerCase(),
              ),
            )
            .find(Boolean);
        if (!subject)
          throw new Error(
            "I couldn't find a practice subject yet. Please try again or go to your dashboard.",
          );
        practicePath = `/practice?intro=1&exam=${values.examType}&subject=${encodeURIComponent(subject.id)}`;
      }
      // Preferences are self-editable study context, not an entitlement or trusted grade.
      const { error: metadataError } = await createClient().auth.updateUser({
        data: {
          prepcore_study_preferences: {
            course: course.trim() || null,
            confidence,
            dailyMinutes: dailyMinutes ?? 60,
          },
        },
      });
      if (metadataError)
        throw new Error(
          "Your study preferences could not sync. Please try again.",
        );
      await completeOnboarding(values);
      // Completion is already durable; a failed draft cleanup must not undo it.
      await createClient().auth.updateUser({
        data: { prepcore_onboarding_draft: null },
      });
      clearLocalOnboardingDraft(userId);
      clearUserReferralCode();
      return practicePath;
    },
    onSuccess: (path) => router.replace(path),
    onError: (reason: Error) => setError(reason.message),
  });

  const buddy = line ?? defaultLine(step, fullName, returning);
  const progressIndex = activeSteps.indexOf(step) + 1;
  const daysToExam =
    examDate && todayMs !== null
      ? Math.max(
          0,
          Math.ceil(
            (new Date(`${examDate}T00:00:00Z`).getTime() - todayMs) / 86400000,
          ),
        )
      : null;
  const focus =
    selectedSubjects.find((subject) => confidence[subject] === "weak") ??
    selectedSubjects[0];

  if (!ready || todayMs === null)
    return (
      <div
        className="mx-auto max-w-xl p-8 text-center text-slate-700 dark:text-slate-300"
        role="status"
      >
        <Loader2 className="mx-auto mb-2 h-5 w-5 animate-spin" />
        Loading your study plan…
      </div>
    );

  return (
    <div className="mx-auto max-w-2xl space-y-4 text-slate-900 dark:text-slate-100">
      <header className="space-y-2">
        <p className="text-xs font-bold uppercase tracking-[0.18em] text-blue-800 dark:text-blue-200">
          Prepcore setup
        </p>
        <div className="flex items-center justify-between gap-3 text-sm font-semibold">
          <span>
            Step {progressIndex} of {activeSteps.length}
          </span>
          <span>{stepTitles[step]}</span>
        </div>
        <div
          role="progressbar"
          aria-valuenow={progressIndex}
          aria-valuemin={1}
          aria-valuemax={activeSteps.length}
          aria-label="Onboarding progress"
          className="h-2 overflow-hidden rounded-full bg-slate-200 dark:bg-slate-700"
        >
          <div
            className="h-full rounded-full bg-blue-600 transition-[width] duration-300 dark:bg-blue-400"
            style={{ width: `${(progressIndex / activeSteps.length) * 100}%` }}
          />
        </div>
      </header>
      <Card className="border-slate-200 bg-white shadow-soft dark:border-border-card dark:bg-card-surface">
        <CardContent className="space-y-5 p-4 sm:p-7">
          <OnboardingBuddy message={buddy.message} pose={buddy.pose} />
          <AnimatePresence mode="wait" initial={false}>
            <motion.div
              key={step}
              initial={reducedMotion ? false : { opacity: 0, x: 12 }}
              animate={{ opacity: 1, x: 0 }}
              exit={reducedMotion ? undefined : { opacity: 0, x: -12 }}
              transition={{ duration: reducedMotion ? 0 : 0.2 }}
              className="space-y-5"
            >
              <div>
                <h1
                  ref={headingRef}
                  tabIndex={-1}
                  className="text-xl font-bold outline-none sm:text-2xl"
                >
                  {stepTitles[step]}
                </h1>
                <p className="mt-1 text-sm text-slate-700 dark:text-slate-300">
                  {step === 1
                    ? "So I know what to call you."
                    : step === 2
                      ? "This decides which questions I can give you."
                      : step === 3
                        ? "This helps me pace your plan."
                        : step === 4
                          ? "A course gives your studying a direction. You'll choose your own subjects."
                          : step === 5
                            ? "Choose the subjects you want to practise first."
                            : step === 6
                              ? "Your first practice set can begin with a subject you find difficult."
                              : step === 7
                                ? "Pick a realistic pace. You can change it later."
                                : "Your plan will get smarter as you practise."}
                </p>
              </div>

              {step === 1 && (
                <div className="space-y-2">
                  <Label htmlFor="fullName">What should I call you?</Label>
                  <Input
                    id="fullName"
                    autoComplete="name"
                    maxLength={30}
                    placeholder="Your preferred name"
                    aria-invalid={Boolean(form.formState.errors.fullName)}
                    {...form.register("fullName")}
                  />
                  {form.formState.errors.fullName && (
                    <p
                      role="alert"
                      className="text-sm text-red-700 dark:text-red-300"
                    >
                      {form.formState.errors.fullName.message}
                    </p>
                  )}
                </div>
              )}

              {step === 2 && (
                <div className="grid gap-2 sm:grid-cols-3">
                  {examOptions.map((option) => {
                    const selected =
                      selectedGoals.join(",") === option.goals.join(",");
                    return (
                      <button
                        key={option.label}
                        type="button"
                        aria-pressed={selected}
                        onClick={() => chooseExam(option.goals, option.primary)}
                        className={`rounded-xl border p-4 text-left transition focus-visible:outline focus-visible:outline-2 focus-visible:outline-blue-600 ${selected ? "border-blue-600 bg-blue-50 dark:border-blue-400 dark:bg-blue-950/40" : "border-slate-300 hover:border-blue-500 dark:border-slate-600 dark:bg-slate-800"}`}
                      >
                        <span className="block font-bold">{option.label}</span>
                        <span className="mt-1 block text-sm text-slate-700 dark:text-slate-300">
                          {option.subtitle}
                        </span>
                      </button>
                    );
                  })}
                  <p className="sm:col-span-3 text-xs text-slate-600 dark:text-slate-300">
                    NECO practice is not available yet, so I won&apos;t promise
                    questions I can&apos;t show you.
                  </p>
                  {form.formState.errors.examGoals && (
                    <p
                      role="alert"
                      className="text-sm text-red-700 dark:text-red-300 sm:col-span-3"
                    >
                      {form.formState.errors.examGoals.message}
                    </p>
                  )}
                </div>
              )}

              {step === 3 && (
                <div className="space-y-3">
                  <Label htmlFor="examDate">Exam date (optional)</Label>
                  <Input
                    id="examDate"
                    type="date"
                    min={lagosDate(todayMs)}
                    aria-invalid={Boolean(
                      form.formState.errors.examDate || error,
                    )}
                    {...form.register("examDate")}
                  />
                  <Button
                    type="button"
                    variant="outline"
                    onClick={() => {
                      form.setValue("examDate", "");
                      advance({
                        message: "No problem. I'll keep your plan flexible.",
                        pose: "encouraging",
                      });
                    }}
                  >
                    I&apos;m not sure yet
                  </Button>
                  {form.formState.errors.examDate && (
                    <p
                      role="alert"
                      className="text-sm text-red-700 dark:text-red-300"
                    >
                      {form.formState.errors.examDate.message}
                    </p>
                  )}
                </div>
              )}

              {step === 4 && (
                <div className="space-y-2">
                  <Label htmlFor="course">
                    Course you&apos;re aiming for (optional)
                  </Label>
                  <Input
                    id="course"
                    value={course}
                    maxLength={100}
                    onChange={(event) => setCourse(event.target.value)}
                    placeholder="e.g. Medicine"
                    autoComplete="off"
                  />
                  <p className="text-xs text-slate-600 dark:text-slate-300">
                    I won&apos;t guess your required subject combination. Check
                    your chosen institution&apos;s current requirements.
                  </p>
                </div>
              )}

              {step === 5 && (
                <div className="space-y-3">
                  <div className="flex flex-wrap items-center justify-between gap-2">
                    <p className="font-semibold">
                      {hasJamb
                        ? `${selectedSubjects.length} of 4 chosen`
                        : `${selectedSubjects.length} of up to 9 chosen`}
                    </p>
                    <p className="text-sm text-slate-700 dark:text-slate-300">
                      {hasJamb ? "English + 3 others" : "Choose at least one"}
                    </p>
                  </div>
                  {selectedGoals.length > 1 && (
                    <p className="text-sm text-slate-700 dark:text-slate-300">
                      Start with your four JAMB subjects. Your WAEC question
                      catalogue stays available in Practice.
                    </p>
                  )}
                  {catalogueStatus === "loading" && (
                    <p
                      role="status"
                      className="flex items-center gap-2 text-sm"
                    >
                      <Loader2 className="h-4 w-4 animate-spin" />
                      Loading subjects…
                    </p>
                  )}
                  {catalogueStatus === "error" && (
                    <div role="alert" className="space-y-2">
                      <p>Subjects could not load.</p>
                      <Button
                        type="button"
                        variant="outline"
                        onClick={() => void loadSubjects()}
                      >
                        Retry
                      </Button>
                    </div>
                  )}
                  {catalogueStatus === "loaded" &&
                    availableSubjects.length === 0 && (
                      <p role="alert">
                        No subjects are available for this exam right now.
                        Please try again later.
                      </p>
                    )}
                  {catalogueStatus === "loaded" &&
                    hasJamb &&
                    !englishSubject && (
                      <p
                        role="alert"
                        className="text-sm text-red-700 dark:text-red-300"
                      >
                        English Language is missing from the current JAMB
                        catalogue. Please contact support.
                      </p>
                    )}
                  {catalogueStatus === "loaded" &&
                    availableSubjects.length > 0 && (
                      <>
                        <Label htmlFor="subjectSearch">Search subjects</Label>
                        <Input
                          id="subjectSearch"
                          value={subjectSearch}
                          onChange={(event) =>
                            setSubjectSearch(event.target.value)
                          }
                          placeholder="Find a subject"
                        />
                        <div
                          role="group"
                          aria-label="Available subjects"
                          className="grid gap-2 sm:grid-cols-2"
                        >
                          {visibleSubjects.map((subject) => {
                            const selected = selectedSubjects.includes(
                              subject.name,
                            );
                            const locked =
                              hasJamb && isJambEnglishSubject(subject.name);
                            return (
                              <label
                                key={subject.name}
                                className={`flex cursor-pointer items-center gap-3 rounded-xl border p-3 text-sm ${selected ? "border-blue-600 bg-blue-50 dark:border-blue-400 dark:bg-blue-950/40" : "border-slate-300 dark:border-slate-600 dark:bg-slate-800"}`}
                              >
                                <input
                                  type="checkbox"
                                  checked={selected}
                                  disabled={
                                    locked ||
                                    (!selected &&
                                      selectedSubjects.length >= maxSubjects)
                                  }
                                  onChange={() => toggleSubject(subject.name)}
                                  className="h-4 w-4 accent-blue-600"
                                />
                                <span className="font-medium">
                                  {subject.name}
                                  {locked ? " · required" : ""}
                                </span>
                              </label>
                            );
                          })}
                        </div>
                        {visibleSubjects.length === 0 && (
                          <p className="text-sm">
                            No subjects match that search.
                          </p>
                        )}
                      </>
                    )}
                  {error && (
                    <p
                      role="alert"
                      className="text-sm text-red-700 dark:text-red-300"
                    >
                      {error}
                    </p>
                  )}
                </div>
              )}

              {step === 6 && (
                <div className="space-y-4">
                  {selectedSubjects.map((subject) => (
                    <fieldset
                      key={subject}
                      className="space-y-2 rounded-xl border border-slate-200 p-3 dark:border-slate-700"
                    >
                      <legend className="px-1 font-semibold">{subject}</legend>
                      <div className="flex flex-wrap gap-2">
                        {(["strong", "okay", "weak"] as const).map((rating) => (
                          <button
                            key={rating}
                            type="button"
                            aria-pressed={confidence[subject] === rating}
                            onClick={() =>
                              setConfidence((current) => ({
                                ...current,
                                [subject]: rating,
                              }))
                            }
                            className={`rounded-lg border px-4 py-2 text-sm capitalize focus-visible:outline focus-visible:outline-2 focus-visible:outline-blue-600 ${confidence[subject] === rating ? "border-blue-600 bg-blue-50 font-semibold dark:border-blue-400 dark:bg-blue-950/40" : "border-slate-300 dark:border-slate-600"}`}
                          >
                            {rating}
                          </button>
                        ))}
                      </div>
                    </fieldset>
                  ))}
                </div>
              )}

              {step === 7 && (
                <div className="grid gap-2 sm:grid-cols-3">
                  {([30, 60, 120] as const).map((minutes) => (
                    <button
                      key={minutes}
                      type="button"
                      aria-pressed={dailyMinutes === minutes}
                      onClick={() => setDailyMinutes(minutes)}
                      className={`rounded-xl border p-4 text-left font-semibold focus-visible:outline focus-visible:outline-2 focus-visible:outline-blue-600 ${dailyMinutes === minutes ? "border-blue-600 bg-blue-50 dark:border-blue-400 dark:bg-blue-950/40" : "border-slate-300 dark:border-slate-600 dark:bg-slate-800"}`}
                    >
                      {minutes === 30
                        ? "30 minutes"
                        : minutes === 60
                          ? "1 hour"
                          : "2+ hours"}
                    </button>
                  ))}
                </div>
              )}

              {step === 8 && (
                <div className="space-y-4">
                  <div className="rounded-2xl border border-blue-200 bg-blue-50 p-4 dark:border-blue-500/40 dark:bg-blue-950/30">
                    <p className="font-semibold">
                      {selectedGoals
                        .map((goal) => goal.toUpperCase())
                        .join(" + ")}{" "}
                      study plan
                    </p>
                    <p className="mt-2 text-sm">
                      {selectedSubjects.join(", ")}
                    </p>
                    <p className="mt-2 text-sm">
                      {daysToExam !== null
                        ? `${daysToExam} days until your exam`
                        : "Flexible exam date"}{" "}
                      · {dailyMinutes ?? 60} minutes a day
                    </p>
                    {focus && (
                      <p className="mt-2 text-sm font-medium">
                        First focus: {focus} — five real questions to begin.
                      </p>
                    )}
                    {course.trim() && (
                      <p className="mt-2 text-sm">Goal: {course.trim()}</p>
                    )}
                  </div>
                  {!existingReferral ? (
                    <div className="space-y-2">
                      <Label htmlFor="referralCode">
                        Have a referral code? (optional)
                      </Label>
                      <Input
                        id="referralCode"
                        placeholder="Friend or centre code"
                        {...form.register("referralCode")}
                      />
                      {form.formState.errors.referralCode && (
                        <p
                          role="alert"
                          className="text-sm text-red-700 dark:text-red-300"
                        >
                          {form.formState.errors.referralCode.message}
                        </p>
                      )}
                    </div>
                  ) : (
                    <p className="flex items-center gap-2 text-sm text-green-800 dark:text-green-300">
                      <Check className="h-4 w-4" />
                      Referred by {existingReferral.partner_name}
                    </p>
                  )}
                </div>
              )}

              {error && step !== 5 && (
                <p
                  role="alert"
                  className="rounded-xl border border-red-300 bg-red-50 p-3 text-sm text-red-900 dark:border-red-700 dark:bg-red-950/40 dark:text-red-100"
                >
                  {error}
                </p>
              )}
              {syncWarning && (
                <p
                  role="status"
                  className="text-xs text-amber-800 dark:text-amber-300"
                >
                  Saved on this device. I&apos;ll sync your progress when the
                  connection returns.
                </p>
              )}
              <div className="sticky bottom-0 z-10 -mx-4 flex items-center gap-2 border-t border-slate-200 bg-white/95 px-4 pb-3 pt-4 backdrop-blur dark:border-slate-700 dark:bg-card-surface/95 sm:mx-0 sm:px-0">
                {step > 1 && (
                  <Button
                    type="button"
                    variant="outline"
                    disabled={transitioning || finishMutation.isPending}
                    onClick={back}
                  >
                    <ChevronLeft className="h-4 w-4" />
                    Back
                  </Button>
                )}
                {step < 8 ? (
                  <Button
                    type="button"
                    className="flex-1"
                    disabled={
                      transitioning ||
                      (step === 5 &&
                        (catalogueStatus !== "loaded" || !subjectCountIsValid))
                    }
                    onClick={() => void continueStep()}
                  >
                    {transitioning ? "Booky is thinking…" : "Continue"}
                    <ArrowRight className="h-4 w-4" />
                  </Button>
                ) : (
                  <Button
                    type="button"
                    className="flex-1"
                    disabled={finishMutation.isPending}
                    onClick={() => finishMutation.mutate("practice")}
                  >
                    {finishMutation.isPending && (
                      <Loader2 className="h-4 w-4 animate-spin" />
                    )}
                    Start my first 5 questions
                    <ArrowRight className="h-4 w-4" />
                  </Button>
                )}
              </div>
              {([4, 6, 7] as Step[]).includes(step) && (
                <button
                  type="button"
                  disabled={transitioning}
                  onClick={() => {
                    const changes =
                      step === 4
                        ? { course: "" }
                        : step === 6
                          ? { confidence: {} }
                          : { dailyMinutes: 60 as const };
                    if (step === 4) setCourse("");
                    if (step === 6) setConfidence({});
                    if (step === 7) setDailyMinutes(60);
                    advance(
                      {
                        message: "No problem. We can adjust your plan later.",
                        pose: "encouraging",
                      },
                      changes,
                    );
                  }}
                  className="block w-full rounded-lg py-2 text-center text-sm font-medium text-blue-800 underline-offset-4 hover:underline dark:text-blue-200"
                >
                  Skip for now
                </button>
              )}
              {step === 8 && (
                <Button
                  type="button"
                  variant="ghost"
                  className="w-full"
                  disabled={finishMutation.isPending}
                  onClick={() => finishMutation.mutate("dashboard")}
                >
                  Go to my dashboard instead
                </Button>
              )}
            </motion.div>
          </AnimatePresence>
        </CardContent>
      </Card>
    </div>
  );
}
