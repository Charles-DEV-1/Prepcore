const VERSION = "prepcore-static-v1";
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
    caches.open(STATIC_CACHE).then((cache) => cache.addAll([
      OFFLINE_URL,
      "/manifest.json",
      "/favicons/android-chrome-192x192.png",
      "/favicons/android-chrome-512x512.png",
      "/favicons/apple-touch-icon.png",
    ])),
  );
  self.skipWaiting();
});

self.addEventListener("activate", (event) => {
  event.waitUntil(
    caches.keys().then((keys) => Promise.all(
      keys
        .filter((key) => key !== STATIC_CACHE)
        .map((key) => caches.delete(key)),
    )),
  );
  self.clients.claim();
});

self.addEventListener("fetch", (event) => {
  const request = event.request;
  const url = new URL(request.url);

  if (request.method !== "GET" || url.origin !== self.location.origin) return;
  if (
    url.pathname.startsWith("/api/") ||
    PERSONALIZED_PATHS.some((path) => url.pathname === path || url.pathname.startsWith(`${path}/`))
  ) return;

  if (request.destination === "script" || request.destination === "style" || request.destination === "font" || request.destination === "image") {
    event.respondWith(
      caches.match(request).then((cached) => cached || fetch(request).then((response) => {
        const copy = response.clone();
        void caches.open(STATIC_CACHE).then((cache) => cache.put(request, copy));
        return response;
      })),
    );
    return;
  }

  if (request.mode === "navigate") {
    event.respondWith(
      fetch(request).catch(() => caches.match(OFFLINE_URL)),
    );
  }
});
