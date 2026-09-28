INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Indices and Standard Form$q$,
    $q$Simplify 2⁵ × 2⁻².$q$,
    $q${"A":"8","B":"4","C":"16","D":"32"}$q$::jsonb,
    $q$A$q$,
    $q$When multiplying powers with the same base, add exponents: 5 + (−2) = 3, so 2³ = 8.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Indices and Standard Form$q$,
    $q$Evaluate 27^(2/3).$q$,
    $q${"A":"3","B":"9","C":"6","D":"18"}$q$::jsonb,
    $q$B$q$,
    $q$The denominator 3 means take the cube root of 27, giving 3. Then square: 3² = 9.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Indices and Standard Form$q$,
    $q$Write 0.00048 in standard form.$q$,
    $q${"A":"4.8 × 10⁻³","B":"4.8 × 10⁻⁵","C":"4.8 × 10⁻⁴","D":"4.8 × 10⁻²"}$q$::jsonb,
    $q$C$q$,
    $q$Move the decimal point four places right to obtain 4.8. Compensate with 10⁻⁴, giving 4.8 × 10⁻⁴.$q$
  );
