"use client";

import { useEffect, useState } from "react";
import { Download, X } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";

type BeforeInstallPromptEvent = Event & {
  prompt: () => Promise<void>;
  userChoice: Promise<{ outcome: "accepted" | "dismissed" }>;
};

const DISMISSED_AT_KEY = "prepcore_install_prompt_dismissed_at";
const DISMISS_WINDOW_MS = 7 * 24 * 60 * 60 * 1000;

function isStandalone() {
  return (
    window.matchMedia("(display-mode: standalone)").matches ||
    ("standalone" in navigator && Boolean(navigator.standalone))
  );
}

// Prepcore - Online PWA foundation
export function InstallPrompt() {
  const [installEvent, setInstallEvent] =
    useState<BeforeInstallPromptEvent | null>(null);
  const [visible, setVisible] = useState(false);

  useEffect(() => {
    if (isStandalone()) return;

    const dismissedAt = Number(localStorage.getItem(DISMISSED_AT_KEY));
    if (Number.isFinite(dismissedAt) && Date.now() - dismissedAt < DISMISS_WINDOW_MS) {
      return;
    }

    const handleBeforeInstallPrompt = (event: Event) => {
      event.preventDefault();
      setInstallEvent(event as BeforeInstallPromptEvent);
      setVisible(true);
    };

    window.addEventListener("beforeinstallprompt", handleBeforeInstallPrompt);
    return () =>
      window.removeEventListener("beforeinstallprompt", handleBeforeInstallPrompt);
  }, []);

  function dismiss() {
    localStorage.setItem(DISMISSED_AT_KEY, String(Date.now()));
    setVisible(false);
    setInstallEvent(null);
  }

  async function install() {
    if (!installEvent) return;
    await installEvent.prompt();
    const choice = await installEvent.userChoice;
    if (choice.outcome === "dismissed") {
      localStorage.setItem(DISMISSED_AT_KEY, String(Date.now()));
    }
    setVisible(false);
    setInstallEvent(null);
  }

  if (!visible || !installEvent) return null;

  return (
    <div className="fixed inset-x-4 bottom-4 z-[60] mx-auto max-w-md">
      <Card className="border-primary/20 shadow-2xl">
        <CardContent className="flex items-center gap-3 p-4">
          <Download className="h-5 w-5 shrink-0 text-primary" aria-hidden="true" />
          <p className="flex-1 text-sm font-medium text-navy dark:text-main">
            Install Prepcore for quick access to your study dashboard.
          </p>
          <Button size="sm" onClick={() => void install()}>
            Install
          </Button>
          <Button
            size="icon"
            variant="ghost"
            aria-label="Dismiss install prompt"
            onClick={dismiss}
          >
            <X className="h-4 w-4" aria-hidden="true" />
          </Button>
        </CardContent>
      </Card>
    </div>
  );
}
