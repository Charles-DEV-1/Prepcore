import { createRequire } from "node:module";
import { isAllowedPushEndpoint, isValidPushKey } from "../src/lib/push-policy.ts";

const require = createRequire(import.meta.url);
const { loadEnvConfig } = require("@next/env");
const { createClient } = require("@supabase/supabase-js");

loadEnvConfig(process.cwd());

const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
const key = process.env.SUPABASE_SERVICE_ROLE_KEY;
if (!url || !key) {
  throw new Error(
    "Supabase URL and service role key are required in .env.local.",
  );
}

const admin = createClient(url, key, {
  auth: { persistSession: false, autoRefreshToken: false },
});

async function countRows(label, table, applyFilter = (query) => query) {
  const { count, error } = await applyFilter(
    admin.from(table).select("*", { count: "exact", head: true }),
  );
  if (error) throw new Error(`${label}: ${error.code ?? error.message}`);
  console.log(`${label}: ${count ?? 0}`);
}

await countRows("Active push subscriptions", "push_subscriptions", (query) =>
  query.eq("is_active", true),
);
await countRows("Study tip opt-ins", "notification_preferences", (query) =>
  query
    .eq("content_notifications_enabled", true)
    .eq("study_tips_enabled", true),
);
await countRows("Streak warning opt-ins", "notification_preferences", (query) =>
  query.eq("streak_reminders_enabled", true),
);
await countRows(
  "Notification claims in 24h",
  "notification_delivery_claims",
  (query) =>
    query.gte(
      "claimed_at",
      new Date(Date.now() - 24 * 60 * 60 * 1000).toISOString(),
    ),
);

const { data: runs, error: runsError } = await admin
  .from("notification_scheduler_runs")
  .select("started_at, status, sent, failed, error_message")
  .order("started_at", { ascending: false })
  .limit(3);
if (runsError)
  throw new Error(`Scheduler runs: ${runsError.code ?? runsError.message}`);
console.log(
  "Recent scheduler runs:",
  (runs ?? []).map(({ started_at, status, sent, failed, error_message }) => ({
    started_at,
    status,
    sent,
    failed,
    has_error: Boolean(error_message),
  })),
);

const [subscriptionRows, preferenceRows, streakRows, contentRows, recentLogs] =
  await Promise.all([
    admin.from("push_subscriptions").select("user_id, endpoint, p256dh, auth").eq("is_active", true),
    admin
      .from("notification_preferences")
      .select(
        "user_id, study_tips_enabled, content_notifications_enabled, streak_reminders_enabled",
      ),
    admin.from("streaks").select("user_id, current_count, last_activity_at"),
    admin
      .from("notification_content")
      .select("id", { count: "exact", head: true })
      .eq("status", "published")
      .eq("notification_type", "study_tip"),
    admin
      .from("notification_logs")
      .select("notification_type, delivery_status")
      .gte("sent_at", new Date(Date.now() - 48 * 60 * 60 * 1000).toISOString()),
  ]);
for (const [label, response] of [
  ["Subscriptions", subscriptionRows],
  ["Preferences", preferenceRows],
  ["Streaks", streakRows],
  ["Published tips", contentRows],
  ["Recent notification logs", recentLogs],
]) {
  if (response.error)
    throw new Error(
      `${label}: ${response.error.code ?? response.error.message}`,
    );
}

const subscribed = new Set(subscriptionRows.data.map((row) => row.user_id));
console.log("Invalid active push subscriptions:", subscriptionRows.data.filter((row) =>
  !isAllowedPushEndpoint(row.endpoint) ||
  !isValidPushKey(row.p256dh, 65) ||
  !isValidPushKey(row.auth, 16)
).length);
const streaks = new Map(streakRows.data.map((row) => [row.user_id, row]));
const tipSubscribers = preferenceRows.data.filter(
  (row) =>
    row.content_notifications_enabled &&
    row.study_tips_enabled &&
    subscribed.has(row.user_id),
);
const streakSubscribers = preferenceRows.data.filter(
  (row) => row.streak_reminders_enabled && subscribed.has(row.user_id),
);
const nowMs = Date.now();
const dueStreaks = streakSubscribers.filter((row) => {
  const streak = streaks.get(row.user_id);
  if (!streak || streak.current_count <= 0 || !streak.last_activity_at)
    return false;
  const elapsed = nowMs - Date.parse(streak.last_activity_at);
  return elapsed >= 22 * 60 * 60 * 1000 && elapsed < 24 * 60 * 60 * 1000;
});
console.log(
  "Opted-in devices: study tips",
  tipSubscribers.length,
  "streak warnings",
  streakSubscribers.length,
);
console.log("Streaks in warning window now:", dueStreaks.length);
console.log("Published admin study tips:", contentRows.count ?? 0);
console.log(
  "Delivery log counts in 48h:",
  recentLogs.data.reduce((totals, row) => {
    const key = `${row.notification_type}:${row.delivery_status}`;
    totals[key] = (totals[key] ?? 0) + 1;
    return totals;
  }, {}),
);
