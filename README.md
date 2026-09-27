# Prepcore

Prepcore is a mobile-first SaaS-style EdTech frontend foundation for Nigerian exam preparation across JAMB, WAEC, and NECO.

## Stack

- Next.js 15 App Router
- TypeScript
- Tailwind CSS and shadcn/ui-style primitives
- Framer Motion-ready structure
- Zustand
- TanStack Query
- Supabase Auth and database
- React Hook Form and Zod
- Lucide React

## Architecture

```txt
src/
  app/              route groups, layouts, loading/error boundaries
  components/       reusable UI and layout primitives
  config/           site and navigation config
  constants/        starter product data and mocks
  features/         feature-owned product screens and workflows
  hooks/            shared React hooks
  lib/              utilities and validation schemas
  providers/        app providers for theme and data fetching
  services/         Supabase clients, auth, and API modules
  store/            modular Zustand state
  types/            product and database types
supabase/
  schema.sql        initial relational schema, enums, and RLS policies
```

## Local Setup

1. Copy `.env.example` to `.env.local`.
2. Add `NEXT_PUBLIC_SUPABASE_URL` and `NEXT_PUBLIC_SUPABASE_ANON_KEY`.
3. Run `npm install`.
4. Run `npm run dev`.

The public landing page can render without Supabase credentials. Authenticated actions require Supabase environment variables.

## Production push notification schedule

The protected `/api/cron/notifications` endpoint sends streak warnings, study reminders, weekly summaries, admin announcements, and automatic study tips. Production currently has an hourly caller; keep it configured with the production `CRON_SECRET`. The daily Vercel cron in `vercel.json` remains a fallback. If the hourly caller stops, restore it before expecting warnings in the final two hours of a streak. An hourly schedule is best effort rather than exact to the minute.

Students must enable notifications on their device and opt in to Study tips or Streak protection in Settings. Tips are considered every hour, delivered during local daytime after at least 12 hours, and remain subject to the database limit of two notification claims per rolling 24 hours. An active streak reserves one of those slots for its expiry warning.

Deployment verification marker: production redeploy trigger.
