# Study recommendations

The dashboard recommendations are deterministic and based on recorded answers, not AI-generated claims.

1. Practice saves each submitted answer through `record_practice_answer` in one database transaction. A client-generated session UUID makes retries safe if the response is lost. Leaving a set early keeps the answers already submitted. Mock-exam submission is unchanged.
2. The dashboard reads up to 1,000 answers from the latest 100 sessions created within 60 days for the selected exam. The rule engine counts only the latest attempt per question, groups by exact subject ID and topic, and returns at most three suggestions.
3. A topic with at least three distinct answers and under 70% accuracy is **Focus now**. One or two answers with a miss are **Check this topic**, not a confirmed weakness. A topic with at least three answers last practised 14 or more days ago is **Refresh**. Each card states its evidence.
4. **Practise this topic** opens `/practice` with exam, subject ID and topic. The authenticated question endpoint validates the subject/exam pair and filters that exact topic *before* limiting the question pool. Free/Pro source restrictions still apply. Focused sets put unseen questions ahead of recently answered ones when history is available.

The topic filter uses the stored topic string. This avoids implying that differently named topics are equivalent; a curated topic taxonomy could be added later. Practice correctness remains self-reported from randomized browser option order, as it was before this change. It is suitable for study guidance, not a tamper-proof exam grade.

Apply `supabase/migrations/20260929100000_record_practice_answers_incrementally.sql` before deploying the updated practice page. Until that migration is present, answer submission will show a save error rather than silently discarding progress.
