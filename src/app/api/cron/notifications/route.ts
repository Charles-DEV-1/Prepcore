import { NextResponse } from "next/server";
import { sendDueStreakReminders } from "@/services/notifications/reminders";

function isAuthorized(request: Request) {
  const secret = process.env.CRON_SECRET;
  if (!secret) return false;
  return request.headers.get("authorization") === `Bearer ${secret}`;
}

export async function GET(request: Request) {
  if (!isAuthorized(request)) return NextResponse.json({ error: "Unauthorized." }, { status: 401 });
  try {
    const result = await sendDueStreakReminders();
    return NextResponse.json({ success: true, ...result });
  } catch (error) {
    console.error("notification_scheduler_failed", error);
    return NextResponse.json({ error: "Notification scheduler failed." }, { status: 500 });
  }
}
