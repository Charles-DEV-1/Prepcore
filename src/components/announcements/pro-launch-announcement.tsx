"use client";

import { useEffect, useMemo, useState } from "react";
import { useRouter } from "next/navigation";
import { ArrowRight, Crown, X } from "lucide-react";
import { createClient } from "@/services/supabase/client";
import { Button } from "@/components/ui/button";
import { PAYMENT_PLANS } from "@/config/payments";

type InAppMessage = {
  id: string;
  title: string;
  body: string;
  cta_label: string;
  cta_path: string;
};

export function ProLaunchAnnouncement({ onChecked }: { onChecked: (shown: boolean) => void }) {
  const router = useRouter();
  const supabase = useMemo(() => createClient(), []);
  const [message, setMessage] = useState<InAppMessage | null>(null);
  const [dismissError, setDismissError] = useState(false);

  useEffect(() => {
    let cancelled = false;
    void supabase
      .rpc("get_my_in_app_message", { p_placement: "dashboard" })
      .then(({ data, error }) => {
        if (cancelled) return;
        const nextMessage = !error ? (data?.[0] ?? null) : null;
        setMessage(nextMessage);
        onChecked(Boolean(nextMessage));
      });
    return () => {
      cancelled = true;
    };
  }, [supabase, onChecked]);

  async function dismiss() {
    if (!message) return;
    setDismissError(false);
    const { error } = await supabase.rpc("dismiss_my_in_app_message", {
      p_message_id: message.id,
    });
    if (error) {
      setDismissError(true);
      return;
    }
    setMessage(null);
  }

  async function openDetails() {
    if (!message) return;
    const destination = message.cta_path;
    await dismiss();
    router.push(destination);
  }

  if (!message) return null;
  const plan = PAYMENT_PLANS.prepcore_pro_annual;

  return (
    <aside
      aria-label="Prepcore announcement"
      className="rounded-2xl border border-amber-300/60 bg-amber-50 p-5 text-slate-900 shadow-sm dark:border-amber-500/40 dark:bg-slate-800 dark:text-slate-100 sm:p-6"
    >
      <div className="flex items-start gap-4">
        <span className="grid h-11 w-11 shrink-0 place-items-center rounded-xl bg-amber-100 text-amber-800 dark:bg-amber-400/15 dark:text-amber-300">
          <Crown aria-hidden className="h-6 w-6" />
        </span>
        <div className="min-w-0 flex-1">
          <h2 className="text-lg font-bold">{message.title}</h2>
          <p className="mt-1 max-w-2xl text-sm leading-6 text-slate-700 dark:text-slate-200">
            {message.body}
          </p>
          <p className="mt-2 text-sm font-semibold text-slate-800 dark:text-slate-100">
            ₦{plan.amount.toLocaleString("en-NG")} for {plan.durationDays} days
          </p>
          <div className="mt-4 flex flex-wrap items-center gap-2">
            <Button size="sm" onClick={() => void openDetails()}>
              {message.cta_label} <ArrowRight aria-hidden className="ml-1 h-4 w-4" />
            </Button>
            <Button variant="ghost" size="sm" onClick={() => void dismiss()}>
              Not now
            </Button>
          </div>
          {dismissError && (
            <p role="alert" className="mt-2 text-xs text-red-700 dark:text-red-300">
              Could not save your choice. This announcement may appear again.
            </p>
          )}
        </div>
        <button
          type="button"
          aria-label="Dismiss announcement"
          className="rounded-lg p-2 text-slate-600 hover:bg-amber-100 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary dark:text-slate-300 dark:hover:bg-slate-700"
          onClick={() => void dismiss()}
        >
          <X aria-hidden className="h-4 w-4" />
        </button>
      </div>
    </aside>
  );
}
