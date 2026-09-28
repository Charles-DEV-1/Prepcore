INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Word Forms and Number$q$,
    $q$Several ______ gathered near the school gate.$q$,
    $q${"A":"children","B":"childs","C":"childes","D":"child's"}$q$::jsonb,
    $q$A$q$,
    $q$Children is the irregular plural of child.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Word Forms and Number$q$,
    $q$The laboratory bought two new ______ for measuring temperature.$q$,
    $q${"A":"thermometer","B":"thermometers","C":"thermometer's","D":"thermometres's"}$q$::jsonb,
    $q$B$q$,
    $q$A plural count noun is needed after two; thermometers is the correct plural.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Word Forms and Number$q$,
    $q$The ______ of the two reports will be checked tomorrow.$q$,
    $q${"A":"accurate","B":"accurately","C":"accuracy","D":"accuracies"}$q$::jsonb,
    $q$C$q$,
    $q$Accuracy is the noun naming the quality being checked.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Word Forms and Number$q$,
    $q$The team worked ______ to finish before sunset.$q$,
    $q${"A":"quick","B":"quicker","C":"quickness","D":"quickly"}$q$::jsonb,
    $q$D$q$,
    $q$Quickly is the adverb modifying worked.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Word Forms and Number$q$,
    $q$The officer gave us useful ______ about the road closure.$q$,
    $q${"A":"information","B":"informations","C":"inform","D":"informative"}$q$::jsonb,
    $q$A$q$,
    $q$Information is an uncountable noun and does not take a regular plural here.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Word Forms and Number$q$,
    $q$Three ______ crossed the field before dawn.$q$,
    $q${"A":"deers","B":"deer","C":"deer's","D":"deeres"}$q$::jsonb,
    $q$B$q$,
    $q$Deer has the same form in singular and plural.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Word Forms and Number$q$,
    $q$Her ______ response helped calm the worried visitors.$q$,
    $q${"A":"thoughtfully","B":"thought","C":"thoughtful","D":"thoughtfulness"}$q$::jsonb,
    $q$C$q$,
    $q$An adjective, thoughtful, is needed before the noun response.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Word Forms and Number$q$,
    $q$The books are on the teachers' desks. How many teachers are indicated by teachers'?$q$,
    $q${"A":"Exactly one","B":"Exactly two desks only","C":"No teacher","D":"More than one"}$q$::jsonb,
    $q$D$q$,
    $q$The apostrophe after plural teachers marks possession by more than one teacher.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Word Forms and Number$q$,
    $q$The company plans to ______ its services next year.$q$,
    $q${"A":"expand","B":"expansion","C":"expansive","D":"expanded"}$q$::jsonb,
    $q$A$q$,
    $q$After plans to, the base verb expand is needed.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Word Forms and Number$q$,
    $q$The researchers drew several ______ from the survey results.$q$,
    $q${"A":"conclusion","B":"conclusions","C":"conclude","D":"conclusive"}$q$::jsonb,
    $q$B$q$,
    $q$Several requires a plural noun, conclusions.$q$
  );
