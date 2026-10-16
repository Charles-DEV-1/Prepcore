"use client";

import { useEffect, useState } from "react";
import { AnimatePresence, motion, useReducedMotion } from "framer-motion";
import { ArrowUpRight, MessageCircleMore, X } from "lucide-react";
import { WHATSAPP_STUDY_GROUP_URL } from "@/config/community";
import {
  recordCommunityNudge,
  shouldShowCommunityNudge,
} from "@/lib/community-nudge";

export function DashboardCommunityNudge({
  userId,
  onChecked,
}: {
  userId: string;
  onChecked: (shown: boolean) => void;
}) {
  const reducedMotion = useReducedMotion();
  const [visible, setVisible] = useState(false);

  useEffect(() => {
    let shouldShow = false;
    if (userId) {
      try {
        shouldShow = shouldShowCommunityNudge(
          window.localStorage,
          userId,
          Date.now(),
        );
      } catch {
        // Storage can be blocked in private modes. Still show the update;
        // dismissing it will hide it for this visit.
        shouldShow = true;
      }
    }
    setVisible(shouldShow);
    onChecked(shouldShow);
  }, [userId, onChecked]);

  function finish(action: "dismissed" | "opened") {
    try {
      recordCommunityNudge(window.localStorage, userId, action, Date.now());
    } catch {
      // The card can still be closed for this visit without storage access.
    }
    setVisible(false);
  }

  return (
    <AnimatePresence>
      {visible && (
        <motion.aside
          aria-label="New Prepcore study community update"
          initial={reducedMotion ? false : { opacity: 0, y: 10 }}
          animate={{ opacity: 1, y: 0 }}
          exit={reducedMotion ? undefined : { opacity: 0, y: -6 }}
          transition={{ duration: 0.28, ease: "easeOut" }}
          className="group relative overflow-hidden rounded-2xl border border-emerald-300 bg-gradient-to-r from-emerald-50 via-white to-blue-50 p-4 text-slate-900 shadow-[0_12px_30px_rgba(15,118,110,0.09)] dark:border-emerald-700/70 dark:from-[#123026] dark:via-slate-800 dark:to-slate-800 dark:text-slate-100 sm:p-5"
        >
          <div className="relative flex items-start gap-3 sm:gap-4">
            <span className="grid h-11 w-11 shrink-0 place-items-center rounded-xl bg-emerald-800 text-white transition-transform duration-300 motion-safe:group-hover:-rotate-6 motion-safe:group-hover:scale-105 dark:bg-emerald-700">
              <MessageCircleMore className="h-6 w-6" aria-hidden="true" />
            </span>
            <div className="min-w-0 flex-1">
              <p className="text-xs font-bold uppercase tracking-[0.16em] text-emerald-800 dark:text-emerald-200">
                New on Prepcore
              </p>
              <h2 className="mt-1 text-lg font-bold sm:text-xl">
                Join our free WhatsApp study group
              </h2>
              <p className="mt-1 max-w-2xl text-sm leading-6 text-slate-700 dark:text-slate-300">
                Practice JAMB and WAEC questions with other learners, discuss
                the answers, and keep studying together.
              </p>
              <a
                href={WHATSAPP_STUDY_GROUP_URL}
                target="_blank"
                rel="noopener noreferrer"
                onClick={() => finish("opened")}
                className="mt-3 inline-flex min-h-10 items-center gap-2 rounded-lg bg-emerald-800 px-4 text-sm font-semibold text-white transition-colors hover:bg-emerald-900 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-emerald-700 focus-visible:ring-offset-2 dark:bg-emerald-700 dark:hover:bg-emerald-600 dark:focus-visible:ring-emerald-400 dark:focus-visible:ring-offset-slate-800"
              >
                Join the group
                <ArrowUpRight
                  className="h-4 w-4 transition-transform duration-300 motion-safe:group-hover:-translate-y-0.5 motion-safe:group-hover:translate-x-0.5"
                  aria-hidden="true"
                />
                <span className="sr-only">(opens in a new tab)</span>
              </a>
              <p className="mt-2 text-xs text-slate-600 dark:text-slate-300">
                Optional to join. Your phone number may be visible to group
                members.
              </p>
            </div>
            <button
              type="button"
              aria-label="Dismiss study group update"
              onClick={() => finish("dismissed")}
              className="grid h-10 w-10 shrink-0 place-items-center rounded-lg text-slate-600 hover:bg-emerald-100 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-emerald-700 dark:text-slate-300 dark:hover:bg-slate-700"
            >
              <X className="h-4 w-4" aria-hidden="true" />
            </button>
          </div>
        </motion.aside>
      )}
    </AnimatePresence>
  );
}
