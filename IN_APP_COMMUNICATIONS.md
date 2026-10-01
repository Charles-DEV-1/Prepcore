# In-app communication and practice results

There are two independent Pro messages. Neither uses web push or notification opt-in.

## Dashboard launch message

`in_app_messages` stores published, scheduled campaigns. The seeded `pro_launch_2026`
campaign targets free users on the dashboard. `get_my_in_app_message('dashboard')`
checks the signed-in user and effective Pro entitlement in the database, then returns
the highest-priority eligible campaign that has not been dismissed. The dashboard
shows a non-blocking card. `dismiss_my_in_app_message` writes a receipt keyed by
user and message, so dismissing it on one device dismisses it everywhere. The
dashboard feedback modal is suppressed for that visit when the launch card appears.

## After practice

The practice completion screen uses the questions and shuffled answer choices that
the learner actually saw. It shows correct count, accuracy, and missed answers
with five reviews per page. Standard explanations and review stay free. A separate
`pro_after_practice_2026` campaign appears only if there are missed answers and
the user is currently free. It can be dismissed independently of the dashboard
campaign. The purchase button is never required to see results or review.

Practice answers are already saved one at a time by `record_practice_answer`.
The new completion review is currently a same-page view of that session; it does
not add a permanent, reloadable practice-result URL. A historical review page
would require saving the presented option order/selected option text so randomized
answer letters remain accurate after a reload.

## Operations and release

Apply `20261001090000_in_app_messages.sql` before deploying the UI. It is a new,
forward-only migration; do not re-run older migrations. To pause a campaign, set
its status to `draft` with an authorized database administrator. Campaign copy and
CTA paths are stored in the database, while the price shown in both cards comes
from the application payment-plan configuration. No admin campaign editor is
included in this release.

The Pro promise here is intentionally limited to verified differentiators: full
timed mock exams and flashcards. Free practice continues to show ordinary answer
explanations and topic recommendations. The current AI explanation allowance is
partly client-side, so do not advertise a guaranteed Pro-exclusive AI quota until
that limit is enforced on the server.
