# AI_DECLARATION.md

## Deklarasi Transparansi Penggunaan AI

**Nama Proyek:** SIMSAR (Sistem Informasi Sarana dan Prasarana)  
**Teknologi:** Flutter dan Dart  
**Tujuan Dokumen:** Menjelaskan penggunaan alat bantu AI selama proses pengembangan aplikasi secara transparan.

## 1. Daftar Alat Bantu

Alat: Penggunaan 

 ChatGPT : Membantu memahami kode Flutter/Dart, menyusun atau merevisi bagian kode berdasarkan kebutuhan, menjelaskan pesan kesalahan, serta memberi saran perbaikan dan perintah Git.
 Visual Studio Code : Editor yang digunakan untuk menulis, mengubah, dan memeriksa kode proyek. 
 Flutter CLI (`flutter analyze`) : Memeriksa kode dan menampilkan error, warning, atau info analisis. 
 Git dan GitHub : Mengelola riwayat perubahan dan menyimpan kode proyek melalui version control. 


## 2. Pembagian Peran AI dan Pengerjaan Manual

AI digunakan sebagai alat bantu, sedangkan keputusan akhir, pemeriksaan, penyesuaian, dan pengujian tetap dilakukan oleh pengembang. Pembagian berikut menjelaskan penggunaan yang tercatat dalam proses pengerjaan; sesuaikan jika ada modul yang sebenarnya dikerjakan dengan cara berbeda.

 Modul atau aktivitas:  Peran AI : Peran pengembang secara manual 

Autentikasi dan navigasi login : Membantu menjelaskan alur login dan memberi contoh navigasi berdasarkan peran akun. : Menempatkan kode pada proyek, mencocokkan nama class dan jalur import, lalu menguji alur login sesuai struktur aplikasi. 

Dashboard admin : Membantu menyusun dan merapikan kode tampilan, ringkasan jumlah laporan, serta navigasi ke halaman lain. : Menyesuaikan kode dengan struktur proyek dan menjaga tampilan yang telah dipilih. 

Kelola laporan : Membantu menyusun tampilan daftar laporan dan contoh perubahan status laporan. : Memeriksa kecocokan dengan model `Laporan` dan `LaporanDummy`, termasuk nama properti serta cara memperbarui data. 

Statistik laporan : Membantu menyusun perhitungan jumlah laporan berdasarkan status dan tampilan ringkasan statistik. : Memeriksa perhitungan serta memperbaiki nama class dan pemanggilannya berdasarkan hasil `flutter analyze`. 

Penanganan masalah kode : Membantu menjelaskan pesan error, warning, dan saran perbaikannya. : Menjalankan `flutter analyze`, menerapkan perubahan, lalu memeriksa kembali hasil analisis. 

Git dan GitHub : Membantu menyarankan perintah Git dan merumuskan pesan commit. : Menjalankan perintah di terminal dan memeriksa perubahan sebelum melakukan commit dan push. 

**Pernyataan tentang kode manual:** Dokumen ini tidak mengklaim bahwa suatu modul sepenuhnya ditulis manual jika hal tersebut belum diverifikasi. Bagian yang diketik atau dirancang sendiri tanpa bantuan AI dapat ditambahkan secara spesifik oleh pengembang berdasarkan riwayat kerja yang sebenarnya.

## 3. Studi Kasus Prompting

### Studi Kasus 1 — Pemisahan halaman admin

**Tujuan:** Memisahkan dashboard, kelola laporan, dan statistik ke file berbeda agar struktur kode lebih mudah dikelola.

**Contoh prompt yang digunakan:**

> “Aku mau memisahkan halaman laporan dan statistik dari dashboard admin ke file Dart masing-masing. Tolong pisahkan kodenya tanpa mengubah UI dashboard admin.”

**Hasil awal dari AI:**  
AI memberikan contoh pemisahan menjadi `admin_dashboard_screen.dart`, `admin_laporan_screen.dart`, dan `admin_statistik_screen.dart`, beserta contoh import dan navigasi antarhalaman.

**Penyesuaian dan pemeriksaan manual:**  
Kode perlu dicocokkan dengan struktur proyek yang sebenarnya. Pengembang memastikan bahwa nama file, nama class, import, serta pemanggilan halaman sesuai. Karena tampilan dashboard harus dipertahankan, perubahan seharusnya berfokus pada pemisahan kode dan navigasi, bukan mendesain ulang tampilan. Hasil akhir perlu dibandingkan dengan UI sebelumnya dan diperiksa menggunakan `flutter analyze`.

### Studi Kasus 2 — Memperbaiki hasil analisis kode

**Tujuan:** Memperbaiki masalah penamaan class dan pemanggilan widget pada halaman statistik.

**Contoh prompt yang digunakan:**

> “Aku menjalankan `flutter analyze`, tetapi muncul error bahwa `_barisStatistik` tidak ditemukan, sementara deklarasi `_BarisStatistik` tidak digunakan. Tolong bantu perbaiki tanpa mengubah UI.”

**Hasil awal dari AI:**  
AI mengidentifikasi bahwa nama class dan nama yang dipanggil harus konsisten. AI menyarankan penggunaan nama `_BarisStatistik` sesuai konvensi penamaan class Dart.

**Penyesuaian dan pemeriksaan manual:**  
Pengembang perlu mengganti seluruh pemanggilan `_barisStatistik(...)` menjadi `_BarisStatistik(...)` dan memastikan deklarasi class serta constructor berada pada struktur yang benar. Setelah perubahan disimpan, pengembang menjalankan kembali `flutter analyze` untuk memastikan error sudah teratasi. Perubahan tidak dianggap berhasil hanya karena saran AI telah diberikan; hasilnya harus diverifikasi melalui analisis kode.

## 4. Verifikasi dan Batasan Penggunaan AI

1. Kode yang dihasilkan atau disarankan AI tidak langsung dianggap benar dan tetap perlu diperiksa.
2. Pengembang bertanggung jawab atas pemahaman alur program, pemilihan perubahan, pengujian, dan hasil akhir aplikasi.
3. Hasil `flutter analyze` digunakan untuk membantu mendeteksi masalah kode, tetapi tidak menggantikan pengujian fungsi aplikasi secara langsung.
4. Jika data masih menggunakan class dummy atau penyimpanan sementara, hal tersebut harus dinyatakan dengan jelas dan tidak disebut sebagai database permanen.
5. Prompt dan contoh hasil AI di dokumen ini merupakan ringkasan dari proses bantuan AI. Untuk pelaporan akademik, isi dokumen perlu disesuaikan dengan riwayat pengerjaan yang benar-benar dilakukan.

## 5. Pernyataan Transparansi

Saya menyatakan bahwa AI digunakan sebagai alat bantu dalam proses pengembangan SIMSAR, terutama untuk memahami kode, memperoleh contoh implementasi, dan membantu menelusuri masalah pemrograman. Penggunaan AI tidak menggantikan tanggung jawab saya dalam memeriksa, menyesuaikan, menguji, dan memahami kode yang digunakan. Saya bertanggung jawab atas keakuratan deklarasi ini serta hasil akhir proyek.
