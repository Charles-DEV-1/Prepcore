INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Volumes$q$,
    $q$A cuboid is 4 cm long, 5 cm wide and 6 cm high. What is its volume?$q$,
    $q${"A":"30 cm³","B":"60 cm³","C":"120 cm³","D":"150 cm³"}$q$::jsonb,
    $q$C$q$,
    $q$Volume of a cuboid = length × width × height = 4 × 5 × 6 = 120 cm³.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Volumes$q$,
    $q$Using π = 22/7, find the volume of a cylinder of radius 7 cm and height 10 cm.$q$,
    $q${"A":"440 cm³","B":"490 cm³","C":"3,080 cm³","D":"1,540 cm³"}$q$::jsonb,
    $q$D$q$,
    $q$Cylinder volume = πr²h = 22/7 × 7² × 10 = 22 × 7 × 10 = 1,540 cm³.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Volumes$q$,
    $q$Using π = 22/7, find the volume of a cone of radius 7 cm and height 9 cm.$q$,
    $q${"A":"462 cm³","B":"154 cm³","C":"1,386 cm³","D":"924 cm³"}$q$::jsonb,
    $q$A$q$,
    $q$Cone volume = 1/3πr²h = 1/3 × 22/7 × 49 × 9 = 462 cm³.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Volumes$q$,
    $q$Using π = 3.14, find the volume of a sphere of radius 3 cm, to two decimal places.$q$,
    $q${"A":"28.26 cm³","B":"113.04 cm³","C":"84.78 cm³","D":"113.10 cm³"}$q$::jsonb,
    $q$B$q$,
    $q$Sphere volume = 4/3πr³ = 4/3 × 3.14 × 27 = 113.04 cm³.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Volumes$q$,
    $q$A square-based pyramid has base side 6 cm and perpendicular height 9 cm. Find its volume.$q$,
    $q${"A":"54 cm³","B":"162 cm³","C":"108 cm³","D":"324 cm³"}$q$::jsonb,
    $q$C$q$,
    $q$Pyramid volume = 1/3 × base area × height = 1/3 × 6² × 9 = 108 cm³.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Volumes$q$,
    $q$Two similar solid models have a length scale factor of 2 from small to large. If the small model has volume 15 cm³, what is the large model's volume?$q$,
    $q${"A":"30 cm³","B":"60 cm³","C":"90 cm³","D":"120 cm³"}$q$::jsonb,
    $q$D$q$,
    $q$Volumes scale by the cube of the length factor: 2³ = 8. Thus 15 × 8 = 120 cm³.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Volumes$q$,
    $q$A solid consists of a cuboid measuring 10 cm by 4 cm by 3 cm and a separate cube of side 2 cm joined without overlap. What is their total volume?$q$,
    $q${"A":"128 cm³","B":"120 cm³","C":"122 cm³","D":"136 cm³"}$q$::jsonb,
    $q$A$q$,
    $q$Add the non-overlapping volumes: cuboid = 10 × 4 × 3 = 120 cm³; cube = 2³ = 8 cm³. Total = 128 cm³.$q$
  );
