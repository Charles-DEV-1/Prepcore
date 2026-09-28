INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Algebraic Operations and Factorisation$q$,
    $q$Expand (x + 3)(x − 5).$q$,
    $q${"A":"x² + 2x − 15","B":"x² − 2x − 15","C":"x² − 8x − 15","D":"x² − 2x + 15"}$q$::jsonb,
    $q$B$q$,
    $q$Multiply each term: x² − 5x + 3x − 15 = x² − 2x − 15.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Algebraic Operations and Factorisation$q$,
    $q$Factorise 12x²y − 18xy² completely.$q$,
    $q${"A":"6xy(2x + 3y)","B":"3xy(4x − 3y)","C":"6xy(2x − 3y)","D":"6xy(3x − 2y)"}$q$::jsonb,
    $q$C$q$,
    $q$The greatest common factor is 6xy. Divide each term by it to get 2x − 3y, so 6xy(2x − 3y).$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Algebraic Operations and Factorisation$q$,
    $q$Use the difference of squares to evaluate 53² − 47².$q$,
    $q${"A":"6","B":"100","C":"10,000","D":"600"}$q$::jsonb,
    $q$D$q$,
    $q$a² − b² = (a − b)(a + b). Hence (53 − 47)(53 + 47) = 6 × 100 = 600.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Algebraic Operations and Factorisation$q$,
    $q$If a ★ b = 2a + b − ab, find 3 ★ 4.$q$,
    $q${"A":"-2","B":"−8","C":"2","D":"22"}$q$::jsonb,
    $q$A$q$,
    $q$Substitute a = 3 and b = 4: 2(3) + 4 − (3)(4) = 6 + 4 − 12 = −2.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Algebraic Operations and Factorisation$q$,
    $q$Factorise x² − 49.$q$,
    $q${"A":"(x − 49)(x + 1)","B":"(x − 7)(x + 7)","C":"(x − 7)²","D":"(x + 7)²"}$q$::jsonb,
    $q$B$q$,
    $q$Recognise 49 = 7². Therefore x² − 49 = (x − 7)(x + 7).$q$
  );
