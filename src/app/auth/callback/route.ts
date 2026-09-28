import { applyReferralFromServerCookies } from "@/lib/referral-server";
import { createServerClient, type CookieOptions } from "@supabase/ssr";
import { cookies } from "next/headers";
import { NextRequest, NextResponse } from "next/server";

type CookieToSet = { name: string; value: string; options: CookieOptions };

export async function GET(request: NextRequest) {
  const requestUrl = new URL(request.url);
  const code = requestUrl.searchParams.get("code");
  const diagnosticToken = requestUrl.searchParams.get("diagnostic_token");
  const origin = requestUrl.origin;

  if (code) {
    const cookieStore = await cookies();

    const supabase = createServerClient(
      process.env.NEXT_PUBLIC_SUPABASE_URL!,
      process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
      {
        cookies: {
          getAll() {
            return cookieStore.getAll();
          },
          setAll(cookiesToSet: CookieToSet[]) {
            try {
              cookiesToSet.forEach(({ name, value, options }) =>
                cookieStore.set(name, value, options),
              );
            } catch {}
          },
        },
      },
    );

    const { error } = await supabase.auth.exchangeCodeForSession(code);

    if (error) {
      return NextResponse.redirect(`${origin}/login?error=sign_in_failed`);
    }
    const {
      data: { user },
      error: userError,
    } = await supabase.auth.getUser();
    if (userError || !user) {
      return NextResponse.redirect(`${origin}/login?error=sign_in_failed`);
    }

    const fullName = user.user_metadata?.full_name;
    const { error: profileWriteError } = await supabase.from("users").upsert(
      {
        id: user.id,
        email: user.email,
        full_name: typeof fullName === "string" ? fullName : null,
      },
      { onConflict: "id", ignoreDuplicates: true },
    );
    if (profileWriteError) {
      console.error("Unable to initialize user profile", { code: profileWriteError.code });
      await supabase.auth.signOut({ scope: "local" });
      return NextResponse.redirect(`${origin}/login?error=profile_setup_failed`);
    }

    const { data: profile, error: profileReadError } = await supabase
      .from("users")
      .select("onboarding_completed")
      .eq("id", user.id)
      .maybeSingle();
    if (profileReadError || !profile) {
      console.error("Unable to verify user profile", { code: profileReadError?.code });
      await supabase.auth.signOut({ scope: "local" });
      return NextResponse.redirect(`${origin}/login?error=profile_setup_failed`);
    }

    await applyReferralFromServerCookies();

    if (diagnosticToken) {
      await supabase
        .from("diagnostic_test_results")
        .update({ converted_to_signup: true })
        .eq("session_token", diagnosticToken);
    }

    if (!profile.onboarding_completed) {
      return NextResponse.redirect(`${origin}/onboarding`);
    }
  }

  return NextResponse.redirect(`${origin}/dashboard`);
}
