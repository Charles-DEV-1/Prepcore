INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Figurative Usage$q$,
    $q$After the announcement, a wave of relief swept through the room. What does wave suggest?$q$,
    $q${"A":"Water entered the room","B":"People began swimming","C":"A feeling shared by many people","D":"The room shook physically"}$q$::jsonb,
    $q$C$q$,
    $q$Wave describes the sudden spread of a feeling, not literal water.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Figurative Usage$q$,
    $q$The market was a beehive of activity before the festival. What does the comparison suggest?$q$,
    $q${"A":"It contained insects","B":"It was unusually quiet","C":"It had no traders","D":"It was very busy"}$q$::jsonb,
    $q$D$q$,
    $q$Calling the market a beehive figuratively suggests constant busy movement.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Figurative Usage$q$,
    $q$The news planted a seed of doubt in Musa's mind. What happened?$q$,
    $q${"A":"He began to feel uncertain","B":"A plant grew in his head","C":"He forgot the news","D":"He became certain"}$q$::jsonb,
    $q$A$q$,
    $q$A seed of doubt means the beginning of uncertainty.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Figurative Usage$q$,
    $q$The speaker's words lit a fire under the volunteers. What did they do?$q$,
    $q${"A":"Caused a real fire","B":"Motivated them to act","C":"Made them leave angrily","D":"Put them to sleep"}$q$::jsonb,
    $q$B$q$,
    $q$Lighting a fire under someone figuratively means prompting energetic action.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Figurative Usage$q$,
    $q$The old classroom walls have heard many stories. Which device gives walls a human ability?$q$,
    $q${"A":"A timetable","B":"A direct definition","C":"Personification","D":"A factual measurement"}$q$::jsonb,
    $q$C$q$,
    $q$Personification attributes a human action, hearing, to walls.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Figurative Usage$q$,
    $q$When the boy said he had a mountain of homework, he meant what?$q$,
    $q${"A":"He studied geography only","B":"His books were on a hill","C":"The homework was impossible to count","D":"He had a very large amount"}$q$::jsonb,
    $q$D$q$,
    $q$Mountain is a figurative exaggeration of quantity.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Figurative Usage$q$,
    $q$Her explanation was a clear window into the problem. What does window suggest?$q$,
    $q${"A":"It made the problem easier to understand","B":"It was written on glass","C":"The problem happened outdoors","D":"It hid the facts"}$q$::jsonb,
    $q$A$q$,
    $q$A window figuratively gives a clear view or understanding.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Figurative Usage$q$,
    $q$The city never sleeps during the festival. What does this suggest?$q$,
    $q${"A":"No resident ever rests","B":"Activity continues through the night","C":"Every shop is open all year","D":"Only children are awake"}$q$::jsonb,
    $q$B$q$,
    $q$The city is personified to emphasize continuous activity.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Figurative Usage$q$,
    $q$The argument left a bitter taste in both friends' mouths. What is conveyed?$q$,
    $q${"A":"A meal was badly cooked","B":"They had eaten medicine","C":"Lingering unpleasant feelings","D":"Their voices became quieter"}$q$::jsonb,
    $q$C$q$,
    $q$Bitter taste figuratively represents a lasting unpleasant feeling.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Figurative Usage$q$,
    $q$Her kindness was a bridge between the two families. What does bridge mean here?$q$,
    $q${"A":"She built a road crossing","B":"The families lived by a river","C":"She carried them across water","D":"It helped bring them together"}$q$::jsonb,
    $q$D$q$,
    $q$Bridge figuratively describes something that connects people.$q$
  );
