INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Areas$q$,
    $q$A triangular plot has base 12 m and perpendicular height 9 m. Find its area.$q$,
    $q${"A":"21 m²","B":"108 m²","C":"54 m","D":"54 m²"}$q$::jsonb,
    $q$D$q$,
    $q$Area of a triangle = 1/2 × base × height = 1/2 × 12 × 9 = 54 m².$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Areas$q$,
    $q$A parallelogram has base 14 cm and perpendicular height 5 cm. What is its area?$q$,
    $q${"A":"70 cm²","B":"19 cm²","C":"35 cm²","D":"140 cm²"}$q$::jsonb,
    $q$A$q$,
    $q$Area of a parallelogram = base × perpendicular height = 14 × 5 = 70 cm².$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Areas$q$,
    $q$A trapezium has parallel sides 8 cm and 14 cm, separated by 6 cm. Find its area.$q$,
    $q${"A":"48 cm²","B":"66 cm²","C":"84 cm²","D":"132 cm²"}$q$::jsonb,
    $q$B$q$,
    $q$Area = 1/2 × sum of parallel sides × height = 1/2 × (8 + 14) × 6 = 66 cm².$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Areas$q$,
    $q$Two sides of a triangle are 8 cm and 10 cm with included angle 30°. Find its area.$q$,
    $q${"A":"10 cm²","B":"40 cm²","C":"20 cm²","D":"80 cm²"}$q$::jsonb,
    $q$C$q$,
    $q$Area = 1/2 ab sin C = 1/2 × 8 × 10 × sin30° = 40 × 1/2 = 20 cm².$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Areas$q$,
    $q$Two similar shapes have corresponding side lengths in the ratio 1:3. If the smaller has area 12 cm², what is the larger area?$q$,
    $q${"A":"36 cm²","B":"72 cm²","C":"144 cm²","D":"108 cm²"}$q$::jsonb,
    $q$D$q$,
    $q$Area scales with the square of the side scale factor. The factor is 3² = 9, so area = 12 × 9 = 108 cm².$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Areas$q$,
    $q$An L-shaped floor is made from a 10 m by 8 m rectangle with a 4 m by 3 m corner removed. What is its area?$q$,
    $q${"A":"68 m²","B":"48 m²","C":"72 m²","D":"92 m²"}$q$::jsonb,
    $q$A$q$,
    $q$Whole rectangle area = 10 × 8 = 80 m². Removed corner = 4 × 3 = 12 m². Remaining area = 68 m².$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Areas$q$,
    $q$Using π = 22/7, find the area of a 90° sector of radius 7 cm.$q$,
    $q${"A":"22 cm²","B":"38.5 cm²","C":"77 cm²","D":"154 cm²"}$q$::jsonb,
    $q$B$q$,
    $q$Area = 90/360 × πr² = 1/4 × 22/7 × 49 = 38.5 cm².$q$
  );
