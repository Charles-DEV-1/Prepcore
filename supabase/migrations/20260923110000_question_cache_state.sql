-- Tracks the provider cursor per exam subject. This lets the application grow
-- its cached question bank without repeatedly retrieving the same first page.
create table if not exists public.question_cache_state (
  subject_id uuid primary key references public.subjects(id) on delete cascade,
  exam_type text not null check (exam_type in ('jamb', 'waec')),
  next_cursor text,
  exhausted boolean not null default false,
  last_attempt_at timestamptz,
  last_success_at timestamptz,
  updated_at timestamptz not null default now()
);

alter table public.question_cache_state enable row level security;

-- This is operational state, never learner-facing data. It is accessed only
-- by the service-role cache worker and protected session route.
revoke all on table public.question_cache_state from anon, authenticated;
grant all on table public.question_cache_state to service_role;
