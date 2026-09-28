INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Statistics$q$,
    $q$In a survey of 60 learners, 18 chose football. What angle should represent football in a pie chart?$q$,
    $q${"A":"18°","B":"90°","C":"120°","D":"108°"}$q$::jsonb,
    $q$D$q$,
    $q$A pie-chart sector is its fraction of 360°: 18/60 × 360° = 108°.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Statistics$q$,
    $q$Find the mean of 4, 6, 8 and 10.$q$,
    $q${"A":"7","B":"6","C":"8","D":"28"}$q$::jsonb,
    $q$A$q$,
    $q$Add the values to get 28, then divide by 4 values: mean = 28/4 = 7.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Statistics$q$,
    $q$What is the median of 3, 7, 8, 11 and 15?$q$,
    $q${"A":"7","B":"8","C":"9","D":"11"}$q$::jsonb,
    $q$B$q$,
    $q$The five values are already ordered. The middle, third value is 8.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Statistics$q$,
    $q$Find the mode of 2, 2, 3, 4, 4, 4.$q$,
    $q${"A":"2","B":"3","C":"4","D":"3.17"}$q$::jsonb,
    $q$C$q$,
    $q$The mode is the most frequent value. Four occurs three times, more than any other value.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Statistics$q$,
    $q$What is the range of 3, 7, 12 and 20?$q$,
    $q${"A":"12","B":"20","C":"23","D":"17"}$q$::jsonb,
    $q$D$q$,
    $q$Range = maximum − minimum = 20 − 3 = 17.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Statistics$q$,
    $q$For the population data 2, 4, 6, what is the variance?$q$,
    $q${"A":"8/3","B":"4","C":"8","D":"2/3"}$q$::jsonb,
    $q$A$q$,
    $q$Mean = 4. Squared deviations are 4, 0 and 4, summing to 8. Population variance = 8/3.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Statistics$q$,
    $q$What is the population standard deviation of 2, 2, 6 and 6?$q$,
    $q${"A":"1","B":"2","C":"4","D":"8"}$q$::jsonb,
    $q$B$q$,
    $q$Mean = 4. Squared deviations total 16; variance = 16/4 = 4, so standard deviation = √4 = 2.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Statistics$q$,
    $q$For ordered data 2, 4, 6, 8, 10, 12, 14, what is the interquartile range using medians of the lower and upper halves?$q$,
    $q${"A":"4","B":"10","C":"8","D":"12"}$q$::jsonb,
    $q$C$q$,
    $q$Exclude median 8. Lower-half median Q₁ = 4 and upper-half median Q₃ = 12. IQR = Q₃ − Q₁ = 8.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Statistics$q$,
    $q$What is the class mark of the interval 20–29?$q$,
    $q${"A":"20","B":"25","C":"29","D":"24.5"}$q$::jsonb,
    $q$D$q$,
    $q$The class mark is the midpoint: (20 + 29)/2 = 24.5.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Statistics$q$,
    $q$Three consecutive classes have frequencies 3, 5 and 7. What is the cumulative frequency up to and including the third class?$q$,
    $q${"A":"15","B":"7","C":"12","D":"21"}$q$::jsonb,
    $q$A$q$,
    $q$Cumulative frequency adds all frequencies up to that class: 3 + 5 + 7 = 15.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Statistics$q$,
    $q$A histogram class has width 2 and frequency 6. What is its frequency density?$q$,
    $q${"A":"2","B":"3","C":"6","D":"12"}$q$::jsonb,
    $q$B$q$,
    $q$Frequency density = frequency ÷ class width = 6 ÷ 2 = 3.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Statistics$q$,
    $q$Two grouped-data classes have marks 5 and 15 with frequencies 1 and 3. What is the estimated mean?$q$,
    $q${"A":"10","B":"15","C":"12.5","D":"20"}$q$::jsonb,
    $q$C$q$,
    $q$Weighted total = 5 × 1 + 15 × 3 = 50. Total frequency = 4, so estimated mean = 50/4 = 12.5.$q$
  );
