INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Subject-Verb Agreement$q$,
    $q$Neither of the two bags ______ large enough for the books.$q$,
    $q${"A":"is","B":"are","C":"were","D":"have"}$q$::jsonb,
    $q$A$q$,
    $q$Neither is singular here, so it takes is.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Subject-Verb Agreement$q$,
    $q$The list of approved candidates ______ on the noticeboard.$q$,
    $q${"A":"are","B":"is","C":"have","D":"were"}$q$::jsonb,
    $q$B$q$,
    $q$The subject is list, not candidates, so the singular verb is is.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Subject-Verb Agreement$q$,
    $q$Each of the players ______ a numbered shirt.$q$,
    $q${"A":"have","B":"were","C":"has","D":"are"}$q$::jsonb,
    $q$C$q$,
    $q$Each is singular and therefore takes has.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Subject-Verb Agreement$q$,
    $q$The scissors ______ in the top drawer.$q$,
    $q${"A":"is","B":"was","C":"has","D":"are"}$q$::jsonb,
    $q$D$q$,
    $q$Scissors is treated as plural in ordinary usage, so it takes are.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Subject-Verb Agreement$q$,
    $q$Ten minutes ______ enough time for this short test.$q$,
    $q${"A":"is","B":"are","C":"were","D":"have"}$q$::jsonb,
    $q$A$q$,
    $q$A single period of ten minutes is treated as one amount, so is is appropriate.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Subject-Verb Agreement$q$,
    $q$Either the teacher or the pupils ______ responsible for arranging the chairs.$q$,
    $q${"A":"is","B":"are","C":"has","D":"was"}$q$::jsonb,
    $q$B$q$,
    $q$With either ... or, the plural noun nearest the verb, pupils, determines are.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Subject-Verb Agreement$q$,
    $q$Neither the players nor the captain ______ available today.$q$,
    $q${"A":"are","B":"were","C":"is","D":"have"}$q$::jsonb,
    $q$C$q$,
    $q$With neither ... nor, the nearest subject captain is singular, so use is.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Subject-Verb Agreement$q$,
    $q$A number of visitors ______ waiting outside the hall.$q$,
    $q${"A":"is","B":"was","C":"has","D":"are"}$q$::jsonb,
    $q$D$q$,
    $q$A number of means several and takes a plural verb.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Subject-Verb Agreement$q$,
    $q$The number of visitors ______ increasing each week.$q$,
    $q${"A":"is","B":"are","C":"were","D":"have"}$q$::jsonb,
    $q$A$q$,
    $q$The number refers to one total and takes a singular verb.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Subject-Verb Agreement$q$,
    $q$My brother, together with his friends, ______ coming later.$q$,
    $q${"A":"are","B":"is","C":"were","D":"have"}$q$::jsonb,
    $q$B$q$,
    $q$The main subject is brother; the added phrase does not make it plural.$q$
  );
