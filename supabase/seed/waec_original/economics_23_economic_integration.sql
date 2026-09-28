INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Economic Integration$q$,
    $q$Neighbouring states remove tariffs on goods traded among themselves but keep separate tariffs on outsiders. What is the arrangement?$q$,
    $q${"A":"Free-trade area","B":"Customs union","C":"Monetary union","D":"A single firm"}$q$::jsonb,
    $q$A$q$,
    $q$A free-trade area removes internal tariffs while members retain separate external tariffs.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Economic Integration$q$,
    $q$Members remove internal tariffs and adopt one common external tariff. What is this?$q$,
    $q${"A":"Free-trade area only","B":"Customs union","C":"Barter agreement","D":"A fixed exchange rate alone"}$q$::jsonb,
    $q$B$q$,
    $q$A customs union combines free internal trade with a common external tariff.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Economic Integration$q$,
    $q$Countries permit goods, labour and capital to move freely among members. What level of integration is this?$q$,
    $q${"A":"A tariff quota only","B":"A bilateral loan","C":"Common market","D":"A single tax office"}$q$::jsonb,
    $q$C$q$,
    $q$A common market adds free movement of production factors to goods trade.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Economic Integration$q$,
    $q$A small producer gains access to buyers across several member countries. What is a potential benefit of integration?$q$,
    $q${"A":"Guaranteed monopoly profit","B":"No transport costs","C":"No need for product quality","D":"A larger market"}$q$::jsonb,
    $q$D$q$,
    $q$Regional integration can expand the market available to firms.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Economic Integration$q$,
    $q$A less industrialized member fears its firms will lose to stronger neighbours. What is this a concern about?$q$,
    $q${"A":"Unequal distribution of integration benefits","B":"The absence of any competition","C":"A fall in market size for all members","D":"The end of specialization"}$q$::jsonb,
    $q$A$q$,
    $q$Benefits may be uneven when firms have different competitive capacities.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Economic Integration$q$,
    $q$ECOWAS tries to make trade easier within West Africa. Which objective does this most directly serve?$q$,
    $q${"A":"An end to all national governments","B":"Regional economic integration","C":"A single global currency","D":"The abolition of agriculture"}$q$::jsonb,
    $q$B$q$,
    $q$Reducing barriers among members advances regional integration.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Economic Integration$q$,
    $q$Different product standards slow trade among member states. What measure could help?$q$,
    $q${"A":"Raise internal tariffs","B":"Ban all regional transport","C":"Harmonize product standards","D":"Remove every quality check"}$q$::jsonb,
    $q$C$q$,
    $q$Compatible standards reduce technical obstacles while preserving quality checks.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Economic Integration$q$,
    $q$Why may poor cross-border roads limit the gains from a free-trade agreement?$q$,
    $q${"A":"Tariff removal creates roads automatically","B":"Trade no longer needs logistics","C":"All goods become weightless","D":"Transport costs can still make trade expensive"}$q$::jsonb,
    $q$D$q$,
    $q$Low tariffs alone do not remove physical transport costs.$q$
  );
