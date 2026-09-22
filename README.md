
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