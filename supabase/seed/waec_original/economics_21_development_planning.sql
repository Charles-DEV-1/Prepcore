INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Economic Development and Planning$q$,
    $q$A country's output rises, but most households remain without clean water or schooling. Why is output growth alone not proof of development?$q$,
    $q${"A":"Development also concerns living standards and opportunities","B":"Growth always reduces output","C":"Income cannot be measured","D":"Population must have fallen"}$q$::jsonb,
    $q$A$q$,
    $q$Development is broader than output growth and includes welfare and access to services.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Economic Development and Planning$q$,
    $q$A government sets education and transport targets for the next five years. What is this process?$q$,
    $q${"A":"Price discrimination","B":"Development planning","C":"Barter","D":"Market clearing"}$q$::jsonb,
    $q$B$q$,
    $q$Development planning sets coordinated goals and policies over a period.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Economic Development and Planning$q$,
    $q$A plan is revised each year as conditions change while keeping a multi-year horizon. What type of plan is this?$q$,
    $q${"A":"Fixed one-day plan","B":"A census","C":"Rolling plan","D":"A trade embargo"}$q$::jsonb,
    $q$C$q$,
    $q$A rolling plan updates and extends the planning period regularly.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Economic Development and Planning$q$,
    $q$A country has high unemployment despite many working-age people. What development resource is underused?$q$,
    $q${"A":"Only mineral deposits","B":"Only imported machines","C":"Foreign currency notes","D":"Labour"}$q$::jsonb,
    $q$D$q$,
    $q$Unemployment means available labour is not fully employed.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Economic Development and Planning$q$,
    $q$Why can poor data weaken an economic development plan?$q$,
    $q${"A":"Targets may be based on inaccurate needs and resources","B":"Data always raises inflation","C":"Plans never use population information","D":"All investments become free"}$q$::jsonb,
    $q$A$q$,
    $q$Planning requires reliable estimates of population, output and resources.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Economic Development and Planning$q$,
    $q$A new factory increases GDP but pollutes drinking water. What trade-off should planners assess?$q$,
    $q${"A":"Only the factory's sales revenue","B":"Economic gains against environmental and health costs","C":"Only the number of machines","D":"Only the import price of fuel"}$q$::jsonb,
    $q$B$q$,
    $q$Development decisions should account for benefits and social or environmental costs.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Economic Development and Planning$q$,
    $q$A country invests in schools to improve workers' skills over time. Which development input is being strengthened?$q$,
    $q${"A":"Only mineral capital","B":"Import tariffs","C":"Human capital","D":"Nominal exchange rates"}$q$::jsonb,
    $q$C$q$,
    $q$Education builds human capital and can improve productivity.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Economic Development and Planning$q$,
    $q$An economy depends heavily on one export crop. Why might diversification be a development goal?$q$,
    $q${"A":"It makes all prices constant","B":"It prevents all imports","C":"It eliminates scarcity","D":"It reduces exposure to one commodity's price shocks"}$q$::jsonb,
    $q$D$q$,
    $q$Diversification spreads risk across activities and sources of income.$q$
  );
