import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import test from "node:test";
import vm from "node:vm";

function loadPushHandler() {
  const handlers = new Map();
  const shown = [];
  const self = {
    location: { origin: "https://www.prepcore.com.ng" },
    addEventListener: (name, handler) => handlers.set(name, handler),
    registration: {
      showNotification: async (title, options) => shown.push({ title, options }),
    },
  };
  vm.runInNewContext(readFileSync(new URL("./sw.js", import.meta.url), "utf8"), {
    self, URL, Date, caches: {}, fetch: () => {},
  });
  return { handler: handlers.get("push"), shown };
}

async function push(handler, payload) {
  let work;
  handler({
    data: { json: () => payload },
    waitUntil: (promise) => { work = promise; },
  });
  if (work) await work;
}

test("service worker shows only fresh, bounded push messages", async () => {
  const { handler, shown } = loadPushHandler();
  const payload = {
    title: "Quick practice",
    body: "Your session is waiting.",
    type: "study_tip",
    url: "/practice",
    expiresAt: new Date(Date.now() + 60_000).toISOString(),
  };
  await push(handler, payload);
  assert.equal(shown.length, 1);
  assert.equal(shown[0].options.data.url, "/practice");
  await push(handler, { ...payload, expiresAt: new Date(Date.now() - 1000).toISOString() });
  await push(handler, { ...payload, url: "https://attacker.example/" });
  await push(handler, { ...payload, expiresAt: undefined });
  assert.equal(shown.length, 1);
});
