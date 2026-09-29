-- Persist each practice answer atomically so leaving a set early still counts.
-- Existing mock-exam persistence is unchanged. The browser's displayed answer
-- order is randomized, so this routine accepts its practice-only correctness
-- result; it is not a secure grading authority for high-stakes exams.
begin;

create index if not exists answers_session_question_lookup_idx
  on public.answers (session_id, question_id);

create or replace function public.record_practice_answer(
  p_session_id uuid,
  p_question_id uuid,
  p_selected_answer text,
  p_is_correct boolean,
  p_exam_type text
)
returns jsonb
language plpgsql
security definer
set search_path = public, pg_temp
as $$
declare
  v_user_id uuid := auth.uid();
  v_session_id uuid := p_session_id;
  v_question_exam_type public.questions.exam_type%type;
  v_question_options jsonb;
  v_existing_answer text;
  v_answered integer;
  v_correct integer;
  v_score integer;
begin
  if v_user_id is null then
    raise exception 'Authentication required' using errcode = '42501';
  end if;
  if p_selected_answer is null or p_selected_answer = ''
     or length(p_selected_answer) > 80
     or p_is_correct is null or p_exam_type is null
     or p_exam_type not in ('jamb', 'waec') then
    raise exception 'Invalid practice answer' using errcode = '22023';
  end if;

  select exam_type, options into v_question_exam_type, v_question_options
  from public.questions where id = p_question_id;
  if v_question_exam_type is null
     or lower(v_question_exam_type::text) <> p_exam_type
     or not (v_question_options ? p_selected_answer) then
    raise exception 'Question does not match exam type' using errcode = '22023';
  end if;

  if v_session_id is null then
    v_session_id := gen_random_uuid();
  end if;

  perform 1 from public.sessions
  where id = v_session_id and user_id = v_user_id
    and mode::text = 'practice'
    and lower(exam_type::text) = p_exam_type
  for update;
  if not found then
    insert into public.sessions
      (id, user_id, mode, exam_type, score, total_questions, completed_at)
    values (v_session_id, v_user_id, 'practice', v_question_exam_type, 0, 0, null);
  end if;

  select selected_answer into v_existing_answer
  from public.answers
  where session_id = v_session_id and question_id = p_question_id
  limit 1;
  if found and v_existing_answer is distinct from p_selected_answer then
    raise exception 'This question was already answered' using errcode = '22023';
  end if;
  if not found then
    insert into public.answers
      (session_id, question_id, selected_answer, is_correct, exam_type)
    values (v_session_id, p_question_id, p_selected_answer,
            p_is_correct, v_question_exam_type);
  end if;

  select count(*), count(*) filter (where is_correct)
  into v_answered, v_correct
  from public.answers where session_id = v_session_id;
  v_score := round(100.0 * v_correct / greatest(v_answered, 1));
  update public.sessions
  set score = v_score, total_questions = v_answered, completed_at = now()
  where id = v_session_id;

  return jsonb_build_object(
    'session_id', v_session_id, 'answered', v_answered,
    'correct', v_correct, 'score', v_score
  );
end;
$$;

revoke all on function public.record_practice_answer(uuid, uuid, text, boolean, text)
  from public, anon, authenticated;
grant execute on function public.record_practice_answer(uuid, uuid, text, boolean, text)
  to authenticated;

commit;
