INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Algebraic Fractions$q$,
    $q$Simplify (6x²)/(9x) for x ≠ 0.$q$,
    $q${"A":"3x/2","B":"2x/9","C":"2x/3","D":"6x/3"}$q$::jsonb,
    $q$C$q$,
    $q$Cancel 3x from numerator and denominator: 6x²/(9x) = 2x/3.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Algebraic Fractions$q$,
    $q$For x ≠ 0, simplify 2/x + 3/x.$q$,
    $q${"A":"6/x","B":"5/(2x)","C":"1/x","D":"5/x"}$q$::jsonb,
    $q$D$q$,
    $q$The denominators are identical, so add numerators: 2/x + 3/x = (2 + 3)/x = 5/x.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Algebraic Fractions$q$,
    $q$Simplify 1/x + 1/(2x) for x ≠ 0.$q$,
    $q${"A":"3/(2x)","B":"2/(3x)","C":"1/(3x)","D":"2/x"}$q$::jsonb,
    $q$A$q$,
    $q$Use common denominator 2x: 1/x = 2/(2x). Adding 1/(2x) gives 3/(2x).$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Algebraic Fractions$q$,
    $q$At which value of x is (x + 2)/(x − 5) undefined?$q$,
    $q${"A":"−5","B":"5","C":"−2","D":"0"}$q$::jsonb,
    $q$B$q$,
    $q$A rational expression is undefined when its denominator is zero. Set x − 5 = 0, giving x = 5.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Algebraic Fractions$q$,
    $q$For x ≠ −3, simplify (x² − 9)/(x + 3).$q$,
    $q${"A":"x + 3","B":"x² − 3","C":"x − 3","D":"x − 9"}$q$::jsonb,
    $q$C$q$,
    $q$Factor the numerator: x² − 9 = (x − 3)(x + 3). Cancel x + 3, leaving x − 3, with x ≠ −3.$q$
  );
