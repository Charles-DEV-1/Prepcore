INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Basic Tools of Economic Analysis$q$,
    $q$Five households earn ₦20, ₦30, ₦40, ₦50 and ₦60 thousand monthly. What is the mean income?$q$,
    $q${"A":"₦40,000","B":"₦30,000","C":"₦45,000","D":"₦50,000"}$q$::jsonb,
    $q$A$q$,
    $q$Add the five incomes and divide by five: (20 + 30 + 40 + 50 + 60) ÷ 5 = 40 thousand naira.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Basic Tools of Economic Analysis$q$,
    $q$The prices of a good are ₦4, ₦6, ₦8, ₦10 and ₦12. What is the median price?$q$,
    $q${"A":"₦6","B":"₦8","C":"₦9","D":"₦10"}$q$::jsonb,
    $q$B$q$,
    $q$The five prices are ordered; the middle, third price is ₦8.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Basic Tools of Economic Analysis$q$,
    $q$A shop sold 2, 3, 3, 5 and 7 bags on five days. What is the mode?$q$,
    $q${"A":"2 bags","B":"4 bags","C":"3 bags","D":"7 bags"}$q$::jsonb,
    $q$C$q$,
    $q$The mode is the value occurring most often; 3 occurs twice.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Basic Tools of Economic Analysis$q$,
    $q$A bar chart compares harvests in three villages. What should its vertical axis show if villages are on the horizontal axis?$q$,
    $q${"A":"The names of villages","B":"The title of the chart","C":"The source of the data only","D":"The quantity harvested"}$q$::jsonb,
    $q$D$q$,
    $q$The vertical axis carries the measured quantity, while the horizontal axis identifies categories.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Basic Tools of Economic Analysis$q$,
    $q$A survey recorded 12, 18, 20 and 30 responses in four groups. How many responses were recorded in all?$q$,
    $q${"A":"80","B":"70","C":"75","D":"90"}$q$::jsonb,
    $q$A$q$,
    $q$Add all group frequencies: 12 + 18 + 20 + 30 = 80.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Basic Tools of Economic Analysis$q$,
    $q$A line graph shows a steady rise in sales over six months. What can be inferred directly?$q$,
    $q${"A":"The firm's profit certainly increased","B":"Sales increased over the period","C":"Production costs fell","D":"All customers were satisfied"}$q$::jsonb,
    $q$B$q$,
    $q$The graph shows sales trend only; it does not prove profit or costs.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Basic Tools of Economic Analysis$q$,
    $q$Seven prices are ₦2, ₦3, ₦3, ₦5, ₦6, ₦8 and ₦9. What is their median?$q$,
    $q${"A":"₦3","B":"₦6","C":"₦5","D":"₦8"}$q$::jsonb,
    $q$C$q$,
    $q$With seven ordered values, the fourth value is the median: ₦5.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Basic Tools of Economic Analysis$q$,
    $q$Which display best shows how four spending categories make up one household budget?$q$,
    $q${"A":"A scatter diagram","B":"A single price label","C":"A time-series line alone","D":"A pie chart"}$q$::jsonb,
    $q$D$q$,
    $q$A pie chart shows each category's share of a whole.$q$
  );
