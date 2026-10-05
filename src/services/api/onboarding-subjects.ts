"use client";

import { createClient } from "@/services/supabase/client";
import { normalizeOnboardingSubjects } from "@/lib/subject-catalogue";
import type { OnboardingSubject } from "@/lib/subject-catalogue";
export type { OnboardingSubject } from "@/lib/subject-catalogue";

// The catalogue is public, but a failed read must not be mistaken for an
// empty catalogue and quietly replaced with hard-coded subjects.
export async function getOnboardingSubjects(): Promise<OnboardingSubject[]> {
  const { data, error } = await createClient()
    .from("subjects")
    .select("name, exam_type")
    .order("name", { ascending: true });

  if (error) throw new Error("Subjects could not load. Please try again.");

  return normalizeOnboardingSubjects(data ?? []);
}
