INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Distributive Trade$q$,
    $q$A manufacturer sells 500 cartons to one wholesaler rather than to many small shops. What role does the wholesaler perform?$q$,
    $q${"A":"Bulk buying and breaking bulk","B":"Setting monetary policy","C":"Issuing passports","D":"Mining raw materials"}$q$::jsonb,
    $q$A$q$,
    $q$Wholesalers buy large quantities and resell smaller lots to retailers.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Distributive Trade$q$,
    $q$A neighbourhood shop sells individual packets directly to households. The shop is a what?$q$,
    $q${"A":"Wholesaler","B":"Retailer","C":"Producer of raw materials","D":"Central bank"}$q$::jsonb,
    $q$B$q$,
    $q$Retailers sell goods to final consumers.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Distributive Trade$q$,
    $q$A rural co-operative collects members' crops and negotiates with buyers. What advantage does this give members?$q$,
    $q${"A":"Guaranteed zero transport cost","B":"A fixed world price","C":"Stronger collective bargaining","D":"The end of storage needs"}$q$::jsonb,
    $q$C$q$,
    $q$Pooling produce can improve bargaining power and market access.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Distributive Trade$q$,
    $q$Perishable tomatoes spoil before they reach distant towns. Which improvement would most directly reduce this loss?$q$,
    $q${"A":"More advertising alone","B":"A higher income tax","C":"Fewer market stalls only","D":"Better cold-chain transport"}$q$::jsonb,
    $q$D$q$,
    $q$Cooling and faster transport help preserve perishable produce.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Distributive Trade$q$,
    $q$A producer sells online directly to customers, bypassing a retailer. What change has occurred?$q$,
    $q${"A":"One intermediary has been removed","B":"The producer has stopped producing","C":"The goods have become public goods","D":"The customers have become wholesalers"}$q$::jsonb,
    $q$A$q$,
    $q$Direct sales shorten the distribution chain.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Distributive Trade$q$,
    $q$A retailer keeps small quantities close to customers' homes. Which service is being provided?$q$,
    $q${"A":"Foreign exchange management","B":"Convenient access in small units","C":"National income accounting","D":"Mining"}$q$::jsonb,
    $q$B$q$,
    $q$Retailers make products available in convenient places and quantities.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Distributive Trade$q$,
    $q$A produce market lacks reliable price information, and farmers accept low offers. What would help most?$q$,
    $q${"A":"A longer route to market","B":"Less communication","C":"Timely market-price information","D":"A ban on weighing produce"}$q$::jsonb,
    $q$C$q$,
    $q$Knowing prevailing prices helps farmers evaluate buyers' offers.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Distributive Trade$q$,
    $q$A commodity board buys crops at a guaranteed price. What is one intended effect?$q$,
    $q${"A":"Elimination of all production risk","B":"A permanent end to imports","C":"A guaranteed world price increase","D":"More stable income for farmers"}$q$::jsonb,
    $q$D$q$,
    $q$A guaranteed purchase price can reduce farmers' price uncertainty.$q$
  );
