import { sendWebPush } from "@/lib/notifications";
import { createServiceRoleClient } from "@/services/supabase/admin";

const INACTIVITY_WINDOW_MS = 24 * 60 * 60 * 1000;

type ReminderResult = {
  considered: number;
  sent: number;
  failed: number;
  expired: number;
};

type NotificationResult = ReminderResult;

const CONTENT_COOLDOWN_MS = 24 * 60 * 60 * 1000;
const WEEKLY_SUMMARY_COOLDOWN_MS = 6 * 24 * 60 * 60 * 1000;

async function deliverToUser(
  admin: ReturnType<typeof createServiceRoleClient>,
  userId: string,
  payload: Parameters<typeof sendWebPush>[1],
  options: { contentId?: string; source: string },
): Promise<Pick<ReminderResult, "sent" | "failed" | "expired">> {
  const { data: subscriptions, error } = await admin
    .from("push_subscriptions")
    .select("id, endpoint, expiration_time, p256dh, auth")
    .eq("user_id", userId)
    .eq("is_active", true);
  if (error) throw error;

  let sent = 0;
  let failed = 0;
  let expired = 0;
  for (const subscription of subscriptions ?? []) {
    try {
      await sendWebPush(
        {
          endpoint: subscription.endpoint,
          expirationTime: subscription.expiration_time,
          keys: { p256dh: subscription.p256dh, auth: subscription.auth },
        },
        payload,
      );
      sent += 1;
      await admin.from("notification_logs").insert({
        user_id: userId,
        subscription_id: subscription.id,
        content_id: options.contentId,
        source: options.source,
        notification_type: payload.type,
        title: payload.title,
        body: payload.body,
        url: payload.url,
        delivery_status: "sent",
      } as never);
    } catch (error) {
      failed += 1;
      const statusCode =
        error && typeof error === "object" && "statusCode" in error
          ? String(error.statusCode)
          : "unknown";
      const isExpired = statusCode === "404" || statusCode === "410";
      if (isExpired) {
        expired += 1;
        await admin
          .from("push_subscriptions")
          .update({ is_active: false, updated_at: new Date().toISOString() } as never)
          .eq("id", subscription.id);
      }
      await admin.from("notification_logs").insert({
        user_id: userId,
        subscription_id: subscription.id,
        content_id: options.contentId,
        source: options.source,
        notification_type: payload.type,
        title: payload.title,
        body: payload.body,
        url: payload.url,
        delivery_status: isExpired ? "expired" : "failed",
        error_code: `${statusCode}: ${error instanceof Error ? error.message : String(error)}`.slice(0, 500),
      } as never);
    }
  }
  return { sent, failed, expired };
}

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

export async function sendDueEngagementNotifications(): Promise<NotificationResult> {
  const admin = createServiceRoleClient();
  const now = new Date();
  const { data: content, error: contentError } = await admin
    .from("notification_content")
    .select("id, notification_type, title, body, url")
    .eq("status", "published")
    .lte("scheduled_at", now.toISOString())
    .or(`expires_at.is.null,expires_at.gt.${now.toISOString()}`)
    .order("scheduled_at", { ascending: true })
    .limit(20);
  if (contentError) throw contentError;

  const { data: preferences, error: preferencesError } = await admin
    .from("notification_preferences")
    .select(
      "user_id, content_notifications_enabled, study_tips_enabled, news_notifications_enabled, last_content_notification_sent_at",
    )
    .eq("content_notifications_enabled", true);
  if (preferencesError) throw preferencesError;

  const result: NotificationResult = { considered: 0, sent: 0, failed: 0, expired: 0 };
  for (const item of content ?? []) {
    for (const preference of preferences ?? []) {
      const eligible =
        (item.notification_type === "study_tip" && preference.study_tips_enabled) ||
        ((item.notification_type === "news" || item.notification_type === "announcement") &&
          preference.news_notifications_enabled);
      if (!eligible) continue;
      if (
        preference.last_content_notification_sent_at &&
        now.getTime() - new Date(preference.last_content_notification_sent_at).getTime() < CONTENT_COOLDOWN_MS
      ) continue;

      const { count: alreadySent } = await admin
        .from("notification_logs")
        .select("id", { count: "exact", head: true })
        .eq("user_id", preference.user_id)
        .eq("content_id", item.id)
        .eq("delivery_status", "sent");
      if ((alreadySent ?? 0) > 0) continue;

      result.considered += 1;
      const delivery = await deliverToUser(
        admin,
        preference.user_id,
        {
          title: item.title,
          body: item.body,
          url: item.url === "/practice" ? "/practice" : "/dashboard",
          type: item.notification_type,
        },
        { contentId: item.id, source: "admin_content" },
      );
      result.sent += delivery.sent;
      result.failed += delivery.failed;
      result.expired += delivery.expired;
      if (delivery.sent > 0) {
        await admin
          .from("notification_preferences")
          .update({ last_content_notification_sent_at: now.toISOString() } as never)
          .eq("user_id", preference.user_id);
      }
    }
  }
  return result;
}

export async function sendDueWeeklySummaries(): Promise<NotificationResult> {
  const admin = createServiceRoleClient();
  const now = new Date();
  if (now.getUTCDay() !== 1) return { considered: 0, sent: 0, failed: 0, expired: 0 };
  const { data: preferences, error } = await admin
    .from("notification_preferences")
    .select("user_id, weekly_summary_enabled, last_weekly_summary_sent_at")
    .eq("weekly_summary_enabled", true);
  if (error) throw error;

  const result: NotificationResult = { considered: 0, sent: 0, failed: 0, expired: 0 };
  const weekAgo = new Date(now.getTime() - 7 * 24 * 60 * 60 * 1000).toISOString();
  for (const preference of preferences ?? []) {
    if (
      preference.last_weekly_summary_sent_at &&
      now.getTime() - new Date(preference.last_weekly_summary_sent_at).getTime() < WEEKLY_SUMMARY_COOLDOWN_MS
    ) continue;
    const { count: sessions } = await admin
      .from("sessions")
      .select("id", { count: "exact", head: true })
      .eq("user_id", preference.user_id)
      .gte("created_at", weekAgo);
    result.considered += 1;
    const delivery = await deliverToUser(
      admin,
      preference.user_id,
      {
        title: "Your Prepcore week",
        body: `You completed ${sessions ?? 0} study session${sessions === 1 ? "" : "s"} this week. Keep your momentum going.`,
        url: "/dashboard",
        type: "weekly_summary",
      },
      { source: "weekly_summary" },
    );
    result.sent += delivery.sent;
    result.failed += delivery.failed;
    result.expired += delivery.expired;
    if (delivery.sent > 0) {
      await admin
        .from("notification_preferences")
        .update({ last_weekly_summary_sent_at: now.toISOString() } as never)
        .eq("user_id", preference.user_id);
    }
  }
  return result;
}
