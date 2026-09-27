import webpush from "web-push";
import { isAllowedPushEndpoint, pushDeliveryPolicy, type PushType } from "@/lib/push-policy";

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
  type: PushType;
  expiresAt?: string;
};

export async function sendWebPush(
  subscription: {
    endpoint: string;
    expirationTime: number | null;
    keys: { p256dh: string; auth: string };
  },
  payload: PushPayload,
) {
  if (!isAllowedPushEndpoint(subscription.endpoint)) {
    throw Object.assign(new Error("Untrusted push endpoint."), { statusCode: "invalid_endpoint" });
  }
  const policy = pushDeliveryPolicy(payload.type, Date.now(), payload.expiresAt);
  if (!policy) return null;
  configureWebPush();
  return webpush.sendNotification(
    subscription,
    JSON.stringify({ ...payload, expiresAt: policy.expiresAt }),
    policy.options,
  );
}
