-- Forward-only hardening: RLS limits which profile row a learner owns, while
-- column privileges limit which fields that learner may create or change.
-- Keep the columns used by auth callback and onboarding available to clients.
begin;

revoke create on schema public from public, anon, authenticated;

revoke insert, update on table public.users from public, anon, authenticated;

grant insert (
  id, full_name, phone, email, exam_type,
  selected_subjects, target_score, exam_date, onboarding_completed
) on table public.users to authenticated;

-- PostgREST upserts include the conflict key in their UPDATE clause. RLS
-- still requires id = auth.uid(), so updating id cannot change ownership.
grant update (
  id, full_name, phone, email, exam_type,
  selected_subjects, target_score, exam_date, onboarding_completed
) on table public.users to authenticated;

-- Older databases may not have the optional exam_goals column yet.
do $$
begin
  if exists (
    select 1 from information_schema.columns
    where table_schema = 'public' and table_name = 'users'
      and column_name = 'exam_goals'
  ) then
    grant insert (exam_goals) on table public.users to authenticated;
    grant update (exam_goals) on table public.users to authenticated;
  end if;
end;
$$;

-- PostgreSQL grants EXECUTE on new functions to PUBLIC by default. The
-- reward grant is called by the subscription trigger, never by a browser.
revoke all on function public.grant_user_referral_rewards(uuid)
  from public, anon, authenticated;
grant execute on function public.grant_user_referral_rewards(uuid)
  to service_role;

revoke all on function public.on_user_pro_subscription()
  from public, anon, authenticated;

-- These referral RPCs are intentionally available only after authentication.
revoke all on function public.ensure_user_referral_code()
  from public, anon, authenticated;
grant execute on function public.ensure_user_referral_code()
  to authenticated;

revoke all on function public.record_user_referral_signup(text)
  from public, anon, authenticated;
grant execute on function public.record_user_referral_signup(text)
  to authenticated;

revoke all on function public.apply_referral_code(text)
  from public, anon, authenticated;
grant execute on function public.apply_referral_code(text)
  to authenticated;

revoke all on function public.apply_any_referral_code(text)
  from public, anon, authenticated;
grant execute on function public.apply_any_referral_code(text)
  to authenticated;

-- SECURITY DEFINER routines must not resolve unqualified objects from a
-- caller-writable temporary schema before the trusted public schema.
alter function public.grant_user_referral_rewards(uuid)
  set search_path = public, pg_temp;
alter function public.on_user_pro_subscription()
  set search_path = public, pg_temp;
alter function public.ensure_user_referral_code()
  set search_path = public, pg_temp;
alter function public.record_user_referral_signup(text)
  set search_path = public, pg_temp;
alter function public.apply_referral_code(text)
  set search_path = public, pg_temp;
alter function public.apply_any_referral_code(text)
  set search_path = public, pg_temp;

do $$
begin
  if has_column_privilege('authenticated', 'public.users', 'is_pro', 'UPDATE')
    or has_column_privilege('authenticated', 'public.users', 'plan', 'UPDATE')
    or has_column_privilege('authenticated', 'public.users', 'subscription_expires_at', 'UPDATE')
    or has_column_privilege('authenticated', 'public.users', 'is_pro', 'INSERT')
    or has_function_privilege('authenticated', 'public.grant_user_referral_rewards(uuid)', 'EXECUTE')
    or has_schema_privilege('authenticated', 'public', 'CREATE')
    or not has_column_privilege('authenticated', 'public.users', 'full_name', 'UPDATE')
    or not has_function_privilege('authenticated', 'public.apply_any_referral_code(text)', 'EXECUTE') then
    raise exception 'Profile or referral privileges are not safely configured';
  end if;
end;
$$;

commit;
