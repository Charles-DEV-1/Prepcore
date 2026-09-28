INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Loci$q$,
    $q$Points A(0, 0) and B(6, 0) are fixed. A point P is equally distant from A and B. On which vertical line must P lie?$q$,
    $q${"A":"x = 0","B":"x = 6","C":"y = 3","D":"x = 3"}$q$::jsonb,
    $q$D$q$,
    $q$The locus is the perpendicular bisector of AB. The midpoint of x-coordinates 0 and 6 is 3, so its line is x = 3.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Loci$q$,
    $q$Which point is exactly 5 units from the origin (0, 0)?$q$,
    $q${"A":"3, 4","B":"2, 4","C":"5, 5","D":"0, 4"}$q$::jsonb,
    $q$A$q$,
    $q$Use distance √(x² + y²). For (3,4), √(3² + 4²) = √25 = 5, whereas the other listed points do not give 5.$q$
  );
