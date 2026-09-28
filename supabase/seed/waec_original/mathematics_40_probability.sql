INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Probability$q$,
    $q$A fair die is rolled once. What is the probability of an even number?$q$,
    $q${"A":"1/6","B":"1/3","C":"2/3","D":"1/2"}$q$::jsonb,
    $q$D$q$,
    $q$Even outcomes are 2, 4 and 6: 3 favourable outcomes out of 6. Probability = 3/6 = 1/2.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Probability$q$,
    $q$Two fair coins are tossed independently. What is the probability that both show heads?$q$,
    $q${"A":"1/4","B":"1/2","C":"2/3","D":"3/4"}$q$::jsonb,
    $q$A$q$,
    $q$Each head has probability 1/2. Independence gives (1/2)(1/2) = 1/4.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Probability$q$,
    $q$A bag contains 3 red and 2 blue balls. Two balls are drawn without replacement. What is the probability that both are red?$q$,
    $q${"A":"3/5","B":"3/10","C":"9/25","D":"2/5"}$q$::jsonb,
    $q$B$q$,
    $q$First red probability = 3/5; after removing one red, second red probability = 2/4. Multiply: 3/5 × 2/4 = 6/20 = 3/10.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Probability$q$,
    $q$Events A and B cannot happen together. If P(A) = 0.3 and P(B) = 0.4, find P(A or B).$q$,
    $q${"A":"0.12","B":"0.4","C":"0.7","D":"1.2"}$q$::jsonb,
    $q$C$q$,
    $q$For mutually exclusive events, add probabilities: P(A or B) = 0.3 + 0.4 = 0.7.$q$
  );
