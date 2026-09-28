INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Modular Arithmetic$q$,
    $q$A seven-day maintenance cycle started 94 days ago. How many days into the current cycle are we?$q$,
    $q${"A":"2","B":"3","C":"4","D":"5"}$q$::jsonb,
    $q$B$q$,
    $q$Divide 94 by 7: 94 = 13 × 7 + 3. Thirteen complete cycles have passed, leaving 3 days into the current cycle.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Modular Arithmetic$q$,
    $q$Find the remainder when 17 × 8 is divided by 6.$q$,
    $q${"A":"2","B":"3","C":"4","D":"5"}$q$::jsonb,
    $q$C$q$,
    $q$17 × 8 = 136. Since 136 = 22 × 6 + 4, the remainder is 4.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Modular Arithmetic$q$,
    $q$A market holds every 5 days. If today is market day, what is the remainder of 18 when divided by 5, representing the position of the market cycle 18 days from now?$q$,
    $q${"A":"1","B":"2","C":"4","D":"3"}$q$::jsonb,
    $q$D$q$,
    $q$18 = 3 × 5 + 3, so 18 days is three full cycles and 3 extra days.$q$
  );
