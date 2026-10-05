import assert from "node:assert/strict";
import test from "node:test";
import {
  buddyVisibilityStorageKey,
  readBuddyVisibility,
} from "../src/lib/buddy-visibility.ts";

test("Booky's hide setting belongs to one account, not the browser", () => {
  const firstUser = "11111111-1111-4111-8111-111111111111";
  const newUser = "22222222-2222-4222-8222-222222222222";
  const saved = new Map([
    ["prepcore:study-buddy-visible", "false"], // obsolete browser-wide setting
    [buddyVisibilityStorageKey(firstUser), "false"],
  ]);
  const storage = { getItem: (key) => saved.get(key) ?? null };

  assert.notEqual(
    buddyVisibilityStorageKey(firstUser),
    buddyVisibilityStorageKey(newUser),
  );
  assert.equal(readBuddyVisibility(storage, firstUser), false);
  assert.equal(readBuddyVisibility(storage, newUser), true);
  saved.set(buddyVisibilityStorageKey(firstUser), "true");
  assert.equal(readBuddyVisibility(storage, firstUser), true);
});
