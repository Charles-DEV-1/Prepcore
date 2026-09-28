INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Cost and Revenue$q$,
    $q$A firm's fixed cost is ₦200 and variable cost is ₦300 at an output of 10 units. What is total cost?$q$,
    $q${"A":"₦500","B":"₦100","C":"₦300","D":"₦2,000"}$q$::jsonb,
    $q$A$q$,
    $q$Total cost = fixed cost + variable cost = 200 + 300 = ₦500.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Cost and Revenue$q$,
    $q$If total cost is ₦500 for 10 units, what is average cost?$q$,
    $q${"A":"₦5","B":"₦50","C":"₦500","D":"₦5,000"}$q$::jsonb,
    $q$B$q$,
    $q$Average cost = total cost ÷ output = 500 ÷ 10 = ₦50.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Cost and Revenue$q$,
    $q$Total cost rises from ₦500 to ₦560 when output rises from 10 to 11 units. What is marginal cost?$q$,
    $q${"A":"₦56","B":"₦500","C":"₦60","D":"₦1,060"}$q$::jsonb,
    $q$C$q$,
    $q$Marginal cost for the extra unit = 560 − 500 = ₦60.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Cost and Revenue$q$,
    $q$A firm sells 20 units at ₦15 each. What is total revenue?$q$,
    $q${"A":"₦35","B":"₦150","C":"₦1.33","D":"₦300"}$q$::jsonb,
    $q$D$q$,
    $q$Total revenue = price × quantity = 15 × 20 = ₦300.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Cost and Revenue$q$,
    $q$Total revenue rises from ₦300 to ₦318 when sales rise from 20 to 21 units. What is marginal revenue?$q$,
    $q${"A":"₦18","B":"₦15","C":"₦21","D":"₦318"}$q$::jsonb,
    $q$A$q$,
    $q$Marginal revenue is the additional revenue from the extra unit: 318 − 300 = ₦18.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Cost and Revenue$q$,
    $q$A small shop uses its owner's building without paying rent. What cost would an economist include that an accountant may omit?$q$,
    $q${"A":"The electricity bill actually paid","B":"The forgone rent from leasing the building","C":"The wage paid to staff","D":"The price of purchased goods"}$q$::jsonb,
    $q$B$q$,
    $q$An economist counts implicit opportunity costs, including rent forgone by using one's own building.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Cost and Revenue$q$,
    $q$A firm earns ₦900 revenue and pays ₦700 explicit costs, while the owner's forgone wage is ₦120. What is economic profit?$q$,
    $q${"A":"₦200","B":"₦120","C":"₦80","D":"₦1,600"}$q$::jsonb,
    $q$C$q$,
    $q$Economic profit = revenue − explicit costs − implicit cost = 900 − 700 − 120 = ₦80.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Cost and Revenue$q$,
    $q$A firm earns ₦600 total revenue from selling 12 units. What is average revenue?$q$,
    $q${"A":"₦12","B":"₦600","C":"₦7,200","D":"₦50"}$q$::jsonb,
    $q$D$q$,
    $q$Average revenue = total revenue ÷ quantity = 600 ÷ 12 = ₦50.$q$
  );
