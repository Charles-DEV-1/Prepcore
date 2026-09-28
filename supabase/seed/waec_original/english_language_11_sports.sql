INSERT INTO public.questions (
  subject_id, exam_type, source, year, topic,
  prompt, options, correct_answer, explanation
) VALUES
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Sports$q$,
    $q$In a relay race, a runner passes an object to the next teammate. What is it?$q$,
    $q${"A":"A baton","B":"A whistle","C":"A medal","D":"A net"}$q$::jsonb,
    $q$A$q$,
    $q$A baton is passed between runners in a relay.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Sports$q$,
    $q$A referee stops a match because a player has broken a rule. The breach is a what?$q$,
    $q${"A":"Fixture","B":"Foul","C":"Final","D":"Draw"}$q$::jsonb,
    $q$B$q$,
    $q$A foul is an action that violates the rules of a sport.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Sports$q$,
    $q$A team wins every match in a round-robin competition. It finishes with the highest what?$q$,
    $q${"A":"Ticket price","B":"Attendance list","C":"Points total","D":"Substitution count"}$q$::jsonb,
    $q$C$q$,
    $q$Wins earn competition points, so repeated wins raise the team's total.$q$
  ),
  (
    $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid,
    (SELECT exam_type FROM public.subjects WHERE id = $q$08a7b6eb-f028-4d94-8cd7-9d3739a01d93$q$::uuid AND lower(exam_type::text) = $q$waec$q$),
    $q$original$q$,
    NULL,
    $q$Sports$q$,
    $q$A player moves from the bench into the game to replace another player. This is a what?$q$,
    $q${"A":"Disqualification","B":"Replay","C":"Forfeit","D":"Substitution"}$q$::jsonb,
    $q$D$q$,
    $q$A substitution replaces one active player with another.$q$
  );
