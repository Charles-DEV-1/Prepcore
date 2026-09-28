INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$International Economic Organizations$q$,
    $q$A country seeks short-term support during a balance-of-payments crisis. Which institution is most closely associated with this role?$q$,
    $q${"A":"International Monetary Fund","B":"OPEC","C":"A local co-operative","D":"A national stock exchange"}$q$::jsonb,
    $q$A$q$,
    $q$The IMF is associated with balance-of-payments assistance and macroeconomic support.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$International Economic Organizations$q$,
    $q$A country seeks long-term financing for a major development project. Which institution is most relevant among these?$q$,
    $q${"A":"A local wholesaler","B":"World Bank/IBRD","C":"A trade union","D":"A retail bank's cash desk"}$q$::jsonb,
    $q$B$q$,
    $q$The IBRD, part of the World Bank, supports development financing.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$International Economic Organizations$q$,
    $q$Oil-exporting countries coordinate petroleum production policy through which organization?$q$,
    $q${"A":"AfDB","B":"ECOWAS only","C":"OPEC","D":"A commodity retailer"}$q$::jsonb,
    $q$C$q$,
    $q$OPEC groups oil-exporting countries for petroleum policy coordination.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$International Economic Organizations$q$,
    $q$An African country seeks a regional development loan. Which institution is specifically African in focus?$q$,
    $q${"A":"International Olympic Committee","B":"A private insurance shop","C":"A national retail union","D":"African Development Bank"}$q$::jsonb,
    $q$D$q$,
    $q$The AfDB finances development in African member countries.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$International Economic Organizations$q$,
    $q$A West African country wants analysis of African economic development trends from a UN regional body. Which body fits?$q$,
    $q${"A":"Economic Commission for Africa","B":"OPEC","C":"A village co-operative","D":"A local customs post"}$q$::jsonb,
    $q$A$q$,
    $q$The UN Economic Commission for Africa focuses on African development policy.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$International Economic Organizations$q$,
    $q$A government wants a UN forum focused on trade and development issues affecting lower-income countries. Which body is most relevant?$q$,
    $q${"A":"OPEC","B":"UNCTAD","C":"A domestic sports federation","D":"A commercial bank branch"}$q$::jsonb,
    $q$B$q$,
    $q$UNCTAD addresses trade and development issues in the UN system.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$International Economic Organizations$q$,
    $q$Why might several countries join a development bank rather than finance every project alone?$q$,
    $q${"A":"They can abolish loan repayment","B":"They can remove all exchange rates","C":"They can pool resources and risk","D":"They can guarantee every project succeeds"}$q$::jsonb,
    $q$C$q$,
    $q$Multilateral institutions pool finance and share project risk, though loans still need repayment.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$International Economic Organizations$q$,
    $q$A country compares policy advice from an international lender with local employment needs. What is the sound approach?$q$,
    $q${"A":"Accept every recommendation without analysis","B":"Reject all data from abroad","C":"Ignore the cost of borrowing","D":"Assess advice against national conditions and trade-offs"}$q$::jsonb,
    $q$D$q$,
    $q$Policy advice should be evaluated against a country's circumstances and objectives.$q$
  );
