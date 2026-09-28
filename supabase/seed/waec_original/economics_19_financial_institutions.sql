INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Financial Institutions$q$,
    $q$A bank accepts deposits and makes loans to households and firms. Which institution is described?$q$,
    $q${"A":"Commercial bank","B":"Central bank","C":"Commodity board","D":"Trade union"}$q$::jsonb,
    $q$A$q$,
    $q$Commercial banks provide deposit and lending services to customers.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Financial Institutions$q$,
    $q$An authority issues currency and acts as banker to the government. Which institution is this?$q$,
    $q${"A":"Retail shop","B":"Central bank","C":"Insurance broker","D":"Co-operative farm"}$q$::jsonb,
    $q$B$q$,
    $q$A central bank is responsible for currency issue and government banking functions.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Financial Institutions$q$,
    $q$A farmer buys insurance against loss of livestock. What does the insurer mainly provide?$q$,
    $q${"A":"A guaranteed increase in farm output","B":"A fixed crop price","C":"Risk pooling and compensation for covered losses","D":"Unlimited government credit"}$q$::jsonb,
    $q$C$q$,
    $q$Insurance pools premiums to meet eligible claims when insured risks occur.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Financial Institutions$q$,
    $q$A business raises long-term funds by issuing shares. Which market does it use?$q$,
    $q${"A":"Money market","B":"Retail market","C":"Labour market","D":"Capital market"}$q$::jsonb,
    $q$D$q$,
    $q$Capital markets supply longer-term finance, including shares.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Financial Institutions$q$,
    $q$A firm borrows for three months to finance inventory. Which market is most relevant to such short-term funds?$q$,
    $q${"A":"Money market","B":"Capital market only","C":"Commodity board","D":"Foreign direct investment only"}$q$::jsonb,
    $q$A$q$,
    $q$Money markets deal mainly in short-term funds.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Financial Institutions$q$,
    $q$A development bank lends for long-term infrastructure that ordinary banks avoid. What gap does it address?$q$,
    $q${"A":"Daily cash change","B":"Long-term project finance","C":"Retail price labels","D":"A shortage of currency notes only"}$q$::jsonb,
    $q$B$q$,
    $q$Development banks finance projects needing long repayment periods.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Financial Institutions$q$,
    $q$A commercial bank keeps reserves at the central bank. Why might it do so?$q$,
    $q${"A":"To become a retailer","B":"To grow crops","C":"To meet regulation and settle payments","D":"To replace every customer account"}$q$::jsonb,
    $q$C$q$,
    $q$Bank reserves support settlement and regulatory requirements.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Financial Institutions$q$,
    $q$A household places savings in a regulated institution rather than keeping cash at home. Which benefit is most direct?$q$,
    $q${"A":"Guaranteed immunity from inflation","B":"No need for identification","C":"Automatic profits without risk","D":"Safer custody and access to payment services"}$q$::jsonb,
    $q$D$q$,
    $q$Financial institutions can safeguard deposits and provide payment services, though risks remain.$q$
  );
