INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Industrialization$q$,
    $q$Several firms making similar products locate near one another and share suppliers. What is this concentration called?$q$,
    $q${"A":"Localization of industry","B":"Nationalization","C":"Price discrimination","D":"Import substitution alone"}$q$::jsonb,
    $q$A$q$,
    $q$Localization is the concentration of related firms in a particular area.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Industrialization$q$,
    $q$A firm places a cement plant near limestone deposits. What location factor is most important?$q$,
    $q${"A":"Proximity to a stock exchange","B":"Proximity to bulky raw material","C":"Access to school uniforms","D":"Availability of foreign tourists"}$q$::jsonb,
    $q$B$q$,
    $q$Transporting heavy limestone is costly, so nearby raw materials matter.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Industrialization$q$,
    $q$A small manufacturing firm uses the same road, power line and training centre as nearby firms. What benefit is this?$q$,
    $q${"A":"A monopoly profit","B":"An internal diseconomy","C":"External economies of scale","D":"A demand shortage"}$q$::jsonb,
    $q$C$q$,
    $q$Shared area infrastructure lowers costs for multiple firms.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Industrialization$q$,
    $q$A government builds an industrial estate with roads and reliable electricity. What is its immediate purpose?$q$,
    $q${"A":"Eliminate consumer demand","B":"Replace every private firm","C":"Prevent all imports","D":"Lower setup costs for manufacturers"}$q$::jsonb,
    $q$D$q$,
    $q$Common infrastructure can make manufacturing investment easier.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Industrialization$q$,
    $q$A country assembles locally goods it previously imported, aiming to reduce import dependence. Which strategy is it following?$q$,
    $q${"A":"Import-substitution industrialization","B":"Export of raw materials only","C":"Deindustrialization","D":"Pure barter"}$q$::jsonb,
    $q$A$q$,
    $q$Import substitution develops domestic production of formerly imported goods.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Industrialization$q$,
    $q$A manufacturer cannot expand because power outages repeatedly stop machines. What bottleneck is described?$q$,
    $q${"A":"Excess demand for exports","B":"Inadequate infrastructure","C":"Too much human capital","D":"Perfect capital mobility"}$q$::jsonb,
    $q$B$q$,
    $q$Unreliable electricity is an infrastructure constraint on industrial output.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Industrialization$q$,
    $q$A firm operates three factories, each making a different product. Which term refers to the whole business organization?$q$,
    $q${"A":"Plant","B":"Machine","C":"Firm","D":"Workshop floor"}$q$::jsonb,
    $q$C$q$,
    $q$A firm is the business organization; each factory is a plant.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Industrialization$q$,
    $q$Why might new industries matter for economic development?$q$,
    $q${"A":"They eliminate scarcity","B":"They always reduce every price","C":"They remove the need for agriculture","D":"They can diversify output and create jobs"}$q$::jsonb,
    $q$D$q$,
    $q$Industry can broaden production and employment, though outcomes depend on conditions.$q$
  );
