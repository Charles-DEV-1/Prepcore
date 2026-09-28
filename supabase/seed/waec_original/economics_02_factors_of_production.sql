INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Factors of Production$q$,
    $q$A baker rents a shop, hires assistants, buys an oven and plans the business. Which factor does the oven represent?$q$,
    $q${"A":"Capital","B":"Land","C":"Labour","D":"Entrepreneurship"}$q$::jsonb,
    $q$A$q$,
    $q$Capital is a produced asset used to make other goods and services.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Factors of Production$q$,
    $q$The same baker combines resources and bears the risk of a new product line. Which factor is she providing?$q$,
    $q${"A":"Land","B":"Entrepreneurship","C":"Unskilled labour","D":"Natural resources"}$q$::jsonb,
    $q$B$q$,
    $q$Entrepreneurship organizes the other factors and accepts business risk.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Factors of Production$q$,
    $q$A fish pond is used to raise tilapia. In economics, the pond's water and site are mainly classified as what?$q$,
    $q${"A":"Capital","B":"Labour","C":"Land","D":"Profit"}$q$::jsonb,
    $q$C$q$,
    $q$Land includes natural resources used in production.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Factors of Production$q$,
    $q$Training workers to repair solar panels raises their productivity. What is being improved?$q$,
    $q${"A":"The quantity of land","B":"The money supply","C":"The market price","D":"Human capital"}$q$::jsonb,
    $q$D$q$,
    $q$Education and skills increase human capital.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Factors of Production$q$,
    $q$A factory replaces hand-operated equipment with a machine to increase output per worker. Which factor has increased?$q$,
    $q${"A":"Capital","B":"Land","C":"Entrepreneurship only","D":"Consumption"}$q$::jsonb,
    $q$A$q$,
    $q$The machine is capital used alongside labour.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Factors of Production$q$,
    $q$A trained nurse moves to another hospital to fill a vacancy. This is an example of what?$q$,
    $q${"A":"Capital depreciation","B":"Occupational or geographical labour mobility","C":"Land reclamation","D":"Price discrimination"}$q$::jsonb,
    $q$B$q$,
    $q$Labour mobility is the ability of workers to change jobs or locations.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Factors of Production$q$,
    $q$Why might a firm pay a specialist technician more than an untrained worker?$q$,
    $q${"A":"All technicians work longer hours by law","B":"Training removes the need for capital","C":"The technician's scarce skills can raise productivity","D":"The technician owns the factory land"}$q$::jsonb,
    $q$C$q$,
    $q$Scarce relevant skills can increase a worker's contribution to output and wage.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Factors of Production$q$,
    $q$An entrepreneur's income for successful risk-taking is usually called what?$q$,
    $q${"A":"Rent","B":"Wages","C":"Interest","D":"Profit"}$q$::jsonb,
    $q$D$q$,
    $q$Profit is the residual return associated with organizing production and bearing risk.$q$
  );
