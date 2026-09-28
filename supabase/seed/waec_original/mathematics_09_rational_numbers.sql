INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Rational Numbers$q$,
    $q$What is −3/4 + 5/6 in simplest form?$q$,
    $q${"A":"−1/12","B":"1/24","C":"19/12","D":"1/12"}$q$::jsonb,
    $q$D$q$,
    $q$Use denominator 12: −3/4 = −9/12 and 5/6 = 10/12. Their sum is 1/12.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Rational Numbers$q$,
    $q$A temperature is −2.5°C and later becomes −1.8°C. By how many degrees did it rise?$q$,
    $q${"A":"0.7°C","B":"−0.7°C","C":"4.3°C","D":"0.7°F"}$q$::jsonb,
    $q$A$q$,
    $q$The rise is final minus initial: −1.8 − (−2.5) = 0.7°C.$q$
  );
