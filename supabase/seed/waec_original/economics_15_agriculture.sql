INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Agriculture$q$,
    $q$A farm grows crops mainly for the household's consumption with little sold. What system is this?$q$,
    $q${"A":"Subsistence or peasant farming","B":"Commercial export farming","C":"Industrial manufacturing","D":"Distributive trade"}$q$::jsonb,
    $q$A$q$,
    $q$Subsistence farming is primarily for the farmer's household needs.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Agriculture$q$,
    $q$A group of farmers jointly buys a tractor and markets its harvest. What system are they using?$q$,
    $q${"A":"Individual subsistence farming","B":"Co-operative farming","C":"A central bank","D":"An import quota"}$q$::jsonb,
    $q$B$q$,
    $q$Co-operative farming pools members' resources and benefits.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Agriculture$q$,
    $q$A government guarantees a minimum crop price to reduce farmers' losses during a price collapse. What is the intended effect?$q$,
    $q${"A":"Higher rainfall","B":"No need for storage","C":"More stable farm income","D":"Elimination of all farm costs"}$q$::jsonb,
    $q$C$q$,
    $q$A price floor can support farm income when market prices are low.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Agriculture$q$,
    $q$A country exports cocoa but imports much of its food. What risk does this create?$q$,
    $q${"A":"Guaranteed food self-sufficiency","B":"No exposure to world prices","C":"Zero transport costs","D":"Dependence on export earnings and food imports"}$q$::jsonb,
    $q$D$q$,
    $q$Relying on export crops and imported food exposes the economy to external price and supply changes.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Agriculture$q$,
    $q$Poor roads cause harvested vegetables to spoil before sale. Which policy would most directly help?$q$,
    $q${"A":"Improve farm-to-market transport","B":"Reduce soil fertility","C":"Ban local markets","D":"Raise the cost of storage"}$q$::jsonb,
    $q$A$q$,
    $q$Better roads cut travel time and post-harvest losses.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Agriculture$q$,
    $q$A farmer uses irrigation to produce vegetables during the dry season. What constraint is being eased?$q$,
    $q${"A":"A permanent shortage of labour","B":"Seasonal water shortage","C":"A lack of buyers","D":"The law of diminishing returns"}$q$::jsonb,
    $q$B$q$,
    $q$Irrigation supplies water when rainfall is insufficient.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Agriculture$q$,
    $q$A commodity board purchases farmers' crops for resale. Which function is it performing?$q$,
    $q${"A":"Commercial banking","B":"Monetary policy","C":"Organized marketing","D":"Population enumeration"}$q$::jsonb,
    $q$C$q$,
    $q$The board aggregates and markets agricultural produce.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Agriculture$q$,
    $q$A rise in farm output supplies food and raw material to local factories. What connection does this illustrate?$q$,
    $q${"A":"Industry must replace all farming","B":"Food output has no effect on industry","C":"Factories only use imported inputs","D":"Agriculture can support industrialization"}$q$::jsonb,
    $q$D$q$,
    $q$Agricultural output can feed workers and supply agro-processing firms.$q$
  );
