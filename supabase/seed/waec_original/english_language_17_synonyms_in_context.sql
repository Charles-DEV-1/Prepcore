INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Synonyms in Context$q$,
    $q$The teacher asked for a concise explanation of the result. Which word best replaces concise?$q$,
    $q${"A":"Brief","B":"Vague","C":"Formal","D":"Difficult"}$q$::jsonb,
    $q$A$q$,
    $q$Concise means expressing the necessary information in few words.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Synonyms in Context$q$,
    $q$The committee postponed the meeting because several members were absent. Which word can replace postponed?$q$,
    $q${"A":"Concluded","B":"Deferred","C":"Recorded","D":"Announced"}$q$::jsonb,
    $q$B$q$,
    $q$To defer a meeting is to move it to a later time.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Synonyms in Context$q$,
    $q$The nurse spoke gently to the anxious patient. Which word is closest to anxious here?$q$,
    $q${"A":"Sleepy","B":"Angry","C":"Worried","D":"Curious"}$q$::jsonb,
    $q$C$q$,
    $q$An anxious patient is worried or uneasy.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Synonyms in Context$q$,
    $q$The bridge remained intact after the storm. Which word best replaces intact?$q$,
    $q${"A":"Crowded","B":"Unfinished","C":"Invisible","D":"Undamaged"}$q$::jsonb,
    $q$D$q$,
    $q$Intact means whole and not damaged.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Synonyms in Context$q$,
    $q$The scientist's findings were consistent across three trials. Which word best replaces consistent?$q$,
    $q${"A":"Similar","B":"Random","C":"Secret","D":"Unexpected"}$q$::jsonb,
    $q$A$q$,
    $q$Results that are consistent agree closely across repeated trials.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Synonyms in Context$q$,
    $q$The council took immediate action after the complaint. Which word best replaces immediate?$q$,
    $q${"A":"Severe","B":"Prompt","C":"Temporary","D":"Public"}$q$::jsonb,
    $q$B$q$,
    $q$Immediate action is prompt action taken without delay.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Synonyms in Context$q$,
    $q$The witness gave a credible account of the event. Which word best replaces credible?$q$,
    $q${"A":"Detailed","B":"Lengthy","C":"Believable","D":"Emotional"}$q$::jsonb,
    $q$C$q$,
    $q$A credible account is one that can reasonably be believed.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Synonyms in Context$q$,
    $q$The path was narrow, so the cyclists rode one behind another. Which word best replaces narrow?$q$,
    $q${"A":"Rough","B":"Steep","C":"Long","D":"Slim"}$q$::jsonb,
    $q$D$q$,
    $q$Narrow means having little width; the path's limited width explains the single-file movement.$q$
  );
