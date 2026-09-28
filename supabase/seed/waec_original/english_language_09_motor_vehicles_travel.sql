INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Motor Vehicles and Travelling$q$,
    $q$A driver sees a sign warning of pedestrians ahead. What should the driver do first?$q$,
    $q${"A":"Slow down and watch for people crossing","B":"Accelerate past the sign","C":"Ignore the sign outside school hours","D":"Sound the horn continuously"}$q$::jsonb,
    $q$A$q$,
    $q$A pedestrian warning calls for reduced speed and closer observation.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Motor Vehicles and Travelling$q$,
    $q$Passengers change from one bus to another at a central station. The central station is a what?$q$,
    $q${"A":"Carriageway","B":"Transport hub","C":"Hard shoulder","D":"Speed bump"}$q$::jsonb,
    $q$B$q$,
    $q$A transport hub is a place where travel routes or services connect.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Motor Vehicles and Travelling$q$,
    $q$The mechanic says the car's brakes need servicing. Which action do brakes control?$q$,
    $q${"A":"Cooling the engine","B":"Lighting the road","C":"Slowing or stopping the car","D":"Holding the luggage"}$q$::jsonb,
    $q$C$q$,
    $q$Brakes reduce a vehicle's speed or stop it.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Motor Vehicles and Travelling$q$,
    $q$A traveller buys a return ticket. What journey does it cover?$q$,
    $q${"A":"Only the outward journey","B":"Unlimited journeys for a year","C":"Only journeys by air","D":"The outward and homeward journeys"}$q$::jsonb,
    $q$D$q$,
    $q$A return ticket covers travel to a destination and back.$q$
  );
