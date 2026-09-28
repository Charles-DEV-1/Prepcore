INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Sets$q$,
    $q$In a class, 18 learners take Physics, 15 take Chemistry and 7 take both. How many take at least one of the two subjects?$q$,
    $q${"A":"33","B":"26","C":"40","D":"22"}$q$::jsonb,
    $q$B$q$,
    $q$Add both group sizes and subtract the overlap counted twice: 18 + 15 − 7 = 26.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Sets$q$,
    $q$A universal set has 40 members, and set P has 17. How many members are in the complement of P?$q$,
    $q${"A":"17","B":"40","C":"23","D":"57"}$q$::jsonb,
    $q$C$q$,
    $q$The complement contains members of the universal set outside P: 40 − 17 = 23.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Sets$q$,
    $q$Of 30 learners, 12 study French, 14 study Arabic and 5 study both. How many study neither language?$q$,
    $q${"A":"5","B":"11","C":"21","D":"9"}$q$::jsonb,
    $q$D$q$,
    $q$The union has 12 + 14 − 5 = 21 learners. Neither group contains 30 − 21 = 9.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Sets$q$,
    $q$Three clubs have 10, 9 and 8 members. Pairwise overlaps are 3, 2 and 4, and 1 learner belongs to all three. How many distinct learners belong to at least one club?$q$,
    $q${"A":"19","B":"17","C":"20","D":"28"}$q$::jsonb,
    $q$A$q$,
    $q$Use inclusion–exclusion: 10 + 9 + 8 − 3 − 2 − 4 + 1 = 19. Add the triple overlap back once.$q$
  );
