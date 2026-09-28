-- Keep original practice available through the authenticated question route,
-- while enforcing the existing Pro-only Mock Exam rule at the database boundary.
create or replace function public.current_user_has_pro_entitlement()
returns boolean
language sql
stable
security definer
set search_path = public, pg_temp
as $$
  select auth.uid() is not null and (
    exists (
      select 1
      from public.subscriptions as subscription
      where subscription.user_id = auth.uid()
        and subscription.plan = 'pro'
        and subscription.status = 'active'
        and (
          subscription.current_period_end is null
          or subscription.current_period_end > now()
        )
    )
    or exists (
      select 1
      from public.user_referrals as referral
      join public.partners as partner on partner.id = referral.partner_id
      where referral.user_id = auth.uid()
        and partner.is_active = true
        and partner.bulk_pro_active = true
        and (
          partner.bulk_pro_expires_at is null
          or partner.bulk_pro_expires_at > now()
        )
    )
  );
$$;

revoke all on function public.current_user_has_pro_entitlement()
  from public, anon, authenticated;
grant execute on function public.current_user_has_pro_entitlement()
  to authenticated;

drop policy if exists "Users can manage own sessions" on public.sessions;
drop policy if exists "Users can read own sessions" on public.sessions;
drop policy if exists "Users can create own sessions" on public.sessions;
drop policy if exists "Users can update own sessions" on public.sessions;
drop policy if exists "Users can delete own sessions" on public.sessions;

create policy "Users can read own sessions" on public.sessions
  for select to authenticated
  using (auth.uid() = user_id);

create policy "Users can create own sessions" on public.sessions
  for insert to authenticated
  with check (
    auth.uid() = user_id
    and (mode::text <> 'mock' or public.current_user_has_pro_entitlement())
  );

create policy "Users can update own sessions" on public.sessions
  for update to authenticated
  using (auth.uid() = user_id)
  with check (
    auth.uid() = user_id
    and (mode::text <> 'mock' or public.current_user_has_pro_entitlement())
  );

create policy "Users can delete own sessions" on public.sessions
  for delete to authenticated
  using (auth.uid() = user_id);
