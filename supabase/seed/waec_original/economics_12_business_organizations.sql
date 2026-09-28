INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Business Organizations$q$,
    $q$A trader owns and controls a shop alone and bears its debts personally. What form of enterprise is this?$q$,
    $q${"A":"Sole proprietorship","B":"Public limited company","C":"Statutory corporation","D":"Co-operative society"}$q$::jsonb,
    $q$A$q$,
    $q$A sole proprietor owns the business alone and generally has unlimited liability.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Business Organizations$q$,
    $q$Two friends share ownership and profits under a written agreement. Which form is most likely?$q$,
    $q${"A":"Sole proprietorship","B":"Partnership","C":"A state corporation","D":"A workers' union"}$q$::jsonb,
    $q$B$q$,
    $q$A partnership is a business carried on by two or more owners.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Business Organizations$q$,
    $q$Farmers pool resources to buy inputs and share benefits as members. What organization have they formed?$q$,
    $q${"A":"A monopoly regulator","B":"A stock exchange","C":"A co-operative","D":"A central bank"}$q$::jsonb,
    $q$C$q$,
    $q$A co-operative is owned and run for the benefit of its members.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Business Organizations$q$,
    $q$A company is sold by the state to private investors. What policy does this illustrate?$q$,
    $q${"A":"Nationalization","B":"Rationing","C":"A tariff","D":"Privatization"}$q$::jsonb,
    $q$D$q$,
    $q$Privatization transfers ownership from the public to the private sector.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Business Organizations$q$,
    $q$A state enterprise stays publicly owned but is expected to cover costs from sales. What policy is this?$q$,
    $q${"A":"Commercialization","B":"Privatization","C":"Barter","D":"A merger"}$q$::jsonb,
    $q$A$q$,
    $q$Commercialization makes a public enterprise operate on business principles without necessarily changing ownership.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Business Organizations$q$,
    $q$A company sells shares to many investors but owners' losses are limited to their investment. Which feature is described?$q$,
    $q${"A":"Unlimited liability","B":"Limited liability","C":"Price control","D":"Public ownership only"}$q$::jsonb,
    $q$B$q$,
    $q$Limited liability caps shareholders' exposure at the value of their investment.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Business Organizations$q$,
    $q$A joint venture lets two firms share the cost of building a new plant. What is a likely benefit?$q$,
    $q${"A":"Scarcity disappears","B":"No management is needed","C":"Risk and finance are shared","D":"The law of demand no longer applies"}$q$::jsonb,
    $q$C$q$,
    $q$Partners can pool capital, expertise and business risks.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Business Organizations$q$,
    $q$A government takes private ownership of a railway into state ownership. What is this called?$q$,
    $q${"A":"Privatization","B":"Commercialization","C":"Franchising","D":"Nationalization"}$q$::jsonb,
    $q$D$q$,
    $q$Nationalization transfers a private enterprise into public ownership.$q$
  );
