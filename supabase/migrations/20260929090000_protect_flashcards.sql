-- The Pro flashcard page must not rely on its client-side gate for access.
-- Remove direct browser reads and expose the deck only through a Pro-checked RPC.
begin;

alter table public.flashcards enable row level security;

revoke select on table public.flashcards from public, anon, authenticated;
do $$
declare
  columns_to_revoke text;
begin
  select string_agg(quote_ident(attname), ', ')
    into columns_to_revoke
  from pg_attribute
  where attrelid = 'public.flashcards'::regclass
    and attnum > 0
    and not attisdropped;

  execute format(
    'revoke select (%s) on table public.flashcards from public, anon, authenticated',
    columns_to_revoke
  );
end;
$$;
grant select on table public.flashcards to service_role;

create or replace function public.get_pro_flashcards()
returns setof public.flashcards
language plpgsql
stable
security definer
set search_path = public, pg_temp
as $$
begin
  if auth.uid() is null or not public.user_has_active_pro(auth.uid()) then
    raise exception 'An active Pro plan is required to view flashcards'
      using errcode = '42501';
  end if;

  return query
    select card.*
    from public.flashcards as card
    order by card.created_at, card.id;
end;
$$;

revoke all on function public.get_pro_flashcards()
  from public, anon, authenticated;
grant execute on function public.get_pro_flashcards() to authenticated;

do $$
begin
  if has_any_column_privilege('anon', 'public.flashcards', 'SELECT')
    or has_any_column_privilege('authenticated', 'public.flashcards', 'SELECT')
    or has_function_privilege('anon', 'public.get_pro_flashcards()', 'EXECUTE')
    or not has_function_privilege('authenticated', 'public.get_pro_flashcards()', 'EXECUTE') then
    raise exception 'Flashcard access is not safely configured';
  end if;
end;
$$;

commit;
