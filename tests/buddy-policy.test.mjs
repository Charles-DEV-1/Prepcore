import assert from "node:assert/strict";
import test from "node:test";
import { buddyPlacementForPath } from "../src/components/buddy/buddy-policy.ts";

test("buddy appears only on pages with dedicated slots", () => {
  assert.equal(buddyPlacementForPath("/dashboard")?.mode, "wander");
  assert.equal(buddyPlacementForPath("/progress")?.mode, "quiet");
  assert.equal(buddyPlacementForPath("/results/a-session")?.mode, "react");
  assert.equal(buddyPlacementForPath("/flashcards")?.mode, "quiet");
  assert.equal(buddyPlacementForPath("/profile")?.mode, "quiet");
});

test("buddy stays off focused, input-heavy, and unrelated routes", () => {
  for (const path of [
    "/practice",
    "/exam",
    "/diagnostic/test",
    "/settings",
    "/admin",
    "/onboarding",
    "/upgrade",
  ]) {
    assert.equal(buddyPlacementForPath(path), null, path);
  }
});
