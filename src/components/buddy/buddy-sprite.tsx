"use client";

import Image from "next/image";

export type BuddyFrame =
  | "stand"
  | "blink"
  | "look"
  | "wave"
  | "big-smile"
  | "thinking"
  | "celebrate"
  | "step-right"
  | "pass-right"
  | "step-left"
  | "pass-left";

type FrameAsset = {
  src: string;
  canvas: [number, number];
  bounds: [number, number, number, number];
};

/** Alpha bounds keep unlike source canvases aligned at the feet and centre. */
const FRAMES: Record<BuddyFrame, FrameAsset> = {
  stand: {
    src: "/images/study-buddy/Prepcore_Buddy_character_standin__20261004181735-removebg-preview.png",
    canvas: [373, 669],
    bounds: [19, 133, 337, 363],
  },
  blink: {
    src: "/images/study-buddy/Character_blinking_in_open_book_20261004181654-removebg-preview.png",
    canvas: [373, 669],
    bounds: [27, 162, 326, 351],
  },
  look: {
    src: "/images/study-buddy/Character_looking_left_20261004181703-removebg-preview.png",
    canvas: [373, 669],
    bounds: [17, 138, 345, 374],
  },
  wave: {
    src: "/images/study-buddy/wave.png",
    canvas: [250, 250],
    bounds: [25, 41, 188, 182],
  },
  "big-smile": {
    src: "/images/study-buddy/big-smile.png",
    canvas: [250, 250],
    bounds: [52, 29, 143, 185],
  },
  thinking: {
    src: "/images/study-buddy/thinking.png",
    canvas: [250, 250],
    bounds: [50, 41, 163, 182],
  },
  celebrate: {
    src: "/images/study-buddy/celebrate.png",
    canvas: [250, 250],
    bounds: [19, 41, 216, 180],
  },
  "step-right": {
    src: "/images/study-buddy/Character_walking_right_20261004181605-removebg-preview.png",
    canvas: [373, 669],
    bounds: [19, 129, 327, 359],
  },
  "pass-right": {
    src: "/images/study-buddy/Character_walking_right_20261004181613-removebg-preview.png",
    canvas: [373, 669],
    bounds: [34, 130, 298, 339],
  },
  "step-left": {
    src: "/images/study-buddy/Mascot_character_walking_right_20261004181647-removebg-preview.png",
    canvas: [373, 669],
    bounds: [19, 149, 341, 349],
  },
  "pass-left": {
    src: "/images/study-buddy/Character_walking_to_right_20261004181723-removebg-preview.png",
    canvas: [373, 669],
    bounds: [22, 122, 338, 364],
  },
};

export const BUDDY_WALK_FRAMES: BuddyFrame[] = [
  "step-right",
  "pass-right",
  "step-left",
  "pass-left",
];

export function BuddySprite({
  frame,
  visibleHeight,
  preloadWalk = false,
}: {
  frame: BuddyFrame;
  visibleHeight: number;
  preloadWalk?: boolean;
}) {
  const shown = preloadWalk
    ? (["stand", "blink", "look", ...BUDDY_WALK_FRAMES] as BuddyFrame[])
    : [frame];
  if (!shown.includes(frame)) shown.push(frame);

  return (
    <span
      aria-hidden="true"
      className="relative block h-full w-full overflow-hidden"
    >
      {shown.map((name) => {
        const asset = FRAMES[name];
        const [canvasWidth, canvasHeight] = asset.canvas;
        const [left, top, width, height] = asset.bounds;
        const scale = visibleHeight / height;
        return (
          <Image
            key={name}
            src={asset.src}
            alt=""
            width={canvasWidth}
            height={canvasHeight}
            unoptimized
            loading="eager"
            draggable={false}
            className="pointer-events-none absolute max-w-none select-none"
            style={{
              width: canvasWidth,
              height: canvasHeight,
              left: `calc(50% - ${(left + width / 2) * scale}px)`,
              top: 16 - top * scale,
              transform: `scale(${scale})`,
              transformOrigin: "top left",
              opacity: name === frame ? 1 : 0,
            }}
          />
        );
      })}
    </span>
  );
}
