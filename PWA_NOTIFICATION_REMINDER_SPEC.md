# Prepcore PWA Notification Reminder System — Team Assignment Spec

## Overview

This feature is the PWA reminder system for Prepcore.

The goal is to remind users to come back and study when they have not completed a study session in 24 hours, and to protect their streaks before they break.

This is not a general marketing notification system. It is a retention and study habit reminder system built around the app’s existing streak logic.

This feature must be opt-in, permission-based, and delivered through the browser push system after the user grants permission.

---

## Product Requirement

When a user completes a study session in Prepcore, the app tracks the last activity timestamp.

If the user does not complete another study session after 24 hours, the system should send a reminder notification.

The reminder should:

- encourage the user to open the app
- protect their streak
- work when the app is closed, as long as the browser/device supports push notifications
- avoid spamming the user
- only send once within the correct reminder window

Examples of reminder copy:

- "Keep your streak alive"
- "It has been 24 hours since your last study session"
- "A quick 10-minute practice session will keep your streak going"

---

## Business Rule

Reminder logic:

- Last activity is updated after a study session, mock exam, or other approved learning action.
- If `now - last_activity_at >= 24 hours` and reminder is enabled, send a reminder.
- If the user completes a study session again, reset the reminder timer.
- Do not send another reminder if one was already sent within the current inactivity window.

---

## Work Distribution

### Michael — Lead backend + core engine

Michael is the lead for the logic that makes the notification system function reliably.

Michael should own the core backend work and the hardest logic.

Responsibilities:

- design the final notification architecture
- define the reminder job logic and cron/scheduler flow
- create the Supabase tables and schema for notifications
- manage user reminder preferences and subscription records
- build the backend APIs to create, deactivate, and update subscriptions
- build the system that checks last activity and sends reminder pushes
- validate the 24-hour reminder rule and deduplication logic
- implement the server-side scheduler job that scans eligible users
- make sure push sends only once per reminder window
- handle logging and retry/failure tracking for a send attempt
- ensure notification logic references the existing streak logic correctly
- partner with the frontend team to confirm payload shape and push event flow

Michael should be the person responsible for the final logic of:

- if reminder qualifies
- when it sends
- when it stops
- when it resets after activity

Michael should also own the backend integration with the push provider.

Suggested split:

- Michael: 45% of the work
- Marcus: 35%
- Webbi: 20%

This is because Michael owns the main backend and scheduling logic.

### Marcus — Frontend PWA + permission UX + animations

Marcus is responsible for all user-facing notification experience.

Responsibilities:

- enable the PWA permission flow in the app
- build the reminder settings UI in the dashboard/settings section
- request browser notification permission only after explicit user action
- handle push subscription registration from the browser
- connect to the backend subscription API
- show whether notifications are enabled, blocked, or disabled
- design and implement the toast/banner UI for reminder prompts
- implement notification animations and smooth reminder states
- build the service worker event flow for push reception and click handling
- handle the app’s “online/offline + permission enabled” behavior
- ensure the UI matches Prepcore style and dark mode design
- keep all reminder visual behavior consistent with the current app identity

Marcus should own the notification UX, including:

- banners
- cards
- permission states
- animated reminder entry states
- notification success/error states
- push-to-app click behavior

Marcus should also work closely with the service worker so the browser notifications feel native and polished.

### Webbi — API integration + backend wiring + testing support

Webbi owns the integration and operational side of the notification system.

Responsibilities:

- implement API routes for subscription save and unsubscribe
- implement user notification preference endpoints
- build the backend push sender integration with the push provider
- validate payload format for push requests
- handle subscription updates when users change devices
- create a test endpoint for sending a manual notification
- manage delivery logs and debug behavior
- help Michael with the scheduler logic and server validation
- help QA test and verify delivery in staging environment
- make sure push requests are correctly signed and sent
- handle edge cases such as expired subscriptions or failed deliveries

Webbi’s work should be focused on the integration layer between the app and the push service.

### Ownership boundaries

To avoid conflicting edits, each person should own these areas unless the team agrees otherwise:

| Area | Primary owner | Supporting owner |
| --- | --- | --- |
| Database migrations and reminder eligibility logic | Michael | Webbi |
| Push provider client and server-side delivery adapter | Michael | Webbi |
| Subscription and preference API routes | Webbi | Michael |
| Browser permission and subscription UI | Marcus | Webbi |
| Service worker push and click handlers | Marcus | Michael |
| Manual test endpoint and delivery diagnostics | Webbi | Michael |
| Final integration review | Michael | Marcus and Webbi |

Do not rewrite another person's area directly. Open a short discussion first, or add the change to your own branch and mention it in the pull request.

### Shared contracts before coding

Before implementation begins, Michael, Marcus, and Webbi must agree on these contracts in the pull request or team chat:

- API paths and HTTP methods for subscribe, unsubscribe, preferences, and manual test delivery.
- The exact browser subscription payload fields: `endpoint`, `p256dh`, `auth`, and `platform`.
- The notification payload fields: `title`, `body`, `url`, and a stable notification type.
- The allowed notification types, beginning with `streak_reminder`.
- Authentication and authorization rules for every API route.
- The push provider choice: Firebase Cloud Messaging or VAPID/web-push.
- The required environment variable names. Secrets must be stored in local environment files or Vercel, never in Git.

Once agreed, these contracts should not be changed silently. A contract change must be called out in the pull request description and communicated to every affected owner.

---

## Git Workflow and Integration Rules

The repository uses this promotion path:

```text
feature branch -> staging -> main
```

- `main` is production. Nobody should push directly to `main`.
- `staging` is the integration branch. Pull requests from the team must target `staging`.
- Each person works on a separate feature branch created from the latest `staging`.
- The owner of a feature branch opens the pull request; only the project owner or an assigned reviewer merges it.

### Branch names

Use these branch names unless the team agrees on a more specific name:

- Michael: `feature/notification-backend`
- Marcus: `feature/notification-ux`
- Webbi: `feature/notification-api-testing`

If a task needs to be split into smaller branches, use the same prefix, for example `feature/notification-schema` or `feature/notification-service-worker`.

### Before creating a branch

Each developer must start from the current integration branch:

```powershell
git switch staging
git pull origin staging
git switch -c feature/your-branch-name
```

Do not create a feature branch from an old local copy of `main`.

### Commit rules

Commits must be small, focused, and easy to review. Use messages that describe one completed change:

```text
feat: add notification preference schema
feat: add push subscription API
feat: add browser reminder settings
test: add reminder deduplication coverage
fix: remove expired push subscriptions
```

Do not mix unrelated formatting, refactoring, dependency upgrades, or personal environment files into a notification commit. Never commit `.env.local`, service-role keys, VAPID private keys, Firebase service-account files, or other secrets.

### Pull request requirements

Every pull request must target `staging`, not `main`, and must include:

- what was implemented
- the files or areas changed
- the API or data contract used
- environment variables required, listed by name only and without secret values
- how the change was tested
- known limitations or follow-up work
- screenshots or a short recording for frontend changes
- manual test instructions for notification behavior

Before opening the pull request, run:

```powershell
npm run typecheck
npm run lint
npm run build
```

The author must fix failing checks before requesting review. The author should also rebase or update their branch from `staging` if the branch has been open while other work was merged.

### Merge order

Merge the work in this order unless the team identifies a dependency that requires another order:

1. Michael creates the schema, shared server types, and core reminder rules.
2. Webbi adds the subscription, preference, and manual test API routes against those contracts.
3. Marcus connects the browser permission flow and settings UI to the agreed API routes.
4. Michael and Webbi connect the scheduler and push delivery, then test the complete path.
5. Marcus and Webbi complete browser, mobile, and installed-PWA verification.

If a pull request depends on another pull request, write the dependency clearly at the top of the description. Do not merge code that imports an API, type, table, or environment variable that does not yet exist in `staging`.

### Integration testing after merges

After each approved pull request is merged into `staging`, the project owner updates the local branch and tests the combined application:

```powershell
git switch staging
git pull origin staging
npm install
npm run typecheck
npm run lint
npm run build
npm run dev
```

Test the application at `http://localhost:3000` while signed in with a staging/test account. Verify both the existing website features and the notification flow. A merge should be reverted or fixed with a follow-up pull request if it breaks an existing feature.

### Promotion to production

Only after the complete `staging` branch passes integration testing should the project owner open:

```text
staging -> main
```

The final pull request must confirm that typecheck, lint, build, authentication, PWA installation, permission handling, subscription saving, notification delivery, click-through routing, and reminder deduplication were tested. Merge this pull request only after approval. The merge to `main` is what triggers the existing Vercel production deployment.

---

## Team Deliverables

### Michael deliverables

- notification schema design
- user reminder preferences table
- push subscription table
- notification log table
- reminder rules service
- inactivity check service
- scheduler/cron job
- push sender service
- deduplication logic
- backend API for reminder creation and subscription management
- production-ready documentation for environment variables and deployment

### Marcus deliverables

- reminder settings UI section
- notification permission request flow
- app-level “reminders enabled” state
- toast/banner UI
- service worker registration and push handlers
- deep-link behavior to `/dashboard` or `/practice`
- mobile-friendly styling and dark mode support
- notification animation states
- app-facing success and error messaging

### Webbi deliverables

- API routes for subscribe/unsubscribe/preferences
- payload validation layer
- push provider integration code
- test notification endpoint
- staging/QA test script
- failed delivery handling and logging
- subscription cleanup and re-registration support
- help with production deployment and environment setup

---

## Required Architecture

### Frontend PWA layer

This layer is for Marcus.

Required responsibilities:

- register notifications permission flow
- subscribe the browser to push notifications
- send subscription payload to backend
- manage reminder settings UI
- register the service worker for push event handling
- open the correct screen when a notification is clicked

### Service worker layer

This layer is shared by Marcus and Michael, but Marcus should lead the implementation.

Responsibilities:

- receive push events
- show notifications
- open app route on click
- handle no-op when app is not active

### Backend layer

This layer is primarily Michael with Webbi support.

Responsibilities:

- store subscriptions
- read user inactivity timestamp
- determine if a reminder is due
- trigger push delivery
- log the send
- prevent duplicates

---

## Data Model Requirements

### Notifications preferences table

Fields:

- id
- user_id
- study_reminders_enabled
- streak_reminders_enabled
- last_reminder_sent_at
- timezone
- updated_at

### Push subscription table

Fields:

- id
- user_id
- endpoint
- p256dh
- auth
- platform
- is_active
- created_at
- updated_at

### Notification logs

Fields:

- id
- user_id
- notification_type
- sent_at
- delivery_status
- message_title
- message_body
- source

---

## Reminder Trigger Logic

The reminder must trigger when:

- the user has active reminder settings
- their last study session is older than 24 hours
- no reminder was already sent in the current inactivity window
- their last activity timestamp is still stale

Recommended flow:

1. User completes study session.
2. Update `last_activity_at` for that user.
3. Scheduler checks eligibility every interval.
4. If `now - last_activity_at >= 24h`, send reminder.
5. Set `last_reminder_sent_at` immediately after a successful send.
6. Do not send again until the user has new activity.

---

## Notification Copy

All reminder text should be short, direct, and motivational.

Examples:

- Title: Keep your streak alive
- Body: It has been 24 hours since your last study session. Come back and keep the streak going.

- Title: Your streak is at risk
- Body: A quick practice session today will help you keep your momentum.

- Title: Study reminder
- Body: Your Prepcore streak is waiting. Come back for a short practice round.

---

## Acceptance Criteria per Role

### Michael acceptance criteria

- scheduler logic works and sends at most one reminder per eligible window
- reminder eligibility checks are correct
- user preference and subscription tables work properly
- backend push sender works in staging
- no duplicate reminders are sent
- The APIs are very secure and scalable.

### Marcus acceptance criteria

- permission flow works for supported browsers
- app settings UI works and is styled correctly
- service worker receives and displays push notifications
- notifications open the correct route
- notification states are animated and polished
- app works in installed PWA mode
- The security on the frontend must be tight avoiding any javascript attack

### Webbi acceptance criteria

- subscription API works and stores the correct device data
- unsubscribe flow works
- push provider integration is working
- notifications can be triggered manually in staging
- failed deliveries are logged and debugged
- endpoint validation and security checks work

---

## Recommended Dependencies

### Frontend

- service worker registration already exists in the app
- browser Notification API
- Push API
- existing Prepcore design system and Tailwind styling

### Backend

- Supabase
- Next.js API routes
- a push provider
- cron job or background scheduler

Recommended push solution:

- Firebase Cloud Messaging for easier browser push delivery
- or web-push with VAPID for a custom backend solution

---

## QA and Staging Tests

### QA Checklist

- user grants permission
- app registers subscription
- Supabase stores the subscription
- scheduler identifies eligible users
- notification is sent after 24 hours of inactivity
- notification is not sent twice in same window
- user completes study session and reminder timer resets
- notification still works when the app is closed
- disabled user does not receive notification
- expired or invalid subscription is ignored

---

## Final Team Positioning

### Michael

The engineering owner of the reminder engine. This is the hardest part of the system and should carry the most logic and responsibility.

### Marcus

The PWA and UX owner. This is the appearance and browser interaction layer.

### Webbi

The integration and delivery owner. This is the push transport and API connectivity layer.

---

## Summary

This feature is not a simple banner or small UI change. It is a real browser-push and reminder system.

The job is split like this:

- Michael: backend, streak logic, scheduler, push engine, data model
- Marcus: frontend, PWA permission flow, service worker, animation, settings UI
- Webbi: API flow, push integration, staging/testing, delivery logs and cleanup

The team must treat this as a real product feature, not a cosmetic addition.

The reminder should be built around the last study activity timestamp, and the system should send a single reminder once the user has been inactive for 24 hours.
