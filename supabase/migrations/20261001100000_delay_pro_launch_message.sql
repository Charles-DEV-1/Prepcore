-- Delay the dashboard Pro launch announcement until a free learner has used
-- practice. Keep the result-page invitation eligible immediately after results.
-- Forward-only: the original in-app message migration may already be live.
begin;

alter table public.in_app_messages
  add column if not exists min_practice_sessions integer not null default 0
    check (min_practice_sessions between 0 and 100),
  add column if not exists min_account_age_days integer not null default 0
    check (min_account_age_days between 0 and 365),
  add column if not exists min_active_practice_days integer not null default 0
    check (min_active_practice_days between 0 and 100);

-- A session counts only once at least five answers have been saved. The
-- alternative age path also requires practice on two separate Lagos dates;
-- an old but unused account does not qualify simply by signing in.
update public.in_app_messages
set min_practice_sessions = 3,
    min_account_age_days = 7,
    min_active_practice_days = 2
where campaign_key = 'pro_launch_2026';

create or replace function public.get_my_in_app_message(p_placement text)
returns table (id uuid, title text, body text, cta_label text, cta_path text)
language plpgsql stable security definer
set search_path = public, pg_temp
as $$
declare
  v_user_id uuid := auth.uid();
  v_signed_up_at timestamptz;
  v_practice_sessions integer;
  v_practice_days integer;
begin
  if v_user_id is null then
    raise exception 'Authentication required' using errcode = '42501';
  end if;
  if p_placement is null or p_placement not in ('dashboard', 'practice_result') then
    raise exception 'Invalid placement' using errcode = '22023';
  end if;

  select u.created_at into v_signed_up_at
  from auth.users u where u.id = v_user_id;

  select count(*)::integer,
         count(distinct (s.created_at at time zone 'Africa/Lagos')::date)::integer
    into v_practice_sessions, v_practice_days
  from public.sessions s
  where s.user_id = v_user_id
    and s.mode::text = 'practice'
    and s.total_questions >= 5;

  return query
    select m.id, m.title, m.body, m.cta_label, m.cta_path
    from public.in_app_messages m
    where m.placement = p_placement
      and m.status = 'published'
      and m.starts_at <= now()
      and (m.expires_at is null or m.expires_at > now())
      and (m.audience = 'all'
        or (m.audience = 'free' and not public.user_has_active_pro(v_user_id)))
      and (
        (m.min_practice_sessions = 0 and m.min_account_age_days = 0)
        or (m.min_practice_sessions > 0
          and v_practice_sessions >= m.min_practice_sessions)
        or (m.min_account_age_days > 0
          and v_signed_up_at <= now() - make_interval(days => m.min_account_age_days)
          and v_practice_days >= m.min_active_practice_days)
      )
      and not exists (
        select 1 from public.in_app_message_receipts r
        where r.user_id = v_user_id and r.message_id = m.id
      )
    order by m.priority desc, m.starts_at desc, m.id
    limit 1;
end;
$$;

revoke all on function public.get_my_in_app_message(text)
  from public, anon, authenticated;
grant execute on function public.get_my_in_app_message(text) to authenticated;

do $$
begin
  if has_function_privilege('anon', 'public.get_my_in_app_message(text)', 'EXECUTE')
     or not has_function_privilege('authenticated', 'public.get_my_in_app_message(text)', 'EXECUTE')
     or not exists (
       select 1 from public.in_app_messages m
       where m.campaign_key = 'pro_launch_2026'
         and m.min_practice_sessions = 3
         and m.min_account_age_days = 7
         and m.min_active_practice_days = 2
     ) then
    raise exception 'Delayed Pro launch eligibility is not configured';
  end if;
end;
$$;

commit;
