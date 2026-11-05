-- INSTALASI BARU: jalankan di Supabase > SQL Editor
-- (Sudah pernah memakai versi lama? Jalankan migration.sql saja.)
create table settings(id int primary key default 1 check(id=1), rate int not null default 3000, work_days int[] not null default '{1,2,3,4,5,6}');
insert into settings default values;
create table days(date date primary key, active boolean not null default true, pm int);
create table divisions(id bigint generated always as identity primary key, name text not null);
create table employees(id bigint generated always as identity primary key, name text not null, division_id bigint not null references divisions(id) on delete cascade, wage int not null default 0);
create table attendance(date date not null, employee_id bigint not null references employees(id) on delete cascade, primary key(date,employee_id));
create table expenses(id bigint generated always as identity primary key, date date not null, name text not null, category text not null default 'Lainnya', type text not null check(type in('harian','bulanan')), amount bigint not null);
create table stocks(id bigint generated always as identity primary key, buy_date date not null, name text not null, category text not null default 'Lainnya', qty numeric not null default 1, unit text not null default 'unit', total bigint not null);
create table stock_use(id bigint generated always as identity primary key, stock_id bigint not null references stocks(id) on delete cascade, date date not null, qty numeric not null);
do $$ declare t text; begin
 foreach t in array array['settings','days','divisions','employees','attendance','expenses','stocks','stock_use'] loop
  execute format('alter table %I enable row level security',t);
  execute format('create policy "login_penuh" on %I for all to authenticated using(true) with check(true)',t);
 end loop; end $$;
