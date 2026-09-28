INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Demand$q$,
    $q$A clothing shop lowers the price of shirts and sells more, with other factors unchanged. This is a what?$q$,
    $q${"A":"Movement along the demand curve","B":"Rightward shift of the demand curve","C":"Leftward shift of supply","D":"Fall in consumer income"}$q$::jsonb,
    $q$A$q$,
    $q$A change in a good's own price changes quantity demanded along its curve.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Demand$q$,
    $q$Tea and coffee are substitutes. If coffee becomes more expensive, what is likely to happen to demand for tea?$q$,
    $q${"A":"It decreases","B":"It increases","C":"It must become zero","D":"It becomes perfectly inelastic"}$q$::jsonb,
    $q$B$q$,
    $q$Consumers may switch from dearer coffee to tea, shifting tea demand right.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Demand$q$,
    $q$A family earns more and buys fewer low-quality staple substitutes. Such staples are what type of goods for this family?$q$,
    $q${"A":"Normal goods","B":"Public goods","C":"Inferior goods","D":"Capital goods"}$q$::jsonb,
    $q$C$q$,
    $q$Demand for an inferior good can fall as income rises.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Demand$q$,
    $q$The price of a product rises from ₦10 to ₦12 and quantity demanded falls from 100 to 90 units. Using the original values, what is price elasticity of demand?$q$,
    $q${"A":"1.0","B":"2.0","C":"5.0","D":"0.5"}$q$::jsonb,
    $q$D$q$,
    $q$Percentage quantity change = 10/100 = 10%; percentage price change = 2/10 = 20%; elasticity magnitude = 10% ÷ 20% = 0.5.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Demand$q$,
    $q$A bus company raises fares and total fare revenue falls. What does this suggest about demand over that range?$q$,
    $q${"A":"It is price elastic","B":"It is perfectly inelastic","C":"It has zero elasticity","D":"It is necessarily unit elastic"}$q$::jsonb,
    $q$A$q$,
    $q$When a price rise lowers total revenue, the proportionate fall in quantity exceeds the price rise.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Demand$q$,
    $q$Demand for bread rises because more households move into a town. What changes on the demand diagram?$q$,
    $q${"A":"There is a movement up one demand curve","B":"The demand curve shifts right","C":"The supply curve must become vertical","D":"The demand curve shifts left"}$q$::jsonb,
    $q$B$q$,
    $q$More buyers increase demand at each price, shifting the demand curve right.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Demand$q$,
    $q$Income rises by 10% and demand for a product rises by 15%. What is income elasticity of demand?$q$,
    $q${"A":"0.5","B":"1.0","C":"1.5","D":"2.5"}$q$::jsonb,
    $q$C$q$,
    $q$Income elasticity = percentage change in quantity demanded ÷ percentage change in income = 15% ÷ 10% = 1.5.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Demand$q$,
    $q$The price of maize rises by 20%, and demand for millet rises by 10%. What is the cross elasticity of demand for millet with respect to maize price?$q$,
    $q${"A":"−0.5","B":"+2.0","C":"−2.0","D":"+0.5"}$q$::jsonb,
    $q$D$q$,
    $q$Cross elasticity = percentage change in millet demand ÷ percentage change in maize price = 10% ÷ 20% = +0.5.$q$
  );
