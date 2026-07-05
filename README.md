# Coffee Kota Hujan — QR Menu Ordering System

Sistem pemesanan berbasis QR code untuk Coffee Kota Hujan
(Kelurahan Stadion, Ternate). Dibuat dari template
[loyalty-template](https://github.com/hellnoo/loyalty-template),
arsitektur sama dengan [hallu-loyalty](https://github.com/hellnoo/hallu-loyalty).

Customer scan QR di meja → pesan dari HP → realtime ke kasir.

## Fitur

**Customer (`/menu?table=N`)**
- Browse menu dengan kategori (Kopi, Non-Kopi, Makanan, Lainnya)
- 3D product showcase modal dengan atmosfer per kategori
- Cart persist di localStorage, order persist 3 jam
- Rating bintang setelah selesai
- 💬 AI Barista chatbot
- ✨ Rekomendasi cerdas saat di cart

**Kasir (`/kasir`)**
- Realtime order masuk + bunyi notif berulang
- Flow: Diterima → Disiapkan → Siap → Selesai
- Input manual, struk WA ke customer
- Wake Lock (layar tidak mati)
- Tutup Kasir → Smart Daily Report ke WA owner

**Admin (`/admin`)**
- Kelola menu + upload foto (auto-compress)
- Kalkulator HPP per komponen
- ✨ Auto-generate deskripsi (AI)
- Analitik: revenue chart, jam ramai, top item
- 🧠 Menu Engineering AI (BCG matrix)
- Pengaturan jam buka/tutup
- CSV export + cleanup data lama

## Tech Stack

- Next.js 15 (App Router)
- Supabase (Postgres + Realtime + Storage)
- Tailwind CSS
- Anthropic Claude (5 fitur AI)
- Web Push (VAPID)
- PWA-ready

## Setup

1. Salin `.env.example` ke `.env.local` dan isi semua nilainya
   (buat project Supabase **baru**, jangan share dengan Hallu)
2. Jalankan `supabase-setup.sql` di Supabase SQL Editor
3. `npm install && npm run dev`

## TODO sebelum launch

- [ ] `src/app/page.tsx` — ganti koordinat `LOC` dengan titik persis dari
  Google Maps (Share → Copy link), sekarang masih perkiraan area Stadion
- [ ] `src/app/page.tsx` — ganti link Instagram/TikTok (`@coffee.kotahujan`
  masih placeholder) dan nomor WA bila bukan nomor owner
- [ ] `src/app/kasir/page.tsx` — cek `OWNER_WA` (tujuan daily report)
- [ ] Isi menu lewat `/admin`, generate QR meja lewat `/admin/qr`
- [ ] Opsional: sesuaikan palet warna (maroon/cream bawaan Hallu) di
  `tailwind.config.ts`, `src/app/globals.css`, `public/icon.svg`
