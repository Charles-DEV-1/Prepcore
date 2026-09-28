INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Angles of Elevation and Depression$q$,
    $q$A learner stands 20 m from a vertical tree and measures its top at an elevation angle of 45°. Ignoring eye height, how tall is the tree?$q$,
    $q${"A":"10 m","B":"20√2 m","C":"20 m","D":"40 m"}$q$::jsonb,
    $q$C$q$,
    $q$tan45° = height/horizontal distance = h/20 = 1. Hence h = 20 m.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Angles of Elevation and Depression$q$,
    $q$A tower is 30 m high. A point on level ground is 30 m from its base. What is the angle of elevation to its top?$q$,
    $q${"A":"30°","B":"60°","C":"90°","D":"45°"}$q$::jsonb,
    $q$D$q$,
    $q$tanθ = opposite/adjacent = 30/30 = 1. Therefore θ = 45°.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Angles of Elevation and Depression$q$,
    $q$An observer on a platform sees a point on level ground at a depression angle of 45°. If the point is 18 m horizontally from the platform's base, what is the platform height?$q$,
    $q${"A":"18 m","B":"9 m","C":"18√2 m","D":"36 m"}$q$::jsonb,
    $q$A$q$,
    $q$The angle of depression equals the angle of elevation from the point. tan45° = h/18 = 1, so h = 18 m.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Angles of Elevation and Depression$q$,
    $q$A 12 m flagpole casts a shadow on level ground. If the sun's angle of elevation is 60°, what is the shadow length?$q$,
    $q${"A":"4 m","B":"4√3 m","C":"6√3 m","D":"12√3 m"}$q$::jsonb,
    $q$B$q$,
    $q$tan60° = 12/shadow = √3. Shadow = 12/√3 = 12√3/3 = 4√3 m.$q$
  );
