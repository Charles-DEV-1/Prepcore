INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Transformations in the Cartesian Plane$q$,
    $q$Reflect the point (3, −2) in the x-axis. What is its image?$q$,
    $q${"A":"(3, 2)","B":"(−3, −2)","C":"(−3, 2)","D":"(3, −2)"}$q$::jsonb,
    $q$A$q$,
    $q$Reflection in the x-axis keeps x unchanged and changes the sign of y: (3, −2) → (3, 2).$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Transformations in the Cartesian Plane$q$,
    $q$Rotate the point (2, 3) by 90° anticlockwise about the origin. What is its image?$q$,
    $q${"A":"(3, −2)","B":"(−3, 2)","C":"(−2, −3)","D":"(−3, −2)"}$q$::jsonb,
    $q$B$q$,
    $q$A 90° anticlockwise rotation maps (x, y) to (−y, x). Hence (2, 3) → (−3, 2).$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Transformations in the Cartesian Plane$q$,
    $q$Translate the point (1, 4) by the vector (−3, 2). What is the image point?$q$,
    $q${"A":"(4, 2)","B":"(−3, 2)","C":"(−2, 6)","D":"(−2, 2)"}$q$::jsonb,
    $q$C$q$,
    $q$Add translation components to the point: (1 + (−3), 4 + 2) = (−2, 6).$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Transformations in the Cartesian Plane$q$,
    $q$Enlarge the point (−2, 3) from the origin by scale factor 2. What is its image?$q$,
    $q${"A":"(−1, 1.5)","B":"(4, 6)","C":"(−4, 3)","D":"(−4, 6)"}$q$::jsonb,
    $q$D$q$,
    $q$An enlargement centred at the origin multiplies each coordinate by the scale factor: 2(−2, 3) = (−4, 6).$q$
  );
