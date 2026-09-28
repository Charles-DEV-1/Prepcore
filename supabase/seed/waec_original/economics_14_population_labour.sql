INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Population and Labour Market$q$,
    $q$A town has 12,000 residents on 30 square kilometres. What is its population density?$q$,
    $q${"A":"400 people per km²","B":"40 people per km²","C":"360 people per km²","D":"12,030 people per km²"}$q$::jsonb,
    $q$A$q$,
    $q$Population density = population ÷ area = 12,000 ÷ 30 = 400 people per km².$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Population and Labour Market$q$,
    $q$A country has 2 million employed people and 0.5 million unemployed people actively seeking work. What is its labour force?$q$,
    $q${"A":"1.5 million","B":"2.5 million","C":"2 million","D":"0.5 million"}$q$::jsonb,
    $q$B$q$,
    $q$Labour force includes the employed plus unemployed people actively seeking work: 2 + 0.5 = 2.5 million.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Population and Labour Market$q$,
    $q$There are 200 unemployed job seekers in a labour force of 2,000. What is the unemployment rate?$q$,
    $q${"A":"20%","B":"5%","C":"10%","D":"90%"}$q$::jsonb,
    $q$C$q$,
    $q$Unemployment rate = unemployed ÷ labour force × 100 = 200 ÷ 2,000 × 100 = 10%.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Population and Labour Market$q$,
    $q$A graduate moves from a village to a city after finding a job there. What demographic movement is this?$q$,
    $q${"A":"Urban-to-rural migration","B":"Natural increase","C":"International emigration","D":"Rural-to-urban migration"}$q$::jsonb,
    $q$D$q$,
    $q$Moving from a rural settlement to a city is rural-to-urban migration.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Population and Labour Market$q$,
    $q$A trained engineer cannot find engineering work and takes a job that uses very few of her skills. What condition is illustrated?$q$,
    $q${"A":"Underemployment","B":"Full employment","C":"Structural inflation","D":"Population density"}$q$::jsonb,
    $q$A$q$,
    $q$Underemployment includes work that makes insufficient use of a worker's skills or time.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Population and Labour Market$q$,
    $q$A national census misses people in remote villages. What is the likely statistical effect?$q$,
    $q${"A":"Population is always overestimated","B":"Population is underestimated","C":"Births are counted twice automatically","D":"The labour force becomes zero"}$q$::jsonb,
    $q$B$q$,
    $q$Undercounting residents makes the recorded population too low.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Population and Labour Market$q$,
    $q$A trade union negotiates collectively for safer conditions. What is the union's role?$q$,
    $q${"A":"Fixing the exchange rate","B":"Issuing government bonds","C":"Representing workers' interests","D":"Managing all firms"}$q$::jsonb,
    $q$C$q$,
    $q$Trade unions bargain on behalf of workers over pay and conditions.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Population and Labour Market$q$,
    $q$Employers demand more trained welders after new factories open. What is most likely to happen to welders' wages if supply does not immediately rise?$q$,
    $q${"A":"They must fall to zero","B":"They cannot change","C":"They are set by population density","D":"They tend to rise"}$q$::jsonb,
    $q$D$q$,
    $q$Stronger demand for scarce welders tends to raise the wage.$q$
  );
