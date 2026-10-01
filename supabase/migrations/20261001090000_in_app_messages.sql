-- Reusable, non-push in-app messages. A learner can dismiss each campaign once.
-- This is separate from notification_content, whose delivery depends on push opt-in.
begin;

create table if not exists public.in_app_messages (
  id uuid primary key default gen_random_uuid(),
  campaign_key text not null unique,
  title text not null,
  body text not null,
  cta_label text not null,
  cta_path text not null check (
    cta_path ~ '^/[a-zA-Z0-9/_-]*$' and left(cta_path, 2) <> '//'
  ),
  placement text not null check (placement in ('dashboard', 'practice_result')),
  audience text not null check (audience in ('free', 'all')),
  status text not null default 'draft' check (status in ('draft', 'published')),
  starts_at timestamptz not null default now(),
  expires_at timestamptz,
  priority integer not null default 0,
  created_at timestamptz not null default now(),
  check (expires_at is null or expires_at > starts_at)
);

create table if not exists public.in_app_message_receipts (
  user_id uuid not null references auth.users(id) on delete cascade,
  message_id uuid not null references public.in_app_messages(id) on delete cascade,
  dismissed_at timestamptz not null default now(),
  primary key (user_id, message_id)
);

create index if not exists in_app_messages_delivery_idx
  on public.in_app_messages (placement, status, priority desc, starts_at desc);

alter table public.in_app_messages enable row level security;
alter table public.in_app_message_receipts enable row level security;
revoke all on public.in_app_messages, public.in_app_message_receipts
  from public, anon, authenticated;

insert into public.in_app_messages
  (campaign_key, title, body, cta_label, cta_path, placement, audience, status)
values (
  'pro_launch_2026',
  'Prepcore Pro is here',
  'Keep practising free. When you are ready for exam-day preparation, unlock full timed JAMB and WAEC mock exams, flashcards, and more help with difficult answers.',
  'See what Pro includes', '/upgrade', 'dashboard', 'free', 'published'
)
on conflict (campaign_key) do nothing;

insert into public.in_app_messages
  (campaign_key, title, body, cta_label, cta_path, placement, audience, status)
values (
  'pro_after_practice_2026',
  'Want more help preparing?',
  'Keep reviewing your missed answers for free. Prepcore Pro adds full timed JAMB and WAEC mock exams and flashcards to help you prepare for exam day.',
  'Explore Pro', '/upgrade', 'practice_result', 'free', 'published'
)
on conflict (campaign_key) do nothing;

create or replace function public.get_my_in_app_message(p_placement text)
returns table (id uuid, title text, body text, cta_label text, cta_path text)
language plpgsql stable security definer
set search_path = public, pg_temp
as $$
declare
  v_user_id uuid := auth.uid();
begin
  if v_user_id is null then
    raise exception 'Authentication required' using errcode = '42501';
  end if;
  if p_placement not in ('dashboard', 'practice_result') then
    raise exception 'Invalid placement' using errcode = '22023';
  end if;

  return query
    select m.id, m.title, m.body, m.cta_label, m.cta_path
    from public.in_app_messages m
    where m.placement = p_placement
      and m.status = 'published'
      and m.starts_at <= now()
      and (m.expires_at is null or m.expires_at > now())
      and (m.audience = 'all'
        or (m.audience = 'free' and not public.user_has_active_pro(v_user_id)))
      and not exists (
        select 1 from public.in_app_message_receipts r
        where r.user_id = v_user_id and r.message_id = m.id
      )
    order by m.priority desc, m.starts_at desc, m.id
    limit 1;
end;
$$;

create or replace function public.dismiss_my_in_app_message(p_message_id uuid)
returns void
language plpgsql security definer
set search_path = public, pg_temp
as $$
declare
  v_user_id uuid := auth.uid();
begin
  if v_user_id is null then
    raise exception 'Authentication required' using errcode = '42501';
  end if;
  if not exists (
    select 1 from public.in_app_messages m
    where m.id = p_message_id and m.status = 'published'
      and m.starts_at <= now()
      and (m.expires_at is null or m.expires_at > now())
      and (m.audience = 'all'
        or (m.audience = 'free' and not public.user_has_active_pro(v_user_id)))
  ) then
    raise exception 'Message unavailable' using errcode = '22023';
  end if;

  insert into public.in_app_message_receipts (user_id, message_id)
  values (v_user_id, p_message_id)
  on conflict (user_id, message_id) do nothing;
end;
$$;

revoke all on function public.get_my_in_app_message(text)
  from public, anon, authenticated;
grant execute on function public.get_my_in_app_message(text) to authenticated;
revoke all on function public.dismiss_my_in_app_message(uuid)
  from public, anon, authenticated;
grant execute on function public.dismiss_my_in_app_message(uuid) to authenticated;

do $$
begin
  if has_any_column_privilege('authenticated', 'public.in_app_messages', 'SELECT')
     or has_any_column_privilege('authenticated', 'public.in_app_message_receipts', 'INSERT')
     or has_function_privilege('anon', 'public.get_my_in_app_message(text)', 'EXECUTE')
     or not has_function_privilege('authenticated', 'public.get_my_in_app_message(text)', 'EXECUTE') then
    raise exception 'In-app message permissions are not safely configured';
  end if;
end;
$$;

commit;
