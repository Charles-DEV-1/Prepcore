export const DAILY_FLASHCARD_COUNT = 15;
export const DAILY_QUESTION_CARD_COUNT = 15;

const DAY_IN_MS = 24 * 60 * 60 * 1000;

export function getLagosDayNumber(date: Date): number {
  const parts = new Intl.DateTimeFormat("en-US", {
    timeZone: "Africa/Lagos",
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
  }).formatToParts(date);
  const values = Object.fromEntries(
    parts.map((part) => [part.type, part.value]),
  );

  return Math.floor(
    Date.UTC(
      Number(values.year),
      Number(values.month) - 1,
      Number(values.day),
    ) / DAY_IN_MS,
  );
}

export function getDailyFlashcards<T>(
  cards: T[],
  dayNumber: number,
  count = DAILY_FLASHCARD_COUNT,
): T[] {
  if (cards.length === 0) return [];

  const cardsToday = Math.min(count, cards.length);
  const start = getDailyStartIndex(cards.length, dayNumber, count);

  return Array.from(
    { length: cardsToday },
    (_, index) => cards[(start + index) % cards.length],
  );
}

export function getDailyStartIndex(
  total: number,
  dayNumber: number,
  count: number,
): number {
  return total > 0 ? (dayNumber * count) % total : 0;
}
