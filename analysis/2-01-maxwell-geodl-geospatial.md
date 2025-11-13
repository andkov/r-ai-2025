# Introducing geodl: An R package for geospatial semantic segmentation

**Speaker:** Aaron Maxwell (West Virginia University)  
**Time:** 10:00-10:35 AM  
**Date:** November 13, 2025  
**Session:** 2-01  

## Package Information

**Current Status:**
- **Version:** 0.3.0 (Latest on CRAN)
- **Publication:** PLoS One, December 5, 2024 (https://doi.org/10.1371/journal.pone.0315127)
- **GitHub:** https://github.com/maxwell-geospatial/geodl
- **Official Website:** https://wvview.org/geodl/index.html
- **Installation:** `install.packages("geodl")`

**Key Innovation:**
First R package for geospatial semantic segmentation using pure R/C++ implementation (torch + terra), eliminating Python dependency common in other DL packages.

## Abstract/Summary

**"Introducing geodl: An R package for geospatial semantic segmentation"**

geodl provides a complete workflow for CNN-based semantic segmentation of geospatial data using UNet architectures. Built on torch (R/C++ implementation) and terra (efficient raster processing), it supports pixel-level classification tasks for multidimensional geospatial arrays with varying bands, resolutions, and coordinate systems.

## Conference Context

This presentation opens Day 2 of the R+AI 2025 conference, serving as the inaugural talk following the completion of Day 1's sessions (including Umair Durrani's branding and visualization session). This session establishes geospatial AI applications as a key theme for Day 2, preceding Russ Conte's deep learning records talk (2-02) and continuing the technical depth established in Day 1's later sessions.

## Key Points & Analysis

*[Live notes during presentation]*

### Main Concepts

**Geospatial Semantic Segmentation**
- *[Definition and applications of semantic segmentation in geospatial contexts]*
- *[Challenges specific to geospatial data processing]*
- *[Integration with existing R geospatial ecosystem]*

**Package Architecture & Design**
- **Core Dependencies:** torch, luz, torchvision, terra, dplyr, sf
- **Design Philosophy:** Standardized workflow for geospatial semantic segmentation without Python
- **Data Standards:** All tensors follow [Channels, Width, Height] format; multiclass approach even for binary problems
- **Performance:** C++ backend via terra for large raster processing; GPU support via torch

### Implementation Details

**Core Functionality**
- **Data Preparation:** makeMasks(), makeChips(), makeChipsDF(), viewChips(), describeChips()
- **Model Architecture:** defineUNet() with customizable encoder/decoder blocks, optional modules
- **Training/Assessment:** luz integration, defineUnifiedFocalLoss(), assessDL(), assessRaster()
- **Spatial Prediction:** predictSpatial() for large extent inference with chip overlap/cropping
- **Dataset Classes:** defineSegDataSet() for torch DataLoader integration with data augmentation

**R Integration**
- *[Integration with sf, raster, terra, and other geospatial packages]*
- *[Workflow compatibility with standard R geospatial analysis]*
- *[Visualization and plotting capabilities]*

## Technical Content

### UNet Architecture Features

**Standard UNet Components:**
- 4 encoder blocks + bottleneck + 4 decoder blocks
- Skip connections between encoder/decoder at same resolution
- Variable input channels (not limited to RGB)
- 2D convolution, ReLU activation, batch normalization
- Max pooling (encoder) and transpose convolution (decoder)

**Optional Architecture Enhancements:**
1. **Residual Connections:** Add input directly to output for gradient flow improvement
2. **Squeeze-and-Excitation Modules:** Capture inter-channel relationships via global average pooling
3. **Attention Gates:** Focus on key features using deeper layer information as gating signal
4. **ASPP Bottleneck:** Modified atrous spatial pyramid pooling for multi-scale context
5. **Deep Supervision:** Auxiliary losses from decoder blocks 1-3 for additional training guidance
6. **Alternative Activations:** Leaky ReLU or Swish instead of standard ReLU

**MobileNet-v2 UNet Variant:**
- defineMobileUNet() with lightweight encoder
- Pre-trained ImageNet weights available
- 3-channel input requirement for ImageNet compatibility

### Loss Functions & Assessment

**Unified Focal Loss Framework:**
- Combines distribution-based (focal cross-entropy) and region-based (focal Tversky) losses
- Configurable parameters: λ (loss weighting), γ (focal adjustment), δ (FP/FN weighting)
- Class weighting support for imbalanced datasets
- LogCosh transform option for gradient smoothing

**Assessment Metrics:**
- Overall accuracy, precision, recall, F1-score
- Macro-averaging with equal class weighting
- Producer's accuracy (recall) and User's accuracy (precision) terminology
- Point-based and raster-based assessment functions

### Code Examples

```r
# Basic geodl workflow
library(geodl)

# 1. Create masks from vector data
makeMasks(vector_data, raster_template, output_dir)

# 2. Generate image chips
makeChips(raster_stack, mask_raster, chip_size = 256, output_dir)

# 3. Create data frame of chips
chip_df <- makeChipsDF(chip_directory)

# 4. Define UNet model with enhancements
model <- defineUNet(
  n_channels = 4,        # Input channels
  n_classes = 2,         # Output classes
  init_features = 64,    # Initial feature maps
  use_attention = TRUE,  # Attention gates
  use_se = TRUE,         # Squeeze-excitation
  use_aspp = TRUE       # ASPP bottleneck
)

# 5. Define dataset and dataloader
dataset <- defineSegDataSet(
  chip_df, 
  normalize = TRUE,
  augment_prob = 0.75
)
dataloader <- torch::dataloader(dataset, batch_size = 16)

# 6. Train with luz
model %>%
  luz::setup(
    loss = defineUnifiedFocalLoss(lambda = 0, gamma = 0.8),
    optimizer = torch::optim_adamw,
    metrics = list(luz_metric_f1_score())
  ) %>%
  luz::fit(dataloader, epochs = 25)

# 7. Predict to spatial extent
predictions <- predictSpatial(
  model, 
  raster_stack, 
  chpSize = 256, 
  stride_x = 192, 
  stride_y = 192
)
```

### Methods & Tools

**Deep Learning Frameworks**
- *[Underlying deep learning libraries (TensorFlow, PyTorch, etc.)]*
- *[Model architectures used for semantic segmentation]*
- *[Training and inference workflows]*

**Geospatial Data Processing**
- *[Raster data handling and preprocessing]*
- *[Vector data integration]*
- *[Coordinate reference system handling]*

**R Package Ecosystem Integration**
- *[sf integration for vector operations]*
- *[raster/terra integration for raster operations]*
- *[leaflet/mapview integration for visualization]*

### Architecture & Design

**Package Structure**
- *[Core package organization and design patterns]*
- *[API design and user interface]*
- *[Extension and customization capabilities]*

**Performance Optimization**
- *[Memory management for large geospatial datasets]*
- *[Parallel processing capabilities]*
- *[GPU acceleration support]*

## Research Implications

### For Geospatial Research

**Case Studies from Maxwell's Research:**

1. **topoDL Dataset - Historic Mining Detection:**
   - Binary segmentation of surface mine extents from USGS topographic maps
   - Dataset: 171 historic maps (eastern KY, OH, southwestern VA)
   - Performance: 99.0% accuracy, 96.3% F1-score with 3,886 training chips
   - Application: Historic environmental impact assessment

2. **landcover.ai Dataset - Multi-class Land Cover:**
   - 5-class segmentation: background, building, woodland, water, road
   - Polish orthophotography (25-50cm resolution, 216.27 km²)
   - Performance: 90.8% accuracy, 82.3% macro-averaged F1-score
   - Application: General land cover mapping from aerial imagery

**Remote Sensing Applications**
- Satellite/aerial imagery semantic segmentation without Python dependency
- Multi-spectral and hyperspectral data processing
- Time-series analysis for change detection
- Large spatial extent processing with efficient memory management

**Urban Planning & GIS**
- *[Urban feature detection and mapping]*
- *[Infrastructure analysis and planning]*
- *[Smart city applications]*

### For R Ecosystem

**Geospatial R Packages**
- *[Contributions to R's geospatial analysis capabilities]*
- *[Integration with existing package ecosystem]*
- *[New workflows enabled for R geospatial users]*

### AI/ML Methods

**Semantic Segmentation Advances**
- *[Novel approaches to geospatial semantic segmentation]*
- *[Transfer learning applications in geospatial contexts]*
- *[Model evaluation and validation methods]*

**Reproducible Geospatial AI**
- *[Standardization of geospatial deep learning workflows]*
- *[Reproducibility considerations for geospatial AI research]*
- *[Open science applications and data sharing]*

## Q&A Session

### Questions Asked

*[Questions from audience and speaker responses]*

### Key Discussion Points

*[Important clarifications, technical details, or implementation considerations]*

## Questions for Further Investigation

**Technical Implementation Questions:**
- How does geodl's torch/terra approach compare to Python-based tools like TorchGeo?
- What are the memory requirements for different chip sizes and batch sizes?
- How does GPU utilization compare between geodl and Python alternatives?
- What coordinate system transformations are handled automatically?

**Answered from Research:**
- Built on torch (R/C++ libtorch backend) eliminating Python dependency
- Uses terra for efficient large raster processing without loading to memory
- luz package integration simplifies training loops and callbacks
- Standardized tensor formats: [Channels, Width, Height] for predictors

**Geospatial Domain Questions:**
- What types of geospatial data work best with the package (satellite, aerial, drone)?
- How does it integrate with existing R geospatial workflows (sf, raster, terra)?
- What validation methods are implemented for segmentation accuracy?
- How does it handle edge cases like cloud cover or seasonal variations?

**Research Applications:**
- What are the most promising applications in environmental monitoring?
- How can this be applied to urban planning and development analysis?
- What opportunities exist for integration with remote sensing research?
- How does this compare to existing geospatial analysis methods?

**R Integration Questions:**
- How does geodl integrate with the broader R geospatial ecosystem?
- What visualization capabilities are provided for segmentation results?
- How can R users get started with geospatial deep learning?
- What training resources are available for R users new to semantic segmentation?

## Resources & References

### Speaker Information
- **Aaron Maxwell** - West Virginia University  
- **Email:** Aaron.Maxwell@mail.wvu.edu
- **Research Focus:** Geospatial deep learning, semantic segmentation, environmental monitoring
- **Recent Work:** Lead author on geodl package (PLoS One 2024), NSF CAREER recipient for Anthropocene geomorphology mapping

### Tools & Packages

**Core Package**
- **CRAN:** https://cran.r-project.org/package=geodl (v0.3.0)
- **GitHub:** https://github.com/maxwell-geospatial/geodl
- **Website:** https://wvview.org/geodl/index.html
- **Installation:** `install.packages("geodl")`
- **License:** GPL (≥ 3)

**Dependencies & Integration**
- **Core Dependencies:** torch, luz, torchvision, terra, dplyr, sf
- **Deep Learning:** Pure R/C++ via torch (libtorch backend), no Python required
- **Geospatial:** terra (raster), sf (vector), MultiscaleDTM (terrain)
- **Additional:** coro, R6, readr, rlang, psych

**Example Datasets**
- **Full Examples:** https://figshare.com/articles/dataset/geodl_example_data/23835165
- **Compact Version:** https://figshare.com/articles/dataset/geodl_example_data_no_chips_/26824909
- **topoDL Dataset:** Historic mining maps (171 USGS quadrangles)
- **landcover.ai:** Polish orthophotography land cover (216.27 km²)

### Publications & Research

**Geospatial Semantic Segmentation**
- *[Key publications in geospatial deep learning]*
- *[Semantic segmentation methodologies]*
- *[Remote sensing and GIS research]*

**R Geospatial Ecosystem**
- *[Relevant publications on R for geospatial analysis]*
- *[Package development best practices]*
- *[Reproducible geospatial research methods]*

### Additional Resources

**Code & Data Access**
- *[Package repository and source code]*
- *[Example datasets and tutorials]*
- *[Reproducibility resources and vignettes]*

**Documentation**
- *[Package documentation and API reference]*
- *[Getting started guides and tutorials]*
- *[Integration examples with other R packages]*

## Action Items

### Completed Research ✅
- ✅ Package repository and installation (CRAN v0.3.0)
- ✅ Deep learning framework (torch/libtorch, no Python needed)  
- ✅ R geospatial integration (terra, sf, luz ecosystem)
- ✅ Example use cases (mining detection, land cover mapping)
- ✅ Performance benchmarks (99% accuracy on topoDL, 90.8% on landcover.ai)
- ✅ Validation methods (confusion matrix, F1, precision/recall)
- ✅ GPU acceleration support via torch
- ✅ Training workflows and data preprocessing functions

### During Presentation Focus:
- **Live Demo:** Package installation and basic workflow
- **Technical Deep-dive:** UNet architecture customization options
- **Case Studies:** Real-world applications and performance results  
- **Integration:** How geodl fits into existing R geospatial workflows
- **Performance:** GPU utilization and memory management strategies
- **Future Development:** Roadmap for additional architectures and features

## Personal Assessment

**Relevance to Current Role:** ⭐⭐ (Technical overview, not immediately applicable)
- Very technical presentation focused on specialized geospatial deep learning
- Comprehensive overview of spatial data packages in R ecosystem
- Would be valuable when working on spatial projects, but not current priority
- **tmap package** caught attention - looks interesting for future spatial visualization needs

**Key Takeaway:** 
geodl fills important gap for R users needing CNN-based semantic segmentation without Python dependency. Good to know this capability exists in R ecosystem for future spatial AI projects.

**For Future Reference:**
- geodl package for when spatial semantic segmentation is needed
- tmap for spatial visualization projects
- Comprehensive R spatial ecosystem overview completed

## Notes

- **Status:** Session completed ✅
- **Context:** Day 2 opener - technical deep dive into geospatial AI
- **Speaker Institution:** West Virginia University - solid academic research
- **Presentation Style:** Technical demonstration with code examples
- **Time:** 35-minute presentation (10:00-10:35 AM)
- **Overall Assessment:** Well-executed technical talk, bookmark for future spatial work

---
*Session 2-01 notes created 2025-11-13 - Ready for Aaron Maxwell's presentation*