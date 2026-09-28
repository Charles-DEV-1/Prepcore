INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Variation$q$,
    $q$y varies directly as x. If y = 18 when x = 6, what is y when x = 11?$q$,
    $q${"A":"33","B":"23","C":"30","D":"36"}$q$::jsonb,
    $q$A$q$,
    $q$Direct variation means y = kx. Here k = 18/6 = 3, so at x = 11, y = 3 × 11 = 33.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Variation$q$,
    $q$The time t for a fixed job varies inversely as the number n of workers. If 4 workers take 15 days, how many days will 6 workers take?$q$,
    $q${"A":"9","B":"10","C":"12","D":"22.5"}$q$::jsonb,
    $q$B$q$,
    $q$For inverse variation, nt is constant: 4 × 15 = 60 worker-days. With 6 workers, t = 60 ÷ 6 = 10 days.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Variation$q$,
    $q$z varies jointly as x and y. If z = 24 when x = 3 and y = 4, find z when x = 5 and y = 2.$q$,
    $q${"A":"10","B":"24","C":"20","D":"40"}$q$::jsonb,
    $q$C$q$,
    $q$Write z = kxy. Since 24 = k × 3 × 4, k = 2. Then z = 2 × 5 × 2 = 20.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Variation$q$,
    $q$A quantity P is partly constant and partly varies as x. Given P = 11 at x = 2 and P = 20 at x = 5, find P at x = 7.$q$,
    $q${"A":"21","B":"23","C":"29","D":"26"}$q$::jsonb,
    $q$D$q$,
    $q$Let P = a + bx. Subtract the two equations to get b = (20 − 11)/(5 − 2) = 3. Then a = 11 − 3 × 2 = 5, so P(7) = 5 + 3 × 7 = 26.$q$
  );
