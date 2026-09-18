create table if not exists public.notification_scheduler_runs (
  id uuid primary key default gen_random_uuid(),
  started_at timestamptz not null default now(),
  completed_at timestamptz,
  status text not null check (status in ('running', 'completed', 'failed')),
  considered integer not null default 0,
  sent integer not null default 0,
  failed integer not null default 0,
  expired integer not null default 0,
  error_message text,
  created_at timestamptz not null default now()
);

alter table public.notification_scheduler_runs enable row level security;

create index if not exists notification_scheduler_runs_created_idx
  on public.notification_scheduler_runs(created_at desc);