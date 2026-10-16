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

test("the community update is available on the first dashboard visit", () => {
  const storage = memoryStorage();
  assert.equal(shouldShowCommunityNudge(storage, "student-1", start), true);
  assert.equal(
    shouldShowCommunityNudge(storage, "student-1", start + day),
    true,
  );
  assert.equal(
    shouldShowCommunityNudge(storage, "student-1", start + 2 * day),
    true,
  );
  assert.equal(shouldShowCommunityNudge(storage, "student-2", start), true);
  assert.equal(shouldShowCommunityNudge(storage, "", start), false);
});

test("dismissal hides the update for 30 days and stays account-scoped", () => {
  const storage = memoryStorage();
  recordCommunityNudge(storage, "student", "dismissed", start);
  assert.equal(
    shouldShowCommunityNudge(storage, "student", start + 29 * day),
    false,
  );
  assert.equal(
    shouldShowCommunityNudge(storage, "student", start + 30 * day),
    true,
  );
  assert.equal(
    shouldShowCommunityNudge(storage, "another-student", start),
    true,
  );
});

test("opening the group pauses reminders for 90 days", () => {
  const storage = memoryStorage();
  recordCommunityNudge(storage, "student", "opened", start);
  assert.equal(
    shouldShowCommunityNudge(storage, "student", start + 89 * day),
    false,
  );
  assert.equal(
    shouldShowCommunityNudge(storage, "student", start + 90 * day),
    true,
  );
});

test("the old delayed-toast record cannot hide the new update", () => {
  const storage = memoryStorage();
  storage.setItem(
    "prepcore.community-nudge.v1.student",
    JSON.stringify({
      firstSeenAt: start,
      lastShownAt: start,
      snoozedUntil: start + 90 * day,
    }),
  );
  assert.equal(shouldShowCommunityNudge(storage, "student", start + day), true);
});

test("a new dismissal is respected and corrupt storage is recoverable", () => {
  const storage = memoryStorage();
  storage.setItem(
    "prepcore.community-nudge.v2.student",
    JSON.stringify({
      firstSeenAt: start,
      lastShownAt: start,
      snoozedUntil: start + 30 * day,
    }),
  );
  assert.equal(
    shouldShowCommunityNudge(storage, "student", start + day),
    false,
  );
  storage.setItem("prepcore.community-nudge.v2.student", "not-json");
  assert.equal(shouldShowCommunityNudge(storage, "student", start + day), true);
});
