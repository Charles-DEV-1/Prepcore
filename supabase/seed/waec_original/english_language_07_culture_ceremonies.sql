INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Culture, Institutions and Ceremonies$q$,
    $q$At a graduation, the principal formally hands certificates to students. This act is the what?$q$,
    $q${"A":"Presentation","B":"Nomination","C":"Registration","D":"Rehearsal"}$q$::jsonb,
    $q$A$q$,
    $q$Presentation is the formal handing over of an award or certificate.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Culture, Institutions and Ceremonies$q$,
    $q$A traditional ceremony has an agreed sequence of events. What is this sequence called?$q$,
    $q${"A":"A census","B":"A programme","C":"A ballot","D":"A receipt"}$q$::jsonb,
    $q$B$q$,
    $q$A programme lists the order of activities at an event.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Culture, Institutions and Ceremonies$q$,
    $q$Guests stand when the guest of honour enters. This gesture shows what?$q$,
    $q${"A":"Permission","B":"Ownership","C":"Respect","D":"Absence"}$q$::jsonb,
    $q$C$q$,
    $q$Standing for a guest of honour is a gesture of respect.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Culture, Institutions and Ceremonies$q$,
    $q$A community museum preserves old tools and clothing mainly as part of its what?$q$,
    $q${"A":"Revenue","B":"Transport","C":"Currency","D":"Heritage"}$q$::jsonb,
    $q$D$q$,
    $q$Heritage comprises valued traditions and objects inherited from the past.$q$
  );
