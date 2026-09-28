INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Algebraic Expressions$q$,
    $q$A ticket costs ₦p and a programme costs ₦q. What expression gives the cost of 3 tickets and 2 programmes?$q$,
    $q${"A":"3p + 2q","B":"5pq","C":"3p + q","D":"p + 2q"}$q$::jsonb,
    $q$A$q$,
    $q$Multiply each unit price by its quantity: 3 tickets cost 3p and 2 programmes cost 2q, so total cost is 3p + 2q.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Algebraic Expressions$q$,
    $q$Evaluate 4x − 3y when x = 7 and y = −2.$q$,
    $q${"A":"22","B":"34","C":"26","D":"−34"}$q$::jsonb,
    $q$B$q$,
    $q$Substitute carefully: 4(7) − 3(−2) = 28 + 6 = 34.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Algebraic Expressions$q$,
    $q$Simplify 5a − 2b + 3a + 7b.$q$,
    $q${"A":"8a − 5b","B":"2a + 5b","C":"8a + 5b","D":"8ab"}$q$::jsonb,
    $q$C$q$,
    $q$Collect like terms: (5a + 3a) + (−2b + 7b) = 8a + 5b.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Algebraic Expressions$q$,
    $q$A rectangle has length x + 4 cm and width x − 1 cm. What expression gives its perimeter?$q$,
    $q${"A":"2x + 3","B":"4x + 3","C":"2x + 6","D":"4x + 6"}$q$::jsonb,
    $q$D$q$,
    $q$Perimeter = 2(length + width) = 2[(x + 4) + (x − 1)] = 2(2x + 3) = 4x + 6.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Algebraic Expressions$q$,
    $q$If C = 2m + 5n, by how much does C increase when m increases by 3 and n is unchanged?$q$,
    $q${"A":"6","B":"3","C":"5","D":"15"}$q$::jsonb,
    $q$A$q$,
    $q$Only 2m changes. Increasing m by 3 increases C by 2 × 3 = 6.$q$
  );
