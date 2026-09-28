INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Building and Building Construction$q$,
    $q$A wall is leaning outward. Which temporary support can hold it safely while repairs are planned?$q$,
    $q${"A":"A brace","B":"A lintel","C":"A tile","D":"A gutter"}$q$::jsonb,
    $q$A$q$,
    $q$A brace props up an unstable structure temporarily; the other items serve different building functions.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Building and Building Construction$q$,
    $q$The builder checks whether a wall is exactly upright. Which tool is most suitable?$q$,
    $q${"A":"A trowel","B":"A plumb line","C":"A saw","D":"A tape measure"}$q$::jsonb,
    $q$B$q$,
    $q$A plumb line uses a hanging weight to show the vertical direction.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Building and Building Construction$q$,
    $q$Water runs from a roof into a long channel fixed along its edge. What is the channel called?$q$,
    $q${"A":"A foundation","B":"A joist","C":"A gutter","D":"A hinge"}$q$::jsonb,
    $q$C$q$,
    $q$A gutter collects rainwater at the roof edge and directs it toward a downpipe.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Building and Building Construction$q$,
    $q$A doorway needs a horizontal support above it to carry the bricks overhead. What should be installed?$q$,
    $q${"A":"A sill","B":"A drain","C":"A coping","D":"A lintel"}$q$::jsonb,
    $q$D$q$,
    $q$A lintel spans an opening and supports the load above it.$q$
  );
