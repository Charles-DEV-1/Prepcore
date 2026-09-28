INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Matrices and Determinants$q$,
    $q$Let M = [[2, −1], [4, 3]] and N = [[5, 6], [−2, 1]]. What is the entry in row 1, column 2 of M + N?$q$,
    $q${"A":"−7","B":"7","C":"1","D":"5"}$q$::jsonb,
    $q$D$q$,
    $q$Add corresponding entries: the row-1, column-2 entry is −1 + 6 = 5.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Matrices and Determinants$q$,
    $q$If A = [[1, 2], [3, 4]] and B = [[2, 0], [1, 5]], what is the entry in row 2, column 2 of AB?$q$,
    $q${"A":"20","B":"8","C":"11","D":"23"}$q$::jsonb,
    $q$A$q$,
    $q$Multiply row 2 of A by column 2 of B: 3 × 0 + 4 × 5 = 20.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Matrices and Determinants$q$,
    $q$Find the determinant of [[4, 3], [2, 5]].$q$,
    $q${"A":"26","B":"14","C":"10","D":"17"}$q$::jsonb,
    $q$B$q$,
    $q$For [[a,b],[c,d]], the determinant is ad − bc. Thus 4 × 5 − 3 × 2 = 14.$q$
  );
