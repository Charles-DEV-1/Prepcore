INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Production$q$,
    $q$In a workshop, one worker repeatedly cuts fabric while another stitches it. This is what?$q$,
    $q${"A":"Division of labour","B":"Price discrimination","C":"Capital depreciation","D":"Consumer equilibrium"}$q$::jsonb,
    $q$A$q$,
    $q$Division of labour splits production into specialized tasks.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Production$q$,
    $q$A farm produces 240 bags with 8 workers. What is average product per worker?$q$,
    $q${"A":"8 bags","B":"30 bags","C":"32 bags","D":"248 bags"}$q$::jsonb,
    $q$B$q$,
    $q$Average product = total product ÷ workers = 240 ÷ 8 = 30 bags.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Production$q$,
    $q$With four workers, output is 90 units; with five it is 108. What is the fifth worker's marginal product?$q$,
    $q${"A":"22 units","B":"90 units","C":"18 units","D":"108 units"}$q$::jsonb,
    $q$C$q$,
    $q$Marginal product = change in total output = 108 − 90 = 18 units.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Production$q$,
    $q$A large firm buys raw materials in bulk and gets a lower unit price. What does it enjoy?$q$,
    $q${"A":"External diseconomies","B":"Diminishing demand","C":"A fall in total output","D":"Internal economies of scale"}$q$::jsonb,
    $q$D$q$,
    $q$Bulk purchasing can lower the firm's average cost as its scale grows.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Production$q$,
    $q$A new road serving every factory in an industrial area lowers transport costs. This is what?$q$,
    $q${"A":"An external economy","B":"An internal diseconomy","C":"Price discrimination","D":"A fixed cost"}$q$::jsonb,
    $q$A$q$,
    $q$A benefit shared by multiple firms from the surrounding industry is external.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Production$q$,
    $q$When more workers use the same fixed land, each additional worker eventually adds less output. What law is illustrated?$q$,
    $q${"A":"Increasing returns forever","B":"Diminishing returns to a variable factor","C":"The law of demand","D":"Perfect competition"}$q$::jsonb,
    $q$B$q$,
    $q$With a fixed factor, extra variable input can eventually yield smaller marginal additions.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Production$q$,
    $q$Total output rises from 300 to 318 units after one extra worker is hired. What is marginal product?$q$,
    $q${"A":"6 units","B":"300 units","C":"18 units","D":"618 units"}$q$::jsonb,
    $q$C$q$,
    $q$Marginal product is the output increase caused by one additional worker: 318 − 300 = 18.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Theory of Production$q$,
    $q$A bakery specializing workers gains speed but finds workers bored by repetitive tasks. What is the boredom an example of?$q$,
    $q${"A":"An increase in land supply","B":"A benefit of monopoly","C":"A decrease in fixed cost","D":"A disadvantage of specialization"}$q$::jsonb,
    $q$D$q$,
    $q$Repetitive specialized work can reduce motivation or flexibility.$q$
  );
