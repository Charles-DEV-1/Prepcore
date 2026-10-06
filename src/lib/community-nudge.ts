const DAY_MS = 24 * 60 * 60 * 1000;
const FIRST_SHOW_DELAY_MS = 2 * DAY_MS;
const REPEAT_DELAY_MS = 7 * DAY_MS;
const DISMISS_DELAY_MS = 30 * DAY_MS;
const OPEN_DELAY_MS = 90 * DAY_MS;

type NudgeState = {
  firstSeenAt: number;
  lastShownAt: number;
  snoozedUntil: number;
};

type StorageLike = Pick<Storage, "getItem" | "setItem">;

function storageKey(userId: string): string {
  return `prepcore.community-nudge.v1.${userId}`;
}

function readState(storage: StorageLike, userId: string): NudgeState | null {
  const raw = storage.getItem(storageKey(userId));
  if (!raw) return null;
  try {
    const value: unknown = JSON.parse(raw);
    if (!value || typeof value !== "object") return null;
    const state = value as Partial<NudgeState>;
    if (
      !Number.isFinite(state.firstSeenAt) ||
      !Number.isFinite(state.lastShownAt) ||
      !Number.isFinite(state.snoozedUntil)
    ) return null;
    return state as NudgeState;
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
  const state = readState(storage, userId);
  if (!state) {
    writeState(storage, userId, {
      firstSeenAt: now,
      lastShownAt: 0,
      snoozedUntil: 0,
    });
    return false;
  }
  return (
    now - state.firstSeenAt >= FIRST_SHOW_DELAY_MS &&
    now - state.lastShownAt >= REPEAT_DELAY_MS &&
    now >= state.snoozedUntil
  );
}

export function recordCommunityNudge(
  storage: StorageLike,
  userId: string,
  action: "shown" | "dismissed" | "opened",
  now: number,
): void {
  const state = readState(storage, userId);
  if (!state) return;
  if (action === "shown") state.lastShownAt = now;
  if (action === "dismissed") state.snoozedUntil = now + DISMISS_DELAY_MS;
  if (action === "opened") state.snoozedUntil = now + OPEN_DELAY_MS;
  writeState(storage, userId, state);
}
