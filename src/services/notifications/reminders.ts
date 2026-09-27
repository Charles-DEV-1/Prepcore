import { sendWebPush } from "@/lib/notifications";
import { createServiceRoleClient } from "@/services/supabase/admin";
import {
  dueReminder,
  examGoalLabel,
  isTipDue,
  STREAK_WINDOW_MS,
} from "@/services/notifications/policy";

const STUDY_TIPS = [
  {
    title: "A focused 15 minutes counts",
    body: "Choose one weak topic and practise a few questions. Small, regular sessions build exam confidence.",
  },
  {
    title: "Review the reason, not just the answer",
    body: "After a question, check why the correct option works. That is how a mistake becomes progress.",
  },
  {
    title: "Try a quick recall break",
    body: "Close your notes and explain one topic in your own words. Then check what you missed.",
  },
  {
    title: "Use your recent mistakes",
    body: "Revisit a question you missed and solve it again before moving to a new topic.",
  },
  {
    title: "Practise at exam pace",
    body: "Time a short set of questions, then review calmly. Accuracy comes before speed.",
  },
  {
    title: "Keep your goal in sight",
    body: "One short practice session today is a useful step toward your JAMB or WAEC goal.",
  },
  {
    title: "Mix practice with review",
    body: "After several questions, pause and write down the rule or idea you used most.",
  },
  {
    title: "Start with one question",
    body: "If studying feels heavy today, begin with a single question. You can decide what comes next.",
  },
] as const;

type ReminderResult = {
  considered: number;
  sent: number;
  failed: number;
  expired: number;
};

type NotificationResult = ReminderResult;

const CONTENT_COOLDOWN_MS = 12 * 60 * 60 * 1000;
const WEEKLY_SUMMARY_COOLDOWN_MS = 6 * 24 * 60 * 60 * 1000;

async function claimNotificationSlot(
  admin: ReturnType<typeof createServiceRoleClient>,
  userId: string,
  deliveryKey: string,
) {
  const { data, error } = await admin.rpc("claim_notification_frequency_slot", {
    p_user_id: userId,
    p_delivery_key: deliveryKey,
  });
  if (error) throw error;
  return data === true;
}

async function deliverToUser(
  admin: ReturnType<typeof createServiceRoleClient>,
  userId: string,
  payload: Parameters<typeof sendWebPush>[1],
  options: { contentId?: string; source: string; deliveryKey: string },
): Promise<Pick<ReminderResult, "sent" | "failed" | "expired">> {
  const { data: subscriptions, error } = await admin
    .from("push_subscriptions")
    .select("id, endpoint, expiration_time, p256dh, auth")
    .eq("user_id", userId)
    .eq("is_active", true);
  if (error) throw error;
  if (!subscriptions?.length) {
    return { sent: 0, failed: 0, expired: 0 };
  }

  // Keep one of the two daily slots available for an active streak warning.
  // This applies to admin content and summaries as well as automatic tips.
  const { data: streak, error: streakError } = await admin
    .from("streaks")
    .select("current_count, last_activity_at")
    .eq("user_id", userId)
    .maybeSingle();
  if (streakError) throw streakError;
  const activityMs = streak?.last_activity_at
    ? Date.parse(streak.last_activity_at)
    : NaN;
  if (
    payload.type !== "streak_reminder" &&
    streak &&
    streak.current_count > 0 &&
    Number.isFinite(activityMs) &&
    Date.now() - activityMs >= 0 &&
    Date.now() - activityMs < STREAK_WINDOW_MS
  ) {
    const { count, error: countError } = await admin
      .from("notification_delivery_claims")
      .select("id", { count: "exact", head: true })
      .eq("user_id", userId)
      .gt("claimed_at", new Date(Date.now() - STREAK_WINDOW_MS).toISOString());
    if (countError) throw countError;
    if ((count ?? 0) >= 1) return { sent: 0, failed: 0, expired: 0 };
  }

  if (!(await claimNotificationSlot(admin, userId, options.deliveryKey))) {
    return { sent: 0, failed: 0, expired: 0 };
  }

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
          .update({
            is_active: false,
            updated_at: new Date().toISOString(),
          } as never)
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
        error_code:
          `${statusCode}: ${error instanceof Error ? error.message : String(error)}`.slice(
            0,
            500,
          ),
      } as never);
    }
  }
  return { sent, failed, expired };
}

export async function sendDueStreakReminders(): Promise<ReminderResult> {
  const admin = createServiceRoleClient();
  const now = Date.now();
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
      .select("current_count, last_activity_at")
      .eq("user_id", preference.user_id)
      .maybeSingle();
    if (streakError) throw streakError;
    const reminderType = dueReminder(
      streak?.last_activity_at ?? null,
      streak?.current_count ?? 0,
      preference.streak_reminders_enabled,
      preference.study_reminders_enabled,
      now,
    );
    if (!reminderType || !streak?.last_activity_at) continue;
    if (
      preference.last_reminder_sent_at &&
      preference.last_reminder_sent_at >= streak.last_activity_at
    )
      continue;

    considered += 1;
    let goal = "your exam";
    if (reminderType === "streak_reminder") {
      const { data: user, error: userError } = await admin
        .from("users")
        .select("exam_goals")
        .eq("id", preference.user_id)
        .maybeSingle();
      if (userError) throw userError;
      goal = examGoalLabel(user?.exam_goals);
    }
    const payload = {
      title:
        reminderType === "streak_reminder"
          ? "Your study streak is close to ending"
          : "Study reminder",
      body:
        reminderType === "streak_reminder"
          ? `Less than two hours left. A quick practice round protects your streak and keeps ${goal} on track.`
          : "Your Prepcore study session is waiting. Come back for a short practice round.",
      url: "/practice" as const,
      type: reminderType as "streak_reminder" | "study_reminder",
    };
    const delivery = await deliverToUser(admin, preference.user_id, payload, {
      source: "study_reminder",
      deliveryKey: `${reminderType}:${streak.last_activity_at}`,
    });
    sent += delivery.sent;
    failed += delivery.failed;
    expired += delivery.expired;

    if (delivery.sent > 0) {
      await admin
        .from("notification_preferences")
        .update({
          last_reminder_sent_at: new Date().toISOString(),
          updated_at: new Date().toISOString(),
        } as never)
        .eq("user_id", preference.user_id);
    }
  }

  return { considered, sent, failed, expired };
}

export async function sendDueStudyTips(): Promise<NotificationResult> {
  const admin = createServiceRoleClient();
  const now = new Date();
  const { data: preferences, error } = await admin
    .from("notification_preferences")
    .select("user_id, timezone, last_content_notification_sent_at")
    .eq("content_notifications_enabled", true)
    .eq("study_tips_enabled", true);
  if (error) throw error;

  const result: NotificationResult = {
    considered: 0,
    sent: 0,
    failed: 0,
    expired: 0,
  };
  for (const preference of preferences ?? []) {
    const { data: lastTip, error: logError } = await admin
      .from("notification_logs")
      .select("body, sent_at")
      .eq("user_id", preference.user_id)
      .eq("notification_type", "study_tip")
      .eq("delivery_status", "sent")
      .order("sent_at", { ascending: false })
      .limit(1)
      .maybeSingle();
    if (logError) throw logError;
    if (
      !isTipDue(
        now,
        preference.timezone,
        lastTip?.sent_at ?? null,
        preference.last_content_notification_sent_at,
      )
    )
      continue;

    const previousIndex = STUDY_TIPS.findIndex(
      (tip) => tip.body === lastTip?.body,
    );
    const tip = STUDY_TIPS[(previousIndex + 1) % STUDY_TIPS.length];
    result.considered += 1;
    const delivery = await deliverToUser(
      admin,
      preference.user_id,
      {
        ...tip,
        url: "/practice",
        type: "study_tip",
      },
      {
        source: "automatic_study_tip",
        deliveryKey: `study_tip:${new Date(now.getTime()).toISOString().slice(0, 13)}`,
      },
    );
    result.sent += delivery.sent;
    result.failed += delivery.failed;
    result.expired += delivery.expired;
    if (delivery.sent > 0) {
      const { error: updateError } = await admin
        .from("notification_preferences")
        .update({
          last_content_notification_sent_at: now.toISOString(),
        } as never)
        .eq("user_id", preference.user_id);
      if (updateError) throw updateError;
    }
  }
  return result;
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

  const result: NotificationResult = {
    considered: 0,
    sent: 0,
    failed: 0,
    expired: 0,
  };
  // `preferences` is loaded once for this scheduler run. Keep the in-memory
  // state in sync after a delivery so a batch of due announcements cannot send
  // multiple content notifications to the same student before the next run.
  const contentSentUserIds = new Set<string>();
  for (const item of content ?? []) {
    for (const preference of preferences ?? []) {
      const eligible =
        (item.notification_type === "study_tip" &&
          preference.study_tips_enabled) ||
        ((item.notification_type === "news" ||
          item.notification_type === "announcement") &&
          preference.news_notifications_enabled);
      if (!eligible) continue;
      if (contentSentUserIds.has(preference.user_id)) continue;
      if (
        preference.last_content_notification_sent_at &&
        now.getTime() -
          new Date(preference.last_content_notification_sent_at).getTime() <
          CONTENT_COOLDOWN_MS
      )
        continue;

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
        {
          contentId: item.id,
          source: "admin_content",
          deliveryKey: `content:${item.id}`,
        },
      );
      result.sent += delivery.sent;
      result.failed += delivery.failed;
      result.expired += delivery.expired;
      if (delivery.sent > 0) {
        contentSentUserIds.add(preference.user_id);
        await admin
          .from("notification_preferences")
          .update({
            last_content_notification_sent_at: now.toISOString(),
          } as never)
          .eq("user_id", preference.user_id);
      }
    }
  }
  return result;
}

export async function sendDueWeeklySummaries(): Promise<NotificationResult> {
  const admin = createServiceRoleClient();
  const now = new Date();
  if (now.getUTCDay() !== 1)
    return { considered: 0, sent: 0, failed: 0, expired: 0 };
  const { data: preferences, error } = await admin
    .from("notification_preferences")
    .select("user_id, weekly_summary_enabled, last_weekly_summary_sent_at")
    .eq("weekly_summary_enabled", true);
  if (error) throw error;

  const result: NotificationResult = {
    considered: 0,
    sent: 0,
    failed: 0,
    expired: 0,
  };
  const weekAgo = new Date(
    now.getTime() - 7 * 24 * 60 * 60 * 1000,
  ).toISOString();
  for (const preference of preferences ?? []) {
    if (
      preference.last_weekly_summary_sent_at &&
      now.getTime() -
        new Date(preference.last_weekly_summary_sent_at).getTime() <
        WEEKLY_SUMMARY_COOLDOWN_MS
    )
      continue;
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
      {
        source: "weekly_summary",
        deliveryKey: `weekly:${now.toISOString().slice(0, 10)}`,
      },
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
