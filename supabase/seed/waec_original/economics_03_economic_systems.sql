INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Types and Basic Features of Economic Systems$q$,
    $q$In an economy, most factories are privately owned and prices guide production. Which system is most closely described?$q$,
    $q${"A":"Capitalism","B":"Central planning","C":"Subsistence farming","D":"A barter economy"}$q$::jsonb,
    $q$A$q$,
    $q$Private ownership and price signals are key features of capitalism.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Types and Basic Features of Economic Systems$q$,
    $q$A government owns major industries while private shops operate freely. What type of system is this?$q$,
    $q${"A":"Pure command economy","B":"Mixed economy","C":"Pure market economy","D":"Barter economy"}$q$::jsonb,
    $q$B$q$,
    $q$A mixed economy combines public and private ownership.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Types and Basic Features of Economic Systems$q$,
    $q$A planning authority fixes output targets for all major factories. Which system relies most on this method?$q$,
    $q${"A":"Pure capitalism","B":"An informal exchange economy","C":"Socialism or command economy","D":"A household economy"}$q$::jsonb,
    $q$C$q$,
    $q$Central planning assigns production targets in a command system.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Types and Basic Features of Economic Systems$q$,
    $q$A market system rewards firms that satisfy buyers, but it may undersupply street lighting. Why?$q$,
    $q${"A":"Streetlights use no resources","B":"Every streetlight has a private owner","C":"Demand for light is always zero","D":"Street lighting is hard to exclude non-payers from"}$q$::jsonb,
    $q$D$q$,
    $q$Non-excludability creates a free-rider problem and weakens private provision.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Types and Basic Features of Economic Systems$q$,
    $q$A command economy can direct resources quickly to a national project, but what information problem may it face?$q$,
    $q${"A":"Planners may not know local preferences and costs","B":"Prices always reveal every preference perfectly","C":"Workers never need equipment","D":"Scarcity disappears"}$q$::jsonb,
    $q$A$q$,
    $q$Central planners may lack the detailed information dispersed among consumers and firms.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Types and Basic Features of Economic Systems$q$,
    $q$Which decision is typically made through market prices in a largely capitalist economy?$q$,
    $q${"A":"How much rain will fall","B":"Which goods firms find profitable to produce","C":"Who has legal citizenship","D":"The country's geographic boundaries"}$q$::jsonb,
    $q$B$q$,
    $q$Profit and price signals guide firms' production decisions.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Types and Basic Features of Economic Systems$q$,
    $q$A state subsidizes schooling while private firms sell textbooks. What does this combination show?$q$,
    $q${"A":"Complete abolition of private enterprise","B":"A purely subsistence economy","C":"Public intervention within a mixed economy","D":"The absence of scarcity"}$q$::jsonb,
    $q$C$q$,
    $q$Public provision and private sales coexist in a mixed economy.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Types and Basic Features of Economic Systems$q$,
    $q$Why can no economic system avoid choosing among alternative uses of resources?$q$,
    $q${"A":"Every government owns factories","B":"All prices are fixed","C":"All households have identical incomes","D":"Resources are scarce relative to wants"}$q$::jsonb,
    $q$D$q$,
    $q$Scarcity requires choices regardless of ownership system.$q$
  );
