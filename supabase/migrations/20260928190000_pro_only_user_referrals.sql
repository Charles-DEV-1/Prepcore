-- Personal referrals require an active Pro entitlement. Existing signups and
-- earned rewards remain intact; new reward batches are cash-only.
begin;

-- Match the application's effective-plan rules, including active lesson-centre
-- bulk Pro. Do not trust users.is_pro, which can outlive an expired subscription.
create or replace function public.user_has_active_pro(p_user_id uuid)
returns boolean
language sql
stable
security definer
set search_path = public, pg_temp
as $$
  select p_user_id is not null and (
    exists (
      select 1 from public.subscriptions s
      where s.user_id = p_user_id
        and s.plan = 'pro'
        and s.status = 'active'
        and (s.current_period_end is null or s.current_period_end > now())
    )
    or exists (
      select 1
      from public.user_referrals ur
      join public.partners p on p.id = ur.partner_id
      where ur.user_id = p_user_id
        and p.is_active
        and p.bulk_pro_active
        and (p.bulk_pro_expires_at is null or p.bulk_pro_expires_at > now())
    )
  );
$$;

revoke all on function public.user_has_active_pro(uuid)
  from public, anon, authenticated;
grant execute on function public.user_has_active_pro(uuid) to service_role;

-- Clients must not bypass the Pro check by inserting their own personal code.
drop policy if exists "Users create own user referral code"
  on public.user_referral_codes;
revoke insert on table public.user_referral_codes
  from public, anon, authenticated;

create or replace function public.ensure_user_referral_code()
returns text
language plpgsql
security definer
set search_path = public, pg_temp
as $$
declare
  v_user_id uuid := auth.uid();
  existing_code text;
  generated_code text;
  base text;
begin
  if v_user_id is null then
    raise exception 'Authentication required' using errcode = '42501';
  end if;
  if not public.user_has_active_pro(v_user_id) then
    raise exception 'An active Pro plan is required to refer friends'
      using errcode = '42501';
  end if;

  select code into existing_code
  from public.user_referral_codes
  where user_id = v_user_id;
  if existing_code is not null then return existing_code; end if;

  select upper(left(regexp_replace(coalesce(full_name, 'PREPCORE'), '[^A-Za-z]', '', 'g'), 5))
    into base from public.users where id = v_user_id;
  base := rpad(coalesce(nullif(base, ''), 'PREP'), 5, 'X');

  loop
    generated_code := base || upper(left(replace(gen_random_uuid()::text, '-', ''), 6));
    begin
      insert into public.user_referral_codes(user_id, code)
      values (v_user_id, generated_code);
      return generated_code;
    exception when unique_violation then
      -- A collision is rare; retry with another suffix.
    end;
  end loop;
end;
$$;

-- Keep the older direct RPC secure even though current onboarding uses
-- apply_any_referral_code instead.
create or replace function public.record_user_referral_signup(p_code text)
returns void
language plpgsql
security definer
set search_path = public, pg_temp
as $$
declare
  v_referrer_id uuid;
  v_referee_id uuid := auth.uid();
  v_code text := upper(trim(p_code));
begin
  if v_referee_id is null or v_code is null or v_code = '' then return; end if;

  select user_id into v_referrer_id
  from public.user_referral_codes
  where code = v_code;
  if v_referrer_id is null or v_referrer_id = v_referee_id
     or not public.user_has_active_pro(v_referrer_id) then return; end if;

  insert into public.user_referral_signups(referrer_id, referee_id, code)
  values (v_referrer_id, v_referee_id, v_code)
  on conflict (referee_id) do nothing;
end;
$$;

-- Preserve affiliate and lesson-centre referral handling. Personal codes
-- belonging to expired/non-Pro users cannot create new attributions.
create or replace function public.apply_any_referral_code(p_code text)
returns jsonb
language plpgsql
security definer
set search_path = public, pg_temp
as $$
declare
  normalized_code text := upper(trim(p_code));
  referrer_id uuid;
  v_partner public.partner_accounts%rowtype;
begin
  if auth.uid() is null then
    return jsonb_build_object('success', false, 'error', 'not_authenticated');
  end if;
  if normalized_code is null or normalized_code = '' then
    return jsonb_build_object('success', false, 'error', 'invalid_code');
  end if;

  select user_id into referrer_id
  from public.user_referral_codes
  where code = normalized_code;
  if referrer_id is not null then
    if referrer_id = auth.uid() then
      return jsonb_build_object('success', false, 'error', 'invalid_code');
    end if;
    if not public.user_has_active_pro(referrer_id) then
      return jsonb_build_object('success', false, 'error', 'referrer_not_pro');
    end if;
    insert into public.user_referral_signups(referrer_id, referee_id, code)
    values (referrer_id, auth.uid(), normalized_code)
    on conflict (referee_id) do nothing;
    return jsonb_build_object('success', true, 'code', normalized_code, 'referral_type', 'user');
  end if;

  select * into v_partner
  from public.partner_accounts
  where referral_code = normalized_code and status = 'active';
  if found then
    insert into public.partner_referral_conversions
      (partner_id, user_id, user_email, user_name, referral_code, commission_amount)
    select v_partner.id, u.id, coalesce(u.email, ''),
           coalesce(u.full_name, ''), normalized_code, v_partner.commission_per_sale
    from public.users u where u.id = auth.uid()
    on conflict (user_id) do nothing;
    return jsonb_build_object('success', true, 'code', normalized_code, 'referral_type', 'affiliate');
  end if;

  return public.apply_referral_code(normalized_code);
end;
$$;

-- Keep the existing conversion trigger, but make new batches cash-only.
-- Historical pro_granted flags and already-awarded Pro time are untouched.
create or replace function public.grant_user_referral_rewards(p_referee_id uuid)
returns void
language plpgsql
security definer
set search_path = public, pg_temp
as $$
declare
  referrer uuid;
  converted_count integer;
  batch_number integer;
begin
  update public.user_referral_signups
  set converted_to_pro = true, converted_at = now()
  where referee_id = p_referee_id and converted_to_pro = false
  returning referrer_id into referrer;
  if referrer is null then return; end if;

  -- Serialize concurrent conversions for one referrer before counting batches.
  perform 1 from public.users where id = referrer for update;

  select count(*) into converted_count
  from public.user_referral_signups urs
  where urs.referrer_id = referrer and urs.converted_to_pro = true;

  for batch_number in 1..floor(converted_count / 5.0)::integer loop
    insert into public.user_referral_rewards(user_id, reward_batch)
    values (referrer, batch_number)
    on conflict (user_id, reward_batch) do nothing;
  end loop;
end;
$$;

-- New functions default to PUBLIC EXECUTE in PostgreSQL. Keep these RPCs
-- callable only by authenticated clients; the reward routine is server-only.
revoke all on function public.ensure_user_referral_code()
  from public, anon, authenticated;
grant execute on function public.ensure_user_referral_code() to authenticated;
revoke all on function public.record_user_referral_signup(text)
  from public, anon, authenticated;
grant execute on function public.record_user_referral_signup(text) to authenticated;
revoke all on function public.apply_any_referral_code(text)
  from public, anon, authenticated;
grant execute on function public.apply_any_referral_code(text) to authenticated;
revoke all on function public.grant_user_referral_rewards(uuid)
  from public, anon, authenticated;
grant execute on function public.grant_user_referral_rewards(uuid) to service_role;

-- Cash claims go through the authenticated, rate-limited server endpoint.
drop policy if exists "Users claim own user referral reward"
  on public.user_referral_rewards;
revoke update on table public.user_referral_rewards
  from public, anon, authenticated;
revoke update (bank_name, account_number, account_name,
               cash_claim_requested_at, cash_claimed)
  on table public.user_referral_rewards from authenticated;

do $$
begin
  if has_any_column_privilege('authenticated', 'public.user_referral_codes', 'INSERT')
    or has_any_column_privilege('authenticated', 'public.user_referral_rewards', 'UPDATE')
    or has_function_privilege('authenticated', 'public.user_has_active_pro(uuid)', 'EXECUTE')
    or not has_function_privilege('authenticated', 'public.ensure_user_referral_code()', 'EXECUTE')
    or not has_function_privilege('authenticated', 'public.apply_any_referral_code(text)', 'EXECUTE') then
    raise exception 'Personal referral permissions are not safely configured';
  end if;
end;
$$;

commit;
