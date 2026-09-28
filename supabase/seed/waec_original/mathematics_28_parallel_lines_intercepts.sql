INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Parallel Lines and Intercepts$q$,
    $q$Two parallel lines are cut by a transversal. If one alternate interior angle is 64°, what is the other alternate interior angle?$q$,
    $q${"A":"26°","B":"64°","C":"116°","D":"128°"}$q$::jsonb,
    $q$B$q$,
    $q$Alternate interior angles formed by parallel lines are equal, so the matching angle is 64°.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Parallel Lines and Intercepts$q$,
    $q$Two interior angles on the same side of a transversal across parallel lines include one angle of 71°. What is the other?$q$,
    $q${"A":"71°","B":"119°","C":"109°","D":"142°"}$q$::jsonb,
    $q$C$q$,
    $q$Co-interior angles sum to 180° when the lines are parallel. The other angle is 180° − 71° = 109°.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Parallel Lines and Intercepts$q$,
    $q$Corresponding angles formed by parallel lines are (3x + 5)° and 80°. Find x.$q$,
    $q${"A":"15","B":"20","C":"30","D":"25"}$q$::jsonb,
    $q$D$q$,
    $q$Corresponding angles are equal: 3x + 5 = 80, so 3x = 75 and x = 25.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Parallel Lines and Intercepts$q$,
    $q$A line parallel to one side of a triangle divides another side into lengths 3 cm and 6 cm. If the matching first segment on a third side is 5 cm, how long is its matching second segment?$q$,
    $q${"A":"10 cm","B":"2.5 cm","C":"8 cm","D":"15 cm"}$q$::jsonb,
    $q$A$q$,
    $q$The intercept theorem gives corresponding segment ratios 3:6 = 5:x. Hence 3x = 30 and x = 10 cm.$q$
  );
