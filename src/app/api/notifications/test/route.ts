import { z } from "zod";
import { forbiddenResponse, getAdminSessionUser } from "@/lib/admin-api-auth";
import { sendWebPush } from "@/lib/notifications";
import { hasTrustedOrigin, noStoreJson, readSafeJson } from "@/lib/api-security";
import { createServiceRoleClient } from "@/services/supabase/admin";

const testSchema = z.object({
  userId: z.string().uuid(),
  title: z.string().trim().min(1).max(120).optional(),
  body: z.string().trim().min(1).max(500).optional(),
  url: z.enum(["/dashboard", "/practice"]).optional(),
});

export async function POST(request: Request) {
  if (!(await getAdminSessionUser())) return forbiddenResponse();
  if (!hasTrustedOrigin(request)) return noStoreJson({ error: "Invalid request origin." }, { status: 403 });
  const parsed = testSchema.safeParse(await readSafeJson<unknown>(request));
  if (!parsed.success) return noStoreJson({ error: "A valid userId is required." }, { status: 400 });

  const admin = createServiceRoleClient();
  const { data: subscriptions, error: subscriptionError } = await admin
    .from("push_subscriptions")
    .select("id, endpoint, expiration_time, p256dh, auth, platform")
    .eq("user_id", parsed.data.userId)
    .eq("is_active", true);
  if (subscriptionError) return noStoreJson({ error: "Could not load push subscriptions." }, { status: 500 });
  if (!subscriptions?.length) return noStoreJson({ error: "No active push subscription found for this user." }, { status: 404 });

  const payload = {
    title: parsed.data.title ?? "Prepcore notification test",
    body: parsed.data.body ?? "Your browser push notifications are connected.",
    url: parsed.data.url ?? "/dashboard",
    type: "test" as const,
  };
  let sent = 0;
  let failed = 0;
  for (const subscription of subscriptions) {
    try {
      await sendWebPush({
        endpoint: subscription.endpoint,
        expirationTime: subscription.expiration_time,
        keys: { p256dh: subscription.p256dh, auth: subscription.auth },
      }, payload);
      sent += 1;
      await admin.from("notification_logs").insert({ user_id: parsed.data.userId, subscription_id: subscription.id, notification_type: "test", title: payload.title, body: payload.body, url: payload.url, delivery_status: "sent" } as never);
    } catch (error) {
      failed += 1;
      const statusCode = error && typeof error === "object" && "statusCode" in error ? String(error.statusCode) : "unknown";
      if (statusCode === "404" || statusCode === "410") {
        await admin.from("push_subscriptions").update({ is_active: false, updated_at: new Date().toISOString() } as never).eq("id", subscription.id);
      }
      await admin.from("notification_logs").insert({ user_id: parsed.data.userId, subscription_id: subscription.id, notification_type: "test", title: payload.title, body: payload.body, url: payload.url, delivery_status: statusCode === "404" || statusCode === "410" ? "expired" : "failed", error_code: statusCode } as never);
    }
  }

  return noStoreJson({ success: sent > 0, sent, failed });
}
