INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$National Income$q$,
    $q$An economy's consumption is ₦500bn, investment ₦120bn, government spending ₦180bn, exports ₦70bn and imports ₦90bn. What is GDP by expenditure?$q$,
    $q${"A":"₦780bn","B":"₦800bn","C":"₦960bn","D":"₦700bn"}$q$::jsonb,
    $q$A$q$,
    $q$GDP = C + I + G + X − M = 500 + 120 + 180 + 70 − 90 = ₦780bn.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$National Income$q$,
    $q$A bakery buys flour for ₦40 and sells bread for ₦100. What value does it add?$q$,
    $q${"A":"₦40","B":"₦60","C":"₦100","D":"₦140"}$q$::jsonb,
    $q$B$q$,
    $q$Value added = sale value − intermediate input cost = 100 − 40 = ₦60.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$National Income$q$,
    $q$GDP is ₦900bn and depreciation is ₦80bn. What is net domestic product?$q$,
    $q${"A":"₦980bn","B":"₦80bn","C":"₦820bn","D":"₦900bn"}$q$::jsonb,
    $q$C$q$,
    $q$Net domestic product = GDP − depreciation = 900 − 80 = ₦820bn.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$National Income$q$,
    $q$Why are intermediate goods excluded when calculating GDP from final output?$q$,
    $q${"A":"Because they have no price","B":"Because factories do not use them","C":"Because they are always imported","D":"To avoid counting the same value more than once"}$q$::jsonb,
    $q$D$q$,
    $q$Their value is already included in the final goods' value.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$National Income$q$,
    $q$A country produces GDP of ₦1,000bn and receives ₦50bn net factor income from abroad. What is GNP?$q$,
    $q${"A":"₦1,050bn","B":"₦950bn","C":"₦1,000bn","D":"₦50bn"}$q$::jsonb,
    $q$A$q$,
    $q$GNP = GDP + net factor income from abroad = 1,000 + 50 = ₦1,050bn.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$National Income$q$,
    $q$National income is ₦600bn for a population of 30 million. What is income per person?$q$,
    $q${"A":"₦2,000","B":"₦20,000","C":"₦200,000","D":"₦18,000"}$q$::jsonb,
    $q$B$q$,
    $q$Per-capita income = ₦600 billion ÷ 30 million = ₦20,000.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$National Income$q$,
    $q$A country's measured GDP grows after unpaid household care is replaced by paid care. What limitation of GDP does this show?$q$,
    $q${"A":"GDP counts every unpaid activity","B":"GDP directly measures happiness","C":"Unpaid work is often omitted","D":"GDP cannot include services"}$q$::jsonb,
    $q$C$q$,
    $q$National accounts generally record market production, not most unpaid household work.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$National Income$q$,
    $q$A rise in GDP comes mainly from price increases rather than more goods. Which measure better tracks real output?$q$,
    $q${"A":"Nominal GDP alone","B":"Import duty revenue","C":"The money supply alone","D":"Real GDP adjusted for inflation"}$q$::jsonb,
    $q$D$q$,
    $q$Real GDP removes the effect of changing prices.$q$
  );
