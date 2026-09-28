INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Human Internal Body Systems and Function$q$,
    $q$After a meal, nutrients pass from the small intestine into the blood. This process is called what?$q$,
    $q${"A":"Absorption","B":"Exhalation","C":"Circulation","D":"Perspiration"}$q$::jsonb,
    $q$A$q$,
    $q$Absorption moves digested nutrients through the intestinal wall into the bloodstream.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Human Internal Body Systems and Function$q$,
    $q$The lungs exchange gases with the blood. Which gas normally enters the blood there?$q$,
    $q${"A":"Nitrogen as food","B":"Oxygen","C":"Carbon dioxide from the air as waste","D":"Water vapour only"}$q$::jsonb,
    $q$B$q$,
    $q$Oxygen moves from inhaled air into the blood at the lungs.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Human Internal Body Systems and Function$q$,
    $q$Blood carries nutrients from the digestive system to body tissues. Which system circulates the blood?$q$,
    $q${"A":"The skeletal system","B":"The urinary system","C":"The circulatory system","D":"The sensory system"}$q$::jsonb,
    $q$C$q$,
    $q$The circulatory system moves blood through the heart and blood vessels.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Human Internal Body Systems and Function$q$,
    $q$The kidneys remove dissolved wastes from the blood and produce what?$q$,
    $q${"A":"Bile","B":"Saliva","C":"Mucus","D":"Urine"}$q$::jsonb,
    $q$D$q$,
    $q$The kidneys filter blood and form urine containing dissolved wastes.$q$
  );
