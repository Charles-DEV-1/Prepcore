import { NextResponse } from "next/server";
import { refreshQuestionCache } from "@/services/questions/aloc-cache";

function isAuthorized(request: Request) {
  const secret = process.env.CRON_SECRET;
  return Boolean(secret) && request.headers.get("authorization") === `Bearer ${secret}`;
}

export async function GET(request: Request) {
  if (!isAuthorized(request)) {
    return NextResponse.json({ error: "Unauthorized." }, { status: 401 });
  }

  try {
    const waec = await refreshQuestionCache("waec");
    return NextResponse.json({ success: true, waec });
  } catch (error) {
    console.error("question_cache_refresh_failed", error);
    return NextResponse.json(
      { error: "Question cache refresh failed." },
      { status: 500 },
    );
  }
}
