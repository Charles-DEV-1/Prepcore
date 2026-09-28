INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Financial Arithmetic$q$,
    $q$A machine costs ₦90,000 and has a residual value of ₦10,000 after 4 years. What is its annual straight-line depreciation?$q$,
    $q${"A":"₦22,500","B":"₦25,000","C":"₦20,000","D":"₦80,000"}$q$::jsonb,
    $q$C$q$,
    $q$Depreciable amount = ₦90,000 − ₦10,000 = ₦80,000. Divide by 4 years to obtain ₦20,000 per year.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Financial Arithmetic$q$,
    $q$A ₦50,000 bond pays a fixed coupon of 8% of its face value each year. How much coupon interest is paid in 3 years?$q$,
    $q${"A":"₦4,000","B":"₦8,000","C":"₦54,000","D":"₦12,000"}$q$::jsonb,
    $q$D$q$,
    $q$Annual coupon = 8% × ₦50,000 = ₦4,000. Over 3 years, total coupons = 3 × ₦4,000 = ₦12,000.$q$
  );
