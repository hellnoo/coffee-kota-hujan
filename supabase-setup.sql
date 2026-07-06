-- ============================================================
-- Coffee Kota Hujan — Supabase Setup
-- Jalankan di SQL Editor project Supabase (atau via Management API)
-- ============================================================

-- ── Tabel ───────────────────────────────────────────────────

create table if not exists menu_items (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  description text,
  price int not null,
  hpp int not null default 0,
  hpp_components jsonb not null default '[]'::jsonb,
  category text,
  available boolean default true,
  image_url text,
  model_3d_url text,
  model_3d_task_id text,
  created_at timestamptz default now()
);

create table if not exists orders (
  id uuid primary key default gen_random_uuid(),
  table_number int not null,
  items jsonb not null,
  status text default 'new',
  note text,
  customer_name text,
  phone text,
  payment_method text,
  rating int,
  outlet text not null default 'cafe',   -- 'cafe' | 'street'
  created_at timestamptz default now()
);
create index if not exists orders_outlet_idx on orders(outlet);

create table if not exists store_settings (
  id int primary key,
  open_time text not null default '08:00',
  close_time text not null default '22:00',
  open_days text not null default 'Senin – Minggu',
  is_manually_closed boolean not null default false,
  location_lat double precision,   -- kosong = pakai default di kode
  location_lng double precision,
  location_address text
);
insert into store_settings (id) values (1) on conflict do nothing;

create table if not exists shifts (
  id uuid primary key default gen_random_uuid(),
  employee_name text not null,
  started_at timestamptz not null default now(),
  ended_at timestamptz,
  opening_notes text,
  closing_notes text,
  handover_to text,
  outlet text not null default 'cafe'    -- 'cafe' | 'street'
);

create table if not exists push_subscriptions (
  endpoint text primary key,
  subscription jsonb not null,
  type text not null,
  order_id uuid,
  created_at timestamptz default now()
);

-- ── Realtime: order masuk/update langsung ke /kasir & /menu ─
alter publication supabase_realtime add table orders;

-- ── Storage: bucket foto menu (publik) ──────────────────────
insert into storage.buckets (id, name, public)
values ('menu-images', 'menu-images', true)
on conflict (id) do nothing;

create policy "anon read menu-images" on storage.objects
  for select using (bucket_id = 'menu-images');
create policy "anon upload menu-images" on storage.objects
  for insert with check (bucket_id = 'menu-images');
create policy "anon update menu-images" on storage.objects
  for update using (bucket_id = 'menu-images');
create policy "anon delete menu-images" on storage.objects
  for delete using (bucket_id = 'menu-images');

-- ── Seed menu awal ──────────────────────────────────────────
insert into menu_items (name, description, price, category, available) values
  ('Americano',         'Espresso dengan air panas, bold dan bersih',                   18000, 'Kopi',     true),
  ('Latte',             'Espresso dengan susu steamed creamy',                          22000, 'Kopi',     true),
  ('V60 Single Origin', 'Manual brew pour-over, tergantung bean hari ini',              28000, 'Kopi',     true),
  ('Kopi Susu Aren',    'Espresso dengan gula aren dan susu segar',                     20000, 'Kopi',     true),
  ('Matcha Latte',      'Matcha Jepang premium dengan susu oat',                        22000, 'Non-Kopi', true),
  ('Coklat Panas',      'Dark chocolate blend, rich dan tidak terlalu manis',           18000, 'Non-Kopi', true),
  ('Es Teh Tarik',      'Teh dengan susu kental manis, segar dan gurih',                15000, 'Non-Kopi', true),
  ('Roti Bakar Keju',   'Roti brioche panggang dengan keju mozarella meleleh',          15000, 'Makanan',  true),
  ('Croissant',         'Croissant butter flaky, disajikan hangat',                     18000, 'Makanan',  true),
  ('Pasta Aglio Olio',  'Spaghetti dengan bawang putih, cabai, olive oil, dan parsley', 35000, 'Makanan',  true);
