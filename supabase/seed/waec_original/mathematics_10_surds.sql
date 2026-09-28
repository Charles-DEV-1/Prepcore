INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Surds (Radicals)$q$,
    $q$Simplify 3√12 − √27.$q$,
    $q${"A":"3√15","B":"3√3","C":"9√3","D":"√3"}$q$::jsonb,
    $q$B$q$,
    $q$√12 = 2√3 and √27 = 3√3. Therefore 3√12 − √27 = 6√3 − 3√3 = 3√3.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Surds (Radicals)$q$,
    $q$Rationalise 5/√5.$q$,
    $q${"A":"5√5","B":"1/√5","C":"√5","D":"√25"}$q$::jsonb,
    $q$C$q$,
    $q$Multiply numerator and denominator by √5: 5/√5 = 5√5/5 = √5.$q$
  );
