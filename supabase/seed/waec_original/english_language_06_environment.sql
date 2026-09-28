INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Environment$q$,
    $q$A factory treats its wastewater before releasing it into a river. Which problem is it trying to prevent?$q$,
    $q${"A":"Water pollution","B":"Soil erosion","C":"Noise pollution","D":"Deforestation"}$q$::jsonb,
    $q$A$q$,
    $q$Untreated industrial wastewater can contaminate a river.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Environment$q$,
    $q$Trees are planted on a bare hillside to help keep the soil in place. What is the main environmental benefit?$q$,
    $q${"A":"Increased litter","B":"Reduced erosion","C":"Faster runoff","D":"Reduced shade"}$q$::jsonb,
    $q$B$q$,
    $q$Roots bind soil and trees reduce the force of runoff and rainfall.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Environment$q$,
    $q$A family sorts glass and paper so they can be processed into new products. This is called what?$q$,
    $q${"A":"Incineration","B":"Dumping","C":"Recycling","D":"Dredging"}$q$::jsonb,
    $q$C$q$,
    $q$Recycling processes used materials into usable new materials.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Environment$q$,
    $q$A town replaces open waste burning with regular collection. Which effect is most likely?$q$,
    $q${"A":"More smoke in the air","B":"More soil erosion","C":"Less rainfall","D":"Less smoke in the air"}$q$::jsonb,
    $q$D$q$,
    $q$Avoiding open burning reduces smoke and airborne pollutants.$q$
  );
