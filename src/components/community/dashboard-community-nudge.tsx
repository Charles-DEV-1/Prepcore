"use client";

import { useEffect, useState } from "react";
import { AnimatePresence, motion, useReducedMotion } from "framer-motion";
import { ArrowUpRight, MessageCircle, X } from "lucide-react";
import { WHATSAPP_STUDY_GROUP_URL } from "@/config/community";
import {
  recordCommunityNudge,
  shouldShowCommunityNudge,
} from "@/lib/community-nudge";

const APPEAR_DELAY_MS = 18_000;
const VISIBLE_DURATION_MS = 14_000;

export function DashboardCommunityNudge({
  userId,
  enabled,
}: {
  userId: string;
  enabled: boolean;
}) {
  const reducedMotion = useReducedMotion();
  const [visible, setVisible] = useState(false);
  const [engaged, setEngaged] = useState(false);

  useEffect(() => {
    if (!enabled || !userId) return;
    try {
      if (!shouldShowCommunityNudge(window.localStorage, userId, Date.now()))
        return;
    } catch {
      return;
    }

    const timer = window.setTimeout(() => {
      if (
        document.visibilityState !== "visible" ||
        document.querySelector('[role="dialog"][data-state="open"]')
      ) return;
      try {
        recordCommunityNudge(window.localStorage, userId, "shown", Date.now());
        setVisible(true);
      } catch {
        // If a browser blocks storage, do not show a repeating invitation.
      }
    }, APPEAR_DELAY_MS);
    return () => window.clearTimeout(timer);
  }, [enabled, userId]);

  useEffect(() => {
    if (!visible || engaged) return;
    const timer = window.setTimeout(() => setVisible(false), VISIBLE_DURATION_MS);
    return () => window.clearTimeout(timer);
  }, [visible, engaged]);

  function finish(action: "dismissed" | "opened") {
    try {
      recordCommunityNudge(window.localStorage, userId, action, Date.now());
    } catch {
      // Keep the dashboard usable if local storage becomes unavailable.
    }
    setVisible(false);
  }

  return (
    <AnimatePresence>
      {visible && enabled && (
        <motion.aside
          aria-label="WhatsApp study group invitation"
          initial={reducedMotion ? false : { opacity: 0, y: 8, scale: 0.98 }}
          animate={{ opacity: 1, y: 0, scale: 1 }}
          exit={reducedMotion ? undefined : { opacity: 0, y: -4 }}
          transition={{ duration: 0.25 }}
          onMouseEnter={() => setEngaged(true)}
          onMouseLeave={() => setEngaged(false)}
          onFocusCapture={() => setEngaged(true)}
          onBlurCapture={(event) => {
            const nextFocus = event.relatedTarget;
            if (!(nextFocus instanceof Node) || !event.currentTarget.contains(nextFocus))
              setEngaged(false);
          }}
          className="ml-auto flex w-full max-w-md items-start gap-3 rounded-2xl border border-emerald-300 bg-emerald-50 p-3 text-slate-900 shadow-md dark:border-emerald-700 dark:bg-slate-800 dark:text-slate-100 sm:p-4"
        >
          <span className="grid h-9 w-9 shrink-0 place-items-center rounded-xl bg-emerald-100 text-emerald-800 dark:bg-emerald-900/70 dark:text-emerald-200">
            <MessageCircle className="h-5 w-5" aria-hidden="true" />
          </span>
          <div className="min-w-0 flex-1">
            <p className="text-sm font-bold">Study with us on WhatsApp</p>
            <p className="mt-1 text-xs leading-5 text-slate-700 dark:text-slate-300">
              Get practice questions and discuss the answers with other learners.
            </p>
            <a
              href={WHATSAPP_STUDY_GROUP_URL}
              target="_blank"
              rel="noopener noreferrer"
              onClick={() => finish("opened")}
              className="mt-2 inline-flex min-h-9 items-center gap-1 rounded-md text-sm font-semibold text-emerald-900 underline underline-offset-4 hover:text-emerald-700 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-emerald-700 dark:text-emerald-200 dark:hover:text-emerald-100"
            >
              Join the group <ArrowUpRight className="h-4 w-4" aria-hidden="true" />
              <span className="sr-only">(opens in a new tab)</span>
            </a>
          </div>
          <button
            type="button"
            aria-label="Dismiss WhatsApp group invitation"
            onClick={() => finish("dismissed")}
            className="grid h-9 w-9 shrink-0 place-items-center rounded-lg text-slate-600 hover:bg-emerald-100 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-emerald-700 dark:text-slate-300 dark:hover:bg-slate-700"
          >
            <X className="h-4 w-4" aria-hidden="true" />
          </button>
        </motion.aside>
      )}
    </AnimatePresence>
  );
}
