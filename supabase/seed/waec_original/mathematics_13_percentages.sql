INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Percentages$q$,
    $q$A bag priced ₦8,000 is discounted by 15%. What is the sale price?$q$,
    $q${"A":"₦1,200","B":"₦7,200","C":"₦6,800","D":"₦9,200"}$q$::jsonb,
    $q$C$q$,
    $q$Discount = 15% of ₦8,000 = ₦1,200. Sale price = ₦8,000 − ₦1,200 = ₦6,800.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Percentages$q$,
    $q$A trader buys an item for ₦2,400 and sells it for ₦3,000. What is the profit percentage on cost?$q$,
    $q${"A":"20%","B":"30%","C":"60%","D":"25%"}$q$::jsonb,
    $q$D$q$,
    $q$Profit = ₦3,000 − ₦2,400 = ₦600. Profit percentage on cost = 600/2400 × 100% = 25%.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Percentages$q$,
    $q$What is the simple interest on ₦12,000 at 5% per annum for 2 years?$q$,
    $q${"A":"₦1,200","B":"₦600","C":"₦1,000","D":"₦13,200"}$q$::jsonb,
    $q$A$q$,
    $q$Simple interest I = Prt/100 = 12,000 × 5 × 2/100 = ₦1,200.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Percentages$q$,
    $q$₦10,000 is invested at 10% compound interest annually for 2 years. What is the amount after 2 years?$q$,
    $q${"A":"₦11,000","B":"₦12,100","C":"₦12,000","D":"₦12,200"}$q$::jsonb,
    $q$B$q$,
    $q$Amount = principal × (1 + rate)² = ₦10,000 × 1.1² = ₦12,100.$q$
  );
