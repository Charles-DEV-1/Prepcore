import assert from "node:assert/strict";
import test from "node:test";
import { buildStudyRecommendations } from "../src/lib/study-recommendations.ts";

const now = new Date("2026-09-29T12:00:00Z");
const answer = (
  questionId,
  topic,
  correct,
  answeredAt = "2026-09-28T12:00:00Z",
) => ({
  questionId,
  subjectId: "subject-1",
  subject: "Biology",
  topic,
  correct,
  answeredAt,
});

test("prioritises a confirmed weak topic with transparent evidence", () => {
  const result = buildStudyRecommendations(
    [
      answer("1", "Cell Structure", false),
      answer("2", "Cell Structure", false),
      answer("3", "Cell Structure", true),
    ],
    now,
  );
  assert.equal(result[0].kind, "focus");
  assert.equal(result[0].accuracy, 33);
  assert.match(result[0].reason, /missed 2 of 3/);
});

test("does not turn one miss into a confident weakness", () => {
  const result = buildStudyRecommendations(
    [answer("1", "Ecology", false)],
    now,
  );
  assert.equal(result[0].kind, "check");
  assert.match(result[0].reason, /confirm/);
});

test("counts the latest attempt per question only", () => {
  const result = buildStudyRecommendations(
    [
      answer("1", "Transport", false, "2026-09-27T12:00:00Z"),
      answer("1", "Transport", true, "2026-09-28T12:00:00Z"),
    ],
    now,
  );
  assert.deepEqual(result, []);
});

test("offers a refresh after two weeks without calling it weakness", () => {
  const old = "2026-09-01T12:00:00Z";
  const result = buildStudyRecommendations(
    [
      answer("1", "Genetics", true, old),
      answer("2", "Genetics", true, old),
      answer("3", "Genetics", true, old),
    ],
    now,
  );
  assert.equal(result[0].kind, "refresh");
});

test("rejects imported prompts masquerading as topics", () => {
  const result = buildStudyRecommendations(
    [answer("1", "These questions are based on the following passage", false)],
    now,
  );
  assert.deepEqual(result, []);
});
