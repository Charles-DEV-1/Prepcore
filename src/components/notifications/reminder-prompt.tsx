"use client";

import { useEffect, useState } from "react";
import { Bell, X } from "lucide-react";
import { usePathname } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { usePushNotifications } from "@/hooks/use-push-notifications";

const DISMISSED_AT_KEY = "prepcore_reminder_prompt_dismissed_at";
const DISMISS_WINDOW_MS = 5 * 24 * 60 * 60 * 1000;
const APP_PATHS = [
  "/dashboard",
  "/exam",
  "/flashcards",
  "/leaderboard",
  "/practice",
  "/profile",
  "/progress",
  "/referrals",
  "/results",
  "/settings",
  "/weekly-quiz",
];

export function ReminderPrompt() {
  const pathname = usePathname();
  const { isBusy, requestPermission, status } = usePushNotifications();
  const [visible, setVisible] = useState(false);

  useEffect(() => {
    if (
      !APP_PATHS.some(
        (path) => pathname === path || pathname.startsWith(`${path}/`),
      )
    ) {
      return;
    }

    if (status !== "disabled" && status !== "needs-permission") return;

    const dismissedAt = Number(localStorage.getItem(DISMISSED_AT_KEY));
    if (
      Number.isFinite(dismissedAt) &&
      Date.now() - dismissedAt < DISMISS_WINDOW_MS
    ) {
      return;
    }

    const timeout = window.setTimeout(() => setVisible(true), 1600);
    return () => window.clearTimeout(timeout);
  }, [pathname, status]);

  function dismiss() {
    localStorage.setItem(DISMISSED_AT_KEY, String(Date.now()));
    setVisible(false);
  }

  async function enable() {
    const enabled = await requestPermission();
    if (enabled) setVisible(false);
  }

  if (!visible) return null;

  return (
    <div className="fixed inset-x-4 bottom-24 z-[55] mx-auto max-w-md animate-in slide-in-from-bottom-3 fade-in duration-300">
      <Card className="border-primary/20 shadow-2xl">
        <CardContent className="flex items-start gap-3 p-4">
          <div className="mt-0.5 flex h-9 w-9 shrink-0 items-center justify-center rounded-full bg-softblue text-primary">
            <Bell className="h-4 w-4" aria-hidden="true" />
          </div>
          <div className="min-w-0 flex-1">
            <p className="text-sm font-semibold text-navy dark:text-main">
              Keep your streak alive
            </p>
            <p className="mt-1 text-sm leading-5 text-slate-600">
              Enable study reminders so Prepcore can nudge you before a streak
              slips.
            </p>
            <div className="mt-3 flex gap-2">
              <Button
                size="sm"
                type="button"
                onClick={() => void enable()}
                disabled={isBusy}
              >
                Enable
              </Button>
              <Button size="sm" type="button" variant="ghost" onClick={dismiss}>
                Later
              </Button>
            </div>
          </div>
          <Button
            size="icon"
            variant="ghost"
            aria-label="Dismiss reminder prompt"
            onClick={dismiss}
          >
            <X className="h-4 w-4" aria-hidden="true" />
          </Button>
        </CardContent>
      </Card>
    </div>
  );
}
