import { createECDH } from "node:crypto";

export type PushType =
  | "streak_reminder"
  | "study_reminder"
  | "study_tip"
  | "news"
  | "announcement"
  | "weekly_summary"
  | "test";

const PUSH_HOSTS = new Set([
  "fcm.googleapis.com",
  "updates.push.services.mozilla.com",
  "android.googleapis.com",
]);

export function isAllowedPushEndpoint(endpoint: string): boolean {
  if (endpoint.length > 2000) return false;
  try {
    const url = new URL(endpoint);
    if (
      url.protocol !== "https:" ||
      url.username ||
      url.password ||
      url.hash ||
      url.port
    ) return false;
    const host = url.hostname.toLowerCase();
    return (
      PUSH_HOSTS.has(host) ||
      host.endsWith(".push.apple.com") ||
      host.endsWith(".notify.windows.com")
    );
  } catch {
    return false;
  }
}

export function isValidPushKey(value: string, expectedBytes: number): boolean {
  if (!/^[A-Za-z0-9_-]+$/.test(value)) return false;
  const decoded = Buffer.from(value, "base64url");
  if (decoded.length !== expectedBytes || decoded.toString("base64url") !== value) return false;
  if (expectedBytes !== 65) return true;
  try {
    const validator = createECDH("prime256v1");
    validator.generateKeys();
    validator.computeSecret(decoded);
    return true;
  } catch {
    return false;
  }
}

const TTL_SECONDS: Record<PushType, number> = {
  streak_reminder: 2 * 60 * 60,
  study_reminder: 6 * 60 * 60,
  study_tip: 12 * 60 * 60,
  news: 24 * 60 * 60,
  announcement: 24 * 60 * 60,
  weekly_summary: 24 * 60 * 60,
  test: 60,
};

export function pushDeliveryPolicy(
  type: PushType,
  now: number,
  requestedExpiry?: string,
) {
  const maximumExpiry = now + TTL_SECONDS[type] * 1000;
  const requestedMs = requestedExpiry ? Date.parse(requestedExpiry) : maximumExpiry;
  if (!Number.isFinite(requestedMs) || requestedMs <= now) return null;
  // The push service must not keep a time-sensitive warning beyond its deadline.
  const expiresAt = Math.min(requestedMs, maximumExpiry);
  const TTL = Math.floor((expiresAt - now) / 1000);
  if (TTL < 1) return null;
  return {
    expiresAt: new Date(expiresAt).toISOString(),
    options: {
      TTL,
      urgency: type === "streak_reminder" ? "high" as const : "normal" as const,
      topic: ["streak_reminder", "study_reminder", "study_tip"].includes(type)
        ? `prepcore-${type.replaceAll("_", "-")}`
        : undefined,
      timeout: 8000,
    },
  };
}
