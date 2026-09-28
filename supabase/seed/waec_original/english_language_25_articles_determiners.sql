INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Articles and Determiners$q$,
    $q$She is ______ honest person who admits her mistakes.$q$,
    $q${"A":"an","B":"a","C":"the","D":"no article"}$q$::jsonb,
    $q$A$q$,
    $q$Honest begins with a vowel sound because h is silent, so use an.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Articles and Determiners$q$,
    $q$There is ______ water left in the bottle, enough for one glass.$q$,
    $q${"A":"a few","B":"a little","C":"many","D":"several"}$q$::jsonb,
    $q$B$q$,
    $q$Water is uncountable; a little means a small but useful amount.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Articles and Determiners$q$,
    $q$Only ______ students completed the optional challenge.$q$,
    $q${"A":"a little","B":"much","C":"a few","D":"any"}$q$::jsonb,
    $q$C$q$,
    $q$Students is a plural count noun, so a few fits.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Articles and Determiners$q$,
    $q$Please pass me ______ blue folder on the desk, not the red one.$q$,
    $q${"A":"a","B":"an","C":"no article","D":"the"}$q$::jsonb,
    $q$D$q$,
    $q$The identifies a specific folder singled out by its colour and location.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Articles and Determiners$q$,
    $q$We need ______ umbrella because it is raining.$q$,
    $q${"A":"an","B":"a","C":"the","D":"no article"}$q$::jsonb,
    $q$A$q$,
    $q$Umbrella begins with a vowel sound, so an is correct for an unspecified umbrella.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Articles and Determiners$q$,
    $q$______ of the two routes is shorter: the one by the river or the one by the market?$q$,
    $q${"A":"What","B":"Which","C":"Whose","D":"How much"}$q$::jsonb,
    $q$B$q$,
    $q$Which asks for a choice between stated alternatives.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Articles and Determiners$q$,
    $q$Every applicant must bring ______ identification document.$q$,
    $q${"A":"a","B":"the","C":"an","D":"no article"}$q$::jsonb,
    $q$C$q$,
    $q$Identification begins with a vowel sound, and an introduces any one such document.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Articles and Determiners$q$,
    $q$I have read ______ books you lent me, so I can return them all.$q$,
    $q${"A":"much","B":"a little","C":"each of","D":"all the"}$q$::jsonb,
    $q$D$q$,
    $q$All the refers to the whole known plural set of books.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Articles and Determiners$q$,
    $q$There isn't ______ sugar in the jar.$q$,
    $q${"A":"much","B":"many","C":"a few","D":"several"}$q$::jsonb,
    $q$A$q$,
    $q$Sugar is uncountable, so much is appropriate in this negative sentence.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Articles and Determiners$q$,
    $q$______ student in this class has a timetable.$q$,
    $q${"A":"Much","B":"Each","C":"Few","D":"Several"}$q$::jsonb,
    $q$B$q$,
    $q$Each takes a singular noun and expresses that every student individually has one.$q$
  );
