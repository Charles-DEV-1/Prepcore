INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Idioms and Collocations$q$,
    $q$After weeks of avoiding the issue, the committee finally faced the music. What did it do?$q$,
    $q${"A":"Accepted the consequences","B":"Held a concert","C":"Ignored the problem","D":"Bought instruments"}$q$::jsonb,
    $q$A$q$,
    $q$To face the music is to confront an unpleasant consequence.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Idioms and Collocations$q$,
    $q$The coach told the team not to throw in the towel after one defeat. What was the advice?$q$,
    $q${"A":"Do not wash uniforms","B":"Do not give up","C":"Stop training immediately","D":"Change the match venue"}$q$::jsonb,
    $q$B$q$,
    $q$To throw in the towel means to surrender or give up.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Idioms and Collocations$q$,
    $q$Ada kept her promise even when it became inconvenient. Which expression fits?$q$,
    $q${"A":"She lost her voice","B":"She spoke out of turn","C":"She kept her word","D":"She changed her tune"}$q$::jsonb,
    $q$C$q$,
    $q$To keep one's word is to do what one promised.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Idioms and Collocations$q$,
    $q$The examiner asked us to ______ attention to every instruction. Which verb forms the natural collocation?$q$,
    $q${"A":"Give","B":"Spend","C":"Make","D":"Pay"}$q$::jsonb,
    $q$D$q$,
    $q$The established collocation is pay attention.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Idioms and Collocations$q$,
    $q$We should ______ a decision before the deadline. Which verb forms the natural collocation?$q$,
    $q${"A":"Make","B":"Do","C":"Take up","D":"Build"}$q$::jsonb,
    $q$A$q$,
    $q$English uses make a decision.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Idioms and Collocations$q$,
    $q$The report said the plan was still up in the air. What does that mean?$q$,
    $q${"A":"It had been announced","B":"It had not been settled","C":"It involved aviation","D":"It was written outdoors"}$q$::jsonb,
    $q$B$q$,
    $q$Something up in the air remains undecided.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Idioms and Collocations$q$,
    $q$The new pupil broke the ice by introducing herself to everyone. What did she do?$q$,
    $q${"A":"Damaged the classroom","B":"Ended the lesson","C":"Eased the initial awkwardness","D":"Made a loud noise"}$q$::jsonb,
    $q$C$q$,
    $q$To break the ice is to help people feel more comfortable at the start.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Idioms and Collocations$q$,
    $q$The contractor was asked to ______ responsibility for the error. Which word fits the collocation?$q$,
    $q${"A":"Make","B":"Draw","C":"Place","D":"Take"}$q$::jsonb,
    $q$D$q$,
    $q$The natural phrase is take responsibility.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Idioms and Collocations$q$,
    $q$The volunteer went the extra mile to help the visitors. What does this mean?$q$,
    $q${"A":"She did more than was required","B":"She walked exactly one mile","C":"She arrived late","D":"She refused assistance"}$q$::jsonb,
    $q$A$q$,
    $q$To go the extra mile means to make an effort beyond the minimum.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Idioms and Collocations$q$,
    $q$The principal said the missing books would be dealt with in due course. When?$q$,
    $q${"A":"Before the speech began","B":"At the appropriate time","C":"Only after many years","D":"Never"}$q$::jsonb,
    $q$B$q$,
    $q$In due course means at a suitable time in the normal sequence of events.$q$
  );
