INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Definition and Scope of Economics$q$,
    $q$A student has ₦3,000 and must choose between a textbook and a football. If she buys the textbook, what is her opportunity cost?$q$,
    $q${"A":"The football she gives up","B":"The price of both items","C":"The money she still owns","D":"The value of every book in the shop"}$q$::jsonb,
    $q$A$q$,
    $q$Opportunity cost is the value of the next best alternative forgone.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Definition and Scope of Economics$q$,
    $q$A workshop can produce either 40 stools or 20 desks with its current resources. What does a point beyond its production possibility curve represent?$q$,
    $q${"A":"Inefficient use of resources","B":"Output unattainable with current resources","C":"A feasible mix of stools and desks","D":"A point with no opportunity cost"}$q$::jsonb,
    $q$B$q$,
    $q$Points outside the curve require more or better resources than are currently available.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Definition and Scope of Economics$q$,
    $q$A farmer grows maize, a mill turns it into flour, and a trader sells the flour. Which activity is secondary production?$q$,
    $q${"A":"Growing the maize","B":"Selling the flour","C":"Milling maize into flour","D":"Eating the flour"}$q$::jsonb,
    $q$C$q$,
    $q$Secondary production transforms raw materials into manufactured goods.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Definition and Scope of Economics$q$,
    $q$A family ranks food above a new television when planning its spending. This ranking is a what?$q$,
    $q${"A":"Production schedule","B":"Balance of payments","C":"Price index","D":"Scale of preference"}$q$::jsonb,
    $q$D$q$,
    $q$A scale of preference orders wants according to their importance.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Definition and Scope of Economics$q$,
    $q$A town has idle machines and unemployed workers. On a production possibility diagram, its output lies where?$q$,
    $q${"A":"Inside the curve","B":"Outside the curve","C":"Only at the vertical intercept","D":"At every point on the curve"}$q$::jsonb,
    $q$A$q$,
    $q$Unused resources imply production below the feasible frontier.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Definition and Scope of Economics$q$,
    $q$If making one extra chair means making two fewer tables, what is the opportunity cost of that chair?$q$,
    $q${"A":"One table","B":"Two tables","C":"Three tables","D":"The chair itself"}$q$::jsonb,
    $q$B$q$,
    $q$The forgone two tables are the next best output sacrificed.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Definition and Scope of Economics$q$,
    $q$A shopkeeper decides how much stock to buy after observing customers' needs. Which basic economic problem is being addressed?$q$,
    $q${"A":"How to calculate national income","B":"How to set a foreign exchange rate","C":"What to produce and in what quantity","D":"How to count the population"}$q$::jsonb,
    $q$C$q$,
    $q$Choosing stock addresses which goods and quantities should be supplied.$q$
  ),
  (
    $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$e25adcfa-580c-46bc-87be-048ef2231b02$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Definition and Scope of Economics$q$,
    $q$An economy shifts workers from mining to software services. Which classification best describes the change?$q$,
    $q${"A":"From tertiary to primary activity","B":"From secondary to primary activity","C":"From consumption to saving","D":"From primary to tertiary activity"}$q$::jsonb,
    $q$D$q$,
    $q$Mining extracts raw materials; software services belong to the tertiary sector.$q$
  );
