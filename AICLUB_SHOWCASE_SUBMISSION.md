# Form Submission: AIClub Indonesia Showcase

Gunakan teks dan data di bawah ini saat mengunggah karya ke formulir pendaftaran [Showcase AIClub.id](https://aiclub.id/showcase/):

---

### 1. Judul Karya (Title)
```text
AI Review Analyst Agent (Ika Agent): Multi-Channel E-Commerce Review & Sentiment Scraper
```

---

### 2. Tagline / Ringkasan Singkat (Short Description)
```text
Otomasi analisis sentimen ulasan e-commerce: scrape ulasan barang/toko Shopee secara otomatis, impor file Excel, dan hasilkan laporan analitik kepuasan pelanggan via Telegram dengan 2-Tier AI Failover.
```

---

### 3. Kategori & Tags (Pills)
* **Kategori:** Open Source / Automation / Artificial Intelligence / Business & E-Commerce
* **Tags:** `n8n`, `Shopee`, `Scraper`, `Apify`, `Gemini`, `Telegram Bot`, `Sentiment Analysis`, `E-Commerce`

---

### 4. Link Proyek (Project URL)
```text
https://github.com/ucuk048/review-analyst-agent
```

---

### 5. Gambar / Thumbnail Karya
* **File:** `flowchart_agent_ikma.png` (Tersedia langsung di dalam repositori ini, siap diunggah sebagai cover/screenshot showcase).

---

### 6. Narasi / Konten Deskripsi Karya (Markdown Body untuk AIClub)

```markdown
### Latar Belakang Masalah
Bagi pemilik brand dan merchant di e-commerce (seperti Shopee), membaca ribuan ulasan pelanggan secara manual membutuhkan waktu berjam-jam. Akibatnya, keluhan krusial mengenai cacat produk, kemasan rusak, atau penurunan performa toko sering terlambat diketahui dan berimbas pada penurunan rating toko.

### Solusi: AI Review Analyst Agent (Ika Agent)
Ika Agent adalah agen otomasi pintar berbasis **n8n** yang menghubungkan ekosistem scraping e-commerce dengan kecerdasan buatan (AI) langsung ke aplikasi Telegram pengguna:

1. **Dual Scraper Shopee Otomatis:**
   * Cukup kirim tautan produk Shopee untuk mengekstrak ulasan rating bintang 1 hingga 5.
   * Mendukung tautan profil toko Shopee untuk membaca performa reputasi seluruh katalog.
   * Dilengkapi *Smart Shortlink Resolver* untuk membuka tautan pendek ponsel (`s.shopee.co.id` / `shp.ee`).
2. **Multi-Channel Ingestion (Excel & Teks Langsung):**
   * Pengguna dapat mengunggah file spreadsheet (.xlsx / .csv) berisi rekapan ulasan internal.
   * Menerima input teks ulasan langsung untuk evaluasi sentimen cepat.
3. **2-Tier AI Failover (Google Gemini 3.5 Flash Lite + Vibe AI):**
   * Menggunakan Gemini 3.5 Flash Lite sebagai otak utama analisis sentimen bahasa Indonesia/gaul yang sangat cepat dan hemat biaya.
   * Dilengkapi jalur cadangan otomatis (Vibe AI fallback) jika API utama mengalami limit kuota atau gangguan jaringan.
4. **Laporan Eksekutif Langsung ke Telegram:**
   * Menampilkan rasio sentimen (Positif, Netral, Negatif).
   * Poin kekuatan produk yang disukai pembeli.
   * Masalah utama yang paling sering dikeluhkan pembeli serta rekomendasi aksi konkret bagi tim QC/Seller.

### Arsitektur Teknologi
* **Automation Engine:** n8n (33 Modular Nodes Pipeline)
* **User Interface:** Telegram Bot API
* **Scraping Engine:** Apify API (Shopee Review Scraper Actor)
* **Intelligence / LLM:** Google Gemini 3.5 Flash Lite (Primary) & Vibe AI (Fallback)
* **Data Processing:** Spreadsheet Parser & Dynamic State Session Manager
```
