# Prepcore System Documentation

This document captures the system architecture, features, flows, business logic, and implementation details of the Prepcore website as it exists in this repository.

Date reviewed: 2026-09-14
Project: Prepcore
Stack: Next.js App Router + TypeScript + Tailwind CSS + Supabase + React Query + Zustand + shadcn/ui-style UI primitives

---

## 1. Product overview

Prepcore is a Nigerian exam-preparation SaaS platform focused on JAMB, WAEC, and NECO. The product is mobile-first and geared toward students who want to:

- practise past questions
- take timed mock exams
- receive explanations and feedback
- track progress and streaks
- unlock Pro features via payment or referral access
- compete in weekly quizzes and leaderboard rankings
- refer friends and earn rewards
- access partner-program opportunities

The product is built as a frontend-rich web application backed by Supabase for auth, relational data, RLS policies, and server/client integrations.

The repo’s README describes it as a “mobile-first SaaS-style EdTech frontend foundation for Nigerian exam preparation across JAMB, WAEC, and NECO.” The code confirms that this is both a consumer product and a partner/admin ecosystem with monetization and referral systems.

---

## 2. High-level architecture

### Core stack

- Next.js 16 App Router
- React 19
- TypeScript
- Tailwind CSS
- Zustand for local app state
- TanStack React Query for data fetching/provider layer
- Supabase SSR + browser clients for auth/session management
- Postgres/Supabase relational database
- Flutterwave for payments
- Nodemailer and custom OTP auth workflow
- Shadcn/ui-style component primitives with custom CSS tokens

### Top-level application structure

- src/app/: route-level pages, layouts, auth callback, public pages, API endpoints
- src/features/: feature modules corresponding to product workflows
- src/components/: shared UI and layout building blocks
- src/services/: business logic, external API integrations, Supabase wrappers
- src/lib/: security, utilities, validation, auth helpers, referral logic
- src/store/: Zustand state stores
- src/config/: site metadata, routes, payment config
- src/types/: application types and database typing contract
- supabase/: schema and migrations

### Runtime model

The app uses a hybrid flow:

- Server Components for route-level auth gating and data loading
- Client Components for interactive learning flows and dashboards
- Route handlers under /api for secure server-side operations
- Supabase Auth for user identity and session cookies
- Service-role Supabase client for privileged admin operations
- Browser Supabase client for user actions in client components

This structure is designed to protect business logic while keeping the UX interactive and fast.

---

## 3. Global app shell and site metadata

### Root layout

The root layout in src/app/layout.tsx sets:

- metadata for SEO/title/description/keywords
- Open Graph and Twitter metadata
- favicon set
- viewport settings
- JSON-LD structured data for organization and founder branding
- AppProviders wrapper

The app uses site metadata from src/config/site.ts and sets the product name, canonical domain, and SEO assets.

### Theme system

AppProviders wraps the app with a ThemeProvider using:

- attribute="class"
- defaultTheme="dark"
- storageKey="prepcore_theme"
- system theme disabled

This means the app is effectively dark-mode-first with light-mode customization support.

---

## 4. Routing and access model

### Public routes

Routes like /, /about, /pricing, /privacy-policy, /waitlist, /partners/register, /login, /signup are public.

### Protected routes

Middleware in middleware.ts protects the following routes:

- /dashboard
- /practice
- /exam
- /results
- /progress
- /leaderboard
- /weekly-quiz
- /upgrade
- /profile
- /settings
- /onboarding
- /admin

Behavior:

- if unauthenticated and trying to access a protected route, redirect to /login with next=pathname
- if authenticated and trying to visit /login or /signup, redirect to /dashboard
- auth callback route is excepted from route protection

### App layout guard

The authenticated app layout in src/app/(app)/layout.tsx:

- reads the Supabase user from server cookies
- redirects to /login if no active user
- renders AppShell and ReferralApplicator

This ensures all post-login screens live behind a server-side authentication gate.

---

## 5. Site navigation and UI design

### Public navbar

The public landing page uses PublicNavbar from src/components/layout/public-navbar.tsx and includes:

- Brand + logo
- Feature, Pricing, About, FAQ nav
- Partner with us CTA
- Login and Start free buttons
- Theme toggle

### App shell navigation

AppShell from src/components/layout/app-shell.tsx creates the authenticated app shell:

- fixed left sidebar on desktop
- mobile slide-over menu
- header with user info, plan badge, live streak badge
- locked feature gating for free users
- live streak updates and points/celebration overlays

### Route menu config

src/config/routes.ts defines:

- publicNav
- appNav
- adminNav

These are used for navigation and route identity across the product.

### Visual language

The application uses:

- custom Tailwind styling
- dark blue / navy palette with blue accent colors
- soft-card surface styling
- rounded panels and gradient headers
- branded UI components such as cards, badge, progress, motion wrappers

The design is clearly oriented around a polished EdTech SaaS aesthetic rather than a generic template.

---

## 6. Feature map

## 6.1 Landing page

The landing page is implemented in src/features/landing/landing-page.tsx.

It includes:

- hero section with exam-prep messaging
- feature cards for:
  - Past Questions
  - Timed Mock Exams
  - AI Explanations
  - Smart Analytics
  - Personalized Learning
  - Leaderboards
- free diagnostic CTA
- stats blocks
- pricing section with Free and Pro plans
- social proof/testimonial cards
- FAQ section using mock data from src/constants/mock-data.ts
- partner program CTA

The page is a conversion-focused marketing portal with a strong “start free / upgrade to Pro” narrative.

## 6.2 Authentication and onboarding

### Auth flows

The app uses Supabase OTP email auth plus Google OAuth in src/services/auth.ts.

Functions:

- sendEmailSignInLink(email, shouldCreateUser, diagnosticToken?)
- checkSignupAvailability(email)
- signInWithGoogle(diagnosticToken?)
- signOut()

The callback route src/app/auth/callback/route.ts exchanges OAuth/session code and refreshes auth.

### Onboarding

The onboarding form is in src/features/onboarding/onboarding-form.tsx.

The validation schema in src/lib/validations.ts includes:

- fullName
- examType: jamb or waec
- examGoals: array of exam types
- subjects: at least one subject
- targetScore
- examDate
- referralCode with simple alphanumeric/hyphen validation

This profile stores the learner’s exam status and subjects.

### App user model

src/types/app.ts defines user and session domain types, including:

- exam goals, user profile, plan, selected subjects, referral codes, rewards, onboarding fields

This is used in feature modules and API contracts.

## 6.3 Dashboard

The dashboard is implemented in src/features/dashboard/dashboard-page.tsx and loaded server-side from src/app/(app)/dashboard/page.tsx.

It displays:

- personalized greeting
- exam-type switching between JAMB and WAEC when allowed
- study streak
- average score
- questions answered
- days until exam
- rank badge and points progress
- recommended weak topics
- recent sessions
- quick actions for practice, exam, and progress review

The route loads data with getDashboardData(...) from src/services/api/dashboard.ts.

This function aggregates:

- sessions by user and exam type
- exam date and target score
- user points and rank
- current streak
- weak topics by answer analysis

## 6.4 Practice mode

The practice experience is in src/features/practice/practice-page.tsx.

It provides:

- exam type switcher (JAMB / WAEC)
- subject selection
- subject-year selection for WAEC
- question loading via API session endpoint
- question-by-question flow
- answer selection and submission
- correctness display
- AI explanation card after each question
- question reporting UI
- progress tracking and session persistence

### Important implementation details

Practice uses a standard learner flow:

- load question set from /api/questions/session
- maintain question state in React
- record selected answers in local state
- on final question, save session result and update:
  - streak
  - points
  - user session history

The backend route filters and randomizes question order while protecting display logic, and prevents the browser from receiving raw incompatible math/provider formatting.

## 6.5 Mock exam mode

The full mock exam flow is in src/features/exam/exam-page.tsx.

This is the most elaborate learning feature in the app.

### Exam setup

Users choose:

- exam type: JAMB or WAEC
- JAMB subjects (English locked and 3 more subjects)
- WAEC subject selection
- start exam prompt with warnings

### Pro gating

The page checks the user plan via useUserPlan(). If the user is not Pro, mock exams are locked and a Pro upgrade card appears.

### Timer and exam mechanics

- JAMB duration: 7200 seconds (2 hours)
- WAEC duration: 3600 seconds (1 hour)
- selected questions loaded in groups by subject
- question map sidebar
- flagging mechanism via Zustand store
- answer tracking with app-level store state

### Exam submission

On submit:

- calculate result percentage from selected answers
- insert a session row into sessions
- increment mock exam usage
- save answer rows to answers
- award points
- update streak
- redirect to results page with session id

This is a full exam simulation workflow.

## 6.6 Results page

Results are handled in src/features/results/results-page.tsx.

Features:

- load session details and answer history from Supabase
- aggregate subject performance
- compute score, correct/wrong answers, and summary
- show score ring and animated performance dashboard
- display wrong answer review with explanation panels
- AI explanation for each wrong answer
- reporting for incorrect questions
- download share card as PNG using html2canvas
- share to WhatsApp
- retake exam / practice weak subjects / back to dashboard actions

The page also renders a hidden “score card” for image export. This is a strong growth/viral share feature.

## 6.7 Progress analytics

Progress analytics are in src/features/progress/progress-page.tsx.

The page shows:

- score trend line chart via Recharts
- total sessions
- best score
- current streak
- average score
- study activity cells for consecutive day streak visualization

This is a personal analytics surface for performance monitoring.

## 6.8 Weekly quiz

Implemented in src/features/weekly-quiz/weekly-quiz-page.tsx.

This feature:

- loads the current active weekly quiz from weekly_quizzes
- checks whether the user has already completed it
- presents a quiz flow when open
- tracks answers and calculates score
- records a row in weekly_quiz_entries
- calculates leaderboard from all entries for that week
- shows user rank and rank labels
- displays badges like Beginner / Studious / Sharp / Genius / Legend

This is a gamified weekly challenge system tied to ranking and engagement.

## 6.9 Leaderboard

LeaderboardPage in src/features/leaderboard/leaderboard-page.tsx loads data from weekly_quizzes and weekly_quiz_entries.

It:

- gets the active week
- fetches participants
- builds percent-based ranking
- highlights current user
- shows rank positions and current-user separator

This is an active-user competition layer for weekly performance.

## 6.10 Referral system

The repo includes a significant referral system across user and partner flows.

### User referral experience

src/features/referrals/referral-page.tsx provides a referral dashboard for signed-in users.

It allows users to:

- generate/share a referral link
- copy code and share on WhatsApp or X
- see total signups
- see conversions and reward progress
- claim cash rewards with bank info form
- monitor reward batches and Pro grant status

### Referral link mechanism

- buildReferralLink(code) creates /signup?ref=CODE
- referral cookie capture logic is used to persist the referral source before onboarding

### Referral backend

The service layer includes src/services/api/referral.ts and src/services/user-referrals/claim.ts, plus lib/referral-server and referral-related utilities.

### Database logic

The refs in supabase/migrations/20260720_user_referral_system.sql show the user referral model:

- user_referral_codes
- user_referral_signups
- user_referral_rewards

Functional features include:

- ensure_user_referral_code() for generating a referral code
- record_user_referral_signup(p_code) for signup attribution
- grant_user_referral_rewards(p_referee_id) for conversion-based rewards
- trigger tied to subscription changes

### Partner referral model

The schema also includes:

- partners
- referral_codes
- user_referrals
- partner_referral_stats view

This supports lesson centres, schools, and training partners selling or promoting Prepcore.

## 6.11 Partner program and admin portal

The repo contains a full partner ecosystem, including:

- /partners/register
- /api/partners/auth/login
- /api/partners/auth/register
- /api/partners/dashboard
- /api/partners/withdrawals
- /api/partners/transfers/webhook

### Partner login flow

The partner account system uses a hashed password model and partner session cookie-based auth.

### Admin pages

Routes under src/app/(app)/admin include:

- analytics
- feedback
- layout
- page.tsx
- partner-program
- partners
- question-upload
- referral-rewards
- referrals
- reports
- revenue
- users

These pages use createServiceRoleClient from src/services/supabase/admin.ts to retrieve database data and run privileged queries.

### Admin responsibilities

The admin system appears to manage:

- user analytics
- partner accounts and referral programs
- revenue and payments
- feedback moderation
- question/report review
- referral reward processing

---

## 7. Payments and monetization

### Payment config

src/config/payments.ts defines the single plan:

- Prepcore Pro annual
- amount: ₦3,000
- duration: 365 days
- currency: NGN

### Payment flow

Payment implementation is in src/services/payments/payment-service.ts and src/services/payments/flutterwave.ts.

Flow:

1. Create pending payment record in Supabase payments table
2. Generate a unique tx_ref
3. Create Flutterwave checkout link
4. Store provider response
5. Redirect user to approval/success page
6. Verify transaction through Flutterwave API
7. Update payment status as verified/failed/cancelled
8. Activate user plan in DB/subscription logic

### Webhook and signature validation

The Flutterwave helper validates webhook signature using both the standard header and legacy header handling.

This is critical because Flutterwave webhooks can arrive with different header names depending on account or migration history.

### Upgrade route

The application includes an upgrade flow and success page that receives tx_ref and verifies subscription activation after payment.

---

## 8. Question architecture and data model

### Question bank

The question system is built around tables like:

- subjects
- questions
- sessions
- answers

The schema in supabase/schema.sql and migrations defines these tables.

### Subject structure

Each question belongs to a subject and exam type, and stores:

- prompt
- options as JSONB
- correct_answer
- explanation
- topic
- year
- subject_id
- exam_type

### Question retrieval logic

src/services/api/questions.ts provides important encapsulation:

- getRandomQuestionsBySubject()
- getSessionQuestions()
- getYearSessionQuestions()
- getSubjectsByExamType()
- getAvailableYears()
- getQuestionsBySubjectYear()

These functions call the protected API endpoint /api/questions/session and fallback to direct Supabase queries when needed.

### Security and filtering in question sessions

The API route /api/questions/session/route.ts does a lot of important work:

- verifies request origin with hasTrustedOrigin
- authenticates the user from Supabase session
- enforces rate limiting via /lib/rate-limit.ts
- validates request shape
- checks if the user is Pro via subscription or partner bulk Pro access
- filters out bad rows that are not renderable (empty prompt, XML/MathML-like content)
- randomizes option order without altering stored answer key semantics
- enforces local Supabase-only question access for non-Pro users

This is important because it protects the product’s business rules while preserving the UX of a clean test question flow.

---

## 9. Session and points system

### Sessions

Sessions represent completed practice or mock exam attempts and are stored in public.sessions.

Fields include:

- user_id
- mode
- score
- total_questions
- exam_type
- completed_at
- created_at

The app records session results for both practice and mock questions.

### Answers

Each answer row stores:

- session_id
- question_id
- selected_answer
- is_correct

This supports diagnostic review and performance analysis.

### Points system

src/services/api/points.ts defines points and ranking tiers:

- Beginner
- Studious
- Sharp
- Genius
- Legend

Award logic gives points based on activity type:

- practice: +10
- mock: +25
- quiz: +20
- streak: +5
- bonus on high score percentages

The system uses a Supabase RPC function add_user_points.

### Streak system

src/services/api/streak.ts maintains a live streak state:

- persistent row in streaks table
- checks if the streak is still active within 24-hour window
- resets to zero if expired
- increments daily streak when new exam/practice activity occurs
- emits custom browser events for UI celebration

This supports a durable habit loop and gamification experience.

---

## 10. Security, validation, and API protection

### Supabase clients

There are three important clients:

- src/services/supabase/client.ts for browser auth interactions
- src/services/supabase/server.ts for server-side auth interactions
- src/services/supabase/admin.ts for service role access

The code explicitly separates user-level and admin-level access.

### Middleware and route protection

middleware.ts enforces protected route rules and login redirect behavior.

### API security helper

src/lib/api-security.ts includes request trust and JSON sanitization logic used by admin and API endpoints.

### Rate limiting

src/lib/rate-limit.ts implements per-user request throttling for sensitive actions such as question session requests.

### Validation

The app uses Zod validation for:

- email OTP auth
- onboarding data
- referral claim forms

This reduces malformed-form and server-side bypass risks.

### Response patterns

The app uses guard logic and sanitized JSON responses in route handlers so the browser receives predictable, safe result payloads.

---

## 11. Database and schema design summary

The Supabase schema is the core business foundation.

Key tables:

- users
- subjects
- questions
- sessions
- answers
- subscriptions
- partners
- referral_codes
- user_referrals
- streaks
- weekly_quizzes
- weekly_quiz_entries
- user_referral_codes
- user_referral_signups
- user_referral_rewards
- payments (from later migrations)

Key concepts:

- exam_type enum includes JAMB, WAEC, NECO
- session_mode enum includes practice and mock
- subscription_plan includes free/pro
- RLS policies gate user access to their own data
- certain tables, such as partner/referral tables, are intentionally exposed for partner and referral logic

### Migrations note

The repository includes multiple Supabase migration files, showing an iterative product evolution.

Examples:

- referral system migrations
- partner bulk pro setup
- payment schema migrations
- security hardening migration
- feedback schema migration
- index creation and scale hardening

This indicates the app was built as a live product rather than a static prototype.

---

## 12. App-wide business flows

### Student onboarding flow

A new user typically follows this flow:

1. Visit landing page
2. Sign up with email or Google
3. Finish onboarding profile
4. Receive exam goals and subject selection
5. Land on dashboard
6. Start practice or mock exam
7. Earn streaks/points
8. Review results and weak topics
9. Upgrade to Pro when needed
10. Possibly refer friends and claim rewards

### Learning loop

The learning loop is built around the following cycle:

- choose subject
- answer questions
- get explanation after each answer
- view score
- monitor weak topics
- revisit difficult subjects
- build streaks and daily consistency

### Pro monetization loop

The business model is:

- free access to basic practice and progress tracking
- Pro required for full mock exams and advanced question access
- annual payment through Flutterwave
- partner bulk access through referral/partner programs
- referral rewards as conversion incentives

### Community and retention layer

The app uses:

- weekly quiz leaderboard
- streaks
- points/ranks
- social sharing of results
- referral rewards

This creates engagement beyond a simple question bank.

---

## 13. Admin and partner management capabilities

The presence of partner/admin routes strongly suggests a broader educational platform in growth mode, not only a consumer app.

### Admin likely responsibilities

- user and analytics reports
- feedback triage
- question upload management
- partner management, approval, and payouts
- revenue reporting
- referral reward administration

### Partner responsibilities

- register as a lesson center or education partner
- distribute referral codes
- access bulk Pro activation logic for referred students
- manage withdrawals and transfer records

This means the repo includes both a student product and a B2B partner network.

---

## 14. Implementation notes and architectural observations

### Strengths in the codebase

- clear separation of route, feature, service, and utility layers
- strong use of typed Supabase contracts
- route-level security and auth gating
- product-specific metrics and gamification features
- real learning workflows rather than placeholder UI only
- substantial admin and partner infrastructure for a SaaS product

### Design patterns used

- Server component route loading for authenticated pages
- Client components for local state-heavy interactions
- Zustand store for exam state
- custom UI primitive components and Tailwind patterns
- centralized config objects for site metadata and routes
- service layer functions to abstract data access and business logic

### Notable product-specific logic

- math/XML question filtering before display
- option randomization in the session response only
- Pro entitlement logic tied to subscriptions and partner referrals
- pro access features in question retrieval and mock exam gating
- celebration events for points and streaks

---

## 15. Important files to understand the system

These files are the most important to understand the architecture quickly:

- src/app/layout.tsx
- src/app/page.tsx
- src/app/(app)/layout.tsx
- middleware.ts
- src/config/routes.ts
- src/config/site.ts
- src/features/landing/landing-page.tsx
- src/features/dashboard/dashboard-page.tsx
- src/features/practice/practice-page.tsx
- src/features/exam/exam-page.tsx
- src/features/results/results-page.tsx
- src/services/api/questions.ts
- src/app/api/questions/session/route.ts
- src/services/api/points.ts
- src/services/api/streak.ts
- src/services/payments/payment-service.ts
- src/services/payments/flutterwave.ts
- src/features/referrals/referral-page.tsx
- supabase/schema.sql
- supabase/migrations/20260720_user_referral_system.sql

---

## 16. Final system summary

Prepcore is a full Nigerian exam-prep platform combining the following layers:

- marketing site with conversion-focused landing page
- authenticated learning dashboard and progress UX
- exam practice system for JAMB and WAEC subjects
- mock exam simulation with Pro gating
- result analytics, subject breakdowns, and review flows
- gamification via points, streaks, weekly quiz, and leaderboard
- monetization via Flutterwave Pro subscriptions
- referral and partner growth engines
- admin and operational backend for payouts, revenue, reports, and partner oversight
- a relational Supabase foundation that supports both product and operations workflows

In short, this project is not just a front-end demo. It is a substantial, multi-module educational SaaS application with a consumer student experience and a partner/admin operating layer built on top of a shared data model.

---

## 17. Repository status note

This documentation reflects the code and schema structure available in the repository at the time of inspection. The product appears to be in active development and includes more advanced architecture than a simple mockup or starter app.
