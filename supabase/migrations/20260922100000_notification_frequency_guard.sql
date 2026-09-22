-- One serialized allowance across reminders, content, and weekly summaries.
-- A claim is intentionally retained after a transport failure: retry storms are
-- worse for students than a deferred notification.
create table if not exists public.notification_delivery_claims (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.users(id) on delete cascade,
  delivery_key text not null check (char_length(delivery_key) between 1 and 200),
  claimed_at timestamptz not null default now(),
  unique (user_id, delivery_key)
);

create index if not exists notification_delivery_claims_recent_user_idx
  on public.notification_delivery_claims (user_id, claimed_at desc);

alter table public.notification_delivery_claims enable row level security;

create or replace function public.claim_notification_frequency_slot(
  p_user_id uuid,
  p_delivery_key text
) returns boolean
language plpgsql
security definer
set search_path = public
as $$
begin
  perform pg_advisory_xact_lock(hashtextextended(p_user_id::text, 0));

  if exists (
    select 1 from public.notification_delivery_claims
    where user_id = p_user_id and delivery_key = p_delivery_key
  ) then
    return false;
  end if;

  if (
    select count(*) from public.notification_delivery_claims
    where user_id = p_user_id and claimed_at > now() - interval '24 hours'
  ) >= 2 then
    return false;
  end if;

  insert into public.notification_delivery_claims (user_id, delivery_key)
  values (p_user_id, p_delivery_key);
  return true;
end;
$$;

revoke all on function public.claim_notification_frequency_slot(uuid, text) from public, anon, authenticated;
grant execute on function public.claim_notification_frequency_slot(uuid, text) to service_role;
