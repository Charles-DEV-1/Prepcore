create table if not exists public.notification_content (
  id uuid primary key default gen_random_uuid(),
  notification_type text not null check (notification_type in ('study_tip', 'news', 'announcement')),
  title text not null,
  body text not null,
  url text not null default '/dashboard',
  status text not null default 'draft' check (status in ('draft', 'published', 'archived')),
  scheduled_at timestamptz not null default now(),
  expires_at timestamptz,
  created_by uuid,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.notification_preferences
  add column if not exists content_notifications_enabled boolean not null default false,
  add column if not exists study_tips_enabled boolean not null default false,
  add column if not exists news_notifications_enabled boolean not null default false,
  add column if not exists weekly_summary_enabled boolean not null default false,
  add column if not exists last_content_notification_sent_at timestamptz,
  add column if not exists last_weekly_summary_sent_at timestamptz;

alter table public.notification_logs
  add column if not exists content_id uuid references public.notification_content(id) on delete set null,
  add column if not exists source text not null default 'system';

alter table public.notification_content enable row level security;

create index if not exists notification_content_schedule_idx
  on public.notification_content(status, scheduled_at, expires_at);

create index if not exists notification_logs_content_idx
  on public.notification_logs(content_id, delivery_status, sent_at desc);

create index if not exists notification_logs_source_idx
  on public.notification_logs(source, sent_at desc);

create trigger notification_content_touch_updated_at
before update on public.notification_content
for each row execute function public.touch_updated_at();
