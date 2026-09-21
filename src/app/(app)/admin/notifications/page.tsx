import { Bell, CheckCircle2, Clock3, XCircle } from "lucide-react";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { createServiceRoleClient } from "@/services/supabase/admin";
import { NotificationComposer } from "./notification-composer";

function metric(value: number | null) {
  return value === null ? "Unavailable" : value.toLocaleString("en-NG");
}

export default async function AdminNotificationsPage() {
  const admin = createServiceRoleClient();
  const [sent, failed, expired, runs, content] = await Promise.all([
    admin.from("notification_logs").select("id", { count: "exact", head: true }).eq("delivery_status", "sent"),
    admin.from("notification_logs").select("id", { count: "exact", head: true }).eq("delivery_status", "failed"),
    admin.from("notification_logs").select("id", { count: "exact", head: true }).eq("delivery_status", "expired"),
    admin.from("notification_scheduler_runs").select("status, completed_at, sent, failed, created_at").order("created_at", { ascending: false }).limit(5),
    admin.from("notification_content").select("id, notification_type, title, status, scheduled_at, created_at").order("created_at", { ascending: false }).limit(10),
  ]);

  const cards = [
    { label: "Delivered", value: sent.error ? null : sent.count, icon: CheckCircle2, color: "text-emerald-600" },
    { label: "Failed", value: failed.error ? null : failed.count, icon: XCircle, color: "text-red-600" },
    { label: "Expired devices", value: expired.error ? null : expired.count, icon: Bell, color: "text-amber-600" },
    { label: "Scheduler runs", value: runs.error ? null : runs.data?.length ?? 0, icon: Clock3, color: "text-primary" },
  ];

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold tracking-normal text-navy">Notifications</h1>
        <p className="mt-2 text-sm text-slate-600">Create useful study nudges and monitor delivery without spamming students.</p>
      </div>
      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
        {cards.map((card) => <Card key={card.label} className="border-border bg-white shadow-sm"><CardContent className="flex items-center justify-between p-5"><div><p className="text-sm text-slate-500">{card.label}</p><p className="mt-2 text-2xl font-bold text-navy">{metric(card.value)}</p></div><card.icon className={`h-5 w-5 ${card.color}`} /></CardContent></Card>)}
      </div>
      <Card className="border-border bg-white shadow-sm"><CardHeader><CardTitle>Create notification content</CardTitle></CardHeader><CardContent><NotificationComposer /></CardContent></Card>
      <div className="grid gap-4 lg:grid-cols-2">
        <Card className="border-border bg-white shadow-sm"><CardHeader><CardTitle>Recent content</CardTitle></CardHeader><CardContent className="space-y-3">{(content.data ?? []).length === 0 ? <p className="text-sm text-slate-500">No content created yet.</p> : (content.data ?? []).map((item) => <div key={item.id} className="flex items-center justify-between gap-3 rounded-xl border border-border p-3"><div><p className="text-sm font-semibold text-navy">{item.title}</p><p className="mt-1 text-xs capitalize text-slate-500">{item.notification_type.replace("_", " ")} · {item.status}</p></div><span className="text-xs text-slate-400">{new Date(item.created_at).toLocaleDateString("en-NG")}</span></div>)}</CardContent></Card>
        <Card className="border-border bg-white shadow-sm"><CardHeader><CardTitle>Scheduler history</CardTitle></CardHeader><CardContent className="space-y-3">{(runs.data ?? []).length === 0 ? <p className="text-sm text-slate-500">No scheduler runs yet.</p> : (runs.data ?? []).map((run, index) => <div key={`${run.created_at}-${index}`} className="flex items-center justify-between gap-3 rounded-xl border border-border p-3"><div><p className="text-sm font-semibold capitalize text-navy">{run.status}</p><p className="mt-1 text-xs text-slate-500">{run.sent} sent · {run.failed} failed</p></div><span className="text-xs text-slate-400">{new Date(run.created_at).toLocaleString("en-NG")}</span></div>)}</CardContent></Card>
      </div>
    </div>
  );
}
