# Notification API Verification

Verified against the handlers on `feature/notification-api-verification` (branched from `origin/staging`). No notification routes or database tables were changed.

## Common behavior

- Auth uses the Supabase browser session cookie and `supabase.auth.getUser()`.
- JSON bodies are read with a 24 KiB limit. Invalid JSON is treated as an invalid request body.
- Successful and application-error responses from these handlers use `Cache-Control: no-store, max-age=0` and `Pragma: no-cache`.
- Unsafe browser requests (`POST`, `PATCH`, and `DELETE`) require either no `Origin` header or an `Origin` whose host exactly matches the request `Host`. A mismatched or malformed origin returns `403` with `{ "error": "Invalid request origin." }`.
- `GET /api/notifications/preferences` does not perform the trusted-origin check.

## `POST /api/notifications/subscription`

Authentication: required for the signed-in user.

Request body:

```json
{
  "endpoint": "https://push.example.test/subscription-token",
  "expirationTime":  null,
  "keys": {
    "p256dh": "browser-p256dh-key",
    "auth": "browser-auth-key"
  },
  "platform": "android"
}
```

- `endpoint`: required URL string, maximum 2,000 characters.
- `expirationTime`: required non-negative integer or `null`.
- `keys.p256dh` and `keys.auth`: required non-empty strings, maximum 500 characters each.
- `platform`: required enum: `android`, `ios`, `desktop`, or `unknown`.
- No device ID or installation ID is required.

Success (`200`):

```json
{
  "success": true,
  "subscription": {
    "id": "uuid",
    "endpoint": "https://push.example.test/subscription-token",
    "platform": "android",
    "is_active": true
  }
}
```

Errors:

- `400`: `{ "error": "Invalid push subscription." }` for invalid/missing JSON or fields.
- `401`: `{ "error": "Unauthorized." }` without a signed-in user.
- `403`: `{ "error": "Invalid request origin." }` for an untrusted origin.
- `429`: `{ "error": "Too many subscription changes." }` with a `Retry-After` header in seconds after more than 20 attempts per user/IP in a one-hour process-local window.
- `500`: `{ "error": "Could not save push subscription." }` if the database upsert fails.

Replacement behavior: the database upsert conflicts on the globally unique `endpoint`. An existing endpoint is updated with the submitted keys, expiration, platform, and active state. The operation does not require a separate installation/device identifier.

## `DELETE /api/notifications/subscription`

Authentication: required for the signed-in user.

Request body:

```json
{
  "endpoint": "https://push.example.test/subscription-token"
}
```

- `endpoint`: required URL string, maximum 2,000 characters.

Success (`200`):

```json
{ "success": true }
```

Errors:

- `400`: `{ "error": "A valid endpoint is required." }` for invalid/missing JSON or endpoint.
- `401`: `{ "error": "Unauthorized." }` without a signed-in user.
- `403`: `{ "error": "Invalid request origin." }` for an untrusted origin.
- `429`: `{ "error": "Too many subscription changes." }` with `Retry-After` after more than 20 attempts per user/IP in one hour.
- `500`: `{ "error": "Could not remove push subscription." }` if the database update fails.

Deletion is a soft delete: the matching signed-in user's row is set to `is_active: false`.

## `GET /api/notifications/preferences`

Authentication: required for the signed-in user. No request body.

Success (`200`) when a row exists:

```json
{
  "preferences": {
    "study_reminders_enabled": false,
    "streak_reminders_enabled": false,
    "timezone": "UTC",
    "last_reminder_sent_at": null
  }
}
```

If no row exists, the same `200` response returns the default object shown above.

Errors:

- `401`: `{ "error": "Unauthorized." }` without a signed-in user.
- `500`: `{ "error": "Could not load notification preferences." }` if the database read fails.

## `PATCH /api/notifications/preferences`

Authentication: required for the signed-in user.

Request body:

```json
{
  "studyRemindersEnabled": true,
  "streakRemindersEnabled": true,
  "timezone": "Africa/Lagos"
}
```

- Both reminder fields are required booleans.
- `timezone` is a required non-empty string, maximum 100 characters. It is not validated against an IANA timezone list.

Success (`200`):

```json
{
  "success": true,
  "preferences": {
    "study_reminders_enabled": true,
    "streak_reminders_enabled": true,
    "timezone": "Africa/Lagos",
    "last_reminder_sent_at": null
  }
}
```

Errors:

- `400`: `{ "error": "Invalid notification preferences." }` for invalid/missing JSON or fields.
- `401`: `{ "error": "Unauthorized." }` without a signed-in user.
- `403`: `{ "error": "Invalid request origin." }` for an untrusted origin.
- `500`: `{ "error": "Could not update notification preferences." }` if the database upsert fails.

## `POST /api/notifications/test`

Authentication/authorization: an authenticated Supabase user whose email is included in the comma-separated `ADMIN_EMAILS` environment variable. Non-admin or unauthenticated callers receive the same `403` response before request validation:

```json
{ "error": "Forbidden" }
```

The request also requires a trusted origin when an `Origin` header is present.

Request body:

```json
{
  "userId": "uuid-of-recipient",
  "title": "Prepcore notification test",
  "body": "Your browser push notifications are connected.",
  "url": "/dashboard"
}
```

- `userId`: required UUID.
- `title`: optional trimmed non-empty string, maximum 120 characters.
- `body`: optional trimmed non-empty string, maximum 500 characters.
- `url`: optional enum: `/dashboard` or `/practice`.
- There is no device ID or installation ID field and no route-level rate limit.

Success (`200`):

```json
{ "success": true, "sent": 1, "failed": 0 }
```

`success` is true when at least one active subscription sends successfully. The counts cover every active subscription for the requested user.

Errors:

- `400`: `{ "error": "A valid userId is required." }` for invalid/missing JSON or fields.
- `403`: `{ "error": "Forbidden" }` for a non-admin/unauthenticated session, or `{ "error": "Invalid request origin." }` for an untrusted origin from an otherwise authorized admin.
- `404`: `{ "error": "No active push subscription found for this user." }` when the user has no active subscriptions.
- `500`: `{ "error": "Could not load push subscriptions." }` if the subscription lookup fails.

Individual delivery failures do not change the response to `500`; they increment `failed`. HTTP `404` or `410` from the push provider also soft-deactivates that subscription and logs it as `expired`. Other provider failures are logged as `failed`.

## Cleanup and environment

- Expired subscription cleanup occurs during the manual test endpoint and the scheduled reminder service when the push provider returns status `404` or `410`; those rows are updated to `is_active: false`.
- `POST` replacement reactivates the endpoint by writing `is_active: true`.
- Required notification environment variables are `NEXT_PUBLIC_WEB_PUSH_PUBLIC_KEY`, `WEB_PUSH_PRIVATE_KEY`, and `WEB_PUSH_SUBJECT`. The private key is server-only. The scheduler additionally requires `CRON_SECRET` for `GET /api/cron/notifications` (`Authorization: Bearer <CRON_SECRET>`). Admin access requires `ADMIN_EMAILS`.
- The implementation uses VAPID/web-push. No VAPID key values are documented or committed here.

## Frontend verification

Marcus's current settings page renders four uncontrolled, `defaultChecked` checkboxes. It does not call the preferences `GET`/`PATCH` routes, does not register or delete a browser `PushSubscription`, does not call the manual test route, and does not supply the required subscription payload (`endpoint`, `expirationTime`, `keys.p256dh`, `keys.auth`, `platform`). It therefore does not yet match this backend contract. The page also presents options that are not represented by the current API (`Mock exam summary`, `Weak-topic alerts`, and `Leaderboard movement`).
