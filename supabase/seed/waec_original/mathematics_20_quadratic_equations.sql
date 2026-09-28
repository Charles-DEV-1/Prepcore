INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Quadratic Equations$q$,
    $q$Which pair solves x² − 9x + 20 = 0?$q$,
    $q${"A":"4 and 5","B":"−4 and −5","C":"2 and 10","D":"1 and 20"}$q$::jsonb,
    $q$A$q$,
    $q$Factor x² − 9x + 20 = (x − 4)(x − 5). Setting each factor to zero gives x = 4 or 5.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Quadratic Equations$q$,
    $q$A quadratic equation has roots 2 and −3. Which equation has these roots?$q$,
    $q${"A":"x² − x − 6 = 0","B":"x² + x − 6 = 0","C":"x² − x + 6 = 0","D":"x² + 5x − 6 = 0"}$q$::jsonb,
    $q$B$q$,
    $q$Use (x − 2)(x + 3) = x² + x − 6, so x² + x − 6 = 0.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Quadratic Equations$q$,
    $q$Find the discriminant of 2x² − 4x + 1 = 0.$q$,
    $q${"A":"4","B":"12","C":"8","D":"24"}$q$::jsonb,
    $q$C$q$,
    $q$For ax² + bx + c = 0, discriminant = b² − 4ac = (−4)² − 4(2)(1) = 8.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Quadratic Equations$q$,
    $q$What is the minimum value of x² − 6x + 11?$q$,
    $q${"A":"−2","B":"0","C":"11","D":"2"}$q$::jsonb,
    $q$D$q$,
    $q$Complete the square: x² − 6x + 11 = (x − 3)² + 2. The square is at least 0, so the minimum is 2.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Quadratic Equations$q$,
    $q$A rectangle has width x metres and length x + 3 metres. If its area is 40 m², what is its positive width?$q$,
    $q${"A":"5 m","B":"4 m","C":"8 m","D":"10 m"}$q$::jsonb,
    $q$A$q$,
    $q$Area gives x(x + 3) = 40, or x² + 3x − 40 = 0. Factor (x + 8)(x − 5) = 0; positive width is 5 m.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Quadratic Equations$q$,
    $q$Solve x² − 4x = 12. What is the positive root?$q$,
    $q${"A":"2","B":"6","C":"4","D":"8"}$q$::jsonb,
    $q$B$q$,
    $q$Rearrange to x² − 4x − 12 = 0 = (x − 6)(x + 2). The roots are 6 and −2, so the positive root is 6.$q$
  );
