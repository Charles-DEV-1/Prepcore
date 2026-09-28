INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Market Structures$q$,
    $q$Many sellers offer identical bags of grain, and none can change the market price alone. Which market is closest to this description?$q$,
    $q${"A":"Perfect competition","B":"Monopoly","C":"Monopolistic competition","D":"A bilateral monopoly"}$q$::jsonb,
    $q$A$q$,
    $q$Many sellers and homogeneous goods make each firm a price taker.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Market Structures$q$,
    $q$One licensed firm is the only supplier of water in a town. Which market structure is illustrated?$q$,
    $q${"A":"Perfect competition","B":"Monopoly","C":"Monopolistic competition","D":"A farmers' co-operative"}$q$::jsonb,
    $q$B$q$,
    $q$A monopoly has one seller with no close substitute in the defined market.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Market Structures$q$,
    $q$Several cafés sell similar but differentiated meals and can set slightly different prices. Which structure fits best?$q$,
    $q${"A":"Perfect competition","B":"Pure monopoly","C":"Monopolistic competition","D":"A market with no buyers"}$q$::jsonb,
    $q$C$q$,
    $q$Many sellers with differentiated products characterize monopolistic competition.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Market Structures$q$,
    $q$A cinema charges students less than adults for the same seat at the same showing. What pricing practice is this?$q$,
    $q${"A":"Cost-plus pricing","B":"A uniform market price","C":"Barter","D":"Price discrimination"}$q$::jsonb,
    $q$D$q$,
    $q$Charging different customer groups different prices for the same service is price discrimination.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Market Structures$q$,
    $q$A price-taking farmer sells one extra basket at the market price. How does marginal revenue compare with price?$q$,
    $q${"A":"It equals price","B":"It is always zero","C":"It is twice price","D":"It is negative"}$q$::jsonb,
    $q$A$q$,
    $q$A price taker receives the same price for each extra unit sold, so MR = price.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Market Structures$q$,
    $q$Why can a monopolist often restrict output to raise its selling price?$q$,
    $q${"A":"It faces a perfectly horizontal demand curve","B":"It controls the market supply of a product with few close substitutes","C":"It has no production costs","D":"It cannot choose its output"}$q$::jsonb,
    $q$B$q$,
    $q$Market power lets a monopolist influence price by altering output.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Market Structures$q$,
    $q$A seller advertises a unique brand to make its product seem different from rivals'. Which market behaviour is this?$q$,
    $q${"A":"Perfectly homogeneous output","B":"A legal price ceiling","C":"Product differentiation","D":"A producer subsidy"}$q$::jsonb,
    $q$C$q$,
    $q$Product differentiation makes buyers perceive one seller's offer as distinct.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Market Structures$q$,
    $q$In a competitive market, a firm keeps producing an extra unit while its marginal revenue exceeds marginal cost. Why?$q$,
    $q${"A":"Fixed cost becomes zero","B":"The market price must fall to zero","C":"Average revenue becomes negative","D":"The extra unit adds more revenue than cost"}$q$::jsonb,
    $q$D$q$,
    $q$An extra unit raises profit when its added revenue exceeds its added cost.$q$
  );
