INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Constructions$q$,
    $q$Point P is constructed on the perpendicular bisector of segment AB. If PA = 7 cm, what is PB?$q$,
    $q${"A":"3.5 cm","B":"7 cm","C":"14 cm","D":"Cannot be determined"}$q$::jsonb,
    $q$B$q$,
    $q$Every point on a segment's perpendicular bisector is equally distant from its endpoints. Thus PB = PA = 7 cm.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Constructions$q$,
    $q$A 126° angle is bisected using ruler and compass. What is the size of each resulting angle?$q$,
    $q${"A":"42°","B":"72°","C":"63°","D":"252°"}$q$::jsonb,
    $q$C$q$,
    $q$An angle bisector divides an angle into two equal parts: 126° ÷ 2 = 63°.$q$
  );
