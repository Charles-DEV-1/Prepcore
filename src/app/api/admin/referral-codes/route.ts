import { forbiddenResponse, getAdminSessionUser } from "@/lib/admin-api-auth";
import { hasTrustedOrigin, noStoreJson, readSafeJson } from "@/lib/api-security";
import { normalizeReferralCode } from "@/lib/referral";
import { createServiceRoleClient } from "@/services/supabase/admin";
import { NextRequest, NextResponse } from "next/server";
import { z } from "zod";

const createCodeSchema = z.object({
  partner_id: z.string().uuid(),
  code: z.string().trim().min(1).max(64).regex(/^[A-Za-z0-9_-]+$/),
  label: z.string().trim().max(100).nullable().optional(),
  is_active: z.boolean().optional(),
  expires_at: z.string().datetime().nullable().optional(),
  max_uses: z.number().int().positive().nullable().optional(),
}).strict();

export async function POST(request: NextRequest) {
  if (!hasTrustedOrigin(request)) return noStoreJson({ error: "Invalid request origin." }, { status: 403 });
  if (!(await getAdminSessionUser())) return forbiddenResponse();

  const parsed = createCodeSchema.safeParse(await readSafeJson<unknown>(request));
  if (!parsed.success) return noStoreJson({ error: "Invalid referral code details." }, { status: 400 });
  const body = parsed.data;
  const partnerId = body.partner_id;
  const code = normalizeReferralCode(body.code);

  const admin = createServiceRoleClient();
  const { data, error } = await admin
    .from("referral_codes")
    .insert({
      partner_id: partnerId,
      code,
      label: body.label ?? null,
      is_active: body.is_active ?? true,
      expires_at: body.expires_at ?? null,
      max_uses: body.max_uses ?? null,
    } as never)
    .select()
    .single();

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }

  return NextResponse.json({ referral_code: data });
}
