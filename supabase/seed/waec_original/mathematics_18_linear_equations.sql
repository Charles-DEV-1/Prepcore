INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Linear and Simultaneous Equations$q$,
    $q$Solve 3x − 7 = 20.$q$,
    $q${"A":"7","B":"8","C":"9","D":"27"}$q$::jsonb,
    $q$C$q$,
    $q$Add 7 to both sides: 3x = 27. Divide by 3 to obtain x = 9.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Linear and Simultaneous Equations$q$,
    $q$Solve 5(2x − 1) = 3x + 16.$q$,
    $q${"A":"2","B":"4","C":"7","D":"3"}$q$::jsonb,
    $q$D$q$,
    $q$Expand: 10x − 5 = 3x + 16. Then 7x = 21, so x = 3.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Linear and Simultaneous Equations$q$,
    $q$Find x if x + y = 11 and x − y = 3.$q$,
    $q${"A":"7","B":"4","C":"8","D":"14"}$q$::jsonb,
    $q$A$q$,
    $q$Add the equations: 2x = 14. Hence x = 7.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Linear and Simultaneous Equations$q$,
    $q$Find y if 2x + y = 13 and x − y = 2.$q$,
    $q${"A":"2","B":"3","C":"4","D":"5"}$q$::jsonb,
    $q$B$q$,
    $q$From x − y = 2, y = x − 2. Substitute: 2x + (x − 2) = 13, so x = 5 and y = 3.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Linear and Simultaneous Equations$q$,
    $q$Three notebooks and two pens cost ₦1,900. A notebook costs ₦300. What is the price of one pen?$q$,
    $q${"A":"₦300","B":"₦400","C":"₦500","D":"₦1,000"}$q$::jsonb,
    $q$C$q$,
    $q$Notebooks cost 3 × ₦300 = ₦900. The two pens cost ₦1,000, so one costs ₦1,000 ÷ 2 = ₦500.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Linear and Simultaneous Equations$q$,
    $q$Solve x/3 + 4 = 9.$q$,
    $q${"A":"5","B":"13","C":"27","D":"15"}$q$::jsonb,
    $q$D$q$,
    $q$Subtract 4: x/3 = 5. Multiply by 3 to get x = 15.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Linear and Simultaneous Equations$q$,
    $q$Two numbers sum to 25 and differ by 7. What is the larger number?$q$,
    $q${"A":"16","B":"9","C":"18","D":"25"}$q$::jsonb,
    $q$A$q$,
    $q$Add the sum and difference: twice the larger number is 25 + 7 = 32. The larger number is 16.$q$
  );
