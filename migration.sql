-- MIGRASI dari versi lama (headcount + nominal persediaan). Jalankan sekali di SQL Editor.
create table employees(id bigint generated always as identity primary key, name text not null, division_id bigint not null references divisions(id) on delete cascade, wage int not null default 0);
create table attendance(date date not null, employee_id bigint not null references employees(id) on delete cascade, primary key(date,employee_id));
alter table stocks add column qty numeric not null default 1, add column unit text not null default 'unit';
alter table stock_use add column qty numeric not null default 0;
update stock_use u set qty=u.amount::numeric/nullif(s.total,0) from stocks s where s.id=u.stock_id;
alter table stock_use drop column amount;
alter table divisions drop column if exists wage;
drop table if exists headcount;
do $$ declare t text; begin
 foreach t in array array['employees','attendance'] loop
  execute format('alter table %I enable row level security',t);
  execute format('create policy "login_penuh" on %I for all to authenticated using(true) with check(true)',t);
 end loop; end $$;
-- Catatan: data relawan harian lama (headcount) tidak ikut karena sekarang dicatat per nama pegawai.
