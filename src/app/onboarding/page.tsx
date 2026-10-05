import { Suspense } from "react";
import { redirect } from "next/navigation";
import type { Metadata } from "next";
import { ReferralUrlCapture } from "@/components/referral/referral-url-capture";
import { UserReferralUrlCapture } from "@/components/referral/user-referral-url-capture";
import { OnboardingForm } from "@/features/onboarding/onboarding-form";
import { createClient } from "@/services/supabase/server";

export const metadata: Metadata = {
  robots: { index: false, follow: false },
};

export default async function OnboardingPage() {
  const supabase = await createClient();
  const {
    data: { user },
    error: userError,
  } = await supabase.auth.getUser();
  if (userError || !user) redirect("/login");

  const { data: profile, error: profileError } = await supabase
    .from("users")
    .select("onboarding_completed")
    .eq("id", user.id)
    .maybeSingle();
  if (profileError)
    throw new Error("Your profile could not be checked. Please try again.");
  if (profile?.onboarding_completed) redirect("/dashboard");

  return (
    <main className="min-h-screen bg-slate-50 px-4 py-8 text-slate-900 dark:bg-app dark:text-slate-100 sm:py-12">
      <Suspense fallback={null}>
        <ReferralUrlCapture />
        <UserReferralUrlCapture />
      </Suspense>
      <OnboardingForm />
    </main>
  );
}
