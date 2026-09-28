INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Public Finance$q$,
    $q$A worker pays ₦15 tax on ₦100 income and ₦30 tax on ₦200 income. What is the tax rate in each case?$q$,
    $q${"A":"15% in both cases","B":"15% then 30%","C":"30% then 15%","D":"5% in both cases"}$q$::jsonb,
    $q$A$q$,
    $q$Tax rate = tax ÷ income × 100. Both 15/100 and 30/200 equal 15%, so this is proportional.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Public Finance$q$,
    $q$A higher share of income is taxed as income rises. What type of taxation is this?$q$,
    $q${"A":"Proportional","B":"Progressive","C":"Regressive","D":"A lump-sum rebate"}$q$::jsonb,
    $q$B$q$,
    $q$A progressive tax takes a larger percentage at higher incomes.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Public Finance$q$,
    $q$A sales tax is added to the price of goods. What broad category does it belong to?$q$,
    $q${"A":"Direct income tax","B":"Capital expenditure","C":"Indirect tax","D":"A public debt repayment"}$q$::jsonb,
    $q$C$q$,
    $q$An indirect tax is levied on goods or transactions rather than directly on income.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Public Finance$q$,
    $q$The government builds a new bridge. Is this mainly recurrent or capital expenditure?$q$,
    $q${"A":"Recurrent expenditure","B":"A transfer payment only","C":"Interest income","D":"Capital expenditure"}$q$::jsonb,
    $q$D$q$,
    $q$A new bridge is a long-lived public asset, so building it is capital spending.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Public Finance$q$,
    $q$A ministry pays monthly salaries to existing staff. What type of spending is this?$q$,
    $q${"A":"Recurrent expenditure","B":"Capital expenditure","C":"An export subsidy only","D":"A foreign reserve"}$q$::jsonb,
    $q$A$q$,
    $q$Regular salaries are ongoing operating costs.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Public Finance$q$,
    $q$Government revenue is ₦900bn and expenditure is ₦1,050bn. What is the budget balance?$q$,
    $q${"A":"₦150bn surplus","B":"₦150bn deficit","C":"₦900bn deficit","D":"₦1,950bn surplus"}$q$::jsonb,
    $q$B$q$,
    $q$Balance = revenue − expenditure = 900 − 1,050 = −150; the negative balance is a ₦150bn deficit.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Public Finance$q$,
    $q$A tax is formally paid by a firm, but the firm raises prices and buyers bear much of it. What concept describes who ultimately bears the tax?$q$,
    $q${"A":"Tax base only","B":"Tax exemption","C":"Tax incidence","D":"Public debt"}$q$::jsonb,
    $q$C$q$,
    $q$Tax incidence concerns the final distribution of a tax burden.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Public Finance$q$,
    $q$A government borrows to pay for investment projects. What does the accumulated borrowing contribute to?$q$,
    $q${"A":"Current tax revenue","B":"Private savings only","C":"The money supply alone","D":"Public debt"}$q$::jsonb,
    $q$D$q$,
    $q$Borrowing adds to outstanding public debt until repaid.$q$
  );
