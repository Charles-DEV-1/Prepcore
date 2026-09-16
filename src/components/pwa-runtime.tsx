"use client";

import { useEffect } from "react";
import { InstallPrompt } from "@/components/install-prompt";

// Prepcore - Online PWA foundation
export function PwaRuntime() {
  useEffect(() => {
    if ("serviceWorker" in navigator) {
      void navigator.serviceWorker.register("/sw.js", { scope: "/" });
    }
  }, []);

  return <InstallPrompt />;
}
