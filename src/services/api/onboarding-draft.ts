"use client";

import { createClient } from "@/services/supabase/client";
import type { OnboardingValues } from "@/lib/validations";

export type Confidence = "strong" | "okay" | "weak";

export type OnboardingDraft = {
  version: 1;
  updatedAt: number;
  step: number;
  values: OnboardingValues;
  course: string;
  confidence: Record<string, Confidence>;
  dailyMinutes: 30 | 60 | 120 | null;
};

const localKey = (userId: string) => `prepcore:onboarding:v1:${userId}`;

export function parseOnboardingDraft(value: unknown): OnboardingDraft | null {
  if (!value || typeof value !== "object") return null;
  const draft = value as Partial<OnboardingDraft>;
  const v = draft.values as Partial<OnboardingValues> | undefined;
  if (
    draft.version !== 1 ||
    !Number.isFinite(draft.updatedAt) ||
    !Number.isInteger(draft.step) ||
    (draft.step ?? 0) < 1 ||
    (draft.step ?? 0) > 8 ||
    !v ||
    typeof v.fullName !== "string" ||
    v.fullName.length > 80 ||
    (v.examType !== "jamb" && v.examType !== "waec") ||
    !Array.isArray(v.examGoals) ||
    v.examGoals.length > 2 ||
    !v.examGoals.every((goal) => goal === "jamb" || goal === "waec") ||
    !Array.isArray(v.subjects) ||
    v.subjects.length > 20 ||
    !v.subjects.every(
      (subject) => typeof subject === "string" && subject.length <= 120,
    ) ||
    typeof v.examDate !== "string" ||
    v.examDate.length > 10 ||
    typeof v.referralCode !== "string" ||
    v.referralCode.length > 80 ||
    (v.targetScore !== null &&
      (typeof v.targetScore !== "number" || !Number.isFinite(v.targetScore))) ||
    typeof draft.course !== "string" ||
    draft.course.length > 100 ||
    !draft.confidence ||
    typeof draft.confidence !== "object" ||
    Object.keys(draft.confidence).length > 20 ||
    !Object.values(draft.confidence).every((rating) =>
      ["strong", "okay", "weak"].includes(rating),
    ) ||
    (draft.dailyMinutes !== null &&
      draft.dailyMinutes !== 30 &&
      draft.dailyMinutes !== 60 &&
      draft.dailyMinutes !== 120)
  )
    return null;
  return draft as OnboardingDraft;
}

export function loadLocalOnboardingDraft(
  userId: string,
): OnboardingDraft | null {
  try {
    return parseOnboardingDraft(
      JSON.parse(localStorage.getItem(localKey(userId)) ?? "null"),
    );
  } catch {
    return null;
  }
}

export function saveLocalOnboardingDraft(
  userId: string,
  draft: OnboardingDraft,
) {
  try {
    localStorage.setItem(localKey(userId), JSON.stringify(draft));
  } catch {
    // Browser storage can be unavailable; the authenticated copy is still attempted.
  }
}

export function clearLocalOnboardingDraft(userId: string) {
  try {
    localStorage.removeItem(localKey(userId));
  } catch {}
}

export async function saveRemoteOnboardingDraft(draft: OnboardingDraft) {
  const { error } = await createClient().auth.updateUser({
    data: { prepcore_onboarding_draft: draft },
  });
  if (error) throw error;
}
