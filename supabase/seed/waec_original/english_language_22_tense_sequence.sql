INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Tense and Sequence of Tenses$q$,
    $q$By the time the bus arrived, we ______ for nearly an hour.$q$,
    $q${"A":"wait","B":"have waited","C":"had waited","D":"will wait"}$q$::jsonb,
    $q$C$q$,
    $q$The waiting happened before another past event, so past perfect is appropriate.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Tense and Sequence of Tenses$q$,
    $q$She usually ______ to school by bicycle, but today she is walking.$q$,
    $q${"A":"rode","B":"is riding","C":"has ridden","D":"rides"}$q$::jsonb,
    $q$D$q$,
    $q$Usually signals a habitual action, expressed by the simple present rides.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Tense and Sequence of Tenses$q$,
    $q$If it rains this evening, we ______ the meeting indoors.$q$,
    $q${"A":"will hold","B":"held","C":"had held","D":"holded"}$q$::jsonb,
    $q$A$q$,
    $q$A real future condition takes present tense in the if-clause and will in the main clause.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Tense and Sequence of Tenses$q$,
    $q$When I entered, the students ______ their notes.$q$,
    $q${"A":"read","B":"were reading","C":"will read","D":"have read"}$q$::jsonb,
    $q$B$q$,
    $q$Past continuous describes an action in progress when another past action occurred.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Tense and Sequence of Tenses$q$,
    $q$He said that he ______ the letter the day before.$q$,
    $q${"A":"posts","B":"will post","C":"had posted","D":"is posting"}$q$::jsonb,
    $q$C$q$,
    $q$The posting occurred before the past act of speaking, so past perfect fits.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Tense and Sequence of Tenses$q$,
    $q$By next June, my sister ______ her training.$q$,
    $q${"A":"completed","B":"has completed","C":"was completing","D":"will have completed"}$q$::jsonb,
    $q$D$q$,
    $q$By a future deadline calls for the future perfect to show completion before then.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Tense and Sequence of Tenses$q$,
    $q$Listen! Someone ______ at the gate.$q$,
    $q${"A":"is knocking","B":"knocks","C":"knocked","D":"had knocked"}$q$::jsonb,
    $q$A$q$,
    $q$Listen points to an action happening now, so present continuous fits.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Tense and Sequence of Tenses$q$,
    $q$They ______ in this town since 2020.$q$,
    $q${"A":"lived","B":"have lived","C":"will live","D":"had lived"}$q$::jsonb,
    $q$B$q$,
    $q$Since 2020 describes a situation beginning in the past and continuing now; present perfect fits.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Tense and Sequence of Tenses$q$,
    $q$The match ______ before the lights went out.$q$,
    $q${"A":"ends","B":"will end","C":"had ended","D":"has ended"}$q$::jsonb,
    $q$C$q$,
    $q$The ending preceded another past event, so past perfect shows that order.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Tense and Sequence of Tenses$q$,
    $q$Every Saturday, the librarian ______ the reading room at nine.$q$,
    $q${"A":"opened","B":"is opening","C":"has opened","D":"opens"}$q$::jsonb,
    $q$D$q$,
    $q$Every Saturday expresses a regular habit, so use simple present.$q$
  );
