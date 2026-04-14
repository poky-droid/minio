# 🚀 Install MinIO via Script (Ubuntu/Debian)

Script ini digunakan untuk menginstall dan menjalankan MinIO secara otomatis menggunakan bash.

---

## 📥 Download Repository

```bash
git clone https://github.com/username/nama-repo.git
cd nama-repo
```

## ⚡ Jalankan Script

```bash
chmod +x install_minio.sh
./install_minio.sh
```
## 🔧 Konfigurasi
Pastikan untuk mengedit variabel `MINIO_ROOT_USER` dan `MINIO_ROOT_PASSWORD` di dalam script sesuai dengan kebutuhan Anda sebelum menjalankan script.
## 📂 Direktori Data
MinIO akan menyimpan data di direktori `/data`. Pastikan direktori ini memiliki izin yang sesuai agar MinIO dapat menulis data.
## 🛠️ Manajemen MinIO
- Untuk memulai MinIO: `systemctl start minio`
- Untuk menghentikan MinIO: `systemctl stop minio`
- Untuk melihat status MinIO: `systemctl status minio`