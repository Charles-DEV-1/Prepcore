import { z } from "zod";
import { hasTrustedOrigin, noStoreJson, readSafeJson } from "@/lib/api-security";
import { getClientIp, rateLimit } from "@/lib/rate-limit";
import { createClient } from "@/services/supabase/server";

const subscriptionSchema = z.object({
  endpoint: z.string().url().max(2000),
  expirationTime: z.number().int().nonnegative().nullable(),
  keys: z.object({
    p256dh: z.string().min(1).max(500),
    auth: z.string().min(1).max(500),
  }),
  platform: z.enum(["android", "ios", "desktop", "unknown"]),
});

async function getAuthenticatedClient(request: Request) {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return { supabase, user: null };
  const limit = rateLimit({
    key: `notifications:subscription:${user.id}:${getClientIp(request)}`,
    limit: 20,
    windowMs: 60 * 60 * 1000,
  });
  if (!limit.allowed) return { supabase, user, retryAfterSeconds: limit.retryAfterSeconds };
  return { supabase, user };
}

export async function POST(request: Request) {
  if (!hasTrustedOrigin(request)) return noStoreJson({ error: "Invalid request origin." }, { status: 403 });
  const { supabase, user, retryAfterSeconds } = await getAuthenticatedClient(request);
  if (!user) return noStoreJson({ error: "Unauthorized." }, { status: 401 });
  if (retryAfterSeconds !== undefined) return noStoreJson({ error: "Too many subscription changes." }, { status: 429, headers: { "Retry-After": String(retryAfterSeconds) } });
  const body = await readSafeJson<unknown>(request);
  const parsed = subscriptionSchema.safeParse(body);
  if (!parsed.success) return noStoreJson({ error: "Invalid push subscription." }, { status: 400 });

  const { data, error } = await supabase.from("push_subscriptions").upsert({
    user_id: user.id,
    endpoint: parsed.data.endpoint,
    expiration_time: parsed.data.expirationTime,
    p256dh: parsed.data.keys.p256dh,
    auth: parsed.data.keys.auth,
    platform: parsed.data.platform,
    is_active: true,
    updated_at: new Date().toISOString(),
  } as never, { onConflict: "endpoint" }).select("id, endpoint, platform, is_active").single();
  if (error) return noStoreJson({ error: "Could not save push subscription." }, { status: 500 });
  return noStoreJson({ success: true, subscription: data });
}

export async function DELETE(request: Request) {
  if (!hasTrustedOrigin(request)) return noStoreJson({ error: "Invalid request origin." }, { status: 403 });
  const { supabase, user, retryAfterSeconds } = await getAuthenticatedClient(request);
  if (!user) return noStoreJson({ error: "Unauthorized." }, { status: 401 });
  if (retryAfterSeconds !== undefined) return noStoreJson({ error: "Too many subscription changes." }, { status: 429, headers: { "Retry-After": String(retryAfterSeconds) } });
  const body = await readSafeJson<unknown>(request);
  const parsed = z.object({ endpoint: z.string().url().max(2000) }).safeParse(body);
  if (!parsed.success) return noStoreJson({ error: "A valid endpoint is required." }, { status: 400 });
  const { error } = await supabase.from("push_subscriptions").update({ is_active: false, updated_at: new Date().toISOString() } as never).eq("user_id", user.id).eq("endpoint", parsed.data.endpoint);
  if (error) return noStoreJson({ error: "Could not remove push subscription." }, { status: 500 });
  return noStoreJson({ success: true });
}
