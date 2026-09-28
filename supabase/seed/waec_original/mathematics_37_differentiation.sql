INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Differentiation$q$,
    $q$For y = x³ + 2x², what is dy/dx at x = 2?$q$,
    $q${"A":"12","B":"16","C":"20","D":"28"}$q$::jsonb,
    $q$C$q$,
    $q$Differentiate term by term: dy/dx = 3x² + 4x. At x = 2 this is 3(4) + 4(2) = 20.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Differentiation$q$,
    $q$Find the gradient of y = x² − 4x + 7 at x = 3.$q$,
    $q${"A":"−2","B":"3","C":"6","D":"2"}$q$::jsonb,
    $q$D$q$,
    $q$Gradient is dy/dx = 2x − 4. At x = 3, the gradient is 6 − 4 = 2.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Differentiation$q$,
    $q$A particle has displacement s = 2t³ + 4 metres after t seconds. What is its instantaneous velocity at t = 2 s?$q$,
    $q${"A":"24 m/s","B":"12 m/s","C":"20 m/s","D":"28 m/s"}$q$::jsonb,
    $q$A$q$,
    $q$Velocity is ds/dt = 6t². At t = 2, v = 6 × 2² = 24 m/s.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Differentiation$q$,
    $q$The cost function is C(x) = x² + 10x + 50. What is the marginal cost dC/dx at x = 5?$q$,
    $q${"A":"10","B":"20","C":"15","D":"25"}$q$::jsonb,
    $q$B$q$,
    $q$Differentiate C: dC/dx = 2x + 10. At x = 5 this equals 20.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Differentiation$q$,
    $q$Using π = 22/7, a circle has area A = πr². At radius r = 7 cm, what is dA/dr?$q$,
    $q${"A":"22 cm","B":"88 cm","C":"44 cm","D":"154 cm"}$q$::jsonb,
    $q$C$q$,
    $q$Differentiate with respect to r: dA/dr = 2πr. At r = 7 and π = 22/7, this is 2 × 22/7 × 7 = 44 cm.$q$
  );
