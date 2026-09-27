import assert from "node:assert/strict";
import test from "node:test";
import { dueReminder, examGoalLabel, HOUR_MS, isTipDue } from "./policy.ts";

const now = Date.parse("2026-09-27T12:00:00.000Z");
const activity = (hoursAgo) => new Date(now - hoursAgo * HOUR_MS).toISOString();

test("streak reminder is sent only in the two hours before expiry", () => {
  assert.equal(dueReminder(activity(21.9), 3, true, true, now), null);
  assert.equal(
    dueReminder(activity(22), 3, true, true, now),
    "streak_reminder",
  );
  assert.equal(
    dueReminder(activity(23.9), 3, true, true, now),
    "streak_reminder",
  );
  assert.equal(dueReminder(activity(24), 3, true, false, now), null);
  assert.equal(dueReminder(activity(22.5), 0, true, true, now), null);
  assert.equal(dueReminder(activity(22.5), 3, false, true, now), null);
});

test("inactive users receive the separate study reminder once eligible", () => {
  assert.equal(
    dueReminder(activity(24), 0, false, true, now),
    "study_reminder",
  );
  assert.equal(dueReminder(activity(25), 2, true, true, now), "study_reminder");
  assert.equal(dueReminder(null, 2, true, true, now), null);
  assert.equal(dueReminder(activity(-1), 2, true, true, now), null);
});

test("study tips respect local daytime and a twelve hour cooldown", () => {
  const time = new Date("2026-09-27T08:00:00.000Z");
  assert.equal(isTipDue(time, "Africa/Lagos", null, null), true);
  assert.equal(
    isTipDue(time, "Africa/Lagos", "2026-09-26T20:00:00.000Z", null),
    true,
  );
  assert.equal(
    isTipDue(time, "Africa/Lagos", "2026-09-26T20:01:00.000Z", null),
    false,
  );
  assert.equal(
    isTipDue(time, "Africa/Lagos", null, "2026-09-27T01:00:00.000Z"),
    false,
  );
  assert.equal(
    isTipDue(new Date("2026-09-27T22:00:00.000Z"), "Africa/Lagos", null, null),
    false,
  );
  assert.equal(isTipDue(time, "Invalid/Timezone", null, null), true);
});

test("streak copy uses only the student's supported exam goals", () => {
  assert.equal(examGoalLabel(["jamb"]), "your JAMB goal");
  assert.equal(examGoalLabel(["waec"]), "your WAEC goal");
  assert.equal(examGoalLabel(["jamb", "waec"]), "your JAMB and WAEC goals");
  assert.equal(examGoalLabel(null), "your exam");
});
