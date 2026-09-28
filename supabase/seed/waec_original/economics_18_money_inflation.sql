INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Money and Inflation$q$,
    $q$A fisher wants rice but the rice seller wants shoes, not fish. What barter problem occurs?$q$,
    $q${"A":"Lack of double coincidence of wants","B":"Excess bank reserves","C":"A budget surplus","D":"Currency appreciation"}$q$::jsonb,
    $q$A$q$,
    $q$Barter requires each side to want what the other offers at the same time.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Money and Inflation$q$,
    $q$A worker keeps part of her wages in cash for future purchases. Which function of money is this?$q$,
    $q${"A":"Unit of account only","B":"Store of value","C":"A production factor","D":"A tax rate"}$q$::jsonb,
    $q$B$q$,
    $q$Money can transfer purchasing power from the present to a later time.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Money and Inflation$q$,
    $q$A basket costs ₦100 last year and ₦110 this year. What is the inflation rate measured by this basket?$q$,
    $q${"A":"5%","B":"11%","C":"10%","D":"110%"}$q$::jsonb,
    $q$C$q$,
    $q$Inflation = (new price − old price) ÷ old price × 100 = (110 − 100) ÷ 100 × 100 = 10%.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Money and Inflation$q$,
    $q$A harvest failure pushes food prices up because less food is available. What type of pressure is this?$q$,
    $q${"A":"Demand-pull inflation from higher incomes","B":"Deflation","C":"A productivity boom","D":"Cost-push or supply-side inflation"}$q$::jsonb,
    $q$D$q$,
    $q$Reduced supply raises production or scarcity costs and pushes prices upward.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Money and Inflation$q$,
    $q$If prices rise faster than wages, what happens to workers' purchasing power?$q$,
    $q${"A":"It falls","B":"It always rises","C":"It stays exactly the same","D":"It becomes unrelated to prices"}$q$::jsonb,
    $q$A$q$,
    $q$A given wage buys fewer goods when prices outpace pay.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Money and Inflation$q$,
    $q$A central bank raises interest rates to restrain borrowing and spending. What is the intended effect on inflation?$q$,
    $q${"A":"Increase demand immediately","B":"Reduce demand pressure","C":"Eliminate scarcity permanently","D":"Fix all supply shortages"}$q$::jsonb,
    $q$B$q$,
    $q$Higher borrowing costs can slow spending and ease demand-driven inflation.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Money and Inflation$q$,
    $q$A price index rises from 125 to 130 over a year. What is the inflation rate?$q$,
    $q${"A":"5%","B":"3%","C":"4%","D":"30%"}$q$::jsonb,
    $q$C$q$,
    $q$Inflation = (130 − 125) ÷ 125 × 100 = 4%.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Money and Inflation$q$,
    $q$A shop posts prices in naira so customers can compare products. Which money function is illustrated?$q$,
    $q${"A":"Means of production","B":"Factor mobility","C":"Balance of trade","D":"Unit of account"}$q$::jsonb,
    $q$D$q$,
    $q$A unit of account expresses values in a common measure.$q$
  );
