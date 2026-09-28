INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Conjunctions and Connectives$q$,
    $q$We stayed inside ______ the rain had become heavy.$q$,
    $q${"A":"although","B":"unless","C":"because","D":"until"}$q$::jsonb,
    $q$C$q$,
    $q$Because introduces the reason for staying inside.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Conjunctions and Connectives$q$,
    $q$______ she was tired, she finished the assignment.$q$,
    $q${"A":"Because","B":"Unless","C":"So","D":"Although"}$q$::jsonb,
    $q$D$q$,
    $q$Although introduces a contrast between tiredness and finishing.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Conjunctions and Connectives$q$,
    $q$You may borrow the book ______ you return it by Friday.$q$,
    $q${"A":"provided that","B":"even though","C":"because","D":"whereas"}$q$::jsonb,
    $q$A$q$,
    $q$Provided that introduces a condition.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Conjunctions and Connectives$q$,
    $q$The road was flooded; ______, the bus took another route.$q$,
    $q${"A":"however","B":"therefore","C":"meanwhile","D":"otherwise"}$q$::jsonb,
    $q$B$q$,
    $q$Therefore shows that the change of route was a result of the flood.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Conjunctions and Connectives$q$,
    $q$The first candidate spoke clearly, ______ the second spoke too softly.$q$,
    $q${"A":"because","B":"unless","C":"whereas","D":"so that"}$q$::jsonb,
    $q$C$q$,
    $q$Whereas contrasts the two candidates' manner of speaking.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Conjunctions and Connectives$q$,
    $q$We packed early ______ we would not miss the bus.$q$,
    $q${"A":"although","B":"because","C":"unless","D":"so that"}$q$::jsonb,
    $q$D$q$,
    $q$So that introduces the purpose of packing early.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Conjunctions and Connectives$q$,
    $q$The pupils waited ______ the bell rang.$q$,
    $q${"A":"until","B":"although","C":"unless","D":"because"}$q$::jsonb,
    $q$A$q$,
    $q$Until marks the point at which the waiting ended.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Conjunctions and Connectives$q$,
    $q$Bring both your pen ______ your ruler to the test.$q$,
    $q${"A":"or","B":"and","C":"but","D":"nor"}$q$::jsonb,
    $q$B$q$,
    $q$Both pairs with and to join the two required items.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Conjunctions and Connectives$q$,
    $q$The plan is affordable; ______, it will save time.$q$,
    $q${"A":"nevertheless","B":"otherwise","C":"moreover","D":"instead"}$q$::jsonb,
    $q$C$q$,
    $q$Moreover adds another supporting advantage.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Conjunctions and Connectives$q$,
    $q$He waited in the office ______ the manager arrived, and only then did they begin the meeting.$q$,
    $q${"A":"although","B":"because","C":"whereas","D":"until"}$q$::jsonb,
    $q$D$q$,
    $q$Until marks the end of the waiting, which is the manager's arrival.$q$
  );
