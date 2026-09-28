INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Health$q$,
    $q$A nurse asks a patient to take the full prescribed course even after symptoms improve. Why?$q$,
    $q${"A":"To complete the treatment properly","B":"To make the tablets expire sooner","C":"To replace a balanced diet","D":"To avoid reading the label"}$q$::jsonb,
    $q$A$q$,
    $q$Completing a prescribed course supports the treatment plan; stopping early may undermine it.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Health$q$,
    $q$Before a minor operation, the nurse uses a sterile instrument. What does sterile mean here?$q$,
    $q${"A":"Made only of metal","B":"Free from living microorganisms","C":"Pain-free to use","D":"Stored in cold water"}$q$::jsonb,
    $q$B$q$,
    $q$Sterile equipment has been treated to remove viable microorganisms.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Health$q$,
    $q$A clinic separates a person with a contagious illness from other patients. This is called what?$q$,
    $q${"A":"Vaccination","B":"Diagnosis","C":"Isolation","D":"Rehabilitation"}$q$::jsonb,
    $q$C$q$,
    $q$Isolation keeps an infectious patient apart to reduce transmission.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Health$q$,
    $q$A doctor measures the number of heartbeats per minute. Which measurement is this?$q$,
    $q${"A":"Body mass","B":"Blood group","C":"Lung capacity","D":"Pulse rate"}$q$::jsonb,
    $q$D$q$,
    $q$Pulse rate is the count of heartbeats per minute.$q$
  );
