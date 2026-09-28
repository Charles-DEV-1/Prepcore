INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Modals, Conditionals and Voice$q$,
    $q$If I had known the road was closed, I ______ another route.$q$,
    $q${"A":"will take","B":"take","C":"would have taken","D":"had taken"}$q$::jsonb,
    $q$C$q$,
    $q$An unreal past condition takes would have plus past participle in the result clause.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Modals, Conditionals and Voice$q$,
    $q$You ______ wear a helmet on this construction site; it is a safety rule.$q$,
    $q${"A":"might","B":"could","C":"would","D":"must"}$q$::jsonb,
    $q$D$q$,
    $q$Must expresses obligation imposed by a rule.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Modals, Conditionals and Voice$q$,
    $q$The tickets ______ at the entrance yesterday.$q$,
    $q${"A":"were checked","B":"checked","C":"are checking","D":"have checked"}$q$::jsonb,
    $q$A$q$,
    $q$The passive past form were checked shows that someone checked the tickets yesterday.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Modals, Conditionals and Voice$q$,
    $q$If water reaches 0°C under ordinary conditions, it ______.$q$,
    $q${"A":"froze","B":"freezes","C":"would freeze","D":"will have frozen"}$q$::jsonb,
    $q$B$q$,
    $q$A general condition uses present tense in both clauses.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Modals, Conditionals and Voice$q$,
    $q$The parcel ______ by the courier tomorrow.$q$,
    $q${"A":"was delivered","B":"delivers","C":"will be delivered","D":"has delivered"}$q$::jsonb,
    $q$C$q$,
    $q$The future passive is will be plus past participle.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Modals, Conditionals and Voice$q$,
    $q$You ______ ask for help if the instructions are unclear; it is allowed.$q$,
    $q${"A":"must not","B":"cannot","C":"would not","D":"may"}$q$::jsonb,
    $q$D$q$,
    $q$May expresses permission.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Modals, Conditionals and Voice$q$,
    $q$If the team practises regularly, it ______ more confident.$q$,
    $q${"A":"will become","B":"would have become","C":"had become","D":"became"}$q$::jsonb,
    $q$A$q$,
    $q$A real future condition uses present in the if-clause and will in the result.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Modals, Conditionals and Voice$q$,
    $q$The scientist recorded the results. Which passive sentence keeps the same meaning?$q$,
    $q${"A":"The results recorded the scientist.","B":"The results were recorded by the scientist.","C":"The scientist was recorded by the results.","D":"The results are recording the scientist."}$q$::jsonb,
    $q$B$q$,
    $q$The active past object results becomes the passive subject, followed by were recorded.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Modals, Conditionals and Voice$q$,
    $q$The report ______ before the meeting began.$q$,
    $q${"A":"will be printed","B":"prints","C":"had been printed","D":"has printing"}$q$::jsonb,
    $q$C$q$,
    $q$The passive past perfect shows printing was completed before another past event.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Modals, Conditionals and Voice$q$,
    $q$If you were in my position, you ______ the request.$q$,
    $q${"A":"will reconsider","B":"had reconsidered","C":"reconsidered","D":"would reconsider"}$q$::jsonb,
    $q$D$q$,
    $q$An unreal present condition uses would plus base verb in the result clause.$q$
  );
