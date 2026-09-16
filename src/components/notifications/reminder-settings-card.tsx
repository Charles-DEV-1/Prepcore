"use client";

import { Bell, BellOff, CheckCircle2, Clock3, ShieldAlert } from "lucide-react";
import { Button } from "@/components/ui/button";
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { usePushNotifications } from "@/hooks/use-push-notifications";
import { cn } from "@/lib/utils";

const statusCopy = {
  unsupported: {
    label: "Unavailable",
    text: "This browser does not support web push reminders.",
    icon: BellOff,
  },
  disabled: {
    label: "Off",
    text: "Turn on reminders when you want Prepcore to protect your study rhythm.",
    icon: Clock3,
  },
  "needs-permission": {
    label: "Needs permission",
    text: "Allow browser notifications to receive streak and study reminders.",
    icon: ShieldAlert,
  },
  blocked: {
    label: "Blocked",
    text: "Notifications are blocked. Enable them from your browser settings.",
    icon: BellOff,
  },
  enabled: {
    label: "Enabled",
    text: "This browser can receive Prepcore study reminders.",
    icon: CheckCircle2,
  },
  checking: {
    label: "Checking",
    text: "Checking reminder support on this browser.",
    icon: Clock3,
  },
};

export function ReminderSettingsCard() {
  const {
    disableReminders,
    isBusy,
    isInitializing,
    message,
    preferences,
    requestPermission,
    status,
    togglePreference,
  } = usePushNotifications();
  const current = statusCopy[status];
  const StatusIcon = current.icon;
  const hasActivePreference =
    preferences.studyReminders || preferences.streakReminders;

  return (
    <Card className="border-border bg-card shadow-sm">
      <CardHeader>
        <div className="flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
          <div>
            <CardTitle>Study reminder notifications</CardTitle>
            <CardDescription className="mt-2">
              Get a browser reminder when a study streak needs attention.
            </CardDescription>
          </div>
          <div
            className={cn(
              "inline-flex w-fit items-center gap-2 rounded-full border px-3 py-1 text-xs font-semibold",
              status === "enabled"
                ? "border-emerald-200 bg-emerald-50 text-emerald-700 dark:border-emerald-500/30 dark:bg-emerald-500/10 dark:text-emerald-300"
                : "border-border bg-softblue text-primary",
            )}
          >
            <StatusIcon className="h-3.5 w-3.5" aria-hidden="true" />
            {current.label}
          </div>
        </div>
      </CardHeader>
      <CardContent className="space-y-5">
        <div className="rounded-2xl border border-border bg-softblue/70 p-4 dark:bg-slate-900/30">
          <p className="text-sm font-medium text-navy dark:text-main">
            {current.text}
          </p>
          {preferences.lastReminderSentAt && (
            <p className="mt-2 text-xs text-slate-500">
              Last reminder sent{" "}
              {new Intl.DateTimeFormat("en-NG", {
                dateStyle: "medium",
                timeStyle: "short",
              }).format(new Date(preferences.lastReminderSentAt))}
            </p>
          )}
          {message && (
            <p className="mt-2 text-sm font-medium text-primary">{message}</p>
          )}
        </div>

        <div className="grid gap-3 sm:grid-cols-2">
          <ReminderToggle
            checked={preferences.studyReminders}
            description="Remind me after 24 hours without a completed study session."
            disabled={
              isBusy ||
              isInitializing ||
              status === "unsupported" ||
              status === "blocked"
            }
            label="Study session reminder"
            onChange={(checked) =>
              void togglePreference("studyReminders", checked)
            }
          />
          <ReminderToggle
            checked={preferences.streakReminders}
            description="Warn me when my current streak is close to breaking."
            disabled={
              isBusy ||
              isInitializing ||
              status === "unsupported" ||
              status === "blocked"
            }
            label="Streak protection"
            onChange={(checked) =>
              void togglePreference("streakReminders", checked)
            }
          />
        </div>

        <div className="flex flex-col gap-3 sm:flex-row">
          <Button
            type="button"
            onClick={() => void requestPermission()}
            disabled={
              isBusy ||
              isInitializing ||
              status === "unsupported" ||
              status === "blocked"
            }
          >
            <Bell className="h-4 w-4" aria-hidden="true" />
            {isBusy
              ? "Saving..."
              : status === "enabled"
                ? "Refresh reminder access"
                : "Enable reminders"}
          </Button>
          <Button
            type="button"
            variant="outline"
            onClick={() => void disableReminders()}
            disabled={isBusy || isInitializing || !hasActivePreference}
          >
            Disable reminders
          </Button>
        </div>
      </CardContent>
    </Card>
  );
}

type ReminderToggleProps = {
  checked: boolean;
  description: string;
  disabled: boolean;
  label: string;
  onChange: (checked: boolean) => void;
};

function ReminderToggle({
  checked,
  description,
  disabled,
  label,
  onChange,
}: ReminderToggleProps) {
  return (
    <label
      className={cn(
        "flex min-h-32 cursor-pointer flex-col justify-between rounded-2xl border p-4 transition-colors",
        checked
          ? "border-primary bg-primary/10"
          : "border-border bg-white hover:border-primary/50 dark:bg-slate-900/30",
        disabled && "cursor-not-allowed opacity-60",
      )}
    >
      <span>
        <span className="flex items-center justify-between gap-3">
          <span className="text-sm font-semibold text-navy dark:text-main">
            {label}
          </span>
          <input
            type="checkbox"
            checked={checked}
            disabled={disabled}
            onChange={(event) => onChange(event.target.checked)}
            className="h-4 w-4 accent-[#2563EB]"
          />
        </span>
        <span className="mt-2 block text-sm leading-6 text-slate-600">
          {description}
        </span>
      </span>
    </label>
  );
}
