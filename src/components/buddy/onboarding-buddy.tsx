"use client";

import Image from "next/image";
import { AnimatePresence, motion, useReducedMotion } from "framer-motion";
import { useEffect, useState } from "react";

export type OnboardingBuddyPose =
  | "wave"
  | "thinking"
  | "encouraging"
  | "cheering"
  | "celebrating";

const poseImages: Record<OnboardingBuddyPose, string> = {
  wave: "/images/study-buddy/wave.png",
  thinking: "/images/study-buddy/thinking.png",
  encouraging: "/images/study-buddy/big-smile.png",
  cheering: "/images/study-buddy/big-smile.png",
  celebrating: "/images/study-buddy/celebrate.png",
};

function BuddySpeech({
  message,
  reducedMotion,
}: {
  message: string;
  reducedMotion: boolean;
}) {
  const [typing, setTyping] = useState(!reducedMotion);
  useEffect(() => {
    if (!typing) return;
    const finish = window.setTimeout(() => setTyping(false), 550);
    return () => window.clearTimeout(finish);
  }, [typing]);
  return (
    <div
      role="status"
      aria-live="polite"
      className="mt-1 text-sm font-medium leading-6 sm:text-base"
    >
      {typing ? (
        <span aria-hidden="true" className="inline-flex gap-1">
          {[0, 1, 2].map((dot) => (
            <motion.span
              key={dot}
              className="h-1.5 w-1.5 rounded-full bg-blue-600 dark:bg-blue-300"
              animate={{ opacity: [0.35, 1, 0.35], y: [0, -3, 0] }}
              transition={{
                duration: 0.5,
                repeat: Infinity,
                delay: dot * 0.11,
              }}
            />
          ))}
        </span>
      ) : (
        message
      )}
    </div>
  );
}

/** Booky's compact, conversational stage. The question remains above the fold. */
export function OnboardingBuddy({
  message,
  pose,
}: {
  message: string;
  pose: OnboardingBuddyPose;
}) {
  const reducedMotion = Boolean(useReducedMotion());
  const poseMovement =
    pose === "celebrating"
      ? {
          opacity: 1,
          y: [5, -13, 0, -6, 0],
          rotate: [0, -5, 5, -2, 0],
          scale: [0.94, 1.08, 0.98, 1.04, 1],
        }
      : pose === "wave"
        ? {
            opacity: 1,
            y: [5, -6, 0],
            rotate: [0, -7, 5, 0],
            scale: [0.94, 1.04, 1],
          }
        : pose === "cheering"
          ? {
              opacity: 1,
              y: [5, -9, 0],
              rotate: [0, -3, 0],
              scale: [0.94, 1.06, 1],
            }
          : pose === "thinking"
            ? { opacity: 1, y: [5, 0], rotate: [0, -4, 0], scale: [0.94, 1] }
            : {
                opacity: 1,
                y: [5, -4, 0],
                rotate: [0, 2, 0],
                scale: [0.94, 1.03, 1],
              };

  return (
    <aside
      aria-label="Booky, your study buddy"
      className="flex items-center gap-3 sm:gap-5"
    >
      <motion.div
        aria-hidden="true"
        className="relative h-24 w-24 shrink-0 sm:h-32 sm:w-32"
        initial={false}
        animate={
          reducedMotion ? undefined : { y: [0, -5, 0], rotate: [0, -2, 0] }
        }
        transition={{ duration: 2.8, repeat: Infinity, ease: "easeInOut" }}
      >
        <AnimatePresence mode="wait" initial={false}>
          <motion.div
            key={pose}
            className="absolute inset-0"
            initial={reducedMotion ? false : { opacity: 0, scale: 0.94, y: 6 }}
            animate={
              reducedMotion
                ? { opacity: 1, scale: 1, y: 0, rotate: 0 }
                : poseMovement
            }
            exit={reducedMotion ? undefined : { opacity: 0, scale: 0.96 }}
            transition={{
              duration: reducedMotion ? 0 : pose === "celebrating" ? 0.9 : 0.6,
              ease: "easeOut",
            }}
          >
            <Image
              src={poseImages[pose]}
              alt=""
              fill
              priority
              sizes="(min-width: 640px) 128px, 96px"
              className="object-contain"
            />
          </motion.div>
        </AnimatePresence>
      </motion.div>
      <div className="relative min-h-20 flex-1 rounded-2xl border border-blue-300 bg-blue-50 px-4 py-3 text-slate-900 shadow-sm before:absolute before:-left-2 before:top-9 before:h-3 before:w-3 before:rotate-45 before:border-b before:border-l before:border-blue-300 before:bg-blue-50 dark:border-blue-500/50 dark:bg-slate-800 dark:text-slate-100 dark:before:border-blue-500/50 dark:before:bg-slate-800">
        <p className="text-xs font-bold uppercase tracking-wider text-blue-800 dark:text-blue-200">
          Booky
        </p>
        <BuddySpeech
          key={message}
          message={message}
          reducedMotion={reducedMotion}
        />
      </div>
    </aside>
  );
}
