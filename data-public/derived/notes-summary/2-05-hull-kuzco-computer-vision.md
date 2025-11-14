# 2-05: kuzco | Computer Vision Made Easy

**One-Sentence Summary**: Frank Hull presents kuzco, a comprehensive R package built on ollamar and ellmer that simplifies computer vision tasks using Large Language Models with structured outputs for classification, sentiment analysis, object recognition, OCR text extraction, and custom vision workflows - supporting both local models (via Ollama) and cloud-hosted LLMs (OpenAI, Claude, Gemini, Perplexity) while eliminating traditional deep learning framework complexity (Keras/PyTorch alternative).

**Speaker**: Frank Hull (@frankiethull) | [GitHub](https://github.com/frankiethull/kuzco) | [Docs](https://frankiethull.github.io/kuzco/)

**Importance Rank**: ⭐⭐⭐⭐ (4/5)
- **Tools/Concepts**: ⭐⭐⭐⭐⭐ (LLM-based computer vision; structured output format; local + cloud model support; kuzco_app Shiny interface)
- **Immediate Applicability**: ⭐⭐⭐⭐ (Development version available; eliminates CNN training overhead; works with accessible models)
- **Novel Techniques**: ⭐⭐⭐⭐ (Alternative CV paradigm using LLMs; standardized tidyverse-compatible output)

## Key Insights from Human Notes

**LLM-Based Computer Vision Alternative**: kuzco represents a **significant shift toward making computer vision accessible** to R users without deep learning expertise. By leveraging LLMs instead of traditional CNN architectures (Keras/PyTorch), it removes barriers to entry for researchers and analysts. This positions **LLM-based computer vision as a viable alternative** particularly valuable for: (1) Rapid prototyping and experimentation; (2) Non-specialist users requiring vision capabilities; (3) Scenarios where training custom models is impractical; (4) Research workflows requiring interpretable vision analysis.

**Flexible Backend Architecture**: Built on **{ollamar}** (suggested outputs) and **{ellmer}** (enforced structured outputs) with support for both **local models** (via Ollama: qwen2.5vl, pixtral-12b) and **cloud-hosted LLMs** (OpenAI, Claude, Gemini, Perplexity). This dual approach enables: (1) **Privacy-preserving workflows** with local deployment; (2) **High-performance analysis** with cloud models; (3) **Cost optimization** through model selection; (4) **Consistent API** regardless of backend. The standardized structured data output format ensures compatibility with tidyverse workflows and reproducible research requirements.

**Comprehensive Vision Task Coverage**: The package provides **five core computer vision functions**: (1) **llm_image_classification()** - Primary/secondary object identification with probability scores; (2) **llm_image_sentiment()** - Emotional content assessment with confidence scoring; (3) **llm_image_recognition()** - Specific object detection with location and count; (4) **llm_image_extract_text()** - OCR text recognition with confidence scores; (5) **llm_image_custom()** - User-defined prompts with structured outputs. Additional capabilities include **alt-text generation** for accessibility, **kuzco_app()** Shiny interface for interactive use, and **I/O helpers** (view_image, view_llm_results).

## Tools & Resources

**Core Package**:
- **GitHub**: https://github.com/frankiethull/kuzco (61 stars, 3 contributors)
- **Documentation**: https://frankiethull.github.io/kuzco/
- **Installation**: `devtools::install_github("frankiethull/kuzco")`
- **CRAN Status**: Not yet published (development version)

**Key Dependencies**:
- **ollamar**: R interface to Ollama for local LLM inference (suggested outputs)
- **ellmer**: R package for LLM interactions with structured outputs (enforced outputs)

**Basic Usage Patterns**:
```r
library(kuzco)
library(ollamar)

test_img <- file.path(system.file(package = "kuzco"), "img/test_img.jpg")

# Image Classification
llm_results <- llm_image_classification(
  llm_model = "qwen2.5vl", image = test_img, backend = 'ollamar'
)
# Returns: image_classification, primary_object, secondary_object, 
#         image_description, colors, proba_names, proba_values

# Sentiment Analysis
llm_emotion <- llm_image_sentiment(llm_model = "qwen2.5vl", image = test_img)
# Returns: image_sentiment, image_score, sentiment_description, keywords

# Object Recognition
llm_detection <- llm_image_recognition(
  llm_model = "qwen2.5vl", image = test_img,
  recognize_object = "nose", backend = "ollamar"
)
# Returns: object_recognized, object_count, object_description, object_location

# OCR Text Extraction
llm_extract_txt <- llm_image_extract_text(
  llm_model = "qwen2.5vl", image = text_img, backend = "ellmer"
)
# Returns: text, confidence_score

# Custom Vision Tasks with Example Output Structure
llm_customized <- llm_image_custom(
  llm_model = "qwen2.5vl", image = test_img,
  system_prompt = "you are a dog breed expert...",
  image_prompt = "tell me what kind of dog is in the image?",
  example_df = data.frame(
    dog_breed_primary = "hound",
    dog_breed_secondary = "corgi",
    dog_breed_information = "breed descriptions"
  )
)
```

**Cloud LLM Integration**:
```r
Sys.setenv(MISTRAL_API_KEY = "your_api_key")
kuzco::llm_image_classification(
  provider = "mistral", llm_model = "pixtral-12b", image = test_img
)
```

**Shiny Application**:
```r
kuzco_app()  # Launch interactive Shiny interface
```

**Related R Computer Vision Packages**:
- **magick**: ImageMagick bindings for image processing
- **imager**: Image processing and computer vision
- **OpenImageR**: Computer vision tasks
- **keras/tensorflow**: Deep learning frameworks
- **torch**: PyTorch interface for R

## Methods & Techniques for Research Analytics

**Applicable Methods**:
1. **LLM-Based Image Analysis**: Computer vision without CNN training overhead
2. **Structured Output Processing**: Consistent data format for statistical analysis and visualization
3. **Multi-Model Comparison**: Testing same task across different LLM backends systematically
4. **Privacy-Preserving Vision**: Local model deployment for sensitive image data
5. **Custom Vision Workflows**: User-defined prompts with example-driven output structures

**Research Workflow Applications**:
- Rapid image analysis prototyping without deep learning expertise
- Accessibility description generation (alt-text) for research publications
- Sentiment analysis of visual stimuli in behavioral research
- OCR for digitizing handwritten research notes and historical documents
- Object detection and counting in scientific imagery (without training datasets)
- Mixed-method research combining quantitative statistics with visual data analysis
- Exploratory visual data analysis with interpretable LLM-generated descriptions
- Integration with R Markdown/Quarto for reproducible visual analysis workflows

## Priority Follow-Up Actions

**🚨 IMMEDIATE**:
- [ ] Install kuzco: `devtools::install_github("frankiethull/kuzco")`
- [ ] Test basic image classification workflow with local Ollama models
- [ ] Explore kuzco_app() Shiny interface for interactive image analysis
- [ ] Review documentation: https://frankiethull.github.io/kuzco/
- [ ] Compare ollamar vs. ellmer backends for structured output consistency

**📋 INVESTIGATE**:
- LLM-based CV accuracy vs. traditional CNN approaches for research use cases
- Computational cost trade-offs between local (Ollama) and cloud-hosted models
- Integration patterns with R Markdown/Quarto for reproducible visual analysis
- Batch processing strategies for large-scale image analysis with kuzco
- Custom vision workflow design for domain-specific research applications
- Model selection guidance (qwen2.5vl, pixtral-12b, etc.) for different task types
- CRAN submission timeline and package maturation roadmap

**🔗 CONNECT**:
- Frank Hull (@frankiethull) for package development updates and use case guidance
- diffuseR author Troy Hernandez (2-06) for R+AI image generation/analysis ecosystem
- geodl author Aaron Maxwell (2-01) for geospatial computer vision integration possibilities
- R computer vision community for LLM-based CV adoption patterns