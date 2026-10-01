"use client";

import { Check, Crown, Loader2, ShieldCheck, Sparkles, X } from "lucide-react";
import Link from "next/link";
import { useEffect, useState } from "react";
import { motion, useReducedMotion } from "framer-motion";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { useUserPlan } from "@/hooks/use-user-plan";
import { getMyReferral, type UserReferral } from "@/services/api/referral";
import { PageSkeleton } from "@/components/layout/page-skeleton";
import { PAYMENT_PLANS } from "@/config/payments";

const proPlan = PAYMENT_PLANS.prepcore_pro_annual;

const FREE_FEATURES = [
  { text: "Unlimited practice mode", included: true },
  { text: "Correct answers and standard explanations", included: true },
  { text: "Score, progress, and topic recommendations", included: true },
  { text: "Weekly quiz", included: true },
  { text: "Limited AI explanations", included: true },
  { text: "Timed mock exams", included: false },
  { text: "Flashcards", included: false },
];

const PRO_FEATURES = [
  "Everything in Free",
  "Flashcards for all subjects",
  "Full JAMB and WAEC mock exams",
  "English 60-question and 40-question subject sections",
  "Subject switching, question maps, timers, and detailed results",
  "Downloadable result cards",
  "One year of Pro access",
];

export default function UpgradePage() {
  const { isPro, isLoading, isPartnerBulkPro, partnerName } = useUserPlan();
  const [referral, setReferral] = useState<UserReferral | null>(null);
  const [checkoutLoading, setCheckoutLoading] = useState(false);
  const [error, setError] = useState("");
  const [pendingRef, setPendingRef] = useState<string | null>(null);
  const [resumeUrl, setResumeUrl] = useState<string | null>(null);
  const reducedMotion = useReducedMotion();

  useEffect(() => {
    void getMyReferral().then(setReferral);
  }, []);

  async function startCheckout() {
    setCheckoutLoading(true);
    setError("");
    setPendingRef(null);
    setResumeUrl(null);

    try {
      const response = await fetch("/api/payments/create", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ plan_key: "prepcore_pro_annual" }),
      });
      const data = (await response.json()) as {
        checkout_url?: string;
        tx_ref?: string;
        state?: "ready" | "resume" | "pending";
        error?: string;
      };

      if (!response.ok) {
        throw new Error(data.error ?? "Could not start payment.");
      }
      if (data.state === "pending" && data.tx_ref) {
        setPendingRef(data.tx_ref);
        setError(
          "An earlier checkout is still being prepared or checked. Please check its status before trying to pay again.",
        );
        setCheckoutLoading(false);
        return;
      }
      if (data.state === "resume" && data.tx_ref && data.checkout_url) {
        setPendingRef(data.tx_ref);
        setResumeUrl(data.checkout_url);
        setError(
          "An earlier checkout is still open. Check its status first if your bank has debited you. Only resume checkout if you have not paid.",
        );
        setCheckoutLoading(false);
        return;
      }
      if (!data.checkout_url)
        throw new Error(
          "Checkout link is unavailable. Please check your payment status.",
        );

      window.location.href = data.checkout_url;
    } catch (checkoutError) {
      setError(
        checkoutError instanceof Error
          ? checkoutError.message
          : "Could not start payment.",
      );
      setCheckoutLoading(false);
    }
  }

  if (isLoading) {
    return <PageSkeleton variant="form" />;
  }

  if (isPro) {
    return (
      <div className="mx-auto max-w-2xl space-y-6">
        <div className="rounded-3xl bg-primary p-8 text-center text-white">
          <div className="mx-auto flex h-16 w-16 items-center justify-center rounded-full bg-white/20">
            <Crown className="h-8 w-8 text-yellow-300" />
          </div>
          <h1 className="mt-4 text-2xl font-bold">You are on Prepcore Pro</h1>
          <p className="mt-2 text-sm text-blue-100">
            {isPartnerBulkPro && partnerName
              ? `Pro included through ${partnerName}.`
              : "Your individual Pro subscription is active."}
          </p>
          <Badge className="mt-4 border-white/30 bg-white/20 text-white">
            Active subscription
          </Badge>
        </div>

        <Card className="border-border bg-white shadow-sm">
          <CardHeader>
            <CardTitle className="flex items-center gap-2">
              <Sparkles className="h-5 w-5 text-primary" />
              Your Pro features
            </CardTitle>
          </CardHeader>
          <CardContent className="space-y-3">
            {PRO_FEATURES.map((feature) => (
              <div key={feature} className="flex items-center gap-3 text-sm">
                <Check className="h-4 w-4 text-green-500" />
                <span className="text-slate-700">{feature}</span>
              </div>
            ))}
          </CardContent>
        </Card>

        <div className="grid grid-cols-2 gap-3">
          <Button asChild variant="outline">
            <Link href="/flashcards">Open Flashcards</Link>
          </Button>
          <Button asChild variant="outline">
            <Link href="/exam">Take Mock Exam</Link>
          </Button>
          <Button asChild variant="outline">
            <Link href="/practice">Practice Mode</Link>
          </Button>
          <Button asChild variant="outline">
            <Link href="/progress">View Progress</Link>
          </Button>
        </div>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-4xl space-y-8">
      <div className="space-y-3 text-center">
        <Badge className="border-amber-200 bg-amber-50 text-amber-700">
          <Sparkles className="mr-1 h-3 w-3" />
          Secure Flutterwave checkout
        </Badge>
        <h1 className="text-3xl font-bold text-navy">
          Upgrade to Prepcore Pro
        </h1>
        <p className="mx-auto max-w-2xl text-slate-600 dark:text-slate-300">
          Practise questions for free. Pro adds realistic timed mock exams and
          flashcards to help you prepare for exam day.
        </p>
        {referral && (
          <p className="mx-auto max-w-md rounded-xl border border-blue-100 bg-softblue px-4 py-3 text-sm text-navy">
            Referred via <strong>{referral.partner_name}</strong> (
            {referral.code})
          </p>
        )}
      </div>

      <div className="grid gap-3 sm:grid-cols-3">
        {[
          {
            title: "Practise like exam day",
            detail:
              "Work through full timed JAMB and WAEC mock exams with question maps and detailed results.",
          },
          {
            title: "Remember more",
            detail:
              "Use flashcards to revisit key ideas between practice sessions.",
          },
          {
            title: "Learn from your results",
            detail:
              "See detailed mock-exam results and review missed answers after a realistic timed session.",
          },
        ].map((benefit) => (
          <div
            key={benefit.title}
            className="rounded-2xl border border-border bg-white p-5 dark:border-border-card dark:bg-card-surface"
          >
            <h2 className="font-semibold text-slate-900 dark:text-slate-100">
              {benefit.title}
            </h2>
            <p className="mt-2 text-sm leading-6 text-slate-700 dark:text-slate-300">
              {benefit.detail}
            </p>
          </div>
        ))}
      </div>

      <div className="grid gap-6 md:grid-cols-2">
        <Card className="border-border bg-white shadow-sm">
          <CardHeader>
            <CardTitle className="text-lg">Free</CardTitle>
            <p className="text-4xl font-bold text-navy">NGN 0</p>
            <p className="text-sm text-slate-500">Forever free</p>
          </CardHeader>
          <CardContent>
            <div className="space-y-3">
              {FREE_FEATURES.map((feature) => (
                <div
                  key={feature.text}
                  className="flex items-center gap-3 text-sm"
                >
                  {feature.included ? (
                    <Check className="h-4 w-4 text-green-500" />
                  ) : (
                    <X className="h-4 w-4 text-slate-300" />
                  )}
                  <span
                    className={
                      feature.included ? "text-slate-700" : "text-slate-400"
                    }
                  >
                    {feature.text}
                  </span>
                </div>
              ))}
            </div>
            <Button variant="outline" className="mt-6 w-full" disabled>
              Current plan
            </Button>
          </CardContent>
        </Card>

        <motion.div
          initial={{ opacity: 0, y: reducedMotion ? 0 : 12 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: reducedMotion ? 0.12 : 0.38, delay: 0.08 }}
        >
          <Card className="relative overflow-hidden border-primary bg-softblue shadow-soft">
            {!reducedMotion && (
              <motion.div
                aria-hidden
                className="pointer-events-none absolute inset-0 bg-[linear-gradient(115deg,transparent_30%,rgba(96,165,250,.16)_48%,transparent_66%)]"
                animate={{ x: ["-100%", "100%"] }}
                transition={{
                  duration: 3.8,
                  repeat: Infinity,
                  repeatDelay: 2,
                  ease: "easeInOut",
                }}
              />
            )}
            <div className="absolute right-4 top-4">
              <Badge className="bg-primary text-white">Most popular</Badge>
            </div>
            <CardHeader>
              <CardTitle className="flex items-center gap-2 text-lg">
                <Sparkles className="h-5 w-5 text-primary" />
                Pro
              </CardTitle>
              <p className="text-4xl font-bold text-navy">
                ₦{proPlan.amount.toLocaleString("en-NG")}
              </p>
              <p className="text-sm text-slate-500">One-time yearly access</p>
            </CardHeader>
            <CardContent>
              <div className="space-y-3">
                {PRO_FEATURES.map((feature) => (
                  <div
                    key={feature}
                    className="flex items-center gap-3 text-sm"
                  >
                    <Check className="h-4 w-4 text-green-500" />
                    <span className="text-slate-700">{feature}</span>
                  </div>
                ))}
              </div>

              <div className="mt-6 rounded-xl border border-blue-100 bg-white p-4">
                <div className="flex items-start gap-3">
                  <ShieldCheck className="mt-0.5 h-5 w-5 text-primary" />
                  <div>
                    <p className="text-sm font-semibold text-navy">
                      Verified before activation
                    </p>
                    <p className="mt-1 text-xs leading-5 text-slate-500">
                      Prepcore verifies the transaction with Flutterwave before
                      upgrading your account.
                    </p>
                  </div>
                </div>
              </div>

              {error && (
                <div className="mt-4 rounded-xl border border-amber-200 bg-amber-50 px-4 py-3 text-sm text-amber-900 dark:border-amber-800 dark:bg-amber-950 dark:text-amber-100">
                  <p>{error}</p>
                  {pendingRef && (
                    <Link
                      className="mt-2 inline-block font-semibold underline"
                      href={`/upgrade/success?tx_ref=${encodeURIComponent(pendingRef)}`}
                    >
                      Check payment status
                    </Link>
                  )}
                  {resumeUrl && (
                    <a
                      className="ml-4 mt-2 inline-block font-semibold underline"
                      href={resumeUrl}
                    >
                      Resume original checkout
                    </a>
                  )}
                </div>
              )}

              <Button
                className="mt-6 w-full"
                onClick={startCheckout}
                disabled={checkoutLoading}
              >
                {checkoutLoading && (
                  <Loader2 className="h-4 w-4 animate-spin" />
                )}
                Pay with Flutterwave
              </Button>
            </CardContent>
          </Card>
        </motion.div>
      </div>
    </div>
  );
}
