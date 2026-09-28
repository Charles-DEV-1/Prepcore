INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Prepositions$q$,
    $q$The students were praised ______ their careful work.$q$,
    $q${"A":"at","B":"by","C":"for","D":"with"}$q$::jsonb,
    $q$C$q$,
    $q$Praise someone for an achievement or quality.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Prepositions$q$,
    $q$She has been interested ______ astronomy since childhood.$q$,
    $q${"A":"on","B":"at","C":"for","D":"in"}$q$::jsonb,
    $q$D$q$,
    $q$The adjective interested is followed by in before the subject of interest.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Prepositions$q$,
    $q$The parcel was delivered ______ the office before noon.$q$,
    $q${"A":"to","B":"for","C":"from","D":"by"}$q$::jsonb,
    $q$A$q$,
    $q$Deliver to identifies the destination of the parcel.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Prepositions$q$,
    $q$We arrived ______ the station just before the train left.$q$,
    $q${"A":"in","B":"at","C":"on","D":"by"}$q$::jsonb,
    $q$B$q$,
    $q$Arrive at is used for a specific place such as a station.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Prepositions$q$,
    $q$The children walked ______ the bridge to reach the other side.$q$,
    $q${"A":"among","B":"beside","C":"across","D":"within"}$q$::jsonb,
    $q$C$q$,
    $q$Across expresses movement from one side to the other.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Prepositions$q$,
    $q$The club divided the tasks ______ its four members.$q$,
    $q${"A":"between","B":"into","C":"onto","D":"among"}$q$::jsonb,
    $q$D$q$,
    $q$Among is used for distribution within a group of four members.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Prepositions$q$,
    $q$She apologized ______ the mistake in the timetable.$q$,
    $q${"A":"for","B":"to","C":"with","D":"by"}$q$::jsonb,
    $q$A$q$,
    $q$Apologize for introduces the action or fault.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Prepositions$q$,
    $q$The mechanic replaced the damaged belt ______ a new one.$q$,
    $q${"A":"by","B":"with","C":"from","D":"of"}$q$::jsonb,
    $q$B$q$,
    $q$Replace something with another thing is the normal construction.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Prepositions$q$,
    $q$The principal congratulated the team ______ its victory.$q$,
    $q${"A":"for","B":"at","C":"on","D":"with"}$q$::jsonb,
    $q$C$q$,
    $q$Congratulate someone on an achievement is the standard pattern.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Prepositions$q$,
    $q$The path runs ______ the river for two kilometres.$q$,
    $q${"A":"through","B":"under","C":"across","D":"along"}$q$::jsonb,
    $q$D$q$,
    $q$Along means following the length or course of something.$q$
  );
