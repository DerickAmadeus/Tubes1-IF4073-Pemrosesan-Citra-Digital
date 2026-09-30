# IF4073 Pemrosesan Citra Digital — Tugas 1: Image Enhancement

Aplikasi MATLAB (App Designer) untuk melakukan *image enhancement* pada citra digital. Semua operasi inti (histogram, equalization, matching, konvolusi, median filter) **diimplementasikan manual**, tanpa memakai fungsi bawaan seperti `imhist`, `histeq`, `imhistmatch`, `conv2`, atau `medfilt2`.

## Fitur

| Teknik di GUI | Fungsi | Keterangan |
| --- | --- | --- |
| Histogram Citra | `manualHist`, `tampilkanHistogram` | Histogram 256 level. Grayscale: 1 kurva; RGB: kurva R, G, B terpisah |
| Intensity Transformation | `intensityTransform` | `Negative`, `Log`, `Gamma` (param: gamma), `Contrast Stretch` (param: Low In, High In) |
| Blur | `convFilter` | Linear filtering dengan konvolusi 2D (zero-padding), output berukuran sama dengan input |
| Median | `manualMedFilter` | Non-linear filtering, window ganjil (Window Size) |
| Histogram Equalization | `manualHistEQ` | Per kanal untuk citra RGB |
| Histogram Matching | `manualHistMatch` | Menyesuaikan histogram citra sumber ke citra referensi (dipilih dari folder referensi) |

Fungsi tambahan `imageFeatures` menghitung min, max, mean, standar deviasi, dan entropy (per kanal untuk RGB) untuk membantu analisis sebelum/sesudah enhancement.

Semua fungsi menerima citra `uint8` grayscale (2D) maupun RGB (3D).

## Struktur Repo

```text
.
├── src/
│   ├── gui/
│   │   └── Main.mlapp              # aplikasi App Designer
│   ├── functions/
│   │   ├── manualHist.m            # histogram
│   │   ├── tampilkanHistogram.m    # plot histogram
│   │   ├── intensityTransform.m    # negative, log, gamma, contrast stretching
│   │   ├── manualHistEQ.m          # histogram equalization
│   │   ├── manualHistMatch.m       # histogram specification/matching
│   │   ├── convFilter.m            # linear filtering (konvolusi)
│   │   └── manualMedFilter.m       # non-linear filtering (median)
│   └── utils/
│       └── imageFeatures.m         # fitur statistik citra
├── data/                           # dataset citra uji
│   ├── 1. Histogram Citra/
│   ├── 2. Kasus 1/
│   ├── 3. Kasus 2/
│   ├── 4. Kasus 3/
│   └── 5. Kasus 4/
└── tests/
    ├── test_manualHist.m           # uji histogram dengan citra kecil yang bisa dicek manual
```

## Prasyarat

- MATLAB dengan **App Designer** (R2020a atau lebih baru disarankan)
- Image Processing Toolbox (dipakai untuk membaca/menampilkan citra, seperti `imread` dan `imshow`)

## Cara Menjalankan

1. Clone repo ini:
   ```bash
   git clone https://github.com/DerickAmadeus/IF4073-Pemrosesan-Citra-Digital.git
   ```
2. Buka MATLAB, lalu jadikan folder repo sebagai *Current Folder*.
3. Tambahkan folder sumber ke path:
   ```matlab
   addpath(genpath('src'));
   ```
4. Jalankan aplikasi:
   ```matlab
   run('src/gui/Main.mlapp')
   ```
   atau buka `Main.mlapp` di App Designer lalu tekan **Run**.

## Cara Pakai GUI

1. Pilih **Folder** dataset (mis. `2. Kasus 1`), lalu pilih **Citra Digunakan**.
2. Pilih **Teknik Digunakan**: Intensity Transformation, Blur, Median, Histogram Equalization, atau Histogram Matching.
3. Isi parameter yang muncul (Gamma, Low In/High In, Window Size, atau Folder/Citra Referensi untuk Histogram Matching).
4. Klik **Process** untuk melihat citra hasil beserta histogramnya.

## Kelompok 1

- Wilson - 18223012
- Derick Amadeus Budiono - 18223090

IF4073 Pemrosesan Citra Digital, Institut Teknologi Bandung.
