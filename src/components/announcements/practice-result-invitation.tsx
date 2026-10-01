"use client";

import { useEffect, useMemo, useState } from "react";
import { useRouter } from "next/navigation";
import { ArrowRight } from "lucide-react";
import { Button } from "@/components/ui/button";
import { createClient } from "@/services/supabase/client";
import { PAYMENT_PLANS } from "@/config/payments";

type Invitation = {
  id: string;
  title: string;
  body: string;
  cta_label: string;
  cta_path: string;
};

export function PracticeResultInvitation() {
  const supabase = useMemo(() => createClient(), []);
  const router = useRouter();
  const [invitation, setInvitation] = useState<Invitation | null>(null);
  const [error, setError] = useState(false);

  useEffect(() => {
    let cancelled = false;
    void supabase.rpc("get_my_in_app_message", { p_placement: "practice_result" })
      .then(({ data, error: queryError }) => {
        if (!cancelled && !queryError) setInvitation(data?.[0] ?? null);
      });
    return () => { cancelled = true; };
  }, [supabase]);

  async function dismiss() {
    if (!invitation) return;
    setError(false);
    const { error: dismissError } = await supabase.rpc("dismiss_my_in_app_message", {
      p_message_id: invitation.id,
    });
    if (dismissError) {
      setError(true);
      return;
    }
    setInvitation(null);
  }

  async function explore() {
    if (!invitation) return;
    const destination = invitation.cta_path;
    await dismiss();
    router.push(destination);
  }

  if (!invitation) return null;
  const plan = PAYMENT_PLANS.prepcore_pro_annual;

  return (
    <aside className="rounded-2xl border border-amber-300/60 bg-amber-50 p-5 dark:border-amber-500/40 dark:bg-slate-800">
      <h3 className="text-lg font-bold text-slate-900 dark:text-slate-100">{invitation.title}</h3>
      <p className="mt-2 text-sm leading-6 text-slate-700 dark:text-slate-200">{invitation.body}</p>
      <p className="mt-2 text-sm font-semibold text-slate-800 dark:text-slate-100">₦{plan.amount.toLocaleString("en-NG")} for {plan.durationDays} days</p>
      <div className="mt-4 flex flex-wrap gap-2">
        <Button size="sm" onClick={() => void explore()}>
          {invitation.cta_label} <ArrowRight aria-hidden className="ml-1 h-4 w-4" />
        </Button>
        <Button variant="ghost" size="sm" onClick={() => void dismiss()}>Not now</Button>
      </div>
      {error && <p role="alert" className="mt-2 text-xs text-red-700 dark:text-red-300">Could not save your choice. This invitation may appear again.</p>}
    </aside>
  );
}
