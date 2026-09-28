INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Logical Reasoning$q$,
    $q$Let p be true and q be false. What is the truth value of the statement 'if p, then q'?$q$,
    $q${"A":"True","B":"False","C":"Both true and false","D":"Cannot be determined"}$q$::jsonb,
    $q$B$q$,
    $q$An implication p ⇒ q is false only when p is true and q is false, which is the case here.$q$
  ),
  (
    $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$99bcb70b-f8e1-4295-841e-bc118a41cc45$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Logical Reasoning$q$,
    $q$A claim says, 'Every one of the 12 boxes is empty.' If one box contains a book, what is the truth value of the original claim?$q$,
    $q${"A":"True","B":"Neither true nor false","C":"False","D":"Cannot be determined"}$q$::jsonb,
    $q$C$q$,
    $q$A universal claim needs all 12 boxes empty. One counterexample is enough to make it false.$q$
  );
