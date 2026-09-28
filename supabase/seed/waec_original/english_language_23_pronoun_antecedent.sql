INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Pronouns and Antecedents$q$,
    $q$Chika lost ______ notebook, so she borrowed another one.$q$,
    $q${"A":"her","B":"his","C":"their","D":"its"}$q$::jsonb,
    $q$A$q$,
    $q$The singular female antecedent Chika is referred to by her.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Pronouns and Antecedents$q$,
    $q$The committee submitted ______ report after its final meeting.$q$,
    $q${"A":"it","B":"its","C":"his","D":"our"}$q$::jsonb,
    $q$B$q$,
    $q$Committee is treated here as one body, so its refers to its report.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Pronouns and Antecedents$q$,
    $q$Bola and I completed the project by ______.$q$,
    $q${"A":"themselves","B":"myself","C":"ourselves","D":"yourself"}$q$::jsonb,
    $q$C$q$,
    $q$The reflexive pronoun for Bola and I is ourselves.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Pronouns and Antecedents$q$,
    $q$The students ______ won the prize thanked their teacher.$q$,
    $q${"A":"which","B":"whose","C":"whom","D":"who"}$q$::jsonb,
    $q$D$q$,
    $q$Who is the subject of won and refers to people.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Pronouns and Antecedents$q$,
    $q$This is the author ______ book won the award.$q$,
    $q${"A":"whose","B":"who","C":"whom","D":"which"}$q$::jsonb,
    $q$A$q$,
    $q$Whose indicates that the book belongs to the author.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Pronouns and Antecedents$q$,
    $q$The manager spoke to Tolu and ______ after the meeting.$q$,
    $q${"A":"I","B":"me","C":"myself","D":"mine"}$q$::jsonb,
    $q$B$q$,
    $q$After the preposition to, the object pronoun me is required.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Pronouns and Antecedents$q$,
    $q$The two cousins shared the prize between ______.$q$,
    $q${"A":"they","B":"themselves","C":"them","D":"their"}$q$::jsonb,
    $q$C$q$,
    $q$Between is a preposition and takes the object pronoun them.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Pronouns and Antecedents$q$,
    $q$I found the keys and returned ______ to their owner.$q$,
    $q${"A":"it","B":"its","C":"those","D":"them"}$q$::jsonb,
    $q$D$q$,
    $q$Keys is plural, so the object pronoun is them.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Pronouns and Antecedents$q$,
    $q$The boy dressed ______ without any help.$q$,
    $q${"A":"himself","B":"him","C":"his","D":"he"}$q$::jsonb,
    $q$A$q$,
    $q$The subject and object refer to the same male child, so use himself.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Pronouns and Antecedents$q$,
    $q$The teacher asked whether the red pen was ______.$q$,
    $q${"A":"my","B":"mine","C":"me","D":"myself"}$q$::jsonb,
    $q$B$q$,
    $q$After was, mine stands alone as a possessive pronoun.$q$
  );
