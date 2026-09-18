const VERSION = "prepcore-static-v2";
const STATIC_CACHE = `${VERSION}-assets`;
const OFFLINE_URL = "/offline";
const PERSONALIZED_PATHS = [
  "/admin",
  "/dashboard",
  "/exam",
  "/flashcards",
  "/leaderboard",
  "/onboarding",
  "/partners/dashboard",
  "/practice",
  "/profile",
  "/progress",
  "/referrals",
  "/results",
  "/settings",
  "/upgrade",
  "/weekly-quiz",
];

self.addEventListener("install", (event) => {
  event.waitUntil(
    caches
      .open(STATIC_CACHE)
      .then((cache) =>
        cache.addAll([
          OFFLINE_URL,
          "/manifest.json",
          "/favicons/android-chrome-192x192.png",
          "/favicons/android-chrome-512x512.png",
          "/favicons/apple-touch-icon.png",
        ]),
      ),
  );
  self.skipWaiting();
});

self.addEventListener("activate", (event) => {
  event.waitUntil(
    caches
      .keys()
      .then((keys) =>
        Promise.all(
          keys
            .filter((key) => key !== STATIC_CACHE)
            .map((key) => caches.delete(key)),
        ),
      ),
  );
  self.clients.claim();
});

self.addEventListener("fetch", (event) => {
  const request = event.request;
  const url = new URL(request.url);

  if (request.method !== "GET" || url.origin !== self.location.origin) return;
  if (
    url.pathname.startsWith("/api/") ||
    PERSONALIZED_PATHS.some(
      (path) => url.pathname === path || url.pathname.startsWith(`${path}/`),
    )
  )
    return;

  if (
    request.destination === "script" ||
    request.destination === "style" ||
    request.destination === "font" ||
    request.destination === "image"
  ) {
    event.respondWith(
      caches.match(request).then(
        (cached) =>
          cached ||
          fetch(request).then((response) => {
            const copy = response.clone();
            void caches
              .open(STATIC_CACHE)
              .then((cache) => cache.put(request, copy));
            return response;
          }),
      ),
    );
    return;
  }

  if (request.mode === "navigate") {
    event.respondWith(fetch(request).catch(() => caches.match(OFFLINE_URL)));
  }
});

function readNotificationPayload(data) {
  const fallback = {
    title: "Keep your streak alive",
    body: "It has been 24 hours since your last study session. Come back and keep going.",
    type: "streak_reminder",
    url: "/dashboard",
  };

  if (!data) return fallback;

  try {
    const parsed = data.json();
    return {
      title: typeof parsed.title === "string" ? parsed.title : fallback.title,
      body: typeof parsed.body === "string" ? parsed.body : fallback.body,
      type: typeof parsed.type === "string" ? parsed.type : fallback.type,
      url: typeof parsed.url === "string" ? parsed.url : fallback.url,
    };
  } catch {
    return {
      ...fallback,
      body: data.text() || fallback.body,
    };
  }
}

function getSafeAppUrl(path) {
  try {
    const url = new URL(path, self.location.origin);
    if (url.origin !== self.location.origin) return "/dashboard";
    return `${url.pathname}${url.search}${url.hash}`;
  } catch {
    return "/dashboard";
  }
}

self.addEventListener("push", (event) => {
  const payload = readNotificationPayload(event.data);
  const url = getSafeAppUrl(payload.url);
  const tag =
    payload.type === "test"
      ? `prepcore-test-${Date.now()}`
      : payload.type || "prepcore-study-reminder";

  event.waitUntil(
    self.registration.showNotification(payload.title, {
      body: payload.body,
      badge: "/favicons/android-chrome-192x192.png",
      data: { type: payload.type, url },
      icon: "/favicons/android-chrome-192x192.png",
      requireInteraction: false,
      tag,
    }),
  );
});

self.addEventListener("notificationclick", (event) => {
  event.notification.close();
  const url = getSafeAppUrl(event.notification.data?.url || "/dashboard");

  event.waitUntil(
    self.clients
      .matchAll({ type: "window", includeUncontrolled: true })
      .then((clientList) => {
        for (const client of clientList) {
          const clientUrl = new URL(client.url);
          if (clientUrl.origin === self.location.origin && "focus" in client) {
            client.navigate(url);
            return client.focus();
          }
        }

        if (self.clients.openWindow) {
          return self.clients.openWindow(url);
        }

        return undefined;
      }),
  );
});
