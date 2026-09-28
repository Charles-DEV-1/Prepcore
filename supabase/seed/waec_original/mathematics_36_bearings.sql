INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Bearings$q$,
    $q$The bearing of B from A is 035°. What is the bearing of A from B?$q$,
    $q${"A":"145°","B":"325°","C":"215°","D":"035°"}$q$::jsonb,
    $q$C$q$,
    $q$Reverse bearings differ by 180°. Add 180° to 035° to obtain 215°.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Bearings$q$,
    $q$A point lies due east of an observer. What is its three-figure bearing from the observer?$q$,
    $q${"A":"000°","B":"180°","C":"270°","D":"090°"}$q$::jsonb,
    $q$D$q$,
    $q$Bearings are measured clockwise from north. Due east is a quarter turn clockwise, or 090°.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Bearings$q$,
    $q$A traveller goes 10 km north then 10 km east. What is the bearing of the final point from the starting point?$q$,
    $q${"A":"045°","B":"090°","C":"135°","D":"315°"}$q$::jsonb,
    $q$A$q$,
    $q$The north and east displacements are equal, making 45° east of north. The three-figure bearing is 045°.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Bearings$q$,
    $q$A destination is southwest of a starting point, exactly halfway between south and west. What is its bearing?$q$,
    $q${"A":"135°","B":"225°","C":"180°","D":"315°"}$q$::jsonb,
    $q$B$q$,
    $q$South is 180° clockwise from north and southwest is another 45° toward west. Bearing = 180° + 45° = 225°.$q$
  );
