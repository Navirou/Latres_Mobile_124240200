# Latres_Mobile_124240200 — NontonSkuy!

Aplikasi Katalog dan Streaming Serial TV (NontonSkuy!) yang dikembangkan menggunakan **Flutter** dan **GetX** untuk memenuhi Latihan Responsi Praktikum Pemrograman Mobile (SI-F). Aplikasi mengintegrasikan API publik **TVMaze**, penyimpanan lokal session menggunakan **SharedPreferences**, dan penyimpanan data favorit menggunakan **Hive**.

---

## 📱 Fitur Utama & Pemenuhan Kriteria

| No | Modul / Kriteria | Bobot | Status | Deskripsi Implementasi |
|---|---|---|---|---|
| 1 | **Login Page** | 15% | ✅ Selesai | Input Username adalah NIM (`124240200`) dan Password adalah `123`. Menyimpan status login di SharedPreferences. Auto-redirect jika session aktif. |
| 2 | **Home Page (Daftar Shows)** | 30% | ✅ Selesai | Mengambil data dari endpoint `https://api.tvmaze.com/shows`. Menampilkan Grid poster, judul, dan rating bintang. Terdapat loading indicator, fitur pencarian instan, pull-to-refresh, dan navigasi ke Detail. Mekanisme fetch dipisah di `ApiService`. |
| 3 | **Detail Page** | 25% | ✅ Selesai | Data diambil dari endpoint `https://api.tvmaze.com/shows/{id}`. Menampilkan poster hero, judul, rating, genre, status rilis, dan ringkasan/overview (tag HTML dibersihkan). Tombol favorit & tombol kembali fungsional. |
| 4 | **Favorite Page** | 20% | ✅ Selesai | Menampilkan daftar TV show favorit yang disimpan di local database **Hive**. Terdapat tombol hapus (delete) dari favorit dan tap item langsung menuju Detail Page. |
| 5 | **Profile Page** | 10% | ✅ Selesai | Menampilkan username/NIM aktif yang diambil langsung dari SharedPreferences, kartu kesan dan pesan selama praktikum, serta tombol Logout fungsional yang menghapus session dan kembali ke login. |
| 6 | **State Management (GetX)** | Bonus | ✅ Selesai | Menggunakan `GetMaterialApp`, reactive state (`Rx`, `Obx`), GetX Controllers (`AuthController`, `HomeController`, `DetailController`, `FavoriteController`, `MainNavController`), dan GetX route navigation. |

---

## 🛠️ Tech Stack & Dependencies

- **Framework:** Flutter 3.47.2 (Dart 3.13.2)
- **State Management & Routing:** `get: ^4.6.6`
- **Networking:** `http: ^1.2.0`
- **Local Storage (Session):** `shared_preferences: ^2.5.3`
- **Local Storage (NoSQL Favorite Database):** `hive: ^2.2.3` & `hive_flutter: ^1.1.0`
- **Design Tokens:** Dark Cinema Theme (Background `#121212`, Surface `#1E1E1E`, Accent Red `#E50914`, Gold Star `#FFC107`).

---

## 📂 Struktur Direktori

```text
lib/
├── constants/
│   └── theme.dart              # Desain token, warna tema gelap bioskop, styling
├── controllers/
│   ├── auth_controller.dart     # Manajemen login, validasi credential, logout
│   ├── home_controller.dart     # Fetch list shows, pencarian, status loading
│   ├── detail_controller.dart   # Fetch detail show, toggle favorit
│   └── favorite_controller.dart # Mengelola data favorit tersimpan di Hive
├── models/
│   └── tv_show.dart            # Model data TV Show & sanitizer HTML tags
├── services/
│   ├── api_service.dart        # Client TVMaze API (/shows dan /shows/{id})
│   ├── auth_service.dart       # Session SharedPreferences
│   └── storage_service.dart    # Hive box CRUD operasi untuk favorit
├── views/
│   ├── login_page.dart         # Halaman Login
│   ├── main_nav_page.dart      # BottomNavigationBar (Beranda, Favorit, Profil)
│   ├── home_page.dart          # Halaman Beranda / Katalog Serial TV
│   ├── detail_page.dart        # Halaman Detail Show & Aksi Nonton/Favorit
│   ├── favorite_page.dart      # Halaman Daftar Favorit
│   └── profile_page.dart       # Halaman Profil, Kesan & Pesan, Logout
├── widgets/
│   └── show_card.dart          # Komponen kartu serial TV dengan poster & rating
└── main.dart                   # Entry point aplikasi & inisialisasi Hive / Auth
```

---

## 🚀 Panduan Menjalankan Aplikasi

1. Clone repositori:
   ```bash
   git clone https://github.com/Navirou/Latres_Mobile_124240200.git
   cd Latres_Mobile_124240200
   ```
2. Pasang dependensi:
   ```bash
   flutter pub get
   ```
3. Jalankan aplikasi pada emulator atau perangkat fisik:
   ```bash
   flutter run
   ```

---

## 🔑 Kredensial Login

- **Username:** `124240200`
- **Password:** `123`
