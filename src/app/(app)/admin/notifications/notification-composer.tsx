"use client";

import { FormEvent, useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";

export function NotificationComposer() {
  const [message, setMessage] = useState<string | null>(null);
  const [busy, setBusy] = useState(false);

  async function submit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setBusy(true);
    setMessage(null);
    const form = new FormData(event.currentTarget);
    try {
      const response = await fetch("/api/admin/notifications", {
        method: "POST",
        headers: { "Content-Type": "application/json", Accept: "application/json" },
        body: JSON.stringify({
          notificationType: form.get("notificationType"),
          title: form.get("title"),
          body: form.get("body"),
          url: form.get("url"),
          publish: form.get("publish") === "on",
        }),
      });
      const result = (await response.json()) as { error?: string };
      if (!response.ok) throw new Error(result.error ?? "Unable to create notification.");
      event.currentTarget.reset();
      setMessage("Notification content saved.");
    } catch (error) {
      setMessage(error instanceof Error ? error.message : "Unable to create notification.");
    } finally {
      setBusy(false);
    }
  }

  return (
    <form onSubmit={submit} className="space-y-4">
      <div className="grid gap-4 sm:grid-cols-2">
        <label className="space-y-2 text-sm font-medium text-navy">
          Type
          <select name="notificationType" defaultValue="study_tip" className="flex h-11 w-full rounded-xl border border-border bg-white px-3 text-sm">
            <option value="study_tip">Study tip</option>
            <option value="news">News</option>
            <option value="announcement">Announcement</option>
          </select>
        </label>
        <label className="space-y-2 text-sm font-medium text-navy">
          Open route
          <select name="url" defaultValue="/dashboard" className="flex h-11 w-full rounded-xl border border-border bg-white px-3 text-sm">
            <option value="/dashboard">Dashboard</option>
            <option value="/practice">Practice</option>
          </select>
        </label>
      </div>
      <label className="block space-y-2 text-sm font-medium text-navy">
        Title
        <Input name="title" required maxLength={120} placeholder="A short reason to come back" />
      </label>
      <label className="block space-y-2 text-sm font-medium text-navy">
        Message
        <textarea name="body" required maxLength={500} rows={4} placeholder="Keep it useful and concise" className="flex w-full rounded-xl border border-border bg-white px-3 py-3 text-sm shadow-sm outline-none focus:ring-2 focus:ring-primary/35" />
      </label>
      <label className="flex items-center gap-3 text-sm font-medium text-slate-600">
        <input name="publish" type="checkbox" className="h-4 w-4 accent-[#2563EB]" />
        Publish when saved
      </label>
      {message && <p className="text-sm font-medium text-primary">{message}</p>}
      <Button type="submit" disabled={busy}>{busy ? "Saving..." : "Save notification"}</Button>
    </form>
  );
}
