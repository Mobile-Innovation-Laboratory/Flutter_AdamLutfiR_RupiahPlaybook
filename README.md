# Rupiah Playbook

![Cuplikan Layar 5](https://raw.githubusercontent.com/Mobile-Innovation-Laboratory/Flutter_AdamLutfiR_RupiahPlaybook/main/assets/splash/Splash.png)

## Daftar Isi

- [Dekripsi Aplikasi](#deskripsi-aplikasi)
- [Fitur](#fitur)
- [Package](#package)
- [Screenshots](#screenshots)
- [Credit](#credit)

## Deskripsi Aplikasi

Rupiah Playbook merupakan aplikasi manajemen keuangan dengan input dari penggunanya, aplikasi ini berfokus pada pengelolaan data penggunanya hingga dapat memvisualisasikan pemasukan dan pengeluaran pengguna menggunakan grafik dan perbandingan aktifitas keuangan penggunanya.

## Fitur

### Fitur Pengguna

- User dapat mendaftarkan dan login menggunakan email dan password melalui Firebase Auth
- User dapat membaca, memasukkan, mengubah dan menghapus data pemasukan maupun pengeluarannya dalam aplikasi melalui Cloud Firestore (CRUD)
- Aplikasi menyimpan data login user, hingga user tidak perlu login kembali untuk masuk ke aplikasi jika sebelumnya belum menekan tombol logout
- User dapat melihat visualisasi data keuangannya seperti grafik yang akan menampilkan data mingguan dan visualisasi perbandingan aktifitas keuangannya
- Aplikasi menyimpan uid user dalam local storage agar user dapat lebih lancar dalam menggunakan aplikasi
- Aplikasi memiliki tampilan yang sederhana dan mudah digunakan
- Aplikasi memiliki fitur tampilan mode malam dan mode cerah

### Fitur Pengembang

- Aplikasi menggunakan state management GetX agar lebih ringan dan lebih cepat dalam pengembangannya
- Aplikasi menggunakan struktur MVC agar lebih mudah dikelola
- Aplikasi menggunakan sistem dashboard untuk memperbagus tampilan dan interatifitas lengkap dengan animasi saat menuju atau keluar dari halaman
- Aplikasi ini memiliki floatingactionbutton yang memiliki fungsi yang digunakan user untuk menambahkan data
- Aplikasi ini dapat menyinkronkan datanya hampir secara realtime melalui layanan firebase
- Lainnya akan dijelaskan pada bagian [Package](#deskripsi-aplikasi)

## Package

- cloud_firestore: ^5.6.3
  > Package ini digunakan untuk mengelola data yang tersambung antar aplikasi dan firebase sebagai penyedia layanan _Backend-as-a-Service (BaaS)_
- firebase_auth: ^5.4.2
  > Package ini digunakan untuk mengelola data user sekaligus menangani proses registrasi dan autentikasi yang juga merupakan salah satu layanan dari firebase
- get: ^4.7.2
  > Package ini digunakan untuk mempermudah dan meringankan state management pengembangan aplikasi flutter
- shared_preferences: ^2.5.2
  > Package ini digunakan untuk melakukan penyimpanan lokal pada aplikasi yang bersifat non-volatile (tidak sementara)
- fl_chart: ^0.70.2
  > Package ini digunakan untuk melakukan visualisasi grafik dari data yang dimasukkan dengan beberapa kustomisasi
- intl: ^0.20.2
  > Package ini digunakan untuk mempermudah pengolahan data seperti konversi format angka, waktu tanggal dan semacamnya
- flutter_screenutil: ^5.9.3
  > Package ini digunakan untuk memperbaiki masalah ukuran ukuran seperti teks dan sebagainya agar tampilan aplikasi menjadi teroptimisasi di berbagai ukuran
- google_fonts: ^6.2.1
  > Package ini digunakan untuk memberi tampilan gaya / font dari teks agar lebih bagus dan interaktif (Pilih roboto karena termasuk font yang sering saya gunakan diberbagai macam hal)
- flutter_native_splash: ^2.4.5
  > Package ini digunakan untuk memberi tampilan splash saat aplikasi dibuka, digunakan native splash karena memiliki performa yang lebih bagus
- flutter_launcher_icons: ^0.14.3
  > Package ini digunakan untuk memberi tampilan icon aplikasi hingga aplikasi mudah dikenali dan memiliki ciri khas tersendiri

## Screenshots

![Cuplikan Layar 1](https://raw.githubusercontent.com/Mobile-Innovation-Laboratory/Flutter_AdamLutfiR_RupiahPlaybook/main/assets/screenshots/Cuplikan%20layar%202025-02-27%20225654.png)  
![Cuplikan Layar 2](https://raw.githubusercontent.com/Mobile-Innovation-Laboratory/Flutter_AdamLutfiR_RupiahPlaybook/main/assets/screenshots/Cuplikan%20layar%202025-02-27%20225706.png)  
![Cuplikan Layar 3](https://raw.githubusercontent.com/Mobile-Innovation-Laboratory/Flutter_AdamLutfiR_RupiahPlaybook/main/assets/screenshots/Cuplikan%20layar%202025-02-27%20225716.png)  
![Cuplikan Layar 4](https://raw.githubusercontent.com/Mobile-Innovation-Laboratory/Flutter_AdamLutfiR_RupiahPlaybook/main/assets/screenshots/Cuplikan%20layar%202025-02-27%20225728.png)  
![Cuplikan Layar 5](https://raw.githubusercontent.com/Mobile-Innovation-Laboratory/Flutter_AdamLutfiR_RupiahPlaybook/main/assets/screenshots/Cuplikan%20layar%202025-02-27%20232629.png)

## Credit

> Versi code berisi berbagai macam dokumentasi error dan bug yang saya temukan akan diupload pada akun github saya - Adam
