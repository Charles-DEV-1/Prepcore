-- Forward-only payment hardening. Reserve one unresolved checkout per user and
-- plan, and make separate successful annual purchases extend access rather
-- than silently replacing the previous expiry.
begin;

alter table public.payments
  add column if not exists last_reconciled_at timestamptz;

create index if not exists payments_reconcile_due_idx
  on public.payments (last_reconciled_at, created_at)
  where processed_at is null and status in ('pending', 'failed', 'cancelled');

create or replace function public.reserve_payment_checkout(
  p_user_id uuid,
  p_tx_ref text,
  p_idempotency_key text,
  p_plan_key text,
  p_plan_name text,
  p_amount numeric,
  p_currency text,
  p_customer_email text,
  p_metadata jsonb
)
returns jsonb
language plpgsql
security definer
set search_path = public, pg_temp
as $$
declare
  v_existing public.payments%rowtype;
begin
  if p_user_id is null or p_tx_ref is null or p_idempotency_key is null
     or p_plan_key is null or p_amount <= 0 or p_currency is null then
    raise exception 'Invalid payment reservation' using errcode = '22023';
  end if;

  -- Serialize all checkout creation for this user and plan, including requests
  -- from different devices. A pending checkout is never silently discarded:
  -- its payment may still settle after a browser or network failure.
  perform pg_advisory_xact_lock(hashtextextended(p_user_id::text || ':' || p_plan_key, 0));
  select * into v_existing
  from public.payments
  where user_id = p_user_id and plan_key = p_plan_key and status = 'pending'
  order by created_at desc
  limit 1
  for update;

  if found then
    return jsonb_build_object(
      'created', false,
      'tx_ref', v_existing.tx_ref,
      'checkout_url', coalesce(v_existing.checkout_url, v_existing.payment_link)
    );
  end if;

  insert into public.payments (
    user_id, tx_ref, flutterwave_tx_ref, idempotency_key, plan_key,
    plan_name, amount, currency, status, customer_email, metadata
  ) values (
    p_user_id, p_tx_ref, p_tx_ref, p_idempotency_key, p_plan_key,
    p_plan_name, p_amount, p_currency, 'pending', p_customer_email,
    coalesce(p_metadata, '{}'::jsonb)
  );

  return jsonb_build_object('created', true, 'tx_ref', p_tx_ref);
end;
$$;

revoke all on function public.reserve_payment_checkout(uuid, text, text, text, text, numeric, text, text, jsonb)
  from public, anon, authenticated;
grant execute on function public.reserve_payment_checkout(uuid, text, text, text, text, numeric, text, text, jsonb)
  to service_role;

create or replace function public.process_successful_payment(
  p_tx_ref text,
  p_flutterwave_transaction_id bigint,
  p_provider_response jsonb,
  p_verified_at timestamptz default now()
)
returns jsonb
language plpgsql
security definer
set search_path = public, pg_temp
as $$
declare
  v_payment public.payments%rowtype;
  v_started_at timestamptz;
  v_expires_at timestamptz;
  v_existing_end timestamptz;
begin
  select * into v_payment
  from public.payments
  where tx_ref = p_tx_ref or flutterwave_tx_ref = p_tx_ref
  for update;
  if not found then
    return jsonb_build_object('success', false, 'error', 'payment_not_found');
  end if;
  if v_payment.status = 'successful' and v_payment.processed_at is not null then
    return jsonb_build_object(
      'success', true, 'already_processed', true,
      'user_id', v_payment.user_id, 'payment_id', v_payment.id
    );
  end if;

  -- The user lock serializes different successful transactions for the same
  -- account so both paid years are preserved under concurrent callbacks.
  perform 1 from public.users where id = v_payment.user_id for update;
  select current_period_end into v_existing_end
  from public.subscriptions where user_id = v_payment.user_id;
  v_started_at := p_verified_at;
  v_expires_at := greatest(p_verified_at, coalesce(v_existing_end, p_verified_at))
    + interval '365 days';

  update public.payments
  set status = 'successful',
      tx_ref = coalesce(public.payments.tx_ref, p_tx_ref),
      flutterwave_tx_ref = coalesce(public.payments.flutterwave_tx_ref, p_tx_ref),
      flutterwave_transaction_id = coalesce(public.payments.flutterwave_transaction_id, p_flutterwave_transaction_id),
      flutterwave_flw_ref = coalesce(p_provider_response #>> '{data,flw_ref}', public.payments.flutterwave_flw_ref),
      provider_response = p_provider_response,
      verification_attempts = public.payments.verification_attempts + 1,
      verified_at = p_verified_at,
      paid_at = coalesce(public.payments.paid_at, p_verified_at),
      processed_at = coalesce(public.payments.processed_at, now()),
      failure_reason = null
  where id = v_payment.id;

  insert into public.subscriptions (
    user_id, plan, status, current_period_end, subscription_started_at,
    subscription_expires_at, provider, provider_subscription_id
  ) values (
    v_payment.user_id, 'pro', 'active', v_expires_at, v_started_at,
    v_expires_at, 'flutterwave', p_flutterwave_transaction_id::text
  )
  on conflict (user_id) do update set
    plan = excluded.plan,
    status = excluded.status,
    current_period_end = excluded.current_period_end,
    subscription_started_at = excluded.subscription_started_at,
    subscription_expires_at = excluded.subscription_expires_at,
    provider = excluded.provider,
    provider_subscription_id = excluded.provider_subscription_id,
    updated_at = now();

  update public.users
  set plan = 'pro', is_pro = true,
      subscription_started_at = v_started_at,
      subscription_expires_at = v_expires_at
  where id = v_payment.user_id;

  return jsonb_build_object(
    'success', true, 'already_processed', false,
    'user_id', v_payment.user_id, 'payment_id', v_payment.id,
    'subscription_expires_at', v_expires_at
  );
end;
$$;

revoke all on function public.process_successful_payment(text, bigint, jsonb, timestamptz)
  from public, anon, authenticated;
grant execute on function public.process_successful_payment(text, bigint, jsonb, timestamptz)
  to service_role;

do $$
begin
  if has_function_privilege('authenticated', 'public.reserve_payment_checkout(uuid, text, text, text, text, numeric, text, text, jsonb)', 'EXECUTE')
     or has_function_privilege('authenticated', 'public.process_successful_payment(text, bigint, jsonb, timestamptz)', 'EXECUTE') then
    raise exception 'Payment routines must remain server-only';
  end if;
end;
$$;

notify pgrst, 'reload schema';

commit;
