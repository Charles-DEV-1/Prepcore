const DAY_MS = 24 * 60 * 60 * 1000;
const DISMISS_DELAY_MS = 30 * DAY_MS;
const OPEN_DELAY_MS = 90 * DAY_MS;

type NudgeState = {
  snoozedUntil: number;
};

type StorageLike = Pick<Storage, "getItem" | "setItem">;

function storageKey(userId: string): string {
  // This is a new, visible dashboard announcement. Previous nudge impressions
  // must not silently suppress it for accounts that missed the old toast.
  return `prepcore.community-nudge.v2.${userId}`;
}

function readState(storage: StorageLike, userId: string): NudgeState | null {
  const raw = storage.getItem(storageKey(userId));
  if (!raw) return null;
  try {
    const value: unknown = JSON.parse(raw);
    if (!value || typeof value !== "object") return null;
    const state = value as Partial<NudgeState>;
    const snoozedUntil = state.snoozedUntil;
    if (typeof snoozedUntil !== "number" || !Number.isFinite(snoozedUntil))
      return null;
    return { snoozedUntil };
  } catch {
    return null;
  }
}

function writeState(storage: StorageLike, userId: string, state: NudgeState) {
  storage.setItem(storageKey(userId), JSON.stringify(state));
}

export function shouldShowCommunityNudge(
  storage: StorageLike,
  userId: string,
  now: number,
): boolean {
  if (!userId) return false;
  const state = readState(storage, userId);
  // An unseen update is visible right away and remains visible until acted on.
  // The new campaign is independent of the old delayed toast.
  return !state || now >= state.snoozedUntil;
}

export function recordCommunityNudge(
  storage: StorageLike,
  userId: string,
  action: "dismissed" | "opened",
  now: number,
): void {
  if (!userId) return;
  writeState(storage, userId, {
    snoozedUntil:
      now + (action === "opened" ? OPEN_DELAY_MS : DISMISS_DELAY_MS),
  });
}
