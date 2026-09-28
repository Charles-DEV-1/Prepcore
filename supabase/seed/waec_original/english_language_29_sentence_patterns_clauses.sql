INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Sentence Patterns and Clauses$q$,
    $q$The girl who won the debate thanked her coach. Which words identify the girl?$q$,
    $q${"A":"who won the debate","B":"thanked her coach","C":"the girl thanked","D":"her coach"}$q$::jsonb,
    $q$A$q$,
    $q$Who won the debate is a relative clause modifying the girl.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Sentence Patterns and Clauses$q$,
    $q$She gave the librarian a note. Which part names the person receiving the note?$q$,
    $q${"A":"She","B":"the librarian","C":"a note","D":"gave"}$q$::jsonb,
    $q$B$q$,
    $q$The librarian is the indirect object, the recipient of the note.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Sentence Patterns and Clauses$q$,
    $q$We stayed home because the storm was severe. Which clause gives the reason?$q$,
    $q${"A":"We stayed home","B":"the storm","C":"because the storm was severe","D":"was severe"}$q$::jsonb,
    $q$C$q$,
    $q$The because-clause explains why the speakers stayed home.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Sentence Patterns and Clauses$q$,
    $q$The students painted the classroom walls. What is the direct object?$q$,
    $q${"A":"The students","B":"painted","C":"classroom","D":"the classroom walls"}$q$::jsonb,
    $q$D$q$,
    $q$The classroom walls receive the action of painting.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Sentence Patterns and Clauses$q$,
    $q$Although the road was rough, the journey was short. Which clause can stand alone?$q$,
    $q${"A":"the journey was short","B":"Although the road was rough","C":"Although the road","D":"was rough"}$q$::jsonb,
    $q$A$q$,
    $q$The journey was short is an independent clause with a complete meaning.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Sentence Patterns and Clauses$q$,
    $q$The boy in the red shirt is my cousin. Which phrase describes the boy?$q$,
    $q${"A":"is my cousin","B":"in the red shirt","C":"the boy is","D":"my cousin"}$q$::jsonb,
    $q$B$q$,
    $q$In the red shirt is a prepositional phrase modifying boy.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Sentence Patterns and Clauses$q$,
    $q$The teacher asked the pupils to sit down. Which word is the subject of the sentence?$q$,
    $q${"A":"pupils","B":"sit","C":"teacher","D":"down"}$q$::jsonb,
    $q$C$q$,
    $q$Teacher is the head of the subject noun phrase The teacher.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Sentence Patterns and Clauses$q$,
    $q$We left after the meeting ended. Which clause tells when we left?$q$,
    $q${"A":"We left","B":"the meeting","C":"ended","D":"after the meeting ended"}$q$::jsonb,
    $q$D$q$,
    $q$The after-clause is an adverbial clause of time.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Sentence Patterns and Clauses$q$,
    $q$The keys are on the desk. Which words form the predicate?$q$,
    $q${"A":"are on the desk","B":"The keys","C":"on the desk","D":"the desk"}$q$::jsonb,
    $q$A$q$,
    $q$The predicate says something about the subject, The keys.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Sentence Patterns and Clauses$q$,
    $q$I know that the shop closes at six. Which clause is the object of know?$q$,
    $q${"A":"I know","B":"that the shop closes at six","C":"the shop closes","D":"at six"}$q$::jsonb,
    $q$B$q$,
    $q$The that-clause states what is known and acts as the object of know.$q$
  );
