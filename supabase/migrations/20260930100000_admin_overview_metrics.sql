-- Aggregate admin-only overview metrics in the database, without paging
-- through sensitive Auth users or payment rows in the web application.
begin;

create index if not exists sessions_admin_activity_idx
  on public.sessions (created_at desc, user_id);

create or replace function public.admin_overview_metrics()
returns table (
  total_users bigint,
  profile_users bigint,
  active_users_7d bigint,
  practice_sessions bigint,
  paid_users bigint,
  revenue_ngn numeric,
  new_users_7d bigint,
  returning_users_7d bigint,
  sessions_today bigint,
  pending_reports bigint
)
language sql
stable
security definer
set search_path = pg_catalog, pg_temp
as $$
  with bounds as (
    select now() - interval '7 days' as week_start,
           date_trunc('day', now() at time zone 'Africa/Lagos')
             at time zone 'Africa/Lagos' as today_start
  ),
  active_ids as materialized (
    -- A refreshed login is not required for someone who used practice/exam.
    select u.id as user_id
    from auth.users as u, bounds as b
    where u.last_sign_in_at >= b.week_start
    union
    select s.user_id
    from public.sessions as s, bounds as b
    where s.created_at >= b.week_start
  ),
  auth_counts as (
    select count(*) as total,
           count(*) filter (where u.created_at >= b.week_start) as new_7d
    from auth.users as u cross join bounds as b
  ),
  payment_counts as (
    select count(distinct p.user_id) as payers,
           coalesce(sum(p.amount) filter (
             where upper(p.currency) = 'NGN'
           ), 0)::numeric as ngn_revenue
    from public.payments as p
    where p.status = 'successful'
  )
  select
    a.total,
    (select count(*) from public.users),
    (select count(*) from active_ids),
    (select count(*) from public.sessions where mode::text = 'practice'
       and total_questions > 0),
    p.payers,
    p.ngn_revenue,
    a.new_7d,
    (select count(*) from active_ids as active
       join auth.users as u on u.id = active.user_id
       cross join bounds as b
       where u.created_at < b.week_start),
    (select count(*) from public.sessions as s cross join bounds as b
       where s.created_at >= b.today_start),
    (select count(*) from public.question_reports where status = 'pending')
  from auth_counts as a cross join payment_counts as p;
$$;

revoke all on function public.admin_overview_metrics()
  from public, anon, authenticated;
grant execute on function public.admin_overview_metrics() to service_role;

do $$
begin
  if has_function_privilege('anon', 'public.admin_overview_metrics()', 'EXECUTE')
    or has_function_privilege('authenticated', 'public.admin_overview_metrics()', 'EXECUTE')
    or not has_function_privilege('service_role', 'public.admin_overview_metrics()', 'EXECUTE') then
    raise exception 'Admin overview metrics are not safely configured';
  end if;
end;
$$;

commit;
