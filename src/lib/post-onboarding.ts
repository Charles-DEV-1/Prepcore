const STARTER_PRACTICE_PATH =
  /^\/practice\?intro=1&exam=(jamb|waec)&subject=([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})$/i;

export function postOnboardingWelcomeHref(destination: string): string {
  return `/welcome?next=${encodeURIComponent(destination)}`;
}

export function safePostOnboardingDestination(
  value: string | string[] | undefined,
): string {
  if (typeof value !== "string") return "/dashboard";
  if (value === "/dashboard") return value;

  const match = STARTER_PRACTICE_PATH.exec(value);
  if (!match) return "/dashboard";

  return `/practice?intro=1&exam=${match[1].toLowerCase()}&subject=${match[2].toLowerCase()}`;
}
