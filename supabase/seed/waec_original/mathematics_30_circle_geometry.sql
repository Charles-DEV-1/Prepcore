INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Circle Geometry$q$,
    $q$An arc subtends 38° at a point on the circumference and an angle at the centre on the same arc. What is the central angle?$q$,
    $q${"A":"19°","B":"38°","C":"142°","D":"76°"}$q$::jsonb,
    $q$D$q$,
    $q$The angle at the centre is twice the angle at the circumference on the same arc: 2 × 38° = 76°.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Circle Geometry$q$,
    $q$A triangle is inscribed in a circle with one side as a diameter. What is the angle opposite that diameter?$q$,
    $q${"A":"90°","B":"45°","C":"60°","D":"180°"}$q$::jsonb,
    $q$A$q$,
    $q$An angle subtended by a diameter at the circumference is a right angle, 90°.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Circle Geometry$q$,
    $q$Two angles stand on the same chord and lie in the same segment of a circle. If one is 47°, what is the other?$q$,
    $q${"A":"43°","B":"47°","C":"94°","D":"133°"}$q$::jsonb,
    $q$B$q$,
    $q$Angles in the same segment of a circle are equal, so the second angle is 47°.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Circle Geometry$q$,
    $q$A cyclic quadrilateral has one interior angle of 112°. What is its opposite interior angle?$q$,
    $q${"A":"22°","B":"112°","C":"68°","D":"248°"}$q$::jsonb,
    $q$C$q$,
    $q$Opposite angles of a cyclic quadrilateral are supplementary. The opposite angle is 180° − 112° = 68°.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Circle Geometry$q$,
    $q$A tangent touches a circle at T and the radius OT is drawn to T. What angle does OT make with the tangent?$q$,
    $q${"A":"0°","B":"45°","C":"180°","D":"90°"}$q$::jsonb,
    $q$D$q$,
    $q$A radius to the point of tangency is perpendicular to the tangent, so the angle is 90°.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Circle Geometry$q$,
    $q$A tangent and a chord meet at a point on a circle. If the angle between them is 58°, what is the angle in the alternate segment subtended by that chord?$q$,
    $q${"A":"58°","B":"29°","C":"116°","D":"122°"}$q$::jsonb,
    $q$A$q$,
    $q$By the tangent–chord theorem, the angle between tangent and chord equals the angle in the alternate segment: 58°.$q$
  );
