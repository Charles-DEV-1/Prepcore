INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Antonyms and Homonyms in Context$q$,
    $q$The instructions were explicit, not ______. Which word completes the contrast?$q$,
    $q${"A":"Vague","B":"Clear","C":"Detailed","D":"Direct"}$q$::jsonb,
    $q$A$q$,
    $q$Explicit means clearly stated; vague means unclear.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Antonyms and Homonyms in Context$q$,
    $q$The medicine's effect was temporary rather than ______. Which word completes the contrast?$q$,
    $q${"A":"Mild","B":"Permanent","C":"Rapid","D":"Useful"}$q$::jsonb,
    $q$B$q$,
    $q$Temporary and permanent contrast in duration.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Antonyms and Homonyms in Context$q$,
    $q$The judge described the evidence as relevant, not ______. Which word completes the contrast?$q$,
    $q${"A":"Reliable","B":"Complete","C":"Irrelevant","D":"Recent"}$q$::jsonb,
    $q$C$q$,
    $q$Relevant evidence bears on the matter; irrelevant evidence does not.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Antonyms and Homonyms in Context$q$,
    $q$The road was passable after repairs, but it had been ______ during the flood. Which word fits?$q$,
    $q${"A":"Accessible","B":"Open","C":"Smooth","D":"Impassable"}$q$::jsonb,
    $q$D$q$,
    $q$Impassable means impossible to travel along.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Antonyms and Homonyms in Context$q$,
    $q$The tailor will ______ the torn sleeve before the ceremony. Which spelling means 'fix'?$q$,
    $q${"A":"Mend","B":"Mind","C":"Mined","D":"Meant"}$q$::jsonb,
    $q$A$q$,
    $q$Mend means repair; the other spellings have different meanings.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Antonyms and Homonyms in Context$q$,
    $q$The students were asked to remain ______ while the announcement was read. Which spelling means 'not moving'?$q$,
    $q${"A":"Stationery","B":"Stationary","C":"Statuary","D":"Sanitary"}$q$::jsonb,
    $q$B$q$,
    $q$Stationary means not moving; stationery refers to writing materials.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Antonyms and Homonyms in Context$q$,
    $q$The boat's ______ tore in the wind. Which spelling names the cloth that catches wind?$q$,
    $q${"A":"Sale","B":"Seal","C":"Sail","D":"Sole"}$q$::jsonb,
    $q$C$q$,
    $q$A sail is the cloth used to catch wind and propel a boat.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Antonyms and Homonyms in Context$q$,
    $q$The manager asked for a ______ of the report, not the original. Which spelling is correct?$q$,
    $q${"A":"Copie","B":"Coffee","C":"Coppy","D":"Copy"}$q$::jsonb,
    $q$D$q$,
    $q$A copy is a reproduction of an original document.$q$
  );
