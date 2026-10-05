import type { ExamType } from "@/types/app";

export type OnboardingSubject = {
  name: string;
  exams: ExamType[];
};

export function isJambEnglishSubject(name: string): boolean {
  return /^(?:use of )?english(?: language)?$/i.test(name.trim());
}

export function normalizeOnboardingSubjects(
  rows: Array<{ name: string; exam_type: string }>,
): OnboardingSubject[] {
  const byName = new Map<string, OnboardingSubject>();
  for (const row of rows) {
    const exam = String(row.exam_type).toLowerCase();
    const name = row.name.trim();
    if (!name || (exam !== "jamb" && exam !== "waec")) continue;
    const key = name.toLocaleLowerCase();
    const entry = byName.get(key) ?? { name, exams: [] };
    if (!entry.exams.includes(exam)) entry.exams.push(exam);
    byName.set(key, entry);
  }
  return [...byName.values()].sort((a, b) => a.name.localeCompare(b.name));
}
