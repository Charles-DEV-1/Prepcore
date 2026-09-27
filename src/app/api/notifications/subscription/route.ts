import { z } from "zod";
import { hasTrustedOrigin, noStoreJson, readSafeJson } from "@/lib/api-security";
import { sharedRateLimit } from "@/lib/rate-limit";
import { isAllowedPushEndpoint, isValidPushKey } from "@/lib/push-policy";
import { createClient } from "@/services/supabase/server";

const subscriptionSchema = z.object({
  endpoint: z.string().url().max(2000).refine(isAllowedPushEndpoint),
  expirationTime: z.number().int().safe().nonnegative().nullable(),
  keys: z.object({
    p256dh: z.string().max(100).refine((value) => isValidPushKey(value, 65)),
    auth: z.string().max(100).refine((value) => isValidPushKey(value, 16)),
  }),
  platform: z.enum(["android", "ios", "desktop", "unknown"]),
});

async function getAuthenticatedClient() {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user) return { supabase, user: null };
  const limit = await sharedRateLimit({
    // The account identifier is stable across instances and client IP changes.
    key: `notifications:subscription:${user.id}`,
    limit: 20,
    windowMs: 60 * 60 * 1000,
  });
  if (!limit.allowed) return { supabase, user, retryAfterSeconds: limit.retryAfterSeconds };
  return { supabase, user };
}

export async function POST(request: Request) {
  if (!hasTrustedOrigin(request)) return noStoreJson({ error: "Invalid request origin." }, { status: 403 });
  const { supabase, user, retryAfterSeconds } = await getAuthenticatedClient();
  if (!user) return noStoreJson({ error: "Unauthorized." }, { status: 401 });
  if (retryAfterSeconds !== undefined) return noStoreJson({ error: "Too many subscription changes." }, { status: 429, headers: { "Retry-After": String(retryAfterSeconds) } });
  const body = await readSafeJson<unknown>(request);
  const parsed = subscriptionSchema.safeParse(body);
  if (!parsed.success) return noStoreJson({ error: "Invalid push subscription." }, { status: 400 });

  const { data: existing, error: existingError } = await supabase
    .from("push_subscriptions")
    .select("id, is_active")
    .eq("user_id", user.id)
    .eq("endpoint", parsed.data.endpoint)
    .maybeSingle();
  if (existingError) return noStoreJson({ error: "Could not check push subscription." }, { status: 500 });
  if (!existing?.is_active) {
    const { count, error: countError } = await supabase
      .from("push_subscriptions")
      .select("id", { count: "exact", head: true })
      .eq("user_id", user.id)
      .eq("is_active", true);
    if (countError) return noStoreJson({ error: "Could not check push subscriptions." }, { status: 500 });
    if ((count ?? 0) >= 5) return noStoreJson({ error: "This account already has five active devices. Remove one before adding another." }, { status: 409 });
  }

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
  const { supabase, user, retryAfterSeconds } = await getAuthenticatedClient();
  if (!user) return noStoreJson({ error: "Unauthorized." }, { status: 401 });
  if (retryAfterSeconds !== undefined) return noStoreJson({ error: "Too many subscription changes." }, { status: 429, headers: { "Retry-After": String(retryAfterSeconds) } });
  const body = await readSafeJson<unknown>(request);
  const parsed = z.object({ endpoint: z.string().url().max(2000) }).safeParse(body);
  if (!parsed.success) return noStoreJson({ error: "A valid endpoint is required." }, { status: 400 });
  const { error } = await supabase.from("push_subscriptions").update({ is_active: false, updated_at: new Date().toISOString() } as never).eq("user_id", user.id).eq("endpoint", parsed.data.endpoint);
  if (error) return noStoreJson({ error: "Could not remove push subscription." }, { status: 500 });
  return noStoreJson({ success: true });
}
