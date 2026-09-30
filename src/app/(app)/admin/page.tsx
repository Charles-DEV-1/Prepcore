import {
  Activity,
  BookOpen,
  CreditCard,
  Flag,
  RotateCcw,
  TrendingUp,
  UserCheck,
  UserPlus,
  Users,
  Wallet,
} from "lucide-react";
import Link from "next/link";
import { redirect } from "next/navigation";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { isAdminEmail } from "@/lib/admin-auth";
import { createServiceRoleClient } from "@/services/supabase/admin";
import { createClient } from "@/services/supabase/server";

export const dynamic = "force-dynamic";

type RecentReport = {
  id: string;
  reason: string;
  details: string | null;
  status: string;
  created_at: string;
};

function formatCount(value: number | null | undefined) {
  return value == null ? "Unavailable" : value.toLocaleString("en-NG");
}

function formatMoney(value: number | null | undefined) {
  return value == null
    ? "Unavailable"
    : `₦${Number(value).toLocaleString("en-NG", { maximumFractionDigits: 2 })}`;
}

export default async function AdminPage() {
  // Check the request before using the service-role client. The layout has the
  // same guard, but page rendering can begin independently of layout rendering.
  const supabase = await createClient();
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (!user || !isAdminEmail(user.email)) redirect("/dashboard");

  const admin = createServiceRoleClient();
  const [overview, recentReports] = await Promise.all([
    admin.rpc("admin_overview_metrics"),
    admin
      .from("question_reports")
      .select("id, reason, details, status, created_at")
      .order("created_at", { ascending: false })
      .limit(5),
  ]);

  const metrics = overview.error ? null : (overview.data?.[0] ?? null);
  const totalUsers = metrics?.total_users ?? null;
  const paidUsers = metrics?.paid_users ?? null;
  const conversionRate =
    totalUsers === null || paidUsers === null
      ? "Unavailable"
      : `${totalUsers === 0 ? 0 : Math.round((paidUsers / totalUsers) * 1000) / 10}%`;
  const cards = [
    {
      label: "Total users",
      value: formatCount(totalUsers),
      note: metrics
        ? `Auth accounts incl. unconfirmed; ${formatCount(metrics.profile_users)} learner profiles`
        : "All Auth accounts, including unconfirmed",
      icon: Users,
    },
    {
      label: "Active users (7 days)",
      value: formatCount(metrics?.active_users_7d),
      note: "Signed in or started a study session",
      icon: UserCheck,
    },
    {
      label: "Practice sessions",
      value: formatCount(metrics?.practice_sessions),
      note: "At least one question answered · all time",
      icon: BookOpen,
    },
    {
      label: "Paid users",
      value: formatCount(paidUsers),
      note: "Distinct users with a successful payment",
      icon: CreditCard,
    },
    {
      label: "Conversion rate",
      value: conversionRate,
      note: "Paid users ÷ total Auth accounts",
      icon: TrendingUp,
    },
    {
      label: "Revenue",
      value: formatMoney(metrics?.revenue_ngn),
      note: "Actual successful NGN payment amounts",
      icon: Wallet,
    },
    {
      label: "New users (7 days)",
      value: formatCount(metrics?.new_users_7d),
      note: "Auth accounts created in the last 7 days",
      icon: UserPlus,
    },
    {
      label: "Returning users (7 days)",
      value: formatCount(metrics?.returning_users_7d),
      note: "Active this week; joined before the week",
      icon: RotateCcw,
    },
    {
      label: "Sessions today",
      value: formatCount(metrics?.sessions_today),
      note: "Practice and mock · Africa/Lagos day",
      icon: Activity,
    },
    {
      label: "Pending reports",
      value: formatCount(metrics?.pending_reports),
      note: "Question reports awaiting review",
      icon: Flag,
    },
  ];

  const reports = (recentReports.data ?? []) as RecentReport[];

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold tracking-normal text-navy">
          Admin dashboard
        </h1>
        <p className="mt-2 text-sm text-slate-600 dark:text-slate-300">
          Live operational overview. Weekly counts use a rolling seven-day
          window.
        </p>
        {overview.error && (
          <p role="alert" className="mt-2 text-sm text-destructive">
            Overview metrics are unavailable. Check that the admin overview
            migration has been applied.
          </p>
        )}
      </div>

      <section
        aria-label="Admin metrics"
        className="grid gap-4 sm:grid-cols-2 xl:grid-cols-5"
      >
        {cards.map(({ label, value, icon: Icon, note }) => (
          <Card key={label} className="border-border bg-white shadow-sm">
            <CardContent className="flex items-start justify-between gap-3 p-5">
              <div className="min-w-0">
                <p className="text-sm text-slate-500 dark:text-slate-300">
                  {label}
                </p>
                <p className="mt-2 break-words text-2xl font-bold text-navy">
                  {value}
                </p>
                <p className="mt-2 text-xs leading-5 text-slate-500 dark:text-slate-300">
                  {note}
                </p>
              </div>
              <Icon
                aria-hidden="true"
                className="h-5 w-5 shrink-0 text-primary"
              />
            </CardContent>
          </Card>
        ))}
      </section>

      <div className="grid gap-4 md:grid-cols-2">
        <Card className="border-border bg-white shadow-sm">
          <CardContent className="p-5">
            <h2 className="font-bold text-navy">Lesson center partners</h2>
            <p className="mt-2 text-sm leading-6 text-slate-600">
              Manage partners, referral codes, and signup links for
              partnerships.
            </p>
            <div className="mt-5 flex flex-wrap gap-2">
              <Button asChild>
                <Link href="/admin/partners">Manage partners</Link>
              </Button>
              <Button asChild variant="outline">
                <Link href="/admin/referrals">View referrals</Link>
              </Button>
            </div>
          </CardContent>
        </Card>
        <Card className="border-border bg-white shadow-sm">
          <CardContent className="p-5">
            <div className="flex items-center justify-between">
              <h2 className="font-bold text-navy">Question reports</h2>
              <span className="rounded-full bg-red-100 px-2 py-0.5 text-xs font-semibold text-red-700 dark:bg-red-500/15 dark:text-red-300">
                {metrics
                  ? `${formatCount(metrics.pending_reports)} pending`
                  : "Unavailable"}
              </span>
            </div>
            <p className="mt-2 text-sm leading-6 text-slate-600">
              Review questions flagged by students as wrong, confusing, or
              having errors.
            </p>
            <Button asChild className="mt-5">
              <Link href="/admin/reports">View reports</Link>
            </Button>
          </CardContent>
        </Card>
        <Card className="border-border bg-white shadow-sm">
          <CardContent className="p-5">
            <h2 className="font-bold text-navy">Question operations</h2>
            <p className="mt-2 text-sm leading-6 text-slate-600">
              Upload, review, and publish new exam question sets.
            </p>
            <Button asChild className="mt-5">
              <Link href="/admin/question-upload">Open uploader</Link>
            </Button>
          </CardContent>
        </Card>
        <Card className="border-border bg-white shadow-sm">
          <CardContent className="p-5">
            <h2 className="font-bold text-navy">Analytics</h2>
            <p className="mt-2 text-sm leading-6 text-slate-600">
              Review student activity, subject performance, and platform growth.
            </p>
            <Button asChild variant="outline" className="mt-5">
              <Link href="/admin/analytics">View analytics</Link>
            </Button>
          </CardContent>
        </Card>
      </div>

      <Card className="border-border bg-white shadow-sm">
        <CardHeader>
          <CardTitle>Recent question reports</CardTitle>
        </CardHeader>
        <CardContent className="space-y-3">
          {recentReports.error ? (
            <p className="text-sm text-destructive">
              Recent reports are currently unavailable.
            </p>
          ) : reports.length === 0 ? (
            <p className="text-sm text-slate-600">No question reports yet.</p>
          ) : (
            reports.map((report) => (
              <Link
                key={report.id}
                href="/admin/reports"
                className="block rounded-2xl border border-border bg-[#F8FAFC] p-3 text-sm text-slate-600 transition hover:border-primary/50 dark:bg-slate-800/70 dark:text-slate-300"
              >
                <div className="flex items-start justify-between gap-3">
                  <p className="font-medium text-navy">{report.reason}</p>
                  <span className="text-xs capitalize text-slate-500">
                    {report.status}
                  </span>
                </div>
                {report.details && (
                  <p className="mt-1 line-clamp-1 text-xs">{report.details}</p>
                )}
                <p className="mt-2 text-xs text-slate-500">
                  {new Intl.DateTimeFormat("en-NG", {
                    dateStyle: "medium",
                    timeStyle: "short",
                  }).format(new Date(report.created_at))}
                </p>
              </Link>
            ))
          )}
        </CardContent>
      </Card>
    </div>
  );
}
