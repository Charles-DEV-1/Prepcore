INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Number bases$q$,
    $q$A stock code is written as 231 in base 4. What is its value in base 10?$q$,
    $q${"A":"45","B":"39","C":"41","D":"49"}$q$::jsonb,
    $q$A$q$,
    $q$The digits represent powers of 4: 2 × 4² + 3 × 4¹ + 1 × 4⁰ = 32 + 12 + 1 = 45.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Number bases$q$,
    $q$Which base-3 numeral represents 58 in base 10?$q$,
    $q${"A":"2002","B":"2011","C":"2101","D":"2021"}$q$::jsonb,
    $q$B$q$,
    $q$Use powers of 3: 58 = 2 × 27 + 0 × 9 + 1 × 3 + 1 × 1. Reading those coefficients gives 2011 in base 3.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Number bases$q$,
    $q$Convert 132 in base 5 to an equivalent numeral in base 3. Which answer is correct?$q$,
    $q${"A":"1112","B":"1020","C":"1120","D":"1200"}$q$::jsonb,
    $q$C$q$,
    $q$First convert to base 10: 1 × 5² + 3 × 5 + 2 = 25 + 15 + 2 = 42. Then 42 = 1 × 3³ + 1 × 3² + 2 × 3 + 0, so the base-3 numeral is 1120.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Number bases$q$,
    $q$Find the sum of 245 and 132 when both numerals are in base 6. Give the answer in base 6.$q$,
    $q${"A":"411","B":"431","C":"320","D":"421"}$q$::jsonb,
    $q$D$q$,
    $q$Add in base 6. Units: 5 + 2 = 7, so write 1 and carry 1. Sixes: 4 + 3 + 1 = 8, so write 2 and carry 1. Thirty-sixes: 2 + 1 + 1 = 4. The answer is 421 in base 6.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Number bases$q$,
    $q$Multiply 34 in base 7 by 5 in base 7. What is the product in base 7?$q$,
    $q${"A":"236","B":"225","C":"246","D":"226"}$q$::jsonb,
    $q$A$q$,
    $q$Multiply from the units place. 4 × 5 = 20 = 2 × 7 + 6, so write 6 and carry 2. Then 3 × 5 + 2 = 17 = 2 × 7 + 3, so write 3 and carry 2. This gives 236 in base 7.$q$
  );
