import { z } from "zod";
import { hasTrustedOrigin, noStoreJson, readSafeJson } from "@/lib/api-security";
import { createClient } from "@/services/supabase/server";

const preferencesSchema = z.object({
  studyRemindersEnabled: z.boolean(),
  streakRemindersEnabled: z.boolean(),
  timezone: z.string().min(1).max(100),
});

async function getUser() {
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  return { supabase, user };
}

export async function GET() {
  const { supabase, user } = await getUser();
  if (!user) return noStoreJson({ error: "Unauthorized." }, { status: 401 });
  const { data, error } = await supabase.from("notification_preferences").select("study_reminders_enabled, streak_reminders_enabled, timezone, last_reminder_sent_at").eq("user_id", user.id).maybeSingle();
  if (error) return noStoreJson({ error: "Could not load notification preferences." }, { status: 500 });
  return noStoreJson({
    preferences: data ?? {
      study_reminders_enabled: false,
      streak_reminders_enabled: false,
      timezone: "UTC",
      last_reminder_sent_at: null,
    },
  });
}

export async function PATCH(request: Request) {
  if (!hasTrustedOrigin(request)) return noStoreJson({ error: "Invalid request origin." }, { status: 403 });
  const { supabase, user } = await getUser();
  if (!user) return noStoreJson({ error: "Unauthorized." }, { status: 401 });
  const parsed = preferencesSchema.safeParse(await readSafeJson<unknown>(request));
  if (!parsed.success) return noStoreJson({ error: "Invalid notification preferences." }, { status: 400 });
  const { data, error } = await supabase.from("notification_preferences").upsert({
    user_id: user.id,
    study_reminders_enabled: parsed.data.studyRemindersEnabled,
    streak_reminders_enabled: parsed.data.streakRemindersEnabled,
    timezone: parsed.data.timezone,
    updated_at: new Date().toISOString(),
  } as never, { onConflict: "user_id" }).select("study_reminders_enabled, streak_reminders_enabled, timezone, last_reminder_sent_at").single();
  if (error) return noStoreJson({ error: "Could not update notification preferences." }, { status: 500 });
  return noStoreJson({ success: true, preferences: data });
}
