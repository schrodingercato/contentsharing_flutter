# Mini Content Sharing App - Flutter Exploration

Proyek ini adalah hasil eksplorasi mandiri dalam membuat aplikasi mobile sederhana berbasis Flutter untuk berbagi konten gambar (ala Instagram/WhatsApp) menggunakan bantuan Generative AI.

## 🚀 Fitur Utama
* **Ambil Foto:** Mengambil gambar secara langsung melalui integrasi kamera perangkat.
* **Content Sharing:** Membagikan foto yang telah diambil ke platform lain (WhatsApp, Instagram, Email) melalui fitur native sharing.
* **UI/UX Modern:** Antarmuka pengguna yang diperhalus dengan tema Navy Blue dan alur interaksi yang intuitif hasil kolaborasi dengan Trae AI.

## 🛠️ Teknologi & Library
* **Framework:** Flutter
* **Language:** Dart
* **Library:**
  * `image_picker`: Untuk akses kamera.
  * `share_plus`: Untuk fitur sharing konten.
  * `path_provider`: Untuk manajemen file sementara.

## 📝 Catatan Pengembangan & Troubleshooting
Proyek ini melalui proses *troubleshooting* yang intensif terkait lingkungan pengembangan di Windows:
1. **Relokasi SDK:** Mengatasi error build akibat karakter spasi pada path direktori user dengan memindahkan Flutter SDK ke `C:\flutter`.
2. **Environment Path:** Konfigurasi ulang System Environment Variables agar perintah `flutter` dapat dikenali secara global.
3. **Build Optimization:** Penggunaan perintah `flutter clean` secara berkala untuk memastikan konsistensi cache build di direktori baru.

## 🎨 Proses Desain (AI Assisted)
Proses pengembangan menggunakan pendekatan **AI-Augmented Development**:
* **Generative AI:** Digunakan untuk menyusun logika dasar dan penanganan error sistem.
* **Trae AI:** Digunakan untuk penyempurnaan UI/UX, penyesuaian tema warna, dan desain alur pengguna ala media sosial modern.

---
*Dibuat untuk memenuhi tugas Eksplorasi Mandiri - MyITS Classroom.*
