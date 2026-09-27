-- A database-serialized limit shared by every API instance. Only the service
-- role may claim slots; bucket identifiers are HMACs made on the server.
create table if not exists public.api_rate_limit_buckets (
  bucket_hash text primary key check (bucket_hash ~ '^[0-9a-f]{64}$'),
  window_started_at timestamptz not null,
  hit_count integer not null check (hit_count >= 1),
  updated_at timestamptz not null default now()
);

create index if not exists api_rate_limit_buckets_updated_idx
  on public.api_rate_limit_buckets (updated_at);

alter table public.api_rate_limit_buckets enable row level security;
revoke all on public.api_rate_limit_buckets from public, anon, authenticated;
grant select, insert, update, delete on public.api_rate_limit_buckets to service_role;

create or replace function public.claim_api_rate_limit_slot(
  p_bucket_hash text,
  p_max_hits integer,
  p_window_seconds integer
) returns table (allowed boolean, remaining integer, retry_after_seconds integer)
language plpgsql
security definer
set search_path = public, pg_temp
as $$
declare
  v_now timestamptz := clock_timestamp();
  v_started_at timestamptz;
  v_hits integer;
begin
  if p_bucket_hash !~ '^[0-9a-f]{64}$'
    or p_max_hits not between 1 and 1000
    or p_window_seconds not between 1 and 86400 then
    raise exception 'Invalid rate limit configuration';
  end if;

  insert into public.api_rate_limit_buckets
    (bucket_hash, window_started_at, hit_count, updated_at)
  values (p_bucket_hash, v_now, 1, v_now)
  on conflict (bucket_hash) do update set
    hit_count = case
      when public.api_rate_limit_buckets.window_started_at <= v_now - make_interval(secs => p_window_seconds)
        then 1
      else public.api_rate_limit_buckets.hit_count + 1
    end,
    window_started_at = case
      when public.api_rate_limit_buckets.window_started_at <= v_now - make_interval(secs => p_window_seconds)
        then v_now
      else public.api_rate_limit_buckets.window_started_at
    end,
    updated_at = v_now
  returning window_started_at, hit_count into v_started_at, v_hits;

  if random() < 0.01 then
    delete from public.api_rate_limit_buckets
    where bucket_hash in (
      select bucket_hash from public.api_rate_limit_buckets
      where updated_at < v_now - interval '7 days'
      order by updated_at
      limit 100
    );
  end if;

  return query select
    v_hits <= p_max_hits,
    greatest(0, p_max_hits - v_hits),
    case when v_hits <= p_max_hits then 0 else
      greatest(1, ceil(extract(epoch from
        (v_started_at + make_interval(secs => p_window_seconds) - v_now)))::integer)
    end;
end;
$$;

revoke all on function public.claim_api_rate_limit_slot(text, integer, integer)
  from public, anon, authenticated;
grant execute on function public.claim_api_rate_limit_slot(text, integer, integer)
  to service_role;
