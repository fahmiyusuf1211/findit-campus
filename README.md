
# FindIt Campus

**FindIt Campus** adalah aplikasi mobile berbasis Flutter untuk membantu mahasiswa mencari informasi barang hilang dan barang yang ditemukan di lingkungan kampus.

## Fitur Aplikasi

- **Beranda:** Menampilkan informasi utama, kategori populer, dan daftar barang terbaru.
- **Pencarian Barang:** Mencari barang berdasarkan nama atau lokasi.
- **Filter Kategori:** Memfilter barang berdasarkan kategori seperti Elektronik, Aksesori & Helm, Kartu Identitas, Alat Tulis, dan Lainnya.
- **Daftar Barang:** Menampilkan daftar barang berdasarkan kategori dan status kehilangan.
- **Detail Barang:** Menampilkan nama, kategori, status, lokasi, waktu laporan, dan deskripsi barang.
- **Navigasi:** Menghubungkan halaman beranda, daftar barang, detail barang, pencarian, laporan, notifikasi, dan profil.

## Teknologi yang Digunakan

- Flutter
- Dart
- Android Studio
- Material Design

## Struktur Halaman

1. **Beranda** — halaman utama aplikasi.
2. **Daftar Barang** — halaman untuk melihat dan memfilter barang.
3. **Detail Barang** — halaman yang menampilkan informasi barang yang dipilih.

## Struktur Proyek

```text
findit_campus/
├── android/
├── lib/
│   ├── main.dart
│   ├── items_page.dart
│   └── detail_page.dart
├── test/
├── pubspec.yaml
├── pubspec.lock
└── README.md
```

## Persyaratan

Sebelum menjalankan aplikasi, pastikan perangkat pengembangan sudah memiliki:

- Flutter SDK
- Android Studio
- Android SDK dan emulator atau perangkat Android fisik

## Cara Menjalankan Aplikasi

1. Clone atau unduh repositori proyek.
2. Buka folder proyek melalui Android Studio.
3. Buka terminal pada direktori proyek.
4. Jalankan perintah berikut:

```bash
flutter pub get
```

5. Hubungkan perangkat Android atau jalankan emulator.
6. Jalankan aplikasi dengan perintah:

```bash
flutter run
```

## Data Aplikasi

Versi saat ini menggunakan data barang contoh (*dummy data*) yang disimpan di dalam kode aplikasi. Data tersebut digunakan untuk mendemonstrasikan pencarian, filter kategori, daftar barang, dan halaman detail.

Aplikasi belum menggunakan backend atau database untuk menyimpan laporan secara permanen.

## Pengujian

Aplikasi dikembangkan menggunakan Flutter dan diuji melalui emulator Android. Pengujian pada perangkat Android fisik dapat dilakukan untuk memeriksa tampilan dan interaksi aplikasi.

## Pengembangan Selanjutnya

- Menambahkan foto barang.
- Mengembangkan fitur pelaporan barang.
- Menghubungkan aplikasi ke database.
- Mengimplementasikan autentikasi pengguna.
- Mengembangkan proses klaim dan verifikasi barang.
