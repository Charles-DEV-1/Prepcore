INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Fractions, Decimals and Approximations$q$,
    $q$A container holds 3/4 litre of juice. After 2/5 litre is poured out, how many litres remain?$q$,
    $q${"A":"7/20","B":"1/20","C":"5/20","D":"13/20"}$q$::jsonb,
    $q$A$q$,
    $q$Use a common denominator of 20: 3/4 − 2/5 = 15/20 − 8/20 = 7/20 litre.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Fractions, Decimals and Approximations$q$,
    $q$A learner divides 0.72 by 0.06. What quotient should be obtained?$q$,
    $q${"A":"1.2","B":"12","C":"120","D":"0.12"}$q$::jsonb,
    $q$B$q$,
    $q$Multiply both numbers by 100: 0.72 ÷ 0.06 = 72 ÷ 6 = 12.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Fractions, Decimals and Approximations$q$,
    $q$A measured length is 8.746 cm. What is it to three significant figures?$q$,
    $q${"A":"8.74 cm","B":"8.7 cm","C":"8.75 cm","D":"8.76 cm"}$q$::jsonb,
    $q$C$q$,
    $q$The first three significant digits are 8, 7 and 4. The next digit is 6, so round the 4 up to 5: 8.75 cm.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Fractions, Decimals and Approximations$q$,
    $q$The mass of a parcel is estimated as 2.96 kg. What is this to one decimal place?$q$,
    $q${"A":"2.9 kg","B":"2.96 kg","C":"3.1 kg","D":"3.0 kg"}$q$::jsonb,
    $q$D$q$,
    $q$At one decimal place, inspect the hundredths digit 6. Round the tenths digit 9 up, carrying into the units: 3.0 kg.$q$
  );
