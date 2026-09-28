INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Degrees of Comparison$q$,
    $q$Of the three routes, the river path is the ______.$q$,
    $q${"A":"shorter","B":"short","C":"shortest","D":"more short"}$q$::jsonb,
    $q$C$q$,
    $q$With three routes, the superlative shortest identifies one extreme.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Degrees of Comparison$q$,
    $q$This suitcase is ______ than the one I carried yesterday.$q$,
    $q${"A":"heaviest","B":"heavy","C":"most heavy","D":"heavier"}$q$::jsonb,
    $q$D$q$,
    $q$Than calls for the comparative form heavier.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Degrees of Comparison$q$,
    $q$The second explanation was ______ than the first.$q$,
    $q${"A":"clearer","B":"clearest","C":"clear","D":"most clear"}$q$::jsonb,
    $q$A$q$,
    $q$A comparison of two explanations takes the comparative clearer.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Degrees of Comparison$q$,
    $q$Of all the applicants, Nura arrived the ______.$q$,
    $q${"A":"earlier","B":"earliest","C":"early","D":"more early"}$q$::jsonb,
    $q$B$q$,
    $q$Among all applicants, the superlative earliest is required.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Degrees of Comparison$q$,
    $q$This problem is ______ difficult than the previous one.$q$,
    $q${"A":"least","B":"little","C":"less","D":"few"}$q$::jsonb,
    $q$C$q$,
    $q$Less is the comparative used before an adjective to compare two things.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Degrees of Comparison$q$,
    $q$The library is ______ than the corridor during break time.$q$,
    $q${"A":"quietest","B":"quiet","C":"most quiet","D":"quieter"}$q$::jsonb,
    $q$D$q$,
    $q$Than calls for the comparative form quieter.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Degrees of Comparison$q$,
    $q$Among the four proposals, this is the ______ practical.$q$,
    $q${"A":"most","B":"more","C":"much","D":"many"}$q$::jsonb,
    $q$A$q$,
    $q$Among four proposals, the superlative most practical is needed.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Degrees of Comparison$q$,
    $q$Tomi answered ______ carefully than she had on the first attempt.$q$,
    $q${"A":"most","B":"more","C":"much","D":"many"}$q$::jsonb,
    $q$B$q$,
    $q$More carefully is the comparative form of the adverb carefully.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Degrees of Comparison$q$,
    $q$The blue ribbon is as long ______ the red ribbon.$q$,
    $q${"A":"than","B":"like","C":"as","D":"from"}$q$::jsonb,
    $q$C$q$,
    $q$The equality pattern is as ... as.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Degrees of Comparison$q$,
    $q$Of the two candidates, Zainab has the ______ score.$q$,
    $q${"A":"highest","B":"high","C":"most high","D":"higher"}$q$::jsonb,
    $q$D$q$,
    $q$When comparing exactly two candidates, higher is the comparative form.$q$
  );
