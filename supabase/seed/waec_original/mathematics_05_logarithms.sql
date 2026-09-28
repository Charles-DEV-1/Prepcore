INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Logarithms$q$,
    $q$If log₁₀ p = 3, what is p?$q$,
    $q${"A":"30","B":"100","C":"3000","D":"1000"}$q$::jsonb,
    $q$D$q$,
    $q$A base-10 logarithm of 3 means p = 10³ = 1000.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Logarithms$q$,
    $q$Evaluate log₁₀ 25 + log₁₀ 4.$q$,
    $q${"A":"2","B":"1","C":"4","D":"0"}$q$::jsonb,
    $q$A$q$,
    $q$Use log a + log b = log(ab): log₁₀(25 × 4) = log₁₀ 100 = 2.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Logarithms$q$,
    $q$If log₁₀ x = 2 and log₁₀ y = 1, find log₁₀(x/y).$q$,
    $q${"A":"2","B":"1","C":"3","D":"10"}$q$::jsonb,
    $q$B$q$,
    $q$Apply the quotient rule: log₁₀(x/y) = log₁₀ x − log₁₀ y = 2 − 1 = 1.$q$
  );
