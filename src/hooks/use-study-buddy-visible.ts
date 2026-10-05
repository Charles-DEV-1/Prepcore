"use client";

import {
  createContext,
  createElement,
  useCallback,
  useContext,
  useEffect,
  useMemo,
  useState,
} from "react";
import {
  buddyVisibilityStorageKey,
  readBuddyVisibility,
} from "@/lib/buddy-visibility";

type BuddyVisibilityContextValue = {
  visible: boolean;
  ready: boolean;
  setVisible: (next: boolean) => void;
};

const BuddyVisibilityContext =
  createContext<BuddyVisibilityContextValue | null>(null);

export function BuddyVisibilityProvider({
  userId,
  children,
}: {
  userId: string;
  children: React.ReactNode;
}) {
  // Avoid briefly showing an intentionally hidden Buddy during hydration.
  const [visible, setState] = useState(false);
  const [ready, setReady] = useState(false);

  useEffect(() => {
    const key = buddyVisibilityStorageKey(userId);
    const read = () => {
      try {
        setState(readBuddyVisibility(window.localStorage, userId));
      } catch {
        setState(true);
      }
      setReady(true);
    };
    read();
    const onStorage = (event: StorageEvent) => {
      if (event.key === key || event.key === null) read();
    };
    window.addEventListener("storage", onStorage);
    return () => window.removeEventListener("storage", onStorage);
  }, [userId]);

  const setVisible = useCallback(
    (next: boolean) => {
      setState(next);
      try {
        window.localStorage.setItem(
          buddyVisibilityStorageKey(userId),
          String(next),
        );
      } catch {
        // Still honor the choice for this visit if storage is unavailable.
      }
    },
    [userId],
  );

  const value = useMemo(
    () => ({ visible, ready, setVisible }),
    [visible, ready, setVisible],
  );
  return createElement(BuddyVisibilityContext.Provider, { value }, children);
}

export function useStudyBuddyVisible(): BuddyVisibilityContextValue {
  const context = useContext(BuddyVisibilityContext);
  if (!context)
    throw new Error("Booky visibility must be used inside AppShell");
  return context;
}
