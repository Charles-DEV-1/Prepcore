INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Supply$q$,
    $q$A bakery raises the price of its bread and offers more loaves for sale, other things unchanged. This is a what?$q$,
    $q${"A":"Movement along the supply curve","B":"Rightward shift of demand","C":"Leftward shift of supply","D":"Fall in input costs"}$q$::jsonb,
    $q$A$q$,
    $q$A change in the good's own price changes quantity supplied along the curve.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Supply$q$,
    $q$A new oven lets a bakery produce each loaf at lower cost. What happens to its supply curve?$q$,
    $q${"A":"It shifts left","B":"It shifts right","C":"It becomes a demand curve","D":"It stays fixed at every price"}$q$::jsonb,
    $q$B$q$,
    $q$Lower production costs increase the quantity firms offer at each price.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Supply$q$,
    $q$Price rises from ₦20 to ₦25 and quantity supplied rises from 80 to 100 units. Using original values, what is price elasticity of supply?$q$,
    $q${"A":"0.5","B":"1.5","C":"1.0","D":"2.0"}$q$::jsonb,
    $q$C$q$,
    $q$Quantity rises 20/80 = 25%; price rises 5/20 = 25%; elasticity of supply = 25% ÷ 25% = 1.0.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Supply$q$,
    $q$A farm can switch land quickly between maize and beans. Compared with a farm with fixed equipment, its supply is likely to be what?$q$,
    $q${"A":"Less price elastic","B":"Perfectly inelastic","C":"Unrelated to price","D":"More price elastic"}$q$::jsonb,
    $q$D$q$,
    $q$Ease of switching resources allows a stronger output response to price changes.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Supply$q$,
    $q$A drought reduces cocoa output at every possible price. What happens to cocoa supply?$q$,
    $q${"A":"The supply curve shifts left","B":"There is movement down one supply curve","C":"The demand curve shifts right automatically","D":"Price elasticity becomes infinite"}$q$::jsonb,
    $q$A$q$,
    $q$Drought reduces the quantity producers can supply at each price.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Supply$q$,
    $q$A farmer can use the same field to grow maize or beans next season. How are the supplies of these crops related?$q$,
    $q${"A":"Joint supply","B":"Competitive supply","C":"Composite demand","D":"Derived demand"}$q$::jsonb,
    $q$B$q$,
    $q$Competitive supply occurs when the same resource, such as land, can produce either of two alternative crops.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Supply$q$,
    $q$Meat and hides emerge from processing cattle. Their supply relationship is what?$q$,
    $q${"A":"Competitive supply","B":"Derived demand","C":"Joint supply","D":"Composite demand"}$q$::jsonb,
    $q$C$q$,
    $q$Joint supply arises when one production process yields two products.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Supply$q$,
    $q$Quantity supplied rises from 50 to 55 units when price rises from ₦10 to ₦12. Using original values, what is supply elasticity?$q$,
    $q${"A":"1.0","B":"2.0","C":"5.0","D":"0.5"}$q$::jsonb,
    $q$D$q$,
    $q$Quantity rises 5/50 = 10%; price rises 2/10 = 20%; elasticity = 10% ÷ 20% = 0.5.$q$
  );
