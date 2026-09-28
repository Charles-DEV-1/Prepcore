INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Triangles and Polygons$q$,
    $q$A triangle has interior angles 55°, 68° and x°. Find x.$q$,
    $q${"A":"47°","B":"57°","C":"67°","D":"123°"}$q$::jsonb,
    $q$B$q$,
    $q$Interior angles of a triangle sum to 180°. Thus x = 180° − 55° − 68° = 57°.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Triangles and Polygons$q$,
    $q$An exterior angle of a triangle has remote interior angles 42° and 73°. What is the exterior angle?$q$,
    $q${"A":"31°","B":"65°","C":"115°","D":"138°"}$q$::jsonb,
    $q$C$q$,
    $q$The exterior angle equals the sum of the two remote interior angles: 42° + 73° = 115°.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Triangles and Polygons$q$,
    $q$Each exterior angle of a regular polygon is 30°. How many sides does it have?$q$,
    $q${"A":"6","B":"10","C":"15","D":"12"}$q$::jsonb,
    $q$D$q$,
    $q$Exterior angles of any polygon sum to 360°. A regular polygon with each exterior angle 30° has 360 ÷ 30 = 12 sides.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Triangles and Polygons$q$,
    $q$What is the sum of interior angles of a pentagon?$q$,
    $q${"A":"540°","B":"360°","C":"720°","D":"900°"}$q$::jsonb,
    $q$A$q$,
    $q$An n-sided polygon has interior angle sum (n − 2) × 180°. For n = 5, this is 3 × 180° = 540°.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Triangles and Polygons$q$,
    $q$Two similar triangles have corresponding side lengths in the ratio 3:5. What is the ratio of their areas?$q$,
    $q${"A":"3:5","B":"9:25","C":"6:10","D":"27:125"}$q$::jsonb,
    $q$B$q$,
    $q$Area ratios are squares of side ratios: 3²:5² = 9:25.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Triangles and Polygons$q$,
    $q$Triangles ABC and DEF are congruent in that order. If side BC is 8 cm, how long is side EF?$q$,
    $q${"A":"4 cm","B":"16 cm","C":"8 cm","D":"Cannot be determined"}$q$::jsonb,
    $q$C$q$,
    $q$In the named correspondence ABC ↔ DEF, B matches E and C matches F. Corresponding side EF equals BC, so it is 8 cm.$q$
  );
