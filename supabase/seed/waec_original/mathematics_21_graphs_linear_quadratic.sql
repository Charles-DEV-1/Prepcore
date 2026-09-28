INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Graphs of Linear and Quadratic Functions$q$,
    $q$A straight line passes through (1, 3) and (5, 11). What is its gradient?$q$,
    $q${"A":"1","B":"4","C":"2","D":"8"}$q$::jsonb,
    $q$C$q$,
    $q$Gradient = change in y ÷ change in x = (11 − 3)/(5 − 1) = 8/4 = 2.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Graphs of Linear and Quadratic Functions$q$,
    $q$For y = 3x − 7, what is the y-intercept?$q$,
    $q${"A":"−3","B":"3","C":"7","D":"−7"}$q$::jsonb,
    $q$D$q$,
    $q$At the y-axis, x = 0. Substitute to get y = 3(0) − 7 = −7.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Graphs of Linear and Quadratic Functions$q$,
    $q$A line has gradient −2 and passes through (1, 5). What is its y-intercept?$q$,
    $q${"A":"7","B":"3","C":"5","D":"−7"}$q$::jsonb,
    $q$A$q$,
    $q$Write y = −2x + c. Substitute (1,5): 5 = −2 + c, so c = 7.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Graphs of Linear and Quadratic Functions$q$,
    $q$What is the x-coordinate of the turning point of y = x² − 8x + 6?$q$,
    $q${"A":"−4","B":"4","C":"8","D":"6"}$q$::jsonb,
    $q$B$q$,
    $q$For y = ax² + bx + c, the turning-point x-coordinate is −b/(2a) = 8/2 = 4.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Graphs of Linear and Quadratic Functions$q$,
    $q$What are the x-intercepts of y = x² − x − 6?$q$,
    $q${"A":"−3 and 2","B":"1 and 6","C":"-2 and 3","D":"−6 and 1"}$q$::jsonb,
    $q$C$q$,
    $q$Set y = 0 and factor: x² − x − 6 = (x − 3)(x + 2). Thus x = −2 or 3.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Graphs of Linear and Quadratic Functions$q$,
    $q$The lines y = 2x + 1 and y = x + 4 meet at which x-coordinate?$q$,
    $q${"A":"1","B":"2","C":"4","D":"3"}$q$::jsonb,
    $q$D$q$,
    $q$At their intersection, 2x + 1 = x + 4. Subtract x and 1 to obtain x = 3.$q$
  );
