INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Stock Exchange$q$,
    $q$A company wants to raise money by offering ownership units to investors. Those units are called what?$q$,
    $q${"A":"Shares","B":"Invoices","C":"Receipts","D":"Wages"}$q$::jsonb,
    $q$A$q$,
    $q$Shares represent units of ownership in a company.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Stock Exchange$q$,
    $q$An investor receives part of a company's profits because she owns its shares. What is that payment called?$q$,
    $q${"A":"A tariff","B":"A dividend","C":"A deposit","D":"A premium"}$q$::jsonb,
    $q$B$q$,
    $q$A dividend is a distribution of company profit to shareholders.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Stock Exchange$q$,
    $q$A share's quoted price rises after strong demand. A holder who sells then may make what?$q$,
    $q${"A":"A bank overdraft","B":"A tax refund","C":"A capital gain","D":"A fixed salary"}$q$::jsonb,
    $q$C$q$,
    $q$A capital gain arises when an asset is sold for more than its purchase price.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Stock Exchange$q$,
    $q$A person who arranges a purchase of shares on behalf of a client is a what?$q$,
    $q${"A":"Auditor","B":"Cashier","C":"Guarantor","D":"Broker"}$q$::jsonb,
    $q$D$q$,
    $q$A broker executes securities transactions for clients.$q$
  );
