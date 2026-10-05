"use client";

import { motion, useReducedMotion } from "framer-motion";
import { useEffect, useMemo, useRef, useState } from "react";
import { createPortal } from "react-dom";
import { usePathname } from "next/navigation";
import { Sparkles } from "lucide-react";
import { useStudyBuddyVisible } from "@/hooks/use-study-buddy-visible";
import {
  BUDDY_WALK_FRAMES,
  BuddySprite,
  type BuddyFrame,
} from "./buddy-sprite";
import { buddyPlacementForPath, type BuddyPlacement } from "./buddy-policy";
import type { BuddyPose } from "./study-buddy";

type BuddyPhase = "idle" | "anticipating" | "walking" | "arriving";

const DESTINATIONS = [0.82, 0.08, 0.7, 0.18];
const REST_SECONDS = [17, 23, 20, 27];
const WALK_FRAME_SECONDS = 0.2;
const WALK_CYCLE_SECONDS = WALK_FRAME_SECONDS * BUDDY_WALK_FRAMES.length;

function BuddyHabitat({
  placement,
  host,
  magicPhase,
}: {
  placement: BuddyPlacement;
  host: HTMLElement;
  magicPhase: "settled" | "vanishing" | "appearing";
}) {
  const reducedMotion = useReducedMotion();
  const { visible } = useStudyBuddyVisible();
  const [width, setWidth] = useState(0);
  const [inView, setInView] = useState(true);
  const [pageVisible, setPageVisible] = useState(true);
  const [phase, setPhase] = useState<BuddyPhase>("idle");
  const [targetX, setTargetX] = useState(0);
  const [travelSeconds, setTravelSeconds] = useState(WALK_CYCLE_SECONDS * 2);
  const [frameIndex, setFrameIndex] = useState(0);
  const [idleGesture, setIdleGesture] = useState<BuddyFrame | null>(null);
  const [reaction, setReaction] = useState(false);
  const [facing, setFacing] = useState<1 | -1>(1);
  const destinationIndex = useRef(0);
  const currentX = useRef(0);
  const reactionTimeout = useRef<ReturnType<typeof setTimeout> | null>(null);

  useEffect(() => {
    const measure = () => setWidth(host.getBoundingClientRect().width);
    measure();
    if (!window.ResizeObserver) {
      window.addEventListener("resize", measure);
      return () => {
        window.removeEventListener("resize", measure);
      };
    }
    const observer = new ResizeObserver(measure);
    observer.observe(host);
    return () => {
      observer.disconnect();
    };
  }, [host]);

  useEffect(() => {
    if (!window.IntersectionObserver) return;
    const observer = new IntersectionObserver(([entry]) => {
      setInView(entry.isIntersecting);
    });
    observer.observe(host);
    return () => observer.disconnect();
  }, [host]);

  useEffect(() => {
    const sync = () => setPageVisible(!document.hidden);
    sync();
    document.addEventListener("visibilitychange", sync);
    return () => document.removeEventListener("visibilitychange", sync);
  }, []);

  useEffect(() => {
    return () => {
      if (reactionTimeout.current) clearTimeout(reactionTimeout.current);
    };
  }, []);

  const size = Math.min(placement.size, Math.max(0, (width - 16) / 1.18));
  const buttonWidth = Math.round(size * 1.18);
  const buttonHeight = Math.round(size + 16);
  const canWalk =
    placement.mode === "wander" &&
    visible &&
    !reducedMotion &&
    magicPhase === "settled" &&
    pageVisible &&
    inView &&
    width >= buttonWidth + 48;

  useEffect(() => {
    if (!canWalk) {
      const frame = requestAnimationFrame(() => {
        setPhase("idle");
        setTargetX(0);
        currentX.current = 0;
      });
      return () => cancelAnimationFrame(frame);
    }

    let timer: ReturnType<typeof setTimeout>;
    let stopped = false;
    const beginWalk = () => {
      if (stopped) return;
      const next =
        Math.max(0, width - buttonWidth - 16) *
        DESTINATIONS[destinationIndex.current % DESTINATIONS.length];
      destinationIndex.current += 1;
      const distance = Math.abs(next - currentX.current);
      const cycles = Math.max(2, Math.round(distance / 42));
      const duration = cycles * WALK_CYCLE_SECONDS;
      setFacing(next >= currentX.current ? 1 : -1);
      currentX.current = next;
      setFrameIndex(0);
      setTravelSeconds(duration);
      setTargetX(next);
      setPhase("walking");
      timer = setTimeout(() => {
        setPhase("arriving");
        timer = setTimeout(scheduleRest, 440);
      }, duration * 1000);
    };
    const readyWalk = () => {
      if (stopped) return;
      setPhase("anticipating");
      timer = setTimeout(beginWalk, 300);
    };
    const scheduleRest = () => {
      if (stopped) return;
      setPhase("idle");
      const rest = REST_SECONDS[destinationIndex.current % REST_SECONDS.length];
      timer = setTimeout(readyWalk, rest * 1000);
    };
    // The first short walk is visible soon after dashboard entry; later walks rest.
    timer = setTimeout(readyWalk, 3700);
    return () => {
      stopped = true;
      clearTimeout(timer);
    };
  }, [canWalk, buttonWidth, width]);

  useEffect(() => {
    if (phase !== "walking" || !canWalk) return;
    const interval = setInterval(() => {
      setFrameIndex((previous) => (previous + 1) % BUDDY_WALK_FRAMES.length);
    }, WALK_FRAME_SECONDS * 1000);
    return () => clearInterval(interval);
  }, [phase, canWalk]);

  useEffect(() => {
    if (
      phase !== "idle" ||
      !visible ||
      reducedMotion ||
      !pageVisible ||
      !inView ||
      magicPhase !== "settled"
    )
      return;
    const gestures: { frame: BuddyFrame; rest: number; duration: number }[] = [
      { frame: "blink", rest: 5700, duration: 160 },
      { frame: "look", rest: 7600, duration: 1150 },
      { frame: "blink", rest: 6900, duration: 160 },
    ];
    let index = 0;
    let timer: ReturnType<typeof setTimeout>;
    let stopped = false;
    const next = () => {
      const gesture = gestures[index % gestures.length];
      index += 1;
      timer = setTimeout(() => {
        if (stopped) return;
        setIdleGesture(gesture.frame);
        timer = setTimeout(() => {
          setIdleGesture(null);
          next();
        }, gesture.duration);
      }, gesture.rest);
    };
    next();
    return () => {
      stopped = true;
      clearTimeout(timer);
      setIdleGesture(null);
    };
  }, [phase, visible, reducedMotion, pageVisible, inView, magicPhase]);

  if (!visible || width < 72) return null;

  const mood = host.dataset.buddyMood as BuddyPose | undefined;
  const idlePose: BuddyPose =
    mood &&
    ["neutral", "wave", "thinking", "big-smile", "celebrate"].includes(mood)
      ? mood
      : placement.mode === "react"
        ? "big-smile"
        : "neutral";
  const activePhase = canWalk ? phase : "idle";
  const idleFrame: BuddyFrame = idlePose === "neutral" ? "stand" : idlePose;
  const displayedFrame: BuddyFrame =
    activePhase === "walking"
      ? BUDDY_WALK_FRAMES[frameIndex]
      : reaction
        ? "wave"
        : (idleGesture ?? idleFrame);

  const respond = () => {
    if (activePhase !== "idle" || reducedMotion) return;
    setReaction(true);
    if (reactionTimeout.current) clearTimeout(reactionTimeout.current);
    reactionTimeout.current = setTimeout(() => setReaction(false), 1500);
  };

  return (
    <div
      className="pointer-events-none relative h-full w-full overflow-hidden"
      data-buddy-phase={activePhase}
    >
      <motion.button
        type="button"
        className="pointer-events-auto absolute bottom-0 left-2 block cursor-pointer rounded-full focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600"
        style={{ width: buttonWidth, height: buttonHeight }}
        aria-label="Wave to Booky"
        onClick={respond}
        initial={reducedMotion ? false : { opacity: 0, y: 12, scale: 0.48 }}
        animate={{
          opacity: magicPhase === "vanishing" ? 0 : 1,
          x: Math.min(targetX, Math.max(0, width - buttonWidth - 16)),
          y:
            magicPhase === "vanishing"
              ? -8
              : activePhase === "anticipating"
                ? 3
                : activePhase === "arriving"
                  ? 1
                  : 0,
          scale:
            magicPhase === "vanishing"
              ? 0.45
              : activePhase === "anticipating"
                ? 0.97
                : 1,
          rotate: magicPhase === "vanishing" ? -10 : 0,
        }}
        transition={{
          opacity: { duration: 0.38 },
          x: {
            duration: activePhase === "walking" ? travelSeconds : 0.35,
            ease: [0.25, 0.08, 0.72, 0.94],
          },
          y: { duration: 0.38, ease: "easeOut" },
          scale: { duration: 0.38, ease: [0.2, 0.8, 0.2, 1] },
          rotate: { duration: 0.38 },
        }}
      >
        {magicPhase !== "settled" && !reducedMotion && (
          <span
            aria-hidden="true"
            className="pointer-events-none absolute inset-0 z-10"
          >
            {[
              {
                position: "-right-1 top-1",
                offsetX: 8,
                offsetY: -11,
                delay: 0,
              },
              {
                position: "left-0 top-4",
                offsetX: -8,
                offsetY: -8,
                delay: 0.06,
              },
              {
                position: "right-3 bottom-2",
                offsetX: 7,
                offsetY: 10,
                delay: 0.12,
              },
            ].map((sparkle) => (
              <motion.span
                key={sparkle.position}
                className={`absolute ${sparkle.position} text-amber-500 dark:text-amber-300`}
                initial={{ opacity: 0, scale: 0.45, x: 0, y: 0 }}
                animate={{
                  opacity: [0, 0.9, 0],
                  scale: [0.45, 1, 0.65],
                  x: sparkle.offsetX,
                  y: sparkle.offsetY,
                }}
                transition={{
                  duration: 0.48,
                  delay: sparkle.delay,
                  ease: "easeOut",
                }}
              >
                <Sparkles className="h-5 w-5" />
              </motion.span>
            ))}
          </span>
        )}
        <motion.div
          className="h-full w-full"
          animate={
            activePhase === "walking"
              ? { y: [0, -3, 0, -3, 0], rotate: [0, 1, 0, -1, 0], scale: 1 }
              : activePhase === "anticipating"
                ? { y: 3, rotate: -3, scale: 0.97 }
                : activePhase === "arriving"
                  ? { y: [0, 2, 0], rotate: [0, 2, 0], scale: 1 }
                  : reducedMotion || !pageVisible || !inView
                    ? { y: 0, rotate: 0, scale: 1 }
                    : { y: [0, -1, 0], rotate: 0, scale: [1, 1.012, 1] }
          }
          transition={
            activePhase === "walking"
              ? {
                  duration: WALK_CYCLE_SECONDS,
                  repeat: Infinity,
                  ease: "easeInOut",
                }
              : activePhase === "idle" && !reducedMotion && pageVisible && inView
                ? { duration: 4.8, repeat: Infinity, ease: "easeInOut" }
              : { duration: 0.32, ease: "easeOut" }
          }
          style={{ scaleX: facing }}
        >
          <BuddySprite
            frame={displayedFrame}
            visibleHeight={size}
            preloadWalk={placement.mode === "wander"}
          />
        </motion.div>
      </motion.button>
    </div>
  );
}

/** Mounted once in AppShell; pages opt in with an empty data-buddy-slot. */
export function BuddyController({
  mobileMenuOpen,
}: {
  mobileMenuOpen: boolean;
}) {
  const pathname = usePathname();
  const placement = useMemo(() => buddyPlacementForPath(pathname), [pathname]);
  const reducedMotion = useReducedMotion();
  const { visible: buddyVisible } = useStudyBuddyVisible();
  const [zones, setZones] = useState<HTMLElement[]>([]);
  const [zoneIndex, setZoneIndex] = useState(0);
  const currentIndex = useRef(0);
  const lastScrollAt = useRef(0);
  const [magicPhase, setMagicPhase] = useState<
    "settled" | "vanishing" | "appearing"
  >("settled");
  const [dialogOpen, setDialogOpen] = useState(false);

  useEffect(() => {
    const markScroll = () => {
      lastScrollAt.current = performance.now();
    };
    window.addEventListener("scroll", markScroll, { passive: true });
    return () => window.removeEventListener("scroll", markScroll);
  }, []);

  useEffect(() => {
    if (!placement) return;
    const locate = () => {
      const found = Array.from(
        document.querySelectorAll<HTMLElement>(
          `[data-buddy-zone="${placement.slot}"]`,
        ),
      ).filter(
        (node) =>
          node.isConnected &&
          getComputedStyle(node).display !== "none" &&
          node.getBoundingClientRect().width >= 72,
      );
      setZones((previous) =>
        previous.length === found.length &&
        previous.every((node, index) => node === found[index])
          ? previous
          : found,
      );
    };
    locate();
    const observer = new MutationObserver(locate);
    const main = document.querySelector("main");
    if (main) observer.observe(main, { childList: true, subtree: true });
    window.addEventListener("resize", locate);
    return () => {
      observer.disconnect();
      window.removeEventListener("resize", locate);
    };
  }, [pathname, placement]);

  useEffect(() => {
    currentIndex.current = 0;
    const frame = requestAnimationFrame(() => {
      setZoneIndex(0);
      setMagicPhase("settled");
    });
    return () => cancelAnimationFrame(frame);
  }, [pathname]);

  useEffect(() => {
    const check = () => {
      setDialogOpen(
        Boolean(document.querySelector('[aria-modal="true"], dialog[open]')),
      );
    };
    const frame = requestAnimationFrame(check);
    const observer = new MutationObserver(check);
    observer.observe(document.body, {
      childList: true,
      subtree: true,
      attributes: true,
      attributeFilter: ["aria-modal", "data-state", "open"],
    });
    return () => {
      cancelAnimationFrame(frame);
      observer.disconnect();
    };
  }, []);

  useEffect(() => {
    if (
      !placement ||
      !buddyVisible ||
      zones.length < 2 ||
      mobileMenuOpen ||
      dialogOpen ||
      reducedMotion
    )
      return;
    let timer: ReturnType<typeof setTimeout>;
    let stopped = false;
    const considerJump = () => {
      if (stopped) return;
      const currentHost = zones[currentIndex.current];
      const currentPhase = currentHost
        ?.querySelector("[data-buddy-phase]")
        ?.getAttribute("data-buddy-phase");
      const visible = zones
        .map((node, index) => ({ node, index }))
        .filter(({ node }) => {
          const rect = node.getBoundingClientRect();
          return (
            rect.width >= 72 &&
            rect.top < window.innerHeight - 20 &&
            rect.bottom > 20
          );
        });
      const focused = document.activeElement;
      const typing =
        focused instanceof HTMLElement &&
        (focused.matches("input, textarea, select") || focused.isContentEditable);
      if (
        document.hidden ||
        typing ||
        performance.now() - lastScrollAt.current < 4000 ||
        currentPhase === "walking" ||
        visible.length < 2
      ) {
        timer = setTimeout(considerJump, 10_000);
        return;
      }
      const next = visible.find(({ index }) => index !== currentIndex.current);
      if (!next) {
        timer = setTimeout(considerJump, 10_000);
        return;
      }
      setMagicPhase("vanishing");
      timer = setTimeout(() => {
        currentIndex.current = next.index;
        setZoneIndex(next.index);
        setMagicPhase("appearing");
        timer = setTimeout(() => {
          setMagicPhase("settled");
          timer = setTimeout(considerJump, 68_000);
        }, 560);
      }, 340);
    };
    timer = setTimeout(considerJump, 42_000);
    return () => {
      stopped = true;
      clearTimeout(timer);
    };
  }, [placement, buddyVisible, zones, mobileMenuOpen, dialogOpen, reducedMotion]);

  const host = zones[zoneIndex] ?? zones[0];
  if (
    !placement ||
    !buddyVisible ||
    !host ||
    !host.isConnected ||
    host.dataset.buddyZone !== placement.slot ||
    mobileMenuOpen ||
    dialogOpen
  ) {
    return null;
  }
  return createPortal(
    <BuddyHabitat
      key={`${pathname}:${placement.slot}:${zoneIndex}`}
      host={host}
      placement={placement}
      magicPhase={magicPhase}
    />,
    host,
  );
}
