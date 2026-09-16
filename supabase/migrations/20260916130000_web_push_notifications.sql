-- Browser push subscriptions, reminder preferences, and delivery logs.

create table if not exists public.notification_preferences (
  user_id uuid primary key references public.users(id) on delete cascade,
  study_reminders_enabled boolean not null default false,
  streak_reminders_enabled boolean not null default false,
  timezone text not null default 'UTC',
  last_reminder_sent_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.push_subscriptions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  endpoint text not null unique,
  expiration_time bigint,
  p256dh text not null,
  auth text not null,
  platform text not null default 'unknown'
    check (platform in ('android', 'ios', 'desktop', 'unknown')),
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.notification_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  subscription_id uuid references public.push_subscriptions(id) on delete set null,
  notification_type text not null,
  title text not null,
  body text not null,
  url text not null default '/dashboard',
  delivery_status text not null
    check (delivery_status in ('sent', 'failed', 'expired', 'skipped')),
  error_code text,
  sent_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);

alter table public.notification_preferences enable row level security;
alter table public.push_subscriptions enable row level security;
alter table public.notification_logs enable row level security;

drop policy if exists "Users can read own notification preferences" on public.notification_preferences;
create policy "Users can read own notification preferences"
  on public.notification_preferences for select
  using (auth.uid() = user_id);

drop policy if exists "Users can update own notification preferences" on public.notification_preferences;
create policy "Users can update own notification preferences"
  on public.notification_preferences for update
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Users can read own push subscriptions" on public.push_subscriptions;
create policy "Users can read own push subscriptions"
  on public.push_subscriptions for select
  using (auth.uid() = user_id);

drop policy if exists "Users can read own notification logs" on public.notification_logs;
create policy "Users can read own notification logs"
  on public.notification_logs for select
  using (auth.uid() = user_id);

create index if not exists push_subscriptions_user_active_idx
  on public.push_subscriptions(user_id, is_active);

create index if not exists notification_logs_user_sent_idx
  on public.notification_logs(user_id, sent_at desc);

create index if not exists notification_logs_type_sent_idx
  on public.notification_logs(notification_type, sent_at desc);

drop trigger if exists notification_preferences_touch_updated_at on public.notification_preferences;
create trigger notification_preferences_touch_updated_at
before update on public.notification_preferences
for each row execute function public.touch_updated_at();

drop trigger if exists push_subscriptions_touch_updated_at on public.push_subscriptions;
create trigger push_subscriptions_touch_updated_at
before update on public.push_subscriptions
for each row execute function public.touch_updated_at();
