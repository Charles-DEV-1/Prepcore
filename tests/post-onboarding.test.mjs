import assert from "node:assert/strict";
import test from "node:test";
import {
  postOnboardingWelcomeHref,
  safePostOnboardingDestination,
} from "../src/lib/post-onboarding.ts";

const starterPath =
  "/practice?intro=1&exam=jamb&subject=11111111-1111-1111-1111-111111111111";

test("the welcome step keeps the selected starter practice", () => {
  const welcomeUrl = new URL(postOnboardingWelcomeHref(starterPath), "https://example.com");
  assert.equal(welcomeUrl.pathname, "/welcome");
  assert.equal(
    safePostOnboardingDestination(welcomeUrl.searchParams.get("next") ?? undefined),
    starterPath,
  );
});

test("the welcome step only continues to safe internal destinations", () => {
  assert.equal(safePostOnboardingDestination("/dashboard"), "/dashboard");
  for (const unsafe of [
    "https://example.com",
    "//example.com",
    "/upgrade",
    "/practice?intro=1&exam=jamb&subject=not-a-uuid",
    "/practice?intro=1&exam=jamb&subject=11111111-1111-1111-1111-111111111111&next=//example.com",
    [starterPath],
    undefined,
  ]) {
    assert.equal(safePostOnboardingDestination(unsafe), "/dashboard");
  }
});
