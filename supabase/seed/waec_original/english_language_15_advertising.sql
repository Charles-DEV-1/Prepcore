INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Advertising$q$,
    $q$A shop's poster states a sale ends on Friday to encourage prompt purchases. Which persuasive device is used?$q$,
    $q${"A":"Urgency","B":"Scientific proof","C":"A legal warning","D":"A personal apology"}$q$::jsonb,
    $q$A$q$,
    $q$A deadline creates a sense of urgency.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Advertising$q$,
    $q$An advert says a bottle holds 500 ml. This statement is a what?$q$,
    $q${"A":"Slogan","B":"Product specification","C":"Testimonial","D":"Guarantee"}$q$::jsonb,
    $q$B$q$,
    $q$A product specification gives a measurable feature of the item.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Advertising$q$,
    $q$A company repeats a short memorable phrase in its radio adverts. The phrase is a what?$q$,
    $q${"A":"Invoice","B":"Caption","C":"Slogan","D":"Footnote"}$q$::jsonb,
    $q$C$q$,
    $q$A slogan is a brief memorable phrase used to identify or promote a brand.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Advertising$q$,
    $q$A poster aimed at students uses simple language and school-related examples. It has adapted its message to its what?$q$,
    $q${"A":"Printer","B":"Distributor","C":"Competitor","D":"Target audience"}$q$::jsonb,
    $q$D$q$,
    $q$The target audience is the group an advert intends to reach.$q$
  );
