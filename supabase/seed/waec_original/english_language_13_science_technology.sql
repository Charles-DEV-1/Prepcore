INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Science and Technology$q$,
    $q$A student repeats an experiment several times to check whether the result is consistent. She is testing its what?$q$,
    $q${"A":"Reliability","B":"Colour","C":"Cost","D":"Ownership"}$q$::jsonb,
    $q$A$q$,
    $q$Repeated trials help show whether a result is reliable.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Science and Technology$q$,
    $q$A phone stores copies of files on a remote server so they can be restored later. What are the copies called?$q$,
    $q${"A":"Passwords","B":"Backups","C":"Viruses","D":"Browsers"}$q$::jsonb,
    $q$B$q$,
    $q$Backups are duplicate data kept for recovery.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Science and Technology$q$,
    $q$A solar panel changes sunlight into useful electrical energy. It is a form of what?$q$,
    $q${"A":"Data compression","B":"Water filtration","C":"Energy conversion","D":"Heat insulation"}$q$::jsonb,
    $q$C$q$,
    $q$A solar panel converts light energy into electrical energy.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Science and Technology$q$,
    $q$A researcher changes one factor while keeping the others the same. The changed factor is the what?$q$,
    $q${"A":"Conclusion","B":"Control group","C":"Measurement error","D":"Independent variable"}$q$::jsonb,
    $q$D$q$,
    $q$The independent variable is the factor deliberately altered in a test.$q$
  );
