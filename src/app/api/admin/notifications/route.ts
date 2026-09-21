import { z } from "zod";
import { forbiddenResponse, getAdminSessionUser } from "@/lib/admin-api-auth";
import { hasTrustedOrigin, noStoreJson, readSafeJson } from "@/lib/api-security";
import { createServiceRoleClient } from "@/services/supabase/admin";

const contentSchema = z.object({
  notificationType: z.enum(["study_tip", "news", "announcement"]),
  title: z.string().trim().min(1).max(120),
  body: z.string().trim().min(1).max(500),
  url: z.enum(["/dashboard", "/practice"]).default("/dashboard"),
  scheduledAt: z.string().datetime().optional(),
  expiresAt: z.string().datetime().optional().nullable(),
  publish: z.boolean().default(false),
});

export async function GET() {
  if (!(await getAdminSessionUser())) return forbiddenResponse();
  const admin = createServiceRoleClient();
  const { data, error } = await admin
    .from("notification_content")
    .select("id, notification_type, title, body, url, status, scheduled_at, expires_at, created_at")
    .order("created_at", { ascending: false })
    .limit(50);
  if (error) return noStoreJson({ error: "Unable to load notification content." }, { status: 500 });
  return noStoreJson({ content: data ?? [] });
}

export async function POST(request: Request) {
  if (!(await getAdminSessionUser())) return forbiddenResponse();
  if (!hasTrustedOrigin(request)) return noStoreJson({ error: "Invalid request origin." }, { status: 403 });
  const parsed = contentSchema.safeParse(await readSafeJson<unknown>(request));
  if (!parsed.success) return noStoreJson({ error: "Invalid notification content." }, { status: 400 });

  const adminUser = await getAdminSessionUser();
  if (!adminUser) return forbiddenResponse();
  const admin = createServiceRoleClient();
  const { data, error } = await admin
    .from("notification_content")
    .insert({
      notification_type: parsed.data.notificationType,
      title: parsed.data.title,
      body: parsed.data.body,
      url: parsed.data.url,
      scheduled_at: parsed.data.scheduledAt ?? new Date().toISOString(),
      expires_at: parsed.data.expiresAt ?? null,
      status: parsed.data.publish ? "published" : "draft",
      created_by: adminUser.id,
    } as never)
    .select("id, notification_type, title, status, scheduled_at")
    .single();
  if (error) return noStoreJson({ error: "Unable to create notification content." }, { status: 500 });
  return noStoreJson({ success: true, content: data }, { status: 201 });
}
