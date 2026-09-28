INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Vectors in a Plane$q$,
    $q$A displacement vector has components (3, 4). What is its magnitude?$q$,
    $q${"A":"1","B":"7","C":"25","D":"5"}$q$::jsonb,
    $q$D$q$,
    $q$Magnitude = √(3² + 4²) = √25 = 5.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Vectors in a Plane$q$,
    $q$Find the sum of the vectors (2, −1) and (−3, 5).$q$,
    $q${"A":"(−1, 4)","B":"(5, 4)","C":"(−1, −6)","D":"(−5, 6)"}$q$::jsonb,
    $q$A$q$,
    $q$Add corresponding components: (2 + (−3), −1 + 5) = (−1, 4).$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Vectors in a Plane$q$,
    $q$What is −2 times the vector (3, −4)?$q$,
    $q${"A":"(−6, −8)","B":"(−6, 8)","C":"(6, 8)","D":"(−1, 2)"}$q$::jsonb,
    $q$B$q$,
    $q$Multiply each component by −2: (−2 × 3, −2 × −4) = (−6, 8).$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Vectors in a Plane$q$,
    $q$What displacement vector takes point A(1, 2) to point B(5, 7)?$q$,
    $q${"A":"(6, 9)","B":"(−4, −5)","C":"(4, 5)","D":"(5, 7)"}$q$::jsonb,
    $q$C$q$,
    $q$Subtract starting coordinates from ending coordinates: B − A = (5 − 1, 7 − 2) = (4, 5).$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Vectors in a Plane$q$,
    $q$Which vector is parallel and points in the same direction as (2, 3)?$q$,
    $q${"A":"(−2, −3)","B":"(3, 2)","C":"(2, −3)","D":"(4, 6)"}$q$::jsonb,
    $q$D$q$,
    $q$A vector is parallel in the same direction when it is a positive scalar multiple. Multiplying (2, 3) by 2 gives (4, 6).$q$
  );
