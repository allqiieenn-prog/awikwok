# Keuangan PM

Web statis (HTML/CSS/JS) + database Supabase. Hosting gratis di GitHub Pages.

## 1. Siapkan Supabase
1. Buat project di supabase.com.
2. SQL Editor → tempel isi `schema.sql` → Run.
3. Authentication → Users → **Add user** (email + password untuk login ke aplikasi). Di Authentication → Sign In / Providers, matikan "Allow new users to sign up".
4. Project Settings → API → salin **Project URL** dan **anon/publishable key** ke `config.js`.

## 2. Upload ke GitHub Pages
Upload semua file ke repository → Settings → Pages → Deploy from branch `main` / root.

## Sudah pernah memakai versi lama?
Jalankan `migration.sql` di SQL Editor (sekali saja), bukan `schema.sql`. Data relawan harian lama tidak ikut karena sekarang dicatat per nama pegawai.

## Cara pakai singkat
- **Pegawai**: tambah divisi, lalu pegawai (nama, divisi, gaji per hari).
- **Harian**: pilih tanggal, isi jumlah PM, klik nama pegawai yang masuk (per divisi), Simpan. Tombol "Lope" menyalin data kemarin.
- **Biaya**: pengeluaran harian/bulanan. **Belanja mingguan**: input jumlah barang + total belanja di awal, lalu catat hanya jumlah yang dipakai; nominal dihitung otomatis.
- **Laporan**: hanya hari yang sudah terisi; klik "Ubah" di baris untuk mengoreksi. Bisa diunduh Excel.
