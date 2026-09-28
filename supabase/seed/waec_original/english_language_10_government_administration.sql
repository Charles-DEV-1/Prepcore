INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Government and Administration$q$,
    $q$Residents send a written request for streetlights to their local council. The document is a what?$q$,
    $q${"A":"Petition","B":"Receipt","C":"Licence","D":"Ballot"}$q$::jsonb,
    $q$A$q$,
    $q$A petition is a formal written request, often signed by several people.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Government and Administration$q$,
    $q$A ministry publishes how much it plans to spend next year. The plan is its what?$q$,
    $q${"A":"Constitution","B":"Budget","C":"Manifesto","D":"Census"}$q$::jsonb,
    $q$B$q$,
    $q$A budget sets out planned income and expenditure.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Government and Administration$q$,
    $q$Citizens vote to choose representatives for the council. This process is an what?$q$,
    $q${"A":"Appointment","B":"Audit","C":"Election","D":"Inquiry"}$q$::jsonb,
    $q$C$q$,
    $q$An election uses votes to select representatives.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Government and Administration$q$,
    $q$A clerk records decisions reached at a committee meeting. The written record is called what?$q$,
    $q${"A":"Credentials","B":"Statutes","C":"Ballots","D":"Minutes"}$q$::jsonb,
    $q$D$q$,
    $q$Minutes record a meeting's proceedings and decisions.$q$
  );
