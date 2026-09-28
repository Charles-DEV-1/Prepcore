INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Sequences and Series$q$,
    $q$The first term of an arithmetic progression is 7 and its common difference is 4. What is its eighth term?$q$,
    $q${"A":"28","B":"32","C":"35","D":"39"}$q$::jsonb,
    $q$C$q$,
    $q$For an arithmetic progression, Uₙ = a + (n − 1)d. Hence U₈ = 7 + 7 × 4 = 35.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Sequences and Series$q$,
    $q$An arithmetic progression starts 5, 8, 11, ... . What is the sum of its first 10 terms?$q$,
    $q${"A":"145","B":"175","C":"190","D":"185"}$q$::jsonb,
    $q$D$q$,
    $q$Here a = 5, d = 3 and n = 10. S₁₀ = n/2[2a + (n − 1)d] = 5(10 + 27) = 185.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Sequences and Series$q$,
    $q$A geometric progression begins 3, 6, 12, ... . What is its sixth term?$q$,
    $q${"A":"96","B":"48","C":"64","D":"192"}$q$::jsonb,
    $q$A$q$,
    $q$The common ratio is 2. U₆ = ar⁵ = 3 × 2⁵ = 96.$q$
  );
