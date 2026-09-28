INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Coordinate Geometry of Straight Lines$q$,
    $q$Find the midpoint of the segment joining (2, 3) and (8, 11).$q$,
    $q${"A":"(6, 8)","B":"(5, 7)","C":"(5, 8)","D":"(10, 14)"}$q$::jsonb,
    $q$B$q$,
    $q$Average corresponding coordinates: x = (2 + 8)/2 = 5 and y = (3 + 11)/2 = 7. The midpoint is (5, 7).$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Coordinate Geometry of Straight Lines$q$,
    $q$What is the distance between (−1, 2) and (5, 10)?$q$,
    $q${"A":"8","B":"12","C":"10","D":"14"}$q$::jsonb,
    $q$C$q$,
    $q$Coordinate differences are 6 and 8. Distance = √(6² + 8²) = √100 = 10.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Coordinate Geometry of Straight Lines$q$,
    $q$Find the gradient of the line through (3, −2) and (7, 6).$q$,
    $q${"A":"1/2","B":"4","C":"8","D":"2"}$q$::jsonb,
    $q$D$q$,
    $q$Gradient = (6 − (−2))/(7 − 3) = 8/4 = 2.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Coordinate Geometry of Straight Lines$q$,
    $q$A straight line has gradient 3 and crosses the y-axis at 4. What is its equation?$q$,
    $q${"A":"y = 3x + 4","B":"y = 4x + 3","C":"y = 3x − 4","D":"y = −3x + 4"}$q$::jsonb,
    $q$A$q$,
    $q$Use y = mx + c with gradient m = 3 and y-intercept c = 4. The equation is y = 3x + 4.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Coordinate Geometry of Straight Lines$q$,
    $q$What is the equation of the line passing through (2, 5) and (4, 9)?$q$,
    $q${"A":"y = x + 3","B":"y = 2x + 1","C":"y = 2x − 1","D":"y = 4x + 1"}$q$::jsonb,
    $q$B$q$,
    $q$Gradient = (9 − 5)/(4 − 2) = 2. Put (2,5) in y = 2x + c: 5 = 4 + c, so c = 1.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Coordinate Geometry of Straight Lines$q$,
    $q$At what x-value does the line 2x + 3y = 12 meet the x-axis?$q$,
    $q${"A":"2","B":"4","C":"6","D":"12"}$q$::jsonb,
    $q$C$q$,
    $q$At the x-axis y = 0. Then 2x + 3(0) = 12, giving x = 6.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Coordinate Geometry of Straight Lines$q$,
    $q$At what y-value does the line 3x − 2y = 8 meet the y-axis?$q$,
    $q${"A":"4","B":"−8","C":"8","D":"−4"}$q$::jsonb,
    $q$D$q$,
    $q$At the y-axis x = 0. Then −2y = 8, so y = −4.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Coordinate Geometry of Straight Lines$q$,
    $q$A line has gradient 3/2. What is the gradient of a perpendicular line?$q$,
    $q${"A":"−2/3","B":"3/2","C":"−3/2","D":"2/3"}$q$::jsonb,
    $q$A$q$,
    $q$Perpendicular gradients multiply to −1. The negative reciprocal of 3/2 is −2/3.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Coordinate Geometry of Straight Lines$q$,
    $q$On the line y = 2x − 3, what is y when x = 5?$q$,
    $q${"A":"2","B":"7","C":"5","D":"13"}$q$::jsonb,
    $q$B$q$,
    $q$Substitute x = 5 into the line: y = 2(5) − 3 = 7.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Coordinate Geometry of Straight Lines$q$,
    $q$Points (1, 2), (3, 6) and (5, 10) are given. Are they collinear?$q$,
    $q${"A":"No","B":"Only the first two","C":"Yes","D":"Cannot be determined"}$q$::jsonb,
    $q$C$q$,
    $q$Gradient between the first two is (6 − 2)/(3 − 1) = 2; between the last two it is (10 − 6)/(5 − 3) = 2. Equal gradients mean the three points are collinear.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Coordinate Geometry of Straight Lines$q$,
    $q$In which quadrant is the point (−4, 3)?$q$,
    $q${"A":"I","B":"III","C":"IV","D":"II"}$q$::jsonb,
    $q$D$q$,
    $q$A negative x-coordinate and positive y-coordinate place a point in Quadrant II.$q$
  );
