# Onboarding and study buddy

The `/onboarding` route is a Booky-led conversation: name, exam, optional exam
date, optional course for JAMB, subjects, optional confidence check, optional
daily study time, then a plan reveal. Each screen asks one main question,
Booky reacts before advancing, and the progress bar replaces the old tabs.
The primary final action opens a five-question starter set in Practice; a
secondary action goes to the dashboard. Neither action initiates payment.

Subject choices come from `public.subjects`. A failed or empty catalogue read
blocks the subject step instead of silently using invented options. JAMB starts
with the real English Language catalogue entry and requires three others;
WAEC allows one to nine. For combined goals, the initial four are JAMB
subjects; the WAEC catalogue remains available in Practice. The saved names
are preferences, not a restriction on Practice. Recommendations continue to
come from actual answers, not self-ratings.

Every completed screen saves a versioned draft in the signed-in user's Auth
metadata, with an account-scoped localStorage fallback and retry on reconnect.
The final profile upsert still owns completion and validates the selected
catalogue names. Course, confidence and daily minutes are self-editable study
preferences in Auth metadata; they do not grant entitlements or override real
performance evidence. The server redirects already-onboarded users away from
setup. Referral capture remains available on the plan screen.

The starter round uses `/practice?intro=1` with a real selected subject ID and
the protected question-session endpoint, limited to five questions. Answers
use the existing incremental practice-answer RPC; the result offers a direct
dashboard link. It stays hidden from the ambient dashboard Buddy policy so
questions are not covered by the character. If a subject has no available
questions, Practice shows its normal honest empty/error state.

NECO is not offered yet: the current practice session API, app exam types and
question flow only support JAMB and WAEC. Course-specific subject suggestions
are likewise not made without a maintained admissions-requirement source.
The optional course is recorded as a learner goal, not used to invent subject
combinations. Funnel analytics and contextual daily nudges are future work.

The buddy's original and walking poses are in `public/images/study-buddy/`.
`BuddyController` mounts once in the authenticated app shell. Its route policy
allows dashboard, progress, results, flashcards, and profile only when a page
provides a reserved `data-buddy-zone`; routes without a safe zone get no Buddy.
Practice, exams, forms, and admin pages are excluded.

The dashboard uses two different safe locations: the clear upper-right of the
welcome banner on wide screens, and a compact right column beside the Buddy
message. There is no longer a full-width empty walking strip. Buddy is about
160 px tall on desktop, and scales down only when a narrower safe zone demands
it. Mobile uses the message location; no large companion is forced over the
welcome text or a practice button.

`BuddySprite` aligns all source poses by their visible feet and centre, not by
their differing transparent canvas sizes. The local walk plays four supplied
poses in a 0.8-second cycle: right step, right passing position, left step,
left passing position. The body bobs a few pixels while the Buddy takes a
short, eased two-or-more-cycle walk within its safe area. About four seconds
after arrival it takes the first walk; later walks have long rests. Between
walks it breathes subtly, blinks, or looks around. A click produces a small
wave. Result pages use an appropriate still reaction pose.

After roughly 42 seconds on a dashboard with both locations visible, Buddy
can shrink/fade with three small sparkles, reappear in the other location, and
settle. Later location changes are less frequent. It never slides across the
intervening content. A generated frame set still has minor artistic differences;
separately layered source artwork would permit more exact foot-contact animation
in the future, but the supplied walk poses now give visible alternating feet.

The Buddy remains inside reserved, clipped space and hides for open modal
dialogs or the mobile navigation menu. Offscreen/hidden tabs pause ambient
movement. Reduced-motion users see a static companion, and the visibility
setting in Settings can hide it entirely. That browser preference is keyed to
the authenticated account ID, so deleting one account and signing up with a
new one does not inherit the old hidden setting. When Booky is hidden, the
dashboard shows a clear **Show Booky** action; Settings also offers Show/Hide.
The character is optional: a click only produces a small wave, never an
essential control.

Onboarding has a separate compact Booky conversation component in
`src/components/buddy/onboarding-buddy.tsx`. It uses the supplied wave,
thinking, smile and celebrate pose art, a speech bubble, a short typing pause,
and subtle idle motion. Dashboard walking continues to use the supplied
alternating-step frames. Reduced-motion mode shows a static pose. The one-time
onboarding greeting does not use the dashboard's ambient hide/show toggle.

Before release, test a new free user, an existing Pro user, a WAEC-only user,
an invalid referral code, a failed subject read, a failed profile save, and
reduced-motion/dark-mode views in a real browser. Static checks alone do not
verify the live Supabase catalogue or payment configuration.
