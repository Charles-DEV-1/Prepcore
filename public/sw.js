const VERSION = "prepcore-static-v4";
const STATIC_CACHE = `${VERSION}-assets`;
const OFFLINE_URL = "/offline";
const PUBLIC_PAGES = ["/", "/login", "/signup", "/privacy-policy"];
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
          "/",
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
    Promise.all([
      caches
        .keys()
        .then((keys) =>
          Promise.all(
            keys
              .filter((key) => key !== STATIC_CACHE)
              .map((key) => caches.delete(key)),
          ),
        ),
      self.registration.navigationPreload?.enable(),
    ]),
  );
  self.clients.claim();
});

self.addEventListener("fetch", (event) => {
  const request = event.request;
  const url = new URL(request.url);

  if (request.method !== "GET" || url.origin !== self.location.origin) return;
  const isPersonalized = PERSONALIZED_PATHS.some(
    (path) => url.pathname === path || url.pathname.startsWith(`${path}/`),
  );

  if (url.pathname.startsWith("/api/")) return;

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
            if (!response.ok) return response;
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
    // Never cache authenticated HTML: a shared device must not be able to see
    // another learner's dashboard from the service-worker cache.
    if (isPersonalized) {
      event.respondWith(
        Promise.resolve(event.preloadResponse)
          .then((response) => response || fetch(request))
          .catch(() => caches.match(OFFLINE_URL)),
      );
      return;
    }

    if (PUBLIC_PAGES.includes(url.pathname) && !url.search) {
      event.respondWith(
        caches.match(request).then((cached) => {
          const network = Promise.resolve(event.preloadResponse)
            .then((response) => response || fetch(request))
            .then((response) => {
              if (response.ok) {
                const copy = response.clone();
                void caches
                  .open(STATIC_CACHE)
                  .then((cache) => cache.put(request, copy));
              }
              return response;
            });

          event.waitUntil(network.catch(() => undefined));
          return cached || network.catch(() => caches.match(OFFLINE_URL));
        }),
      );
      return;
    }

    event.respondWith(
      Promise.resolve(event.preloadResponse)
        .then((response) => response || fetch(request))
        .catch(() => caches.match(OFFLINE_URL)),
    );
  }
});

function readNotificationPayload(data) {
  if (!data) return null;
  try {
    const parsed = data.json();
    const validTypes = new Set([
      "streak_reminder", "study_reminder", "study_tip", "news",
      "announcement", "weekly_summary", "test",
    ]);
    if (!parsed || typeof parsed !== "object" ||
      typeof parsed.title !== "string" || !parsed.title.trim() || parsed.title.length > 120 ||
      typeof parsed.body !== "string" || !parsed.body.trim() || parsed.body.length > 500 ||
      !validTypes.has(parsed.type) ||
      (parsed.url !== "/dashboard" && parsed.url !== "/practice") ||
      typeof parsed.expiresAt !== "string") return null;
    const expiresAt = Date.parse(parsed.expiresAt);
    if (!Number.isFinite(expiresAt) || expiresAt <= Date.now()) return null;
    return parsed;
  } catch {
    return null;
  }
}

function getSafeAppUrl(path) {
  return path === "/practice" ? "/practice" : "/dashboard";
}

self.addEventListener("push", (event) => {
  const payload = readNotificationPayload(event.data);
  if (!payload) return;
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
