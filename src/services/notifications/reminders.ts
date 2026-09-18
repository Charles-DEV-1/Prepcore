import { sendWebPush } from "@/lib/notifications";
import { createServiceRoleClient } from "@/services/supabase/admin";

const INACTIVITY_WINDOW_MS = 24 * 60 * 60 * 1000;

type ReminderResult = {
  considered: number;
  sent: number;
  failed: number;
  expired: number;
};

export async function sendDueStreakReminders(): Promise<ReminderResult> {
  const admin = createServiceRoleClient();
  const cutoff = new Date(Date.now() - INACTIVITY_WINDOW_MS).toISOString();
  const { data: preferences, error: preferencesError } = await admin
    .from("notification_preferences")
    .select(
      "user_id, last_reminder_sent_at, study_reminders_enabled, streak_reminders_enabled",
    )
    .or("study_reminders_enabled.eq.true,streak_reminders_enabled.eq.true");
  if (preferencesError) throw preferencesError;

  let considered = 0;
  let sent = 0;
  let failed = 0;
  let expired = 0;

  for (const preference of preferences ?? []) {
    const { data: streak, error: streakError } = await admin
      .from("streaks")
      .select("last_activity_at")
      .eq("user_id", preference.user_id)
      .maybeSingle();
    if (streakError || !streak?.last_activity_at || streak.last_activity_at > cutoff) continue;
    if (preference.last_reminder_sent_at && preference.last_reminder_sent_at >= streak.last_activity_at) continue;

    considered += 1;
    const { data: subscriptions, error: subscriptionError } = await admin
      .from("push_subscriptions")
      .select("id, endpoint, expiration_time, p256dh, auth")
      .eq("user_id", preference.user_id)
      .eq("is_active", true);
    if (subscriptionError) throw subscriptionError;
    if (!subscriptions?.length) continue;

    const reminderType = preference.streak_reminders_enabled
      ? "streak_reminder"
      : "study_reminder";
    const payload = {
      title:
        reminderType === "streak_reminder"
          ? "Keep your streak alive"
          : "Study reminder",
      body:
        reminderType === "streak_reminder"
          ? "It has been 24 hours since your last study session. Come back and keep going."
          : "Your Prepcore study session is waiting. Come back for a short practice round.",
      url: "/dashboard" as const,
      type: reminderType as "streak_reminder" | "study_reminder",
    };
    let userSent = false;

    for (const subscription of subscriptions) {
      try {
        await sendWebPush({
          endpoint: subscription.endpoint,
          expirationTime: subscription.expiration_time,
          keys: { p256dh: subscription.p256dh, auth: subscription.auth },
        }, payload);
        userSent = true;
        sent += 1;
        await admin.from("notification_logs").insert({
          user_id: preference.user_id,
          subscription_id: subscription.id,
          notification_type: reminderType,
          title: payload.title,
          body: payload.body,
          url: payload.url,
          delivery_status: "sent",
        } as never);
      } catch (error) {
        failed += 1;
        const statusCode = error && typeof error === "object" && "statusCode" in error ? String(error.statusCode) : "unknown";
        const errorMessage = error instanceof Error ? error.message : String(error);
        console.error("notification_delivery_failed", {
          subscriptionId: subscription.id,
          userId: preference.user_id,
          statusCode,
          errorMessage,
        });
        const isExpired = statusCode === "404" || statusCode === "410";
        if (isExpired) {
          expired += 1;
          await admin.from("push_subscriptions").update({ is_active: false, updated_at: new Date().toISOString() } as never).eq("id", subscription.id);
        }
        await admin.from("notification_logs").insert({
          user_id: preference.user_id,
          subscription_id: subscription.id,
          notification_type: reminderType,
          title: payload.title,
          body: payload.body,
          url: payload.url,
          delivery_status: isExpired ? "expired" : "failed",
          error_code: `${statusCode}: ${errorMessage}`.slice(0, 500),
        } as never);
      }
    }

    if (userSent) {
      await admin.from("notification_preferences").update({ last_reminder_sent_at: new Date().toISOString(), updated_at: new Date().toISOString() } as never).eq("user_id", preference.user_id);
    }
  }

  return { considered, sent, failed, expired };
}
