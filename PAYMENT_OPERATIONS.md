# Payment safety and recovery

Apply `supabase/migrations/20261001110000_payment_recovery_and_idempotency.sql`
before deploying the matching web code. The new checkout route requires its
`reserve_payment_checkout` RPC. Do not edit an already-applied payment migration.

## What the app now does

- It creates one unresolved checkout per user and plan. A repeated click reuses
  the existing reference; it never silently creates another checkout while one
  is pending. If checkout creation times out, the attempt stays pending because
  a timeout does not prove the provider rejected it.
- It grants Pro only after a fresh server-side Flutterwave verification matches
  the stored reference, exact NGN amount and currency, and successful status.
  The database activation is idempotent for that payment. Separate successful
  annual payments extend the expiry instead of erasing paid time.
- Browser status checks use the authenticated student's reference, so a missing
  redirect transaction ID is recoverable. Unconfirmed results remain pending.
- Signed webhook events are retried until they are processed; duplicate
  deliveries of an unfinished event are not discarded. A daily cron checks a
  small batch of recent unresolved payments by reference as a fallback.
- Only an HTTPS Flutterwave hosted-checkout URL is handed to the browser.

## Production checks

1. Keep `FLUTTERWAVE_SECRET_KEY`, `FLUTTERWAVE_WEBHOOK_SECRET`, and `CRON_SECRET`
   server-side only. Use a separate, random Flutterwave webhook Secret Hash;
   never put the API key in that field. Confirm the webhook URL is the live
   `/api/payments/webhook` endpoint and enable webhook retries in Flutterwave.
2. Set `NEXT_PUBLIC_APP_URL` to the live HTTPS origin. Confirm HTTPS redirects
   and HSTS are active at the hosting edge. Do not put card or bank credentials
   into Prepcore pages; users pay on Flutterwave-hosted checkout.
3. Vercel runs `/api/cron/payments` daily as a fallback. For faster unattended
   recovery, configure an hourly trusted caller with the same `CRON_SECRET` if
   your hosting plan permits it. Watch cron failures and payment-related logs.
4. Test a successful payment, cancelled checkout, bank-transfer pending state,
   lost browser redirect, repeated signed webhook, and temporary provider API
   failure in Flutterwave's test environment before releasing. Confirm a
   non-Pro user cannot invoke the service-role payment RPCs.

## If a student says their bank debited them

Ask for the Prepcore payment reference and bank transaction reference, not
their password, card number, PIN, or OTP. Check the saved payment and verify
the reference in Flutterwave's dashboard/API. If Flutterwave confirms success
but Pro is inactive, rerun the authenticated status check or protected cron;
investigate processing errors. If Flutterwave has no successful transaction,
do not manually activate Pro based on a screenshot. Ask the bank and Flutterwave
to trace or reverse the debit. A missing provider record is not proof that a
debit will settle later or that a refund already happened.

Review amount/reference mismatches, duplicate successful transactions,
refunds, chargebacks, and old linkless pending checkouts manually. This release
does not automate refunds or chargeback adjudication. A student should not
start a second checkout while the first payment is being investigated.
