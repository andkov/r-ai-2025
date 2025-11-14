# 2-01: Introducing geodl: An R Package for Geospatial Semantic Segmentation

**One-Sentence Summary**: Aaron Maxwell (West Virginia University) presents geodl (v0.3.0), the first R package for CNN-based geospatial semantic segmentation using pure R/C++ implementation (torch + terra), eliminating Python dependencies while providing comprehensive UNet architectures with optional enhancements (attention gates, squeeze-excitation, ASPP, deep supervision) for pixel-level classification of multidimensional geospatial arrays across varying bands, resolutions, and coordinate systems.

**Speaker**: Aaron Maxwell (West Virginia University) | [CRAN](https://cran.r-project.org/package=geodl) | [GitHub](https://github.com/maxwell-geospatial/geodl) | [Website](https://wvview.org/geodl/index.html)

**Importance Rank**: ⭐⭐ (2/5)
- **Tools/Concepts**: ⭐⭐⭐⭐ (Pure R geospatial DL; UNet architectures; terra/torch integration; semantic segmentation)
- **Immediate Applicability**: ⭐ (Highly specialized; requires geospatial context and specific use cases)
- **Novel Techniques**: ⭐⭐ (R-native implementation; optional architecture enhancements)

## Key Insights from Human Notes

**Personal Assessment: Bookmark for Future Spatial Work**: ⭐⭐ relevance - Very technical presentation focused on specialized geospatial deep learning. Comprehensive overview of spatial data packages in R ecosystem would be valuable when working on spatial projects, but not current priority. **Key takeaway**: geodl fills important gap for R users needing CNN-based semantic segmentation without Python dependency. **Good to know this capability exists** in R ecosystem for future spatial AI projects. **tmap package** caught attention - looks interesting for future spatial visualization needs.

**R-Native Geospatial Deep Learning Architecture**: geodl's core innovation is **pure R/C++ implementation** built on torch (R libtorch backend) and terra (efficient raster processing), completely eliminating the Python dependency common in other DL packages. Standardized workflow features: all tensors follow **[Channels, Width, Height] format**, multiclass approach even for binary problems, C++ backend via terra for large raster processing without loading to memory, and GPU support via torch. The package provides complete end-to-end workflow: **data preparation** (makeMasks, makeChips, makeChipsDF, viewChips, describeChips) → **model architecture** (defineUNet with customizable encoder/decoder blocks) → **training/assessment** (luz integration, defineUnifiedFocalLoss, assessDL) → **spatial prediction** (predictSpatial for large extent inference with chip overlap/cropping).

**Validated Performance on Real-World Datasets**: (1) **topoDL Dataset - Historic Mining Detection**: Binary segmentation of surface mine extents from USGS topographic maps (171 historic maps, eastern KY/OH/southwestern VA) achieving **99.0% accuracy, 96.3% F1-score** with 3,886 training chips for historic environmental impact assessment. (2) **landcover.ai Dataset - Multi-class Land Cover**: 5-class segmentation (background, building, woodland, water, road) from Polish orthophotography (25-50cm resolution, 216.27 km²) achieving **90.8% accuracy, 82.3% macro-averaged F1-score** for general land cover mapping from aerial imagery.

## Tools & Resources

**Core Package**:
- **CRAN**: https://cran.r-project.org/package=geodl (v0.3.0)
- **GitHub**: https://github.com/maxwell-geospatial/geodl
- **Official Website**: https://wvview.org/geodl/index.html
- **Installation**: `install.packages("geodl")`
- **Publication**: PLoS One, December 5, 2024 (https://doi.org/10.1371/journal.pone.0315127)
- **License**: GPL (≥ 3)

**Key Dependencies**:
- **torch, luz, torchvision**: Deep learning infrastructure (R/C++ libtorch, no Python)
- **terra**: Efficient raster processing without loading to memory
- **dplyr, sf**: Data manipulation and spatial vector operations
- **MultiscaleDTM**: Terrain analysis
- **coro, R6, readr, rlang, psych**: Supporting infrastructure

**Example Datasets**:
- **Full Examples**: https://figshare.com/articles/dataset/geodl_example_data/23835165
- **Compact Version**: https://figshare.com/articles/dataset/geodl_example_data_no_chips_/26824909
- **topoDL**: Historic mining maps (171 USGS quadrangles)
- **landcover.ai**: Polish orthophotography land cover (216.27 km²)

**Basic Workflow**:
```r
library(geodl)

# 1. Create masks and chips
makeMasks(vector_data, raster_template, output_dir)
makeChips(raster_stack, mask_raster, chip_size = 256, output_dir)
chip_df <- makeChipsDF(chip_directory)

# 2. Define UNet with enhancements
model <- defineUNet(n_channels = 4, n_classes = 2, init_features = 64,
                    use_attention = TRUE, use_se = TRUE, use_aspp = TRUE)

# 3. Train with luz
dataset <- defineSegDataSet(chip_df, normalize = TRUE, augment_prob = 0.75)
dataloader <- torch::dataloader(dataset, batch_size = 16)

model %>%
  luz::setup(
    loss = defineUnifiedFocalLoss(lambda = 0, gamma = 0.8),
    optimizer = torch::optim_adamw
  ) %>%
  luz::fit(dataloader, epochs = 25)

# 4. Predict to spatial extent
predictions <- predictSpatial(model, raster_stack, chpSize = 256, 
                              stride_x = 192, stride_y = 192)
```

**UNet Architecture Enhancements**:
- **Residual Connections**: Gradient flow improvement
- **Squeeze-and-Excitation**: Inter-channel relationship capture
- **Attention Gates**: Focus on key features using deeper layer information
- **ASPP Bottleneck**: Multi-scale context via atrous spatial pyramid pooling
- **Deep Supervision**: Auxiliary losses from decoder blocks for additional training guidance
- **MobileNet-v2 Variant**: Lightweight encoder with pre-trained ImageNet weights

## Methods & Techniques for Research Analytics

**Applicable Methods**:
1. **CNN-Based Semantic Segmentation**: UNet architectures for pixel-level geospatial classification
2. **Unified Focal Loss**: Combined distribution-based and region-based losses with class weighting
3. **Large Spatial Extent Processing**: Chip-based inference with overlap and cropping for memory efficiency
4. **Multi-spectral Data Handling**: Variable input channels (not limited to RGB) for satellite/aerial imagery
5. **Data Augmentation**: Configurable augmentation probability for training robustness

**Research Workflow Applications** (When Spatial Projects Arise):
- Satellite/aerial imagery semantic segmentation for land cover mapping
- Multi-spectral and hyperspectral data processing without Python dependency
- Time-series geospatial analysis for change detection and monitoring
- Large spatial extent processing with efficient memory management (terra backend)
- Historic environmental impact assessment (mining, deforestation, urban development)
- Urban planning feature detection (buildings, roads, infrastructure)

## Priority Follow-Up Actions

**🚨 IMMEDIATE** (When Spatial Project Arises):
- [ ] Install geodl: `install.packages("geodl")`
- [ ] Review tmap package for spatial visualization
- [ ] Bookmark geodl documentation: https://wvview.org/geodl/index.html
- [ ] Download example datasets from figshare for testing

**📋 INVESTIGATE** (Future Spatial Work):
- How geodl compares to Python TorchGeo for geospatial deep learning
- GPU memory requirements for different chip sizes and batch sizes
- Integration with existing R geospatial workflows (sf, raster, terra, tmap)
- Coordinate system transformations and handling edge cases (cloud cover, seasonal variations)
- Model selection guidance for different remote sensing applications

**🔗 CONNECT**:
- Aaron Maxwell (aaron.maxwell@mail.wvu.edu) for geospatial DL guidance when needed
- R geospatial community (sf, terra, raster package ecosystems)
- WVU geospatial research group for case studies and best practices