# Flydle App – Aplikasi Mobile Autentikasi

Flydle App adalah aplikasi mobile yang dibangun menggunakan **Flutter** dengan fokus pada implementasi **autentikasi dan manajemen profil pengguna** menggunakan **Supabase** sebagai backend service. Proyek ini bertujuan untuk mempelajari integrasi backend pada aplikasi mobile, khususnya untuk proses login, registrasi, dan pengelolaan profil pengguna.

## Tech Stack

- Framework: Flutter
- Bahasa: Dart
- Backend as a Service: Supabase
- Navigation: Navigator
- State Management: setState

## Menjalankan proyek

Pastikan **Flutter SDK** sudah terpasang dan terkonfigurasi dengan benar.

1. **Clone repository**
```bash
git clone https://github.com/auxiliaz/flydle-app.git
cd flydle-app 
```
2. **Install dependencies**
```bash
flutter pub get
```
3. **Konfigurasi Supabase**
   - Buat project di Supabase
   - Masukkan `SUPABASE_URL` dan `SUPABASE_ANON_KEY` ke dalam konfigurasi aplikasi (misalnya di file constant / env)
4. **Jalankan aplikasi**
```bash
flutter run 
```

## Fitur utama

- Registrasi pengguna menggunakan email dan password.
- Login pengguna dengan autentikasi Supabase.
- Halaman utama (Home) setelah login.
- Halaman profil pengguna.
- Update data profil (nama dan password).
- Logout dan penghapusan session.
- Navigasi antar halaman menggunakan Navigator.

## Alur kerja aplikasi

1. **Autentikasi Pengguna**
   - Pengguna dapat melakukan registrasi dengan nama, email, dan password.
   - Proses autentikasi sepenuhnya ditangani oleh Supabase Auth.
   - Setelah login berhasil, session pengguna disimpan oleh Supabase.

2. **Home Page**
   - Pengguna diarahkan ke halaman Home setelah autentikasi berhasil.
   - Nama pengguna ditampilkan berdasarkan data yang diambil dari Supabase.
   - Konten pada halaman ini masih berupa dummy data sebagai representasi UI aplikasi utama.

3. **Profile Page**
   - Pengguna dapat melihat data profil yang tersimpan di Supabase.
   - Pengguna dapat memperbarui:
     1. Nama
     2. Password
   - Perubahan data langsung disinkronkan ke database Supabase.

4. **Navigasi**
   - Navigasi antar halaman (Login, Home, Profile) menggunakan Navigator Flutter.
   - Akses ke halaman Home dan Profile dibatasi hanya untuk pengguna yang sudah login.

5. **Logout**
   - Pengguna dapat melakukan logout dari aplikasi.
   - Session Supabase dihapus.
   - Pengguna diarahkan kembali ke halaman login.

## Manajemen Data

- Autentikasi pengguna dikelola menggunakan Supabase Authentication.
- Data profil pengguna disimpan dan diambil dari Supabase Database.
- Tidak menggunakan state management tambahan (mengandalkan `setState`).

## Struktur penting

- `lib/main.dart` – Entry point aplikasi.
- `lib/pages/` – Halaman utama (Login, Home, Profile).
- `lib/services/` – Integrasi Supabase (auth dan database).
- `lib/models/` – Model data pengguna.
- `lib/widgets/` – Komponen UI reusable.

## Keterbatasan Aplikasi

- Konten Home Page masih berupa data statis (dummy).
- Belum terdapat fitur bisnis lanjutan.
- Fokus aplikasi masih terbatas pada autentikasi dan profil pengguna.

## Tujuan Proyek

Proyek ini dibuat untuk:

1. Mempelajari integrasi Supabase pada aplikasi Flutter.
2. Memahami alur autentikasi dan manajemen session.
3. Melatih penggunaan backend service pada aplikasi mobile.
4. Menjadi proyek pembelajaran / evaluasi teknis.
