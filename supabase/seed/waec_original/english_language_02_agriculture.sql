INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Agriculture$q$,
    $q$A farmer leaves cut grass on the soil to reduce evaporation. What is this practice called?$q$,
    $q${"A":"Mulching","B":"Irrigation","C":"Harvesting","D":"Pruning"}$q$::jsonb,
    $q$A$q$,
    $q$Mulching covers the soil with material such as grass to conserve moisture.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Agriculture$q$,
    $q$A maize farmer grows beans in the same field to help restore soil nitrogen. The beans are useful mainly because they are what?$q$,
    $q${"A":"Cereals","B":"Legumes","C":"Tubers","D":"Weeds"}$q$::jsonb,
    $q$B$q$,
    $q$Legumes can support nitrogen fixation through bacteria associated with their roots.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Agriculture$q$,
    $q$After harvesting cassava, a farmer plants a different crop on the plot the next season. What is this system called?$q$,
    $q${"A":"Monoculture","B":"Transplanting","C":"Crop rotation","D":"Thinning"}$q$::jsonb,
    $q$C$q$,
    $q$Crop rotation changes the crop grown on a plot over successive seasons.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Agriculture$q$,
    $q$Water is supplied to crops during a long dry spell through channels. This is an example of what?$q$,
    $q${"A":"Drainage","B":"Pollination","C":"Weeding","D":"Irrigation"}$q$::jsonb,
    $q$D$q$,
    $q$Irrigation supplies water artificially when rainfall is insufficient.$q$
  );
