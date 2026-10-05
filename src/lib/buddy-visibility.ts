/** A browser preference belongs to the authenticated account, not the device. */
export function buddyVisibilityStorageKey(userId: string): string {
  return `prepcore:study-buddy-visible:v2:${userId}`;
}

export function readBuddyVisibility(
  storage: Pick<Storage, "getItem">,
  userId: string,
): boolean {
  return storage.getItem(buddyVisibilityStorageKey(userId)) !== "false";
}
