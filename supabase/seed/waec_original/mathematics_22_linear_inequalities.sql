INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Linear Inequalities$q$,
    $q$Solve 3x − 5 > 10. What is the smallest integer solution?$q$,
    $q${"A":"6","B":"4","C":"5","D":"7"}$q$::jsonb,
    $q$A$q$,
    $q$3x > 15, so x > 5. The smallest integer greater than 5 is 6.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Linear Inequalities$q$,
    $q$Solve −2x ≤ 8. Which statement describes the solution?$q$,
    $q${"A":"x ≤ −4","B":"x ≥ −4","C":"x ≥ 4","D":"x ≤ 4"}$q$::jsonb,
    $q$B$q$,
    $q$Divide by −2 and reverse the inequality sign: x ≥ −4.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Linear Inequalities$q$,
    $q$An item costs ₦250. A buyer has at most ₦1,400. What is the greatest whole number of items the buyer can buy?$q$,
    $q${"A":"4","B":"6","C":"5","D":"7"}$q$::jsonb,
    $q$C$q$,
    $q$Let n be the number of items. 250n ≤ 1,400 gives n ≤ 5.6. Therefore the greatest whole number is 5.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Linear Inequalities$q$,
    $q$Which integer satisfies both x > 2 and x ≤ 4?$q$,
    $q${"A":"1","B":"2","C":"5","D":"3"}$q$::jsonb,
    $q$D$q$,
    $q$The combined interval is 2 < x ≤ 4. Among the given choices, 3 lies in it.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Linear Inequalities$q$,
    $q$For non-negative x and y with x + y ≤ 6, which proposed point is feasible?$q$,
    $q${"A":"2, 3","B":"4, 4","C":"−1, 2","D":"7, 0"}$q$::jsonb,
    $q$A$q$,
    $q$Feasibility needs x ≥ 0, y ≥ 0 and x + y ≤ 6. At (2, 3), the sum is 5, so all conditions hold.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Linear Inequalities$q$,
    $q$A profit model is P = 4x + 3y. At feasible vertices (0, 0), (0, 5), (4, 2) and (6, 0), what is the maximum profit value?$q$,
    $q${"A":"15","B":"24","C":"20","D":"22"}$q$::jsonb,
    $q$B$q$,
    $q$Evaluate P at each vertex: 0, 15, 22 and 24. The maximum is 24 at (6, 0).$q$
  );
