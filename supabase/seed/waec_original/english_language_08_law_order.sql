INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Law and Order$q$,
    $q$A person accused of a crime is brought before a court. Until guilt is proved, that person is a what?$q$,
    $q${"A":"Defendant","B":"Convict","C":"Witness for the prosecution","D":"Juror"}$q$::jsonb,
    $q$A$q$,
    $q$A defendant faces a charge in court; a convict has already been found guilty.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Law and Order$q$,
    $q$Two neighbours ask a neutral person to help settle their dispute without a trial. This is called what?$q$,
    $q${"A":"Prosecution","B":"Mediation","C":"Arrest","D":"Sentencing"}$q$::jsonb,
    $q$B$q$,
    $q$Mediation uses an impartial third party to help disputants reach agreement.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Law and Order$q$,
    $q$A court orders a person to pay money for damage caused to another person's property. The money is called what?$q$,
    $q${"A":"Bail","B":"A warrant","C":"Compensation","D":"A summons"}$q$::jsonb,
    $q$C$q$,
    $q$Compensation is money awarded to make up for loss or injury.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Law and Order$q$,
    $q$A witness promises to tell the truth before giving evidence. The formal promise is an what?$q$,
    $q${"A":"Appeal","B":"Acquittal","C":"Injunction","D":"Oath"}$q$::jsonb,
    $q$D$q$,
    $q$An oath is a formal promise, often made before testimony.$q$
  );
