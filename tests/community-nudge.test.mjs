import assert from "node:assert/strict";
import test from "node:test";
import {
  recordCommunityNudge,
  shouldShowCommunityNudge,
} from "../src/lib/community-nudge.ts";

const day = 24 * 60 * 60 * 1000;
const start = 100 * day;

function memoryStorage() {
  const values = new Map();
  return {
    getItem: (key) => values.get(key) ?? null,
    setItem: (key, value) => values.set(key, value),
  };
}

test("the community nudge waits for a returning dashboard visit", () => {
  const storage = memoryStorage();
  assert.equal(shouldShowCommunityNudge(storage, "student-1", start), false);
  assert.equal(shouldShowCommunityNudge(storage, "student-1", start + day), false);
  assert.equal(shouldShowCommunityNudge(storage, "student-1", start + 2 * day), true);
  assert.equal(shouldShowCommunityNudge(storage, "student-2", start + 2 * day), false);
});

test("it appears at most weekly and a dismissal gives a longer break", () => {
  const storage = memoryStorage();
  shouldShowCommunityNudge(storage, "student", start);
  const firstShow = start + 2 * day;
  recordCommunityNudge(storage, "student", "shown", firstShow);
  assert.equal(shouldShowCommunityNudge(storage, "student", firstShow + 6 * day), false);
  assert.equal(shouldShowCommunityNudge(storage, "student", firstShow + 7 * day), true);

  recordCommunityNudge(storage, "student", "dismissed", firstShow + 7 * day);
  assert.equal(shouldShowCommunityNudge(storage, "student", firstShow + 36 * day), false);
  assert.equal(shouldShowCommunityNudge(storage, "student", firstShow + 37 * day), true);
});

test("opening the group pauses reminders for 90 days", () => {
  const storage = memoryStorage();
  shouldShowCommunityNudge(storage, "student", start);
  const firstShow = start + 2 * day;
  recordCommunityNudge(storage, "student", "shown", firstShow);
  recordCommunityNudge(storage, "student", "opened", firstShow);
  assert.equal(shouldShowCommunityNudge(storage, "student", firstShow + 89 * day), false);
  assert.equal(shouldShowCommunityNudge(storage, "student", firstShow + 90 * day), true);
});
