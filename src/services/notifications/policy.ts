export const HOUR_MS = 60 * 60 * 1000;
export const STREAK_WINDOW_MS = 24 * HOUR_MS;
export const STREAK_WARNING_START_MS = 22 * HOUR_MS;
export const STUDY_TIP_COOLDOWN_MS = 12 * HOUR_MS;

export function dueReminder(
  lastActivityAt: string | null,
  currentCount: number,
  streakEnabled: boolean,
  studyEnabled: boolean,
  nowMs: number,
): "streak_reminder" | "study_reminder" | null {
  if (!lastActivityAt) return null;
  const activityMs = Date.parse(lastActivityAt);
  if (!Number.isFinite(activityMs)) return null;
  const elapsed = nowMs - activityMs;
  if (elapsed < 0) return null;
  if (
    streakEnabled &&
    currentCount > 0 &&
    elapsed >= STREAK_WARNING_START_MS &&
    elapsed < STREAK_WINDOW_MS
  ) {
    return "streak_reminder";
  }
  if (studyEnabled && elapsed >= STREAK_WINDOW_MS) return "study_reminder";
  return null;
}

export function isTipDue(
  now: Date,
  timezone: string,
  lastTipSentAt: string | null,
  lastContentSentAt: string | null,
) {
  let hour: number;
  try {
    hour = Number(
      new Intl.DateTimeFormat("en-GB", {
        hour: "2-digit",
        hourCycle: "h23",
        timeZone: timezone,
      }).format(now),
    );
  } catch {
    hour = Number(
      new Intl.DateTimeFormat("en-GB", {
        hour: "2-digit",
        hourCycle: "h23",
        timeZone: "Africa/Lagos",
      }).format(now),
    );
  }
  if (hour < 8 || hour >= 21) return false;
  return [lastTipSentAt, lastContentSentAt].every((timestamp) => {
    if (!timestamp) return true;
    const sentAt = Date.parse(timestamp);
    return (
      Number.isFinite(sentAt) && now.getTime() - sentAt >= STUDY_TIP_COOLDOWN_MS
    );
  });
}

export function examGoalLabel(goals: unknown) {
  if (!Array.isArray(goals)) return "your exam";
  const hasJamb = goals.includes("jamb");
  const hasWaec = goals.includes("waec");
  if (hasJamb && hasWaec) return "your JAMB and WAEC goals";
  if (hasJamb) return "your JAMB goal";
  if (hasWaec) return "your WAEC goal";
  return "your exam";
}
