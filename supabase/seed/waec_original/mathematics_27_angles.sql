INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Angles$q$,
    $q$Three angles around a point measure 85°, 120° and x°. Find x.$q$,
    $q${"A":"145°","B":"155°","C":"165°","D":"205°"}$q$::jsonb,
    $q$B$q$,
    $q$Angles around a point total 360°. Thus x = 360° − 85° − 120° = 155°.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Angles$q$,
    $q$Two adjacent angles on a straight line are 127° and y°. Find y.$q$,
    $q${"A":"37°","B":"63°","C":"53°","D":"127°"}$q$::jsonb,
    $q$C$q$,
    $q$Adjacent angles on a straight line sum to 180°. Hence y = 180° − 127° = 53°.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Angles$q$,
    $q$Two intersecting lines form one angle of 68°. What is the angle vertically opposite it?$q$,
    $q${"A":"22°","B":"112°","C":"136°","D":"68°"}$q$::jsonb,
    $q$D$q$,
    $q$Vertically opposite angles are equal, so the opposite angle is 68°.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Angles$q$,
    $q$A full turn is divided into angles 2x°, 3x° and 4x°. Find x.$q$,
    $q${"A":"40°","B":"20°","C":"45°","D":"90°"}$q$::jsonb,
    $q$A$q$,
    $q$A full turn is 360°, so 2x + 3x + 4x = 360. Therefore 9x = 360 and x = 40°.$q$
  );
