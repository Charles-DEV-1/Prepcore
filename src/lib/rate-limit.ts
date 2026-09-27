import { createHmac } from "node:crypto";
import { createServiceRoleClient } from "@/services/supabase/admin";

type RateLimitOptions = {
  key: string;
  limit: number;
  windowMs: number;
};

type RateLimitEntry = {
  count: number;
  resetAt: number;
};

const buckets = new Map<string, RateLimitEntry>();
const MAX_BUCKETS = 10_000;

function cleanupExpiredBuckets(now: number) {
  for (const [key, bucket] of buckets.entries()) {
    if (bucket.resetAt <= now) buckets.delete(key);
  }

  // This is a process-local fallback. Bound its memory so an attacker cannot
  // grow the map indefinitely with unique keys before a shared limiter is set.
  while (buckets.size >= MAX_BUCKETS) {
    const oldestKey = buckets.keys().next().value;
    if (!oldestKey) break;
    buckets.delete(oldestKey);
  }
}

export function rateLimit({ key, limit, windowMs }: RateLimitOptions) {
  if (!Number.isInteger(limit) || limit < 1 || !Number.isFinite(windowMs) || windowMs <= 0) {
    throw new Error("Invalid rate-limit configuration.");
  }
  const now = Date.now();
  cleanupExpiredBuckets(now);

  const existing = buckets.get(key);
  if (!existing || existing.resetAt <= now) {
    const resetAt = now + windowMs;
    buckets.set(key, { count: 1, resetAt });
    return {
      allowed: true,
      remaining: Math.max(0, limit - 1),
      resetAt,
      retryAfterSeconds: 0,
    };
  }

  existing.count += 1;
  const retryAfterSeconds = Math.max(
    1,
    Math.ceil((existing.resetAt - now) / 1000),
  );

  return {
    allowed: existing.count <= limit,
    remaining: Math.max(0, limit - existing.count),
    resetAt: existing.resetAt,
    retryAfterSeconds,
  };
}

export async function sharedRateLimit(options: RateLimitOptions) {
  const local = rateLimit(options);
  if (!local.allowed) return local;

  const secret = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!secret) throw new Error("Shared rate limit is not configured.");
  const bucketHash = createHmac("sha256", secret).update(options.key).digest("hex");
  const { data, error } = await createServiceRoleClient().rpc("claim_api_rate_limit_slot", {
    p_bucket_hash: bucketHash,
    p_max_hits: options.limit,
    p_window_seconds: Math.ceil(options.windowMs / 1000),
  });
  if (error || !data?.[0]) {
    console.error("shared_rate_limit_unavailable", error?.code ?? "empty_response");
    throw new Error("Shared rate limit is unavailable.");
  }
  return {
    allowed: data[0].allowed,
    remaining: data[0].remaining,
    resetAt: Date.now() + data[0].retry_after_seconds * 1000,
    retryAfterSeconds: data[0].retry_after_seconds,
  };
}

export function getClientIp(request: Request) {
  const forwardedFor = process.env.VERCEL
    ? request.headers.get("x-vercel-forwarded-for")
    : request.headers.get("x-forwarded-for");
  if (forwardedFor) return forwardedFor.split(",")[0]?.trim() ?? "unknown";

  return (
    request.headers.get("x-real-ip") ??
    request.headers.get("cf-connecting-ip") ??
    "unknown"
  );
}
