INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$International Trade and Balance of Payments$q$,
    $q$Country A can produce a shirt with fewer resources than Country B. Which advantage does A have in shirts?$q$,
    $q${"A":"Absolute advantage","B":"A guaranteed trade surplus","C":"A balance-of-payments deficit","D":"A tariff advantage"}$q$::jsonb,
    $q$A$q$,
    $q$Absolute advantage means producing a good with fewer inputs.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$International Trade and Balance of Payments$q$,
    $q$Two countries can both make food and cloth, but one gives up less cloth to make food. Why may it specialize in food?$q$,
    $q${"A":"It has no opportunity cost","B":"It has a comparative advantage in food","C":"It must import all cloth","D":"Its population is larger"}$q$::jsonb,
    $q$B$q$,
    $q$Comparative advantage depends on the lower opportunity cost.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$International Trade and Balance of Payments$q$,
    $q$A country exports goods worth ₦500bn and imports goods worth ₦420bn. What is its merchandise trade balance?$q$,
    $q${"A":"₦80bn deficit","B":"₦920bn surplus","C":"₦80bn surplus","D":"₦420bn deficit"}$q$::jsonb,
    $q$C$q$,
    $q$Merchandise trade balance = exports − imports = 500 − 420 = ₦80bn surplus.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$International Trade and Balance of Payments$q$,
    $q$An export price index is 120 and an import price index is 150. What are the commodity terms of trade?$q$,
    $q${"A":"125","B":"30","C":"270","D":"80"}$q$::jsonb,
    $q$D$q$,
    $q$Terms of trade = export price index ÷ import price index × 100 = 120 ÷ 150 × 100 = 80.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$International Trade and Balance of Payments$q$,
    $q$A tariff is placed on imported shoes. What is the direct policy action?$q$,
    $q${"A":"A tax on imports","B":"A quota on exports","C":"A subsidy to foreign firms","D":"An exchange of goods without money"}$q$::jsonb,
    $q$A$q$,
    $q$A tariff taxes imported goods.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$International Trade and Balance of Payments$q$,
    $q$A country receives foreign-currency payment for exported cocoa. Where is this receipt recorded in the balance of payments?$q$,
    $q${"A":"Only the capital account","B":"The current account","C":"The domestic tax account","D":"The central bank's payroll"}$q$::jsonb,
    $q$B$q$,
    $q$Exports of goods are recorded in the current account.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$International Trade and Balance of Payments$q$,
    $q$A persistent current-account deficit may be financed by what?$q$,
    $q${"A":"Printing foreign banknotes domestically","B":"Eliminating every import immediately","C":"Borrowing or drawing down foreign reserves","D":"Ignoring foreign payments"}$q$::jsonb,
    $q$C$q$,
    $q$A deficit requires financing, such as external borrowing or reserve use.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$International Trade and Balance of Payments$q$,
    $q$A country's export value is ₦240bn and import value is ₦300bn. By how much do imports exceed exports?$q$,
    $q${"A":"₦540bn","B":"₦240bn","C":"₦300bn","D":"₦60bn"}$q$::jsonb,
    $q$D$q$,
    $q$Imports exceed exports by 300 − 240 = ₦60bn.$q$
  );
