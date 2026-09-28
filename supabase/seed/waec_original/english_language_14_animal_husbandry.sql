INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Animal Husbandry$q$,
    $q$A poultry keeper places newly hatched chicks in a warm enclosure. What is the enclosure called?$q$,
    $q${"A":"A brooder","B":"A silo","C":"A paddock","D":"A trough"}$q$::jsonb,
    $q$A$q$,
    $q$A brooder provides controlled warmth for young chicks.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Animal Husbandry$q$,
    $q$A farmer moves cattle between grazing areas to prevent overuse of one field. This is what kind of grazing?$q$,
    $q${"A":"Continuous","B":"Rotational","C":"Indoor","D":"Selective breeding"}$q$::jsonb,
    $q$B$q$,
    $q$Rotational grazing moves animals between areas to allow pasture recovery.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Animal Husbandry$q$,
    $q$The farmer keeps a record of when each goat was vaccinated. The record helps track what?$q$,
    $q${"A":"Market prices only","B":"Rainfall only","C":"Animal health care","D":"Fence repairs only"}$q$::jsonb,
    $q$C$q$,
    $q$Vaccination records help manage each animal's health care.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Animal Husbandry$q$,
    $q$A cow has a diet containing roughage and other nutrients. The roughage mainly provides what?$q$,
    $q${"A":"Electricity","B":"Medication","C":"Salt alone","D":"Fibre"}$q$::jsonb,
    $q$D$q$,
    $q$Roughage supplies fibre that supports normal digestion in livestock.$q$
  );
