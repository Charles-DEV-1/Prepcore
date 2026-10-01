import { getClientIp, sharedRateLimit } from "@/lib/rate-limit";
import {
  hasTrustedOrigin,
  noStoreJson,
  readSafeJson,
} from "@/lib/api-security";
import { createClient } from "@/services/supabase/server";
import { verifyAndActivatePaymentByReference } from "@/services/payments/payment-service";

export const runtime = "nodejs";
export const maxDuration = 60;

export async function POST(request: Request) {
  if (!hasTrustedOrigin(request)) {
    return noStoreJson(
      { success: false, error: "Invalid request origin." },
      { status: 403 },
    );
  }
  const body = await readSafeJson<{ tx_ref?: string }>(request);
  const txRef = body?.tx_ref;

  if (!txRef) {
    return noStoreJson(
      { success: false, error: "Missing tx_ref." },
      { status: 400 },
    );
  }
  if (typeof txRef !== "string" || txRef.length > 120) {
    return noStoreJson(
      { success: false, error: "Invalid payment reference." },
      { status: 400 },
    );
  }

  try {
    const ip = getClientIp(request);
    const ipLimit = await sharedRateLimit({
      key: `payments:verify:ip:${ip}`,
      limit: 30,
      windowMs: 10 * 60 * 1000,
    });

    if (!ipLimit.allowed) {
      return noStoreJson(
        { success: false, error: "Too many verification attempts." },
        {
          status: 429,
          headers: { "Retry-After": String(ipLimit.retryAfterSeconds) },
        },
      );
    }

    const supabase = await createClient();
    const {
      data: { user },
      error: userError,
    } = await supabase.auth.getUser();

    if (userError || !user) {
      return noStoreJson(
        { success: false, error: "Unauthorized" },
        { status: 401 },
      );
    }

    const userLimit = await sharedRateLimit({
      key: `payments:verify:user:${user.id}`,
      limit: 10,
      windowMs: 10 * 60 * 1000,
    });

    if (!userLimit.allowed) {
      return noStoreJson(
        { success: false, error: "Too many verification attempts." },
        {
          status: 429,
          headers: { "Retry-After": String(userLimit.retryAfterSeconds) },
        },
      );
    }

    const result = await verifyAndActivatePaymentByReference(txRef, user.id);
    return noStoreJson(result, {
      status: result.state === "failed" ? 400 : 200,
    });
  } catch (error) {
    console.error("payments_verify_route_failed", error);
    return noStoreJson(
      { success: false, error: "Could not verify payment." },
      { status: 500 },
    );
  }
}
