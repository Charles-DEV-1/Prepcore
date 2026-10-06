import type { Metadata } from "next";
import Link from "next/link";
import { WhatsAppStudyCard } from "@/components/community/whatsapp-study-card";
import { Button } from "@/components/ui/button";
import { safePostOnboardingDestination } from "@/lib/post-onboarding";

export const metadata: Metadata = {
  title: "Your study plan is ready | Prepcore",
  robots: { index: false, follow: false },
};

export default async function WelcomePage({
  searchParams,
}: {
  searchParams: Promise<{ next?: string | string[] }>;
}) {
  const { next } = await searchParams;
  const continueHref = safePostOnboardingDestination(next);

  return (
    <div className="mx-auto max-w-xl space-y-5 py-4 sm:py-8">
      <div className="space-y-2 text-center">
        <p className="text-xs font-bold uppercase tracking-[0.18em] text-blue-800 dark:text-blue-200">
          Your study plan is ready
        </p>
        <h1 className="text-3xl font-bold text-slate-900 dark:text-slate-100">
          One more way to prepare together
        </h1>
        <p className="text-sm leading-6 text-slate-700 dark:text-slate-300">
          Your Prepcore practice is ready. If you like learning with others,
          come study with us on WhatsApp too.
        </p>
      </div>

      <WhatsAppStudyCard />

      <Button asChild variant="outline" className="w-full">
        <Link href={continueHref}>
          {continueHref.startsWith("/practice?")
            ? "Continue to my first 5 questions"
            : "Continue to my dashboard"}
        </Link>
      </Button>
    </div>
  );
}
