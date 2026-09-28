INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Religion$q$,
    $q$Members of different faiths meet to discuss shared concerns respectfully. This is an example of what?$q$,
    $q${"A":"Interfaith dialogue","B":"Pilgrimage","C":"Fasting","D":"Ordination"}$q$::jsonb,
    $q$A$q$,
    $q$Interfaith dialogue is discussion between people of different religious traditions.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Religion$q$,
    $q$A congregation collects donations to support families after a flood. This action is an act of what?$q$,
    $q${"A":"Ceremony","B":"Charity","C":"Competition","D":"Conversion"}$q$::jsonb,
    $q$B$q$,
    $q$Charity involves giving help to people in need.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Religion$q$,
    $q$A person travels to a place regarded as sacred by their faith. The journey is a what?$q$,
    $q${"A":"Migration","B":"Inspection","C":"Pilgrimage","D":"Commute"}$q$::jsonb,
    $q$C$q$,
    $q$A pilgrimage is a journey made for religious reasons to a sacred place.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Religion$q$,
    $q$A speaker asks listeners to allow neighbours to worship differently without hostility. The quality urged is what?$q$,
    $q${"A":"Rivalry","B":"Secrecy","C":"Indifference","D":"Tolerance"}$q$::jsonb,
    $q$D$q$,
    $q$Tolerance means respecting others' right to hold different beliefs.$q$
  );
