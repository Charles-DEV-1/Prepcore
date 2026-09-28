INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Price Determination$q$,
    $q$At ₦5, buyers demand 60 units and sellers supply 40. What shortage exists?$q$,
    $q${"A":"20 units","B":"10 units","C":"40 units","D":"100 units"}$q$::jsonb,
    $q$A$q$,
    $q$Shortage = quantity demanded − quantity supplied = 60 − 40 = 20.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Price Determination$q$,
    $q$At ₦8, sellers supply 90 units and buyers demand 70. What surplus exists?$q$,
    $q${"A":"10 units","B":"20 units","C":"70 units","D":"160 units"}$q$::jsonb,
    $q$B$q$,
    $q$Surplus = quantity supplied − quantity demanded = 90 − 70 = 20.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Price Determination$q$,
    $q$If demand rises while supply is unchanged, what usually happens to equilibrium price and quantity?$q$,
    $q${"A":"Both fall","B":"Price falls and quantity rises","C":"Both rise","D":"Price rises and quantity falls"}$q$::jsonb,
    $q$C$q$,
    $q$A rightward demand shift moves equilibrium to a higher price and quantity.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Price Determination$q$,
    $q$A government sets a maximum price below the market equilibrium price. What is a likely immediate result?$q$,
    $q${"A":"A surplus","B":"No change in quantity demanded","C":"A guaranteed increase in supply","D":"A shortage"}$q$::jsonb,
    $q$D$q$,
    $q$The lower controlled price raises quantity demanded while reducing quantity supplied.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Price Determination$q$,
    $q$A guaranteed minimum price is fixed above equilibrium. What is likely to appear?$q$,
    $q${"A":"A surplus","B":"A shortage","C":"A lower supply quantity","D":"A fall in demand at every price"}$q$::jsonb,
    $q$A$q$,
    $q$At the higher price, suppliers offer more than buyers demand.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Price Determination$q$,
    $q$Demand is Qd = 100 − 2P and supply is Qs = 20 + 2P. What is the equilibrium price?$q$,
    $q${"A":"₦10","B":"₦20","C":"₦25","D":"₦40"}$q$::jsonb,
    $q$B$q$,
    $q$Set demand equal to supply: 100 − 2P = 20 + 2P; 80 = 4P; P = 20.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Price Determination$q$,
    $q$Using Qd = 100 − 2P and Qs = 20 + 2P, what is equilibrium quantity?$q$,
    $q${"A":"40 units","B":"80 units","C":"60 units","D":"100 units"}$q$::jsonb,
    $q$C$q$,
    $q$Equilibrium price is ₦20. Substitute into demand: Q = 100 − 2(20) = 60.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Price Determination$q$,
    $q$A legal price ceiling leads some sellers to trade secretly at higher prices. What is the unofficial trade called?$q$,
    $q${"A":"A futures market","B":"A capital market","C":"A labour exchange","D":"A black market"}$q$::jsonb,
    $q$D$q$,
    $q$A black market trades outside price regulations, often at prices above the ceiling.$q$
  );
