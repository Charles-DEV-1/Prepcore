INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Trigonometric Ratios and Graphs$q$,
    $q$In a right triangle, the side opposite angle θ is 6 cm and the hypotenuse is 10 cm. What is sin θ in simplest form?$q$,
    $q${"A":"3/5","B":"3/4","C":"4/5","D":"5/3"}$q$::jsonb,
    $q$A$q$,
    $q$Sine is opposite ÷ hypotenuse = 6/10 = 3/5.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Trigonometric Ratios and Graphs$q$,
    $q$In a right triangle, the side adjacent to angle θ is 8 cm and the hypotenuse is 10 cm. What is cos θ?$q$,
    $q${"A":"3/5","B":"4/5","C":"5/4","D":"8/5"}$q$::jsonb,
    $q$B$q$,
    $q$Cosine is adjacent ÷ hypotenuse = 8/10 = 4/5.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Trigonometric Ratios and Graphs$q$,
    $q$A right triangle has opposite side 9 cm and adjacent side 12 cm relative to θ. What is tan θ?$q$,
    $q${"A":"3/5","B":"4/3","C":"3/4","D":"9/10"}$q$::jsonb,
    $q$C$q$,
    $q$Tangent is opposite ÷ adjacent = 9/12 = 3/4.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Trigonometric Ratios and Graphs$q$,
    $q$What is the exact value of sin 150°?$q$,
    $q${"A":"−1/2","B":"√3/2","C":"1","D":"1/2"}$q$::jsonb,
    $q$D$q$,
    $q$150° is in quadrant II, where sine is positive. Its reference angle is 30°, so sin150° = sin30° = 1/2.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Trigonometric Ratios and Graphs$q$,
    $q$What is the exact value of cos 210°?$q$,
    $q${"A":"−√3/2","B":"√3/2","C":"−1/2","D":"1/2"}$q$::jsonb,
    $q$A$q$,
    $q$210° lies in quadrant III, where cosine is negative. Its reference angle is 30°, giving cos210° = −√3/2.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Trigonometric Ratios and Graphs$q$,
    $q$For y = 3 sin x, what is the maximum value of y?$q$,
    $q${"A":"0","B":"3","C":"1","D":"−3"}$q$::jsonb,
    $q$B$q$,
    $q$Because sin x ≤ 1, multiplying by 3 gives y ≤ 3. The maximum is 3.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Trigonometric Ratios and Graphs$q$,
    $q$What is the period of y = sin(2x) when x is measured in degrees?$q$,
    $q${"A":"90°","B":"360°","C":"180°","D":"720°"}$q$::jsonb,
    $q$C$q$,
    $q$Sine repeats after its input increases 360°. For 2x, x needs only 360°/2 = 180°.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Trigonometric Ratios and Graphs$q$,
    $q$Evaluate sin 0° + cos 0°.$q$,
    $q${"A":"0","B":"2","C":"−1","D":"1"}$q$::jsonb,
    $q$D$q$,
    $q$sin0° = 0 and cos0° = 1, so their sum is 1.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Trigonometric Ratios and Graphs$q$,
    $q$Which pair gives all solutions to sin x = 1/2 for 0° ≤ x ≤ 360°?$q$,
    $q${"A":"30° and 150°","B":"30° and 330°","C":"60° and 120°","D":"150° and 330°"}$q$::jsonb,
    $q$A$q$,
    $q$Sine is positive in quadrants I and II. Reference angle is 30°, so x = 30° or 180° − 30° = 150°.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Trigonometric Ratios and Graphs$q$,
    $q$Find tan 45° + sin 30°.$q$,
    $q${"A":"0.5","B":"1.5","C":"1","D":"2"}$q$::jsonb,
    $q$B$q$,
    $q$tan45° = 1 and sin30° = 1/2. Their sum is 1 + 1/2 = 1.5.$q$
  );
