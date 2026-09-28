INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Fishing$q$,
    $q$A fisher catches very young fish and returns them to the water. What is the main purpose?$q$,
    $q${"A":"To allow them to grow and reproduce","B":"To increase the net's weight","C":"To reduce water temperature","D":"To attract birds"}$q$::jsonb,
    $q$A$q$,
    $q$Returning immature fish helps maintain future fish populations.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Fishing$q$,
    $q$A fishing boat needs to know the depth of water beneath it. Which instrument is most relevant?$q$,
    $q${"A":"A thermometer","B":"An echo sounder","C":"A barometer","D":"A compass"}$q$::jsonb,
    $q$B$q$,
    $q$An echo sounder estimates water depth using reflected sound.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Fishing$q$,
    $q$Fish are kept on ice immediately after landing. Why?$q$,
    $q${"A":"To increase their size","B":"To remove their bones","C":"To slow spoilage","D":"To make them saltier"}$q$::jsonb,
    $q$C$q$,
    $q$Cooling slows the growth of microorganisms and delays spoilage.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Fishing$q$,
    $q$A large net is dragged through the water behind a boat. The method is called what?$q$,
    $q${"A":"Angling","B":"Spearing","C":"Hatching","D":"Trawling"}$q$::jsonb,
    $q$D$q$,
    $q$Trawling involves towing a net through water to catch fish.$q$
  );
