"use client";

import Image from "next/image";
import { AnimatePresence, motion, useReducedMotion } from "framer-motion";
import { useEffect, useState } from "react";
import { useStudyBuddyVisible } from "@/hooks/use-study-buddy-visible";
import { cn } from "@/lib/utils";

export type BuddyPose =
  | "neutral"
  | "wave"
  | "blink"
  | "thinking"
  | "big-smile"
  | "celebrate";

const images: Record<BuddyPose, string> = {
  neutral: "/images/study-buddy/neutral.png",
  wave: "/images/study-buddy/wave.png",
  blink: "/images/study-buddy/blink.png",
  thinking: "/images/study-buddy/thinking.png",
  "big-smile": "/images/study-buddy/big-smile.png",
  celebrate: "/images/study-buddy/celebrate.png",
};

export function StudyBuddy({
  pose,
  size = 150,
  className,
  ambient = false,
}: {
  pose: BuddyPose;
  size?: number;
  className?: string;
  ambient?: boolean;
}) {
  const reducedMotion = useReducedMotion();
  const { visible } = useStudyBuddyVisible();
  const [gesture, setGesture] = useState<BuddyPose | null>(null);
  const [pageVisible, setPageVisible] = useState(true);

  useEffect(() => {
    const syncVisibility = () => setPageVisible(!document.hidden);
    syncVisibility();
    document.addEventListener("visibilitychange", syncVisibility);
    return () =>
      document.removeEventListener("visibilitychange", syncVisibility);
  }, []);

  useEffect(() => {
    if (reducedMotion || !visible || !pageVisible) return;
    if (!ambient && pose !== "neutral") return;

    // A small expression every few seconds; the buddy rests between gestures.
    const actions: { pose: BuddyPose; delay: number; duration: number }[] =
      ambient
        ? [
            { pose: "blink", delay: 5200, duration: 180 },
            { pose: "wave", delay: 8400, duration: 1500 },
            { pose: "blink", delay: 6800, duration: 180 },
            { pose: "thinking", delay: 9200, duration: 1600 },
            { pose: "big-smile", delay: 8000, duration: 1700 },
          ]
        : [{ pose: "blink", delay: 7000, duration: 180 }];
    let actionIndex = 0;
    let actionTimeout: ReturnType<typeof setTimeout>;
    let restTimeout: ReturnType<typeof setTimeout>;
    const queueAction = () => {
      const action = actions[actionIndex % actions.length];
      actionIndex += 1;
      actionTimeout = setTimeout(() => {
        setGesture(action.pose);
        restTimeout = setTimeout(() => {
          setGesture(null);
          queueAction();
        }, action.duration);
      }, action.delay);
    };
    queueAction();
    return () => {
      clearTimeout(actionTimeout);
      clearTimeout(restTimeout);
    };
  }, [ambient, pose, reducedMotion, visible, pageVisible]);

  if (!visible) return null;

  const displayedPose = reducedMotion ? pose : (gesture ?? pose);
  const movement =
    reducedMotion || !pageVisible
      ? { rotate: 0, y: 0, scale: 1 }
      : displayedPose === "celebrate"
        ? { rotate: [0, -5, 5, 0], y: [0, -7, 0], scale: [1, 1.05, 1] }
        : displayedPose === "wave"
          ? { rotate: [0, -3, 3, 0], y: [0, -3, 0], scale: 1 }
          : displayedPose === "thinking"
            ? { rotate: [0, -3, 0], y: 0, scale: 1 }
            : { rotate: 0, y: 0, scale: 1 };

  return (
    <div
      aria-hidden="true"
      className={cn("relative shrink-0", className)}
      style={{ width: size, height: size }}
    >
      <motion.div
        className="absolute inset-0"
        animate={
          ambient && !reducedMotion && pageVisible
            ? { y: [0, -2, 0], scale: [1, 1.015, 1] }
            : { y: 0, scale: 1 }
        }
        transition={
          ambient && !reducedMotion && pageVisible
            ? { duration: 4.8, repeat: Infinity, ease: "easeInOut" }
            : { duration: 0.2 }
        }
      >
        <motion.div
          className="absolute inset-0"
          animate={movement}
          transition={{ duration: reducedMotion ? 0 : 0.75, ease: "easeOut" }}
        >
          <AnimatePresence initial={false} mode="sync">
            <motion.div
              key={displayedPose}
              className="absolute inset-0"
              initial={{ opacity: reducedMotion ? 1 : 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0 }}
              transition={{ duration: reducedMotion ? 0 : 0.14 }}
            >
              <Image
                src={images[displayedPose]}
                alt=""
                fill
                sizes={`${size}px`}
                className="object-contain"
              />
            </motion.div>
          </AnimatePresence>
        </motion.div>
      </motion.div>
    </div>
  );
}

export function BuddyNote({
  message,
  pose = "neutral",
  className,
  zone,
}: {
  message: string;
  pose?: BuddyPose;
  className?: string;
  zone?: "dashboard";
}) {
  const { visible, setVisible } = useStudyBuddyVisible();
  if (!visible) return null;

  return (
    <aside
      className={cn(
        "rounded-2xl border border-blue-200/70 bg-blue-50/80 p-3 dark:border-blue-500/30 dark:bg-slate-800/80",
        className,
      )}
      aria-label="Booky, your study buddy"
    >
      {zone ? (
        <div className="grid grid-cols-[minmax(0,1fr)_minmax(140px,48%)] items-center gap-2 sm:grid-cols-[minmax(0,1fr)_minmax(200px,18rem)]">
          <div className="min-w-0">
            <p className="text-sm leading-6 text-slate-800 dark:text-slate-100">
              {message}
            </p>
            <button
              type="button"
              onClick={() => setVisible(false)}
              className="mt-2 min-h-10 rounded-lg px-3 py-2 text-xs font-medium text-blue-800 underline-offset-2 hover:underline focus-visible:outline focus-visible:outline-2 focus-visible:outline-blue-600 dark:text-blue-200"
              aria-label="Hide Booky"
            >
              Hide Booky
            </button>
          </div>
          <div
            data-buddy-zone={zone}
            data-buddy-mood={pose}
            className="pointer-events-none relative h-48 w-full overflow-hidden rounded-xl"
          />
        </div>
      ) : (
        <div className="flex items-center gap-3">
          <StudyBuddy pose={pose} size={78} />
          <p className="min-w-0 flex-1 text-sm leading-6 text-slate-800 dark:text-slate-100">
            {message}
          </p>
          <button
            type="button"
            onClick={() => setVisible(false)}
            className="min-h-10 self-start rounded-lg px-3 py-2 text-xs font-medium text-blue-800 underline-offset-2 hover:underline focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600 dark:text-blue-200"
            aria-label="Hide Booky"
          >
            Hide
          </button>
        </div>
      )}
    </aside>
  );
}
