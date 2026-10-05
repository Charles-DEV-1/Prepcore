export type BuddyPlacement = {
  slot: "dashboard" | "progress" | "results" | "flashcards" | "profile";
  mode: "wander" | "quiet" | "react";
  size: number;
};

/** Only opt-in pages with a reserved, non-interactive space may host Buddy. */
export function buddyPlacementForPath(pathname: string): BuddyPlacement | null {
  if (pathname === "/dashboard") {
    return { slot: "dashboard", mode: "wander", size: 160 };
  }
  if (pathname === "/progress") {
    return { slot: "progress", mode: "quiet", size: 124 };
  }
  if (pathname.startsWith("/results/")) {
    return { slot: "results", mode: "react", size: 136 };
  }
  if (pathname === "/flashcards") {
    return { slot: "flashcards", mode: "quiet", size: 120 };
  }
  if (pathname === "/profile") {
    return { slot: "profile", mode: "quiet", size: 120 };
  }
  // Practice, timed exams, forms, administration, and pages without a safe
  // reserved slot deliberately have no ambient companion.
  return null;
}
