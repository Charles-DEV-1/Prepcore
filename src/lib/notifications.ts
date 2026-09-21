import webpush from "web-push";

let configured = false;

function configureWebPush() {
  if (configured) return;
  const publicKey = process.env.NEXT_PUBLIC_WEB_PUSH_PUBLIC_KEY;
  const privateKey = process.env.WEB_PUSH_PRIVATE_KEY;
  const subject = process.env.WEB_PUSH_SUBJECT;
  if (!publicKey || !privateKey || !subject) {
    throw new Error("Web Push VAPID environment variables are not configured.");
  }
  webpush.setVapidDetails(subject, publicKey, privateKey);
  configured = true;
}

export type PushPayload = {
  title: string;
  body: string;
  url: "/dashboard" | "/practice";
  type:
    | "streak_reminder"
    | "study_reminder"
    | "study_tip"
    | "news"
    | "announcement"
    | "weekly_summary"
    | "test";
};

export async function sendWebPush(
  subscription: {
    endpoint: string;
    expirationTime: number | null;
    keys: { p256dh: string; auth: string };
  },
  payload: PushPayload,
) {
  configureWebPush();
  return webpush.sendNotification(subscription, JSON.stringify(payload));
}
