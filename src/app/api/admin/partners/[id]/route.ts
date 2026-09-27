import { forbiddenResponse, getAdminSessionUser } from "@/lib/admin-api-auth";
import { hasTrustedOrigin, noStoreJson, readSafeJson } from "@/lib/api-security";
import { createServiceRoleClient } from "@/services/supabase/admin";
import { NextRequest, NextResponse } from "next/server";
import { z } from "zod";

const updatePartnerSchema = z.object({
  name: z.string().trim().min(1).max(100).optional(),
  slug: z.string().trim().min(1).max(100).optional(),
  city: z.string().trim().max(100).nullable().optional(),
  contact_name: z.string().trim().max(100).nullable().optional(),
  contact_phone: z.string().trim().max(30).nullable().optional(),
  contact_email: z.string().email().max(254).nullable().optional(),
  notes: z.string().max(2000).nullable().optional(),
  commission_percent: z.number().min(0).max(100).nullable().optional(),
  is_active: z.boolean().optional(),
  bulk_pro_active: z.boolean().optional(),
  bulk_pro_expires_at: z.string().datetime().nullable().optional(),
  wholesale_price_naira: z.number().int().min(0).max(1_000_000_000).nullable().optional(),
  student_price_naira: z.number().int().min(0).max(1_000_000_000).nullable().optional(),
}).strict().refine((value) => Object.keys(value).length > 0);

export async function PATCH(
  request: NextRequest,
  { params }: { params: Promise<{ id: string }> },
) {
  if (!hasTrustedOrigin(request)) return noStoreJson({ error: "Invalid request origin." }, { status: 403 });
  if (!(await getAdminSessionUser())) return forbiddenResponse();

  const { id } = await params;
  if (!z.string().uuid().safeParse(id).success) return noStoreJson({ error: "Invalid partner ID." }, { status: 400 });
  const parsed = updatePartnerSchema.safeParse(await readSafeJson<unknown>(request));
  if (!parsed.success) return noStoreJson({ error: "Invalid partner update." }, { status: 400 });
  const body = parsed.data;
  const admin = createServiceRoleClient();

  const updates: Record<string, unknown> = {};
  const fields = [
    "name",
    "slug",
    "city",
    "contact_name",
    "contact_phone",
    "contact_email",
    "notes",
    "commission_percent",
    "is_active",
    "bulk_pro_active",
    "bulk_pro_expires_at",
    "wholesale_price_naira",
    "student_price_naira",
  ] as const;

  for (const field of fields) {
    if (field in body) updates[field] = body[field];
  }

  const { data, error } = await admin
    .from("partners")
    .update(updates as never)
    .eq("id", id)
    .select()
    .single();

  if (error) {
    return NextResponse.json({ error: error.message }, { status: 500 });
  }

  return NextResponse.json({ partner: data });
}
