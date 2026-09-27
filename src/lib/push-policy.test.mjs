import assert from "node:assert/strict";
import { createECDH } from "node:crypto";
import test from "node:test";
import { isAllowedPushEndpoint, isValidPushKey, pushDeliveryPolicy } from "./push-policy.ts";

test("only recognized HTTPS browser push endpoints are accepted", () => {
  for (const endpoint of [
    "https://fcm.googleapis.com/fcm/send/example",
    "https://updates.push.services.mozilla.com/wpush/v2/example",
    "https://web.push.apple.com/example",
    "https://wns2-bn3p.notify.windows.com/example",
  ]) assert.equal(isAllowedPushEndpoint(endpoint), true, endpoint);

  for (const endpoint of [
    "http://fcm.googleapis.com/fcm/send/example",
    "https://127.0.0.1/private",
    "https://169.254.169.254/latest/meta-data",
    "https://fcm.googleapis.com.evil.example/send",
    "https://evilpush.apple.com/send",
    "https://evil@fcm.googleapis.com/send",
    "https://fcm.googleapis.com:444/send",
    "https://fcm.googleapis.com/send#fragment",
  ]) assert.equal(isAllowedPushEndpoint(endpoint), false, endpoint);
});

test("push encryption keys have canonical lengths and encoding", () => {
  const p256dh = createECDH("prime256v1").generateKeys().toString("base64url");
  const auth = Buffer.alloc(16, 2).toString("base64url");
  assert.equal(isValidPushKey(p256dh, 65), true);
  assert.equal(isValidPushKey(auth, 16), true);
  assert.equal(isValidPushKey("not a key", 16), false);
  assert.equal(isValidPushKey(Buffer.alloc(65).toString("base64url"), 65), false);
  assert.equal(isValidPushKey(Buffer.concat([Buffer.from([4]), Buffer.alloc(64, 1)]).toString("base64url"), 65), false);
});

test("streak messages expire at their real deadline, not when a device reconnects", () => {
  const now = Date.parse("2026-09-27T12:00:00.000Z");
  const deadline = new Date(now + 45 * 60_000).toISOString();
  const policy = pushDeliveryPolicy("streak_reminder", now, deadline);
  assert.equal(policy?.options.TTL, 45 * 60);
  assert.equal(policy?.expiresAt, deadline);
  assert.equal(policy?.options.urgency, "high");
  assert.equal(pushDeliveryPolicy("streak_reminder", now + 45 * 60_000, deadline), null);
});

test("lower-priority tips and tests cannot pile up indefinitely offline", () => {
  const now = Date.parse("2026-09-27T12:00:00.000Z");
  assert.equal(pushDeliveryPolicy("study_tip", now)?.options.TTL, 12 * 60 * 60);
  assert.equal(pushDeliveryPolicy("test", now)?.options.TTL, 60);
  assert.equal(pushDeliveryPolicy("study_tip", now)?.options.topic, "prepcore-study-tip");
  assert.equal(pushDeliveryPolicy("news", now)?.options.topic, undefined);
  assert.equal(pushDeliveryPolicy("study_tip", now, "invalid"), null);
  const announcementExpiry = new Date(now + 15 * 60_000).toISOString();
  assert.equal(pushDeliveryPolicy("announcement", now, announcementExpiry)?.options.TTL, 15 * 60);
});
