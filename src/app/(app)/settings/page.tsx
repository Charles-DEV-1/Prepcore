"use client";

import { useEffect, useState } from "react";
import { Bell, Check, Moon, ShieldCheck, Sun } from "lucide-react";
import { useTheme } from "next-themes";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";

export default function SettingsPage() {
  const { resolvedTheme, setTheme } = useTheme();
  const [mounted, setMounted] = useState(false);

  useEffect(() => setMounted(true), []);

  const settings = [
    {
      title: "Study reminders",
      body: "Daily nudges for streaks and mock exam targets.",
      icon: Bell,
    },
    {
      title: "Appearance",
      body: "Choose the light or softened navy interface that suits your study sessions.",
      icon: Moon,
    },
    {
      title: "Security",
      body: "Session and account protection settings.",
      icon: ShieldCheck,
    },
  ];

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold tracking-normal text-navy">
          Settings
        </h1>
        <p className="mt-2 text-sm text-slate-600">
          Manage your Prepcore study experience.
        </p>
      </div>
      <div className="grid gap-4 md:grid-cols-3">
        {settings.map((item) => (
          <Card key={item.title} className="border-border bg-card shadow-sm">
            <CardContent className="p-5">
              <div className="flex h-12 w-12 items-center justify-center rounded-2xl bg-softblue text-primary">
                <item.icon className="h-6 w-6" />
              </div>
              <h2 className="mt-4 font-bold text-navy">{item.title}</h2>
              <p className="mt-2 text-sm leading-6 text-slate-600">
                {item.body}
              </p>
            </CardContent>
          </Card>
        ))}
      </div>
      <Card className="border-border bg-card shadow-sm">
        <CardHeader>
          <CardTitle>Notification preferences</CardTitle>
        </CardHeader>
        <CardContent className="grid gap-3 sm:grid-cols-2">
          {[
            "Daily study reminder",
            "Mock exam summary",
            "Weak-topic alerts",
            "Leaderboard movement",
          ].map((item) => (
            <label
              key={item}
              className="flex items-center gap-3 rounded-2xl border border-border p-4 text-sm font-medium text-slate-600"
            >
              <input
                type="checkbox"
                defaultChecked
                className="h-4 w-4 accent-[#2563EB]"
              />
              {item}
            </label>
          ))}
        </CardContent>
      </Card>
      <Card className="border-border bg-card shadow-sm">
        <CardHeader>
          <CardTitle>Appearance</CardTitle>
          <p className="text-sm text-muted-foreground">
            Your choice is remembered on this device.
          </p>
        </CardHeader>
        <CardContent>
          <div className="grid gap-3 sm:grid-cols-2" role="group" aria-label="Appearance mode">
            {[
              { value: "light", label: "Light mode", icon: Sun },
              { value: "dark", label: "Dark mode", icon: Moon },
            ].map(({ value, label, icon: Icon }) => {
              const selected = mounted && resolvedTheme === value;

              return (
                <button
                  key={value}
                  type="button"
                  aria-pressed={selected}
                  onClick={() => setTheme(value)}
                  className={`flex items-center justify-between rounded-2xl border p-4 text-left text-sm font-semibold transition-colors ${
                    selected
                      ? "border-primary bg-primary/10 text-primary"
                      : "border-border text-muted-foreground hover:border-primary/50 hover:bg-softblue"
                  }`}
                >
                  <span className="flex items-center gap-3">
                    <Icon className="h-5 w-5" />
                    {label}
                  </span>
                  {selected && <Check className="h-4 w-4" aria-hidden="true" />}
                </button>
              );
            })}
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
