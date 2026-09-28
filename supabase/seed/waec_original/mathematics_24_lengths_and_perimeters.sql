INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Lengths and Perimeters$q$,
    $q$A right-angled triangular garden has perpendicular sides of 6 m and 8 m. How long is its third side?$q$,
    $q${"A":"9 m","B":"14 m","C":"48 m","D":"10 m"}$q$::jsonb,
    $q$D$q$,
    $q$Apply Pythagoras: the third side is √(6² + 8²) = √(36 + 64) = 10 m.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Lengths and Perimeters$q$,
    $q$A 13 m ladder leans against a wall, with its foot 5 m from the wall. How high up the wall does it reach?$q$,
    $q${"A":"12 m","B":"8 m","C":"18 m","D":"√194 m"}$q$::jsonb,
    $q$A$q$,
    $q$The ladder is the hypotenuse. Height = √(13² − 5²) = √(169 − 25) = √144 = 12 m.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Lengths and Perimeters$q$,
    $q$Using π = 22/7, find the length of a 90° arc of a circle of radius 7 cm.$q$,
    $q${"A":"7 cm","B":"11 cm","C":"22 cm","D":"44 cm"}$q$::jsonb,
    $q$B$q$,
    $q$An arc is its central-angle fraction of the circumference: 90/360 × 2 × 22/7 × 7 = 11 cm.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Lengths and Perimeters$q$,
    $q$Using π = 22/7, find the perimeter of a 90° sector of radius 14 cm.$q$,
    $q${"A":"22 cm","B":"44 cm","C":"50 cm","D":"88 cm"}$q$::jsonb,
    $q$C$q$,
    $q$The 90° arc is 90/360 × 2πr = 22 cm. Add two radii: 22 + 14 + 14 = 50 cm.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Lengths and Perimeters$q$,
    $q$Two sides of a triangle are 5 cm and 8 cm, with an included angle of 60°. What is the length of the opposite side?$q$,
    $q${"A":"6 cm","B":"8 cm","C":"13 cm","D":"7 cm"}$q$::jsonb,
    $q$D$q$,
    $q$Use the cosine rule: c² = 5² + 8² − 2(5)(8)cos60° = 25 + 64 − 40 = 49. Thus c = 7 cm.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Lengths and Perimeters$q$,
    $q$A side of length 6 cm is opposite a 30° angle in a triangle. What length is opposite a 90° angle?$q$,
    $q${"A":"12 cm","B":"3 cm","C":"6 cm","D":"18 cm"}$q$::jsonb,
    $q$A$q$,
    $q$By the sine rule, b/sin90° = 6/sin30°. Hence b = 6 × 1/(1/2) = 12 cm.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Lengths and Perimeters$q$,
    $q$A rectangle is 8.5 cm long and 3.5 cm wide. What is its perimeter?$q$,
    $q${"A":"12 cm","B":"24 cm","C":"17 cm","D":"29.75 cm"}$q$::jsonb,
    $q$B$q$,
    $q$Perimeter = 2(length + width) = 2(8.5 + 3.5) = 24 cm.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Lengths and Perimeters$q$,
    $q$A simplified model gives Earth's equator a circumference of 40,000 km. What distance along the equator corresponds to 45° of longitude?$q$,
    $q${"A":"2,500 km","B":"8,000 km","C":"5,000 km","D":"20,000 km"}$q$::jsonb,
    $q$C$q$,
    $q$A 45° arc is 45/360 = 1/8 of a full circle. Its equatorial distance is 40,000 ÷ 8 = 5,000 km.$q$
  );
