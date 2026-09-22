
``` text
if4073-tugas1-enhancement/
├── README.md
├── .gitignore
├── src/
│   ├── gui/
│   │   └── Main.mlapp             # file App Designer
│   ├── functions/
│   │   ├── manualHist.m           # histogram
│   │   ├── intensityTransform.m   # Intensity Transformation
│   │   ├── manualHistEQ.m         # Histogram Equalization
│   │   ├── manualHistMatch.m      # Histogram Specification/Matching
│   │   ├── convFilter.m           # linear filtering (konvolusi)
│   │   └── manualMedFilter.m      # non-linear filtering
│   └── utils/
│       └── imageFeatures.m        
├── data/                          
│   ├── kasus1/
│   ├── kasus2/
│   ├── kasus3/
│   ├── kasus4/
│   └── histogram_citra/
├── tests/                         
│   └── compareWithBuiltin.m
└── docs/                          
```

Toolbox Used :
1. Image Processing Toolbox
2. etc...

## Kontrak Fungsi (Input/Output)

| Fungsi | Input | Output |
|---|---|---|
| `manualHist(img)` | `img` — uint8, grayscale (2D) atau RGB (3D) | `counts` — 256x1 (grayscale) atau 256x3 (RGB) |
| `intensityTransform(img, params)` | `img` — uint8; `params` — parameter transformasi | `imgHasil` — uint8, ukuran sama dengan input |
| `manualHistEQ(img)` | `img` — uint8, grayscale/RGB | `imgHasil` — uint8, ukuran sama dengan input |
| `manualHistMatch(img, imgRef)` | `img`, `imgRef` — uint8 | `imgHasil` — uint8, ukuran sama dengan input |
| `convFilter(img, kernel)` | `img` — uint8; `kernel` — matrix konvolusi | `imgHasil` — uint8, ukuran sama dengan input |
| `manualMedFilter(img, windowSize)` | `img` — uint8; `windowSize` — ukuran jendela filter | `imgHasil` — uint8, ukuran sama dengan input |
| `imageFeatures(img)` | `img` — uint8 | `struct` dengan field `.mean`, `.std`, `.entropy` |