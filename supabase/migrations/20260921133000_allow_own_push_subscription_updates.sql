-- Browsers re-register the same endpoint when its keys rotate.  Keep that
-- update scoped to the owning authenticated user; it cannot transfer an
-- endpoint to another account.
drop policy if exists "Users can update own push subscriptions" on public.push_subscriptions;
create policy "Users can update own push subscriptions"
  on public.push_subscriptions for update
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
