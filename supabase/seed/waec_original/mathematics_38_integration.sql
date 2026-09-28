INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Integration$q$,
    $q$Which expression is an antiderivative of 6x + 4?$q$,
    $q${"A":"6x² + 4x + C","B":"3x² + 4 + C","C":"6x + 4x² + C","D":"3x² + 4x + C"}$q$::jsonb,
    $q$D$q$,
    $q$Integrate each term: ∫6x dx = 3x² and ∫4 dx = 4x. Add a constant C.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Integration$q$,
    $q$Evaluate the definite integral of 2x from x = 0 to x = 3.$q$,
    $q${"A":"9","B":"3","C":"6","D":"18"}$q$::jsonb,
    $q$A$q$,
    $q$An antiderivative of 2x is x². Evaluate x² at 3 and 0: 3² − 0² = 9.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Integration$q$,
    $q$A moving object has velocity v(t) = 4t m/s. How far does it travel from t = 0 to t = 5 s?$q$,
    $q${"A":"10 m","B":"50 m","C":"25 m","D":"100 m"}$q$::jsonb,
    $q$B$q$,
    $q$Distance is ∫₀⁵ 4t dt = [2t²]₀⁵ = 2 × 25 − 0 = 50 m.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Integration$q$,
    $q$Evaluate ∫₀² 3x² dx.$q$,
    $q${"A":"4","B":"6","C":"8","D":"12"}$q$::jsonb,
    $q$C$q$,
    $q$An antiderivative of 3x² is x³. At the limits, 2³ − 0³ = 8.$q$
  );
