import { z } from "zod";
import { hasTrustedOrigin, noStoreJson, readSafeJson } from "@/lib/api-security";
import { getClientIp, rateLimit } from "@/lib/rate-limit";
import { createServiceRoleClient } from "@/services/supabase/admin";
import { createClient } from "@/services/supabase/server";

const installSchema = z.object({
  installationId: z.string().uuid(),
  platform: z.enum(["android", "ios", "desktop", "unknown"]),
});

export async function POST(request: Request) {
  if (!hasTrustedOrigin(request)) {
    return noStoreJson({ error: "Invalid request origin." }, { status: 403 });
  }

  const limit = rateLimit({
    key: `pwa-install:${getClientIp(request)}`,
    limit: 20,
    windowMs: 60 * 60 * 1000,
  });
  if (!limit.allowed) {
    return noStoreJson(
      { error: "Too many installation events." },
      { status: 429, headers: { "Retry-After": String(limit.retryAfterSeconds) } },
    );
  }

  const parsed = installSchema.safeParse(await readSafeJson<unknown>(request));
  if (!parsed.success) {
    return noStoreJson({ error: "Invalid installation data." }, { status: 400 });
  }

  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  const admin = createServiceRoleClient();
  const { error } = await admin.from("pwa_installations").upsert(
    {
      installation_id: parsed.data.installationId,
      user_id: user?.id ?? null,
      platform: parsed.data.platform,
    } as never,
    { onConflict: "installation_id" },
  );

  if (error) {
    console.error("pwa_installation_tracking_failed", error.code);
    return noStoreJson({ error: "Could not record installation." }, { status: 500 });
  }

  return noStoreJson({ success: true });
}
