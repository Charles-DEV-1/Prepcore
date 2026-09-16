"use client";

import { useCallback, useEffect, useMemo, useState } from "react";

type ReminderPreference = {
  studyReminders: boolean;
  streakReminders: boolean;
  lastReminderSentAt: string | null;
  timezone: string;
};

export type NotificationStatus =
  | "checking"
  | "unsupported"
  | "disabled"
  | "needs-permission"
  | "blocked"
  | "enabled";

type PushSubscriptionSnapshot = {
  endpoint: string;
  expirationTime: number | null;
  keys: {
    auth: string;
    p256dh: string;
  };
};

const DEFAULT_PREFERENCES: ReminderPreference = {
  lastReminderSentAt: null,
  studyReminders: false,
  streakReminders: false,
  timezone: "Africa/Lagos",
};

type PreferencesResponse = {
  preferences: {
    last_reminder_sent_at: string | null;
    streak_reminders_enabled: boolean;
    study_reminders_enabled: boolean;
    timezone: string | null;
  };
};

type PreferencesUpdate = {
  streakRemindersEnabled: boolean;
  studyRemindersEnabled: boolean;
  timezone: string;
};

function getBrowserTimezone() {
  try {
    return Intl.DateTimeFormat().resolvedOptions().timeZone || "Africa/Lagos";
  } catch {
    return "Africa/Lagos";
  }
}

function urlBase64ToUint8Array(value: string) {
  const padding = "=".repeat((4 - (value.length % 4)) % 4);
  const base64 = `${value}${padding}`.replace(/-/g, "+").replace(/_/g, "/");
  const raw = window.atob(base64);
  const output = new Uint8Array(raw.length);

  for (let index = 0; index < raw.length; index += 1) {
    output[index] = raw.charCodeAt(index);
  }

  return output;
}

function isPushSupported() {
  return (
    typeof window !== "undefined" &&
    "Notification" in window &&
    "serviceWorker" in navigator &&
    "PushManager" in window
  );
}

function getPlatform(): "android" | "ios" | "desktop" | "unknown" {
  if (typeof navigator === "undefined") return "unknown";
  const userAgent = navigator.userAgent.toLowerCase();
  const platform = navigator.platform.toLowerCase();

  if (/android/.test(userAgent)) return "android";
  if (/iphone|ipad|ipod/.test(userAgent) || /iphone|ipad|ipod/.test(platform)) {
    return "ios";
  }
  if (/win|mac|linux|cros/.test(platform)) return "desktop";

  return "unknown";
}

async function readJsonResponse<T>(response: Response, fallback: string) {
  const payload = (await response.json().catch(() => ({}))) as {
    error?: string;
  };

  if (!response.ok) {
    throw new Error(payload.error ?? fallback);
  }

  return payload as T;
}

function mapPreferencesResponse(
  response: PreferencesResponse,
): ReminderPreference {
  const preferences = response.preferences;
  return {
    lastReminderSentAt: preferences.last_reminder_sent_at,
    streakReminders: preferences.streak_reminders_enabled,
    studyReminders: preferences.study_reminders_enabled,
    timezone: preferences.timezone ?? getBrowserTimezone(),
  };
}

async function fetchPreferences() {
  const response = await fetch("/api/notifications/preferences", {
    headers: { Accept: "application/json" },
  });
  const payload = await readJsonResponse<PreferencesResponse>(
    response,
    "Unable to load reminder preferences.",
  );

  return mapPreferencesResponse(payload);
}

async function updatePreferences(update: PreferencesUpdate) {
  const response = await fetch("/api/notifications/preferences", {
    method: "PATCH",
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
    },
    body: JSON.stringify(update),
  });
  const payload = await readJsonResponse<PreferencesResponse>(
    response,
    "Unable to update reminder preferences.",
  );

  return mapPreferencesResponse(payload);
}

async function saveSubscription(subscription: PushSubscriptionSnapshot) {
  const response = await fetch("/api/notifications/subscription", {
    method: "POST",
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      endpoint: subscription.endpoint,
      expirationTime: subscription.expirationTime,
      keys: subscription.keys,
      platform: getPlatform(),
    }),
  });

  await readJsonResponse(response, "Unable to save this device for reminders.");
}

async function removeSubscription(endpoint: string) {
  const response = await fetch("/api/notifications/subscription", {
    method: "DELETE",
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
    },
    body: JSON.stringify({ endpoint }),
  });

  await readJsonResponse(response, "Unable to remove this device.");
}

async function getExistingSubscription() {
  const registration = await navigator.serviceWorker.ready;
  return registration.pushManager.getSubscription();
}

function toSubscriptionSnapshot(
  subscription: PushSubscription,
): PushSubscriptionSnapshot {
  const json = subscription.toJSON();

  return {
    endpoint: json.endpoint ?? subscription.endpoint,
    expirationTime: subscription.expirationTime,
    keys: {
      auth: json.keys?.auth ?? "",
      p256dh: json.keys?.p256dh ?? "",
    },
  };
}

export function usePushNotifications() {
  const [preferences, setPreferencesState] =
    useState<ReminderPreference>(DEFAULT_PREFERENCES);
  const [permission, setPermission] =
    useState<NotificationPermission>("default");
  const [supported, setSupported] = useState(false);
  const [subscription, setSubscription] =
    useState<PushSubscriptionSnapshot | null>(null);
  const [isInitializing, setIsInitializing] = useState(true);
  const [isBusy, setIsBusy] = useState(false);
  const [message, setMessage] = useState<string | null>(null);

  const refreshSubscription = useCallback(async () => {
    if (!isPushSupported()) return;
    const existing = await getExistingSubscription();
    setSubscription(existing ? toSubscriptionSnapshot(existing) : null);
  }, []);

  useEffect(() => {
    let active = true;

    const available = isPushSupported();
    setSupported(available);

    async function initialize() {
      if (!available) {
        setIsInitializing(false);
        return;
      }

      setPermission(Notification.permission);
      await refreshSubscription();

      try {
        const nextPreferences = await fetchPreferences();
        if (active) setPreferencesState(nextPreferences);
      } catch {
        if (active) {
          setPreferencesState({
            ...DEFAULT_PREFERENCES,
            timezone: getBrowserTimezone(),
          });
        }
      } finally {
        if (active) setIsInitializing(false);
      }
    }

    void initialize();

    return () => {
      active = false;
    };
  }, [refreshSubscription]);

  const enabledByPreference =
    preferences.studyReminders || preferences.streakReminders;

  const status = useMemo<NotificationStatus>(() => {
    if (isInitializing) return "checking";
    if (!supported) return "unsupported";
    if (permission === "denied") return "blocked";
    if (!enabledByPreference) return "disabled";
    if (permission !== "granted") return "needs-permission";
    return "enabled";
  }, [enabledByPreference, isInitializing, permission, supported]);

  const togglePreference = useCallback(
    async (key: "studyReminders" | "streakReminders", value: boolean) => {
      setIsBusy(true);
      setMessage(null);

      const next = { ...preferences, [key]: value };

      try {
        const saved = await updatePreferences({
          studyRemindersEnabled: next.studyReminders,
          streakRemindersEnabled: next.streakReminders,
          timezone: next.timezone,
        });
        setPreferencesState(saved);
        setMessage("Reminder preferences updated.");
      } catch (error) {
        setMessage(
          error instanceof Error
            ? error.message
            : "Unable to update reminder preferences.",
        );
      } finally {
        setIsBusy(false);
      }
    },
    [preferences],
  );

  const requestPermission = useCallback(async () => {
    if (!isPushSupported()) {
      setSupported(false);
      setMessage("This browser does not support web push notifications.");
      return false;
    }

    setIsBusy(true);
    setMessage(null);

    try {
      const nextPermission = await Notification.requestPermission();
      setPermission(nextPermission);

      if (nextPermission !== "granted") {
        setMessage(
          nextPermission === "denied"
            ? "Notifications are blocked in this browser."
            : "Notifications were not enabled yet.",
        );
        return false;
      }

      const publicKey = process.env.NEXT_PUBLIC_WEB_PUSH_PUBLIC_KEY;
      if (!publicKey) {
        setMessage("Missing NEXT_PUBLIC_WEB_PUSH_PUBLIC_KEY.");
        return false;
      }

      const registration = await navigator.serviceWorker.ready;
      const existing = await registration.pushManager.getSubscription();
      const activeSubscription =
        existing ??
        (await registration.pushManager.subscribe({
          userVisibleOnly: true,
          applicationServerKey: urlBase64ToUint8Array(publicKey),
        }));
      const subscriptionSnapshot = toSubscriptionSnapshot(activeSubscription);

      await saveSubscription(subscriptionSnapshot);
      setSubscription(subscriptionSnapshot);

      const savedPreferences = await updatePreferences({
        studyRemindersEnabled: true,
        streakRemindersEnabled: true,
        timezone: getBrowserTimezone(),
      });
      setPreferencesState(savedPreferences);
      setMessage("Study reminders are ready on this browser.");
      return true;
    } catch (error) {
      setMessage(
        error instanceof Error
          ? error.message
          : "We could not enable reminders on this browser.",
      );
      return false;
    } finally {
      setIsBusy(false);
    }
  }, []);

  const disableReminders = useCallback(async () => {
    setIsBusy(true);
    setMessage(null);

    try {
      const existing = supported ? await getExistingSubscription() : null;
      const endpoint = existing?.endpoint ?? subscription?.endpoint;

      if (existing) {
        await existing.unsubscribe();
      }

      if (endpoint) {
        await removeSubscription(endpoint);
      }

      const savedPreferences = await updatePreferences({
        studyRemindersEnabled: false,
        streakRemindersEnabled: false,
        timezone: preferences.timezone,
      });
      setSubscription(null);
      setPreferencesState(savedPreferences);
      setMessage("Study reminders are disabled on this browser.");
    } catch (error) {
      setMessage(
        error instanceof Error
          ? error.message
          : "We could not disable reminders. Please try again.",
      );
    } finally {
      setIsBusy(false);
    }
  }, [preferences.timezone, subscription?.endpoint, supported]);

  return {
    disableReminders,
    isInitializing,
    isBusy,
    message,
    permission,
    preferences,
    requestPermission,
    status,
    subscription,
    supported,
    togglePreference,
  };
}
