INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Ratio, Proportions and Rates$q$,
    $q$Two friends share ₦840 in the ratio 3:4. How much does the first friend receive?$q$,
    $q${"A":"₦280","B":"₦420","C":"₦360","D":"₦480"}$q$::jsonb,
    $q$C$q$,
    $q$There are 3 + 4 = 7 equal parts. One part is ₦840 ÷ 7 = ₦120, so the first friend gets 3 × ₦120 = ₦360.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Ratio, Proportions and Rates$q$,
    $q$A metal block has mass 540 g and volume 60 cm³. What is its density?$q$,
    $q${"A":"6 g/cm³","B":"60 g/cm³","C":"9 cm³/g","D":"9 g/cm³"}$q$::jsonb,
    $q$D$q$,
    $q$Density = mass ÷ volume = 540 g ÷ 60 cm³ = 9 g/cm³.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Ratio, Proportions and Rates$q$,
    $q$A vehicle travels 150 km in 2.5 hours at constant speed. What is its speed?$q$,
    $q${"A":"60 km/h","B":"37.5 km/h","C":"62.5 km/h","D":"375 km/h"}$q$::jsonb,
    $q$A$q$,
    $q$Speed = distance ÷ time = 150 ÷ 2.5 = 60 km/h.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Ratio, Proportions and Rates$q$,
    $q$At ₦1,200 for 3 kg of rice, what is the cost of 5 kg at the same rate?$q$,
    $q${"A":"₦1,600","B":"₦2,000","C":"₦2,400","D":"₦3,000"}$q$::jsonb,
    $q$B$q$,
    $q$Unit cost = ₦1,200 ÷ 3 = ₦400 per kg. For 5 kg, cost = 5 × ₦400 = ₦2,000.$q$
  );
