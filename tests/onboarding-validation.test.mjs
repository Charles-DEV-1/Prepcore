import assert from "node:assert/strict";
import test from "node:test";
import { onboardingSchema } from "../src/lib/validations.ts";

const validPlan = {
  fullName: "Ada",
  examType: "jamb",
  examGoals: ["jamb"],
  subjects: ["Biology"],
  targetScore: null,
  examDate: "",
  referralCode: "",
};

test("onboarding accepts genuinely optional target and date", () => {
  assert.equal(onboardingSchema.safeParse(validPlan).success, true);
});

test("onboarding requires an explicit exam and at least one subject", () => {
  assert.equal(
    onboardingSchema.safeParse({ ...validPlan, examGoals: [] }).success,
    false,
  );
  assert.equal(
    onboardingSchema.safeParse({ ...validPlan, subjects: [] }).success,
    false,
  );
  assert.equal(
    onboardingSchema.safeParse({ ...validPlan, examGoals: ["waec"] }).success,
    false,
  );
});

test("onboarding rejects invalid scores and dates", () => {
  assert.equal(
    onboardingSchema.safeParse({ ...validPlan, targetScore: 401 }).success,
    false,
  );
  assert.equal(
    onboardingSchema.safeParse({ ...validPlan, targetScore: 0 }).success,
    false,
  );
  assert.equal(
    onboardingSchema.safeParse({ ...validPlan, examDate: "2026-02-30" })
      .success,
    false,
  );
  assert.equal(
    onboardingSchema.safeParse({ ...validPlan, examDate: "2026-12-20" })
      .success,
    true,
  );
});

test("onboarding caps the conversational display name", () => {
  assert.equal(
    onboardingSchema.safeParse({ ...validPlan, fullName: "A".repeat(30) })
      .success,
    true,
  );
  assert.equal(
    onboardingSchema.safeParse({ ...validPlan, fullName: "A".repeat(31) })
      .success,
    false,
  );
});
