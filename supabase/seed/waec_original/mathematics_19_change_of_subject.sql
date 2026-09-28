INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Change of Subject of Formula$q$,
    $q$Given A = bh/2, find h when A = 42 and b = 7.$q$,
    $q${"A":"3","B":"12","C":"6","D":"24"}$q$::jsonb,
    $q$B$q$,
    $q$Multiply A = bh/2 by 2 and divide by b: h = 2A/b = 84/7 = 12.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Change of Subject of Formula$q$,
    $q$For v = u + at, find t when v = 31, u = 7 and a = 4.$q$,
    $q${"A":"5","B":"8","C":"6","D":"9.5"}$q$::jsonb,
    $q$C$q$,
    $q$Rearrange to t = (v − u)/a. Substitute: t = (31 − 7)/4 = 6.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Change of Subject of Formula$q$,
    $q$From P = 2l + 2w, find l when P = 34 and w = 6.$q$,
    $q${"A":"5","B":"8","C":"14","D":"11"}$q$::jsonb,
    $q$D$q$,
    $q$Subtract 2w from both sides and halve: l = (P − 2w)/2 = (34 − 12)/2 = 11.$q$
  );
