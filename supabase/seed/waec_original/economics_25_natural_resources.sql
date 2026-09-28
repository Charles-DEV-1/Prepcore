INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Major Natural Resources$q$,
    $q$A country exports unprocessed timber but imports expensive furniture. What opportunity might domestic processing create?$q$,
    $q${"A":"More local value added","B":"A guaranteed end to deforestation","C":"No need for skilled labour","D":"A fall in all transport costs"}$q$::jsonb,
    $q$A$q$,
    $q$Processing timber locally can retain more value in the domestic economy.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Major Natural Resources$q$,
    $q$A government saves part of oil revenue during high-price years. What risk is it trying to manage?$q$,
    $q${"A":"A fixed export price forever","B":"Volatile commodity prices","C":"Too many public schools","D":"The impossibility of imports"}$q$::jsonb,
    $q$B$q$,
    $q$Saving during booms can cushion budgets when commodity prices fall.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Major Natural Resources$q$,
    $q$Mining creates jobs but damages nearby farmland. What policy response best addresses both sides?$q$,
    $q${"A":"Ignore the damage","B":"Close every mine without assessing alternatives","C":"Require environmental safeguards while retaining useful production","D":"Pay no attention to workers"}$q$::jsonb,
    $q$C$q$,
    $q$Regulation can reduce environmental harm while allowing economic benefits.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Major Natural Resources$q$,
    $q$A country relies on one mineral for most export earnings. What makes this risky?$q$,
    $q${"A":"Minerals never face price changes","B":"Export earnings cannot be saved","C":"Domestic industry always grows automatically","D":"A world-price fall can sharply reduce income"}$q$::jsonb,
    $q$D$q$,
    $q$Concentration makes export income vulnerable to one commodity's price.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Major Natural Resources$q$,
    $q$A company extracts gold but hires few local workers and sends most profits abroad. What concern does this raise?$q$,
    $q${"A":"Limited domestic linkages and benefits","B":"Excessive local value added","C":"A guaranteed budget surplus","D":"Complete industrial diversification"}$q$::jsonb,
    $q$A$q$,
    $q$Resource extraction may add little locally if employment and retained income are limited.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Major Natural Resources$q$,
    $q$Which investment can help a petroleum-producing country move beyond crude exports?$q$,
    $q${"A":"Only storing crude indefinitely","B":"Domestic refining and related skills","C":"Eliminating transport networks","D":"Reducing technical training"}$q$::jsonb,
    $q$B$q$,
    $q$Refining and skills can add value and create industrial linkages.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Major Natural Resources$q$,
    $q$A community receives mining royalties but has polluted water. Which measure would best improve welfare?$q$,
    $q${"A":"Measure royalties only","B":"Increase extraction without safeguards","C":"Use revenue for clean water and enforce pollution controls","D":"Ignore health costs"}$q$::jsonb,
    $q$C$q$,
    $q$Resource income should be weighed against environmental costs and used to improve local welfare.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Major Natural Resources$q$,
    $q$Why is it useful to invest some non-renewable resource revenue in education?$q$,
    $q${"A":"It makes the mineral renewable","B":"It eliminates all future taxes","C":"It guarantees a fixed global price","D":"It creates lasting human capital after the resource is depleted"}$q$::jsonb,
    $q$D$q$,
    $q$Education turns temporary resource income into longer-lived productive capacity.$q$
  );
