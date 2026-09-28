INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Consumer Behaviour$q$,
    $q$Total utility rises from 30 to 36 units when a consumer buys a fourth orange. What is marginal utility of the fourth orange?$q$,
    $q${"A":"6 units","B":"9 units","C":"30 units","D":"36 units"}$q$::jsonb,
    $q$A$q$,
    $q$Marginal utility is the change in total utility from one extra unit: 36 − 30 = 6.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Consumer Behaviour$q$,
    $q$A consumer gets 24 utility units from three identical cups of tea. What is average utility per cup?$q$,
    $q${"A":"3 units","B":"8 units","C":"21 units","D":"72 units"}$q$::jsonb,
    $q$B$q$,
    $q$Average utility = total utility ÷ quantity = 24 ÷ 3 = 8.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Consumer Behaviour$q$,
    $q$A consumer's satisfaction from each extra biscuit falls as more biscuits are eaten. What principle is shown?$q$,
    $q${"A":"Increasing total cost","B":"Perfectly elastic demand","C":"Diminishing marginal utility","D":"Economies of scale"}$q$::jsonb,
    $q$C$q$,
    $q$Diminishing marginal utility means each additional unit adds less satisfaction.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Consumer Behaviour$q$,
    $q$A student has ₦20 to spend and chooses between snacks and notebooks. What limits the combinations she can buy?$q$,
    $q${"A":"The producer's profit only","B":"The national income total","C":"The exchange rate alone","D":"Her budget constraint"}$q$::jsonb,
    $q$D$q$,
    $q$A budget constraint lists affordable combinations at given prices and income.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Consumer Behaviour$q$,
    $q$A fourth unit adds 5 utility units, while the fifth adds 2. By how many units does marginal utility fall?$q$,
    $q${"A":"3","B":"2","C":"5","D":"7"}$q$::jsonb,
    $q$A$q$,
    $q$Marginal utility falls from 5 to 2, a decrease of 5 − 2 = 3 units.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Consumer Behaviour$q$,
    $q$Why might a consumer buy more of a good after its price falls, assuming income is unchanged?$q$,
    $q${"A":"Its total utility must become negative","B":"Its marginal utility per naira becomes more attractive","C":"Its supply must fall to zero","D":"Its production cost must rise"}$q$::jsonb,
    $q$B$q$,
    $q$A lower price can increase utility gained per unit of spending.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Consumer Behaviour$q$,
    $q$Good A gives 12 utility units per ₦4 spent and good B gives 10 per ₦5. Which gives more marginal utility per naira?$q$,
    $q${"A":"Good B","B":"Both are equal","C":"Good A","D":"Neither can be compared"}$q$::jsonb,
    $q$C$q$,
    $q$A gives 12 ÷ 4 = 3 utility units per naira; B gives 10 ÷ 5 = 2, so A gives more.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Consumer Behaviour$q$,
    $q$At a consumer optimum across two goods, what is equalized, assuming divisible goods and no other constraints?$q$,
    $q${"A":"Their total quantities","B":"Their market prices","C":"Their total utilities","D":"Marginal utility per unit of money spent"}$q$::jsonb,
    $q$D$q$,
    $q$The last naira spent on each good should yield equal marginal utility.$q$
  );
