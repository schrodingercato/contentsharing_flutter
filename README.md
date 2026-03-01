# contentsharing_flutter

Aplikasi Flutter sederhana bergaya Instagram/WhatsApp/TikTok untuk mengambil/memilih gambar, melihat feed (FYP), mengelola kontak ringan, dan membagikan konten melalui lembar berbagi sistem.

## Highlights
- Tema navy gelap yang modern dengan gradasi pada AppBar.
- Tab navigasi:
  - FYP: feed vertikal ala TikTok/Instagram (dummy, berbasis warna gradasi).
  - Kamera: ambil foto dari kamera.
  - Galeri: pilih gambar dari galeri.
  - Chats: daftar kontak, tambah kontak (nama, nomor HP, kategori), kirim konten.
- Berbagi konten via share sheet native (WhatsApp, Instagram, DM, dll.) menggunakan `share_plus`.
- Menggunakan `image_picker` untuk akses kamera/galeri.

## Cuplikan Fitur
- Ambil/Pilih Gambar: pratinjau langsung di tab Kamera/Galeri.
- Kirim ke Kontak: pilih kontak di tab Chats, ubah gambar dari sheet jika perlu, lalu “Kirim”.
- FYP: geser vertikal untuk melihat postingan orang lain (mock), tombol like/comment/share tersedia.

## Teknologi
- Flutter (Material 3).
- Paket:
  - [`image_picker`](https://pub.dev/packages/image_picker): kamera/galeri.
  - [`share_plus`](https://pub.dev/packages/share_plus): berbagi ke aplikasi lain.

## Struktur Utama
```
lib/
└─ main.dart        // Seluruh UI & flow (FYP, Kamera, Galeri, Chats)
```

## Menjalankan (Android Studio/Emulator)
1. Buka folder proyek ini di Android Studio.
2. Jalankan:
   - Get dependencies: `flutter pub get`
   - Run di emulator Android: `flutter run`

> Catatan: Proyek sudah menyertakan izin dasar Android untuk kamera. Tidak ada penambahan konfigurasi selain dependensi standar Flutter.

## Izin Android
- `android.permission.CAMERA` untuk mengambil foto.
- (Opsional, tergantung OS) akses penyimpanan sesuai kebijakan Android versi target.

## Alur Pengguna
1. Masuk ke tab Kamera/Galeri untuk memilih gambar.
2. Jika sudah ada gambar terpilih, tombol aksi dan footer memudahkan pindah ke Chats.
3. Di tab Chats:
   - Tekan “Tambah Kontak” untuk menambahkan nama, nomor HP, dan kategori.
   - Ketuk kontak untuk membuka sheet compose, lalu kirim melalui share sheet.
4. Tab FYP menampilkan feed vertikal sebagai inspirasi tampilan explore.

## Penyesuaian
- Ubah daftar kontak awal, warna feed, atau teks caption dummy di `lib/main.dart`.
- Mudah diekstensikan ke backend/API untuk FYP dan daftar kontak nyata.

## Lisensi
Proyek ini ditujukan sebagai contoh pembelajaran/poc. Silakan gunakan dan modifikasi sesuai kebutuhan.
