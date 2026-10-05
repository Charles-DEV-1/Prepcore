import assert from "node:assert/strict";
import test from "node:test";
import {
  isJambEnglishSubject,
  normalizeOnboardingSubjects,
} from "../src/lib/subject-catalogue.ts";

test("normalizes real JAMB and WAEC subjects without duplicating shared names", () => {
  assert.deepEqual(
    normalizeOnboardingSubjects([
      { name: "Biology", exam_type: "JAMB" },
      { name: " biology ", exam_type: "waec" },
      { name: "Government", exam_type: "WAEC" },
      { name: "NECO only", exam_type: "NECO" },
    ]),
    [
      { name: "Biology", exams: ["jamb", "waec"] },
      { name: "Government", exams: ["waec"] },
    ],
  );
});

test("requires the English paper, not Literature in English", () => {
  assert.equal(isJambEnglishSubject("English Language"), true);
  assert.equal(isJambEnglishSubject("Use of English"), true);
  assert.equal(isJambEnglishSubject("Literature in English"), false);
});
