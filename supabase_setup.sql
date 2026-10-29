-- Execute este SQL no SQL Editor do seu projeto Supabase.
create table if not exists public.app_state (
  user_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.app_state enable row level security;
create policy "Usuário lê seus próprios dados" on public.app_state
for select to authenticated using (auth.uid() = user_id);
create policy "Usuário cria seus próprios dados" on public.app_state
for insert to authenticated with check (auth.uid() = user_id);
create policy "Usuário atualiza seus próprios dados" on public.app_state
for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
