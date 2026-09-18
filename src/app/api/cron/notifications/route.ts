import { NextResponse } from "next/server";
import { sendDueStreakReminders } from "@/services/notifications/reminders";
import { createServiceRoleClient } from "@/services/supabase/admin";

function isAuthorized(request: Request) {
  const secret = process.env.CRON_SECRET;
  if (!secret) return false;
  return request.headers.get("authorization") === `Bearer ${secret}`;
}

export async function GET(request: Request) {
  if (!isAuthorized(request)) return NextResponse.json({ error: "Unauthorized." }, { status: 401 });
  const admin = createServiceRoleClient();
  const startedAt = new Date().toISOString();
  const { data: run } = await admin
    .from("notification_scheduler_runs")
    .insert({ started_at: startedAt, status: "running" } as never)
    .select("id")
    .single();
  try {
    const result = await sendDueStreakReminders();
    if (run?.id) {
      await admin.from("notification_scheduler_runs").update({
        ...result,
        completed_at: new Date().toISOString(),
        status: "completed",
      } as never).eq("id", run.id);
    }
    return NextResponse.json({ success: true, ...result });
  } catch (error) {
    console.error("notification_scheduler_failed", error);
    if (run?.id) {
      await admin.from("notification_scheduler_runs").update({
        completed_at: new Date().toISOString(),
        status: "failed",
        error_message: error instanceof Error ? error.message : String(error),
      } as never).eq("id", run.id);
    }
    return NextResponse.json({ error: "Notification scheduler failed." }, { status: 500 });
  }
}
