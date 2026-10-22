# SIMSAR — Sistem Informasi Sarana dan Prasarana Sekolah

SIMSAR adalah prototipe aplikasi mobile berbasis Flutter yang dirancang untuk membantu warga sekolah melaporkan kerusakan fasilitas dan memantau status penanganan laporan. Aplikasi ini dikembangkan sebagai proyek mata kuliah **Mobile Programming**.

> **Status proyek:** project versi ini masih menggunakan data dummy yang disimpan selama aplikasi berjalan. Integrasi backend/database persisten belum terlihat pada kode yang diperiksa. Karena itu, SIMSAR pada versi ini sebaiknya dipahami sebagai prototipe antarmuka dan alur dasar aplikasi, bukan sistem produksi yang sudah terhubung ke server.

## Tujuan

- Memudahkan pengguna membuat laporan kerusakan fasilitas sekolah.
- Menampilkan informasi dan status laporan.
- Membantu admin melihat laporan, memperbarui status, dan memantau ringkasan laporan.
- Menyediakan riwayat laporan sebagai gambaran dokumentasi pelaporan digital.

## Fitur yang tersedia pada kode saat ini

### Pengguna

- Registrasi akun dan login menggunakan data akun dummy.
- Beranda dengan ringkasan dan daftar laporan.
- Membuat laporan kerusakan dengan kategori, lokasi, deskripsi, dan foto.
- Memilih foto dari galeri atau mengambil foto menggunakan kamera, sesuai dukungan perangkat dan izin aplikasi.
- Melihat riwayat laporan, mencari laporan, dan memfilter berdasarkan status.
- Melihat detail laporan.
- Mengubah informasi profil dan memilih foto profil.
- Logout kembali ke halaman login.

### Admin

- Dashboard ringkasan laporan.
- Melihat dan mengelola daftar laporan.
- Memperbarui status laporan menjadi **Menunggu**, **Diproses**, atau **Selesai**.
- Melihat statistik laporan berdasarkan status.
- Mengubah informasi profil admin dan memilih foto profil.
- Logout kembali ke halaman login.

Fitur di atas dideskripsikan berdasarkan struktur dan kode yang tersedia. Ketersediaan fitur di kode tidak berarti semua skenario sudah melalui pengujian formal.

## Teknologi

- **Flutter** — framework antarmuka aplikasi.
- **Dart** — bahasa pemrograman.
- **Visual Studio Code** — editor yang digunakan dalam pengembangan.
- **`image_picker`** — pemilihan foto dari galeri atau kamera.
- **Material Design** — komponen antarmuka Flutter.

## Struktur direktori utama

simsar/

├── assets/

│   └── logo_simsar.png

├── lib/

│   ├── data/

│   │   ├── akun_dummy.dart

│   │   └── laporan_dummy.dart

│   ├── screens/

│   │   ├── admin/

│   │   ├── auth/

│   │   ├── siswa/

│   │   └── splash_screen.dart

│   ├── utils/

│   │   ├── app_colors.dart

│   │   └── app_theme.dart

│   └── main.dart

├── test/

├── pubspec.yaml

└── README.md


## Persyaratan

Sebelum menjalankan aplikasi, siapkan:

- Flutter SDK yang sudah terpasang dan dapat diakses melalui terminal.
- Dart SDK yang sesuai dengan versi Flutter.
- Visual Studio Code atau editor lain yang mendukung Flutter.
- Emulator Android atau perangkat Android yang dikonfigurasi untuk pengembangan.

Versi SDK yang ditentukan dalam `pubspec.yaml` proyek ini adalah `^3.13.3`. Pastikan versi Flutter/Dart yang terpasang memenuhi persyaratan tersebut.

## Cara menjalankan aplikasi

1. Buka folder proyek `simsar` di Visual Studio Code.
2. Buka terminal pada direktori proyek.
3. Unduh dependensi:

   flutter pub get


4. Periksa perangkat atau emulator yang tersedia:

   flutter devices


5. Jalankan aplikasi:

   flutter run

Jika ada lebih dari satu perangkat yang terhubung, pilih perangkat tujuan sesuai daftar dari `flutter devices`.

## Catatan tentang data dan autentikasi

Pada kode yang diperiksa, akun dan laporan dikelola melalui kelas `PengelolaAkun` dan `LaporanDummy`. Data tersebut bersifat dummy/in-memory, sehingga perubahan tidak dirancang untuk tersimpan permanen ke database setelah aplikasi ditutup. Login pada versi ini juga belum menggunakan layanan autentikasi server. Jangan menggunakan akun atau kata sandi contoh untuk layanan nyata.

Untuk penggunaan nyata, aplikasi masih memerlukan backend/database, autentikasi yang aman, penyimpanan laporan dan foto secara persisten, serta pengujian keamanan dan fungsional.

## Dokumentasi aplikasi

## Pengembang

- **Nama:** Tiara Dwi Priliantika
- **NPM:** 2413025060
- **Kelas:** PTI 24B
- **Program Studi:** Pendidikan Teknologi Informasi
- **Fakultas:** Fakultas Keguruan dan Ilmu Pendidikan
- **Universitas:** Universitas Lampung
- **Mata kuliah:** Mobile Programming
- **Dosen pengampu:** Ghea Chandra Surawan, M.Pd.

## Pengembangan selanjutnya

Beberapa hal yang dapat dikembangkan pada tahap berikutnya:

- Menghubungkan aplikasi dengan backend dan database.
- Menyimpan akun, laporan, foto, dan perubahan status secara persisten.
- Memperkuat autentikasi dan pengelolaan hak akses.
- Melakukan pengujian fungsional pada perangkat Android.
- Menambahkan notifikasi apabila dibutuhkan.
