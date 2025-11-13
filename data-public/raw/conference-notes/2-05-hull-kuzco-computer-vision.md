# 2-05 | kuzco | Computer Vision made easy
**Frank Hull** | **12:20-12:55 PM** | **Day 2: Thursday, November 13, 2025**

## Abstract/Summary
**kuzco | Computer Vision made easy** - Frank Hull presents a comprehensive R package that simplifies computer vision tasks using Large Language Models (LLMs). The kuzco package is designed as a computer vision assistant that provides structured outputs for image analysis tasks, offering an alternative to traditional deep learning frameworks like Keras or PyTorch.

**Package Overview**: kuzco is built on top of {ollamar} and {ellmer}, providing a standardized approach to computer vision tasks including classification, recognition, sentiment analysis, text extraction (OCR), and custom vision workflows. The package supports both local models (via Ollama) and cloud-hosted LLMs (OpenAI, Claude, Gemini, Perplexity, etc.).

## Conference Context
- **Position**: Day 2, Talk 5 of 9
- **Time Slot**: 12:20-12:55 PM (35 minutes)
- **Speaker**: Frank Hull
- **Topic Focus**: Computer Vision in R
- **Session Type**: Technical presentation

## Key Points & Analysis
<!-- Live notes during talk -->

## Technical Content
### kuzco Package Overview
**Installation**: `devtools::install_github("frankiethull/kuzco")`

**Core Architecture**:
- Built on {ollamar} and {ellmer} packages
- Flexible backend support: 'ollamar' (suggested outputs) vs 'ellmer' (enforced structured outputs)
- Support for both local and cloud-hosted LLMs
- Standardized structured data output format

**Key Functions**:
- `llm_image_classification()` - Image classification with confidence scores
- `llm_image_sentiment()` - Sentiment analysis of images  
- `llm_image_recognition()` - Object detection and recognition
- `llm_image_extract_text()` - OCR text extraction
- `llm_image_custom()` - Fully customizable computer vision tasks
- `view_image()` / `view_llm_results()` - I/O helper functions
- `kuzco_app()` - Shiny application interface

### Computer Vision Methods
**Supported Tasks**:
1. **Image Classification** - Primary/secondary object identification with probability scores
2. **Sentiment Analysis** - Emotional content assessment with confidence scoring
3. **Object Recognition** - Specific object detection with location and count
4. **OCR (Text Extraction)** - Text recognition with confidence scores
5. **Custom Vision Tasks** - User-defined prompts with structured outputs
6. **Alt-text Generation** - Accessibility description creation

**Technical Approach**:
- LLM-based computer vision (alternative to traditional CNN/deep learning)
- Structured output format for consistent data processing
- Multi-model support (qwen2.5vl, pixtral-12b, etc.)
- Probability scoring and confidence metrics

### Code Examples
**Basic Image Classification**:
```r
library(kuzco)
library(ollamar)

# Load test image
test_img <- file.path(system.file(package = "kuzco"), "img/test_img.jpg")

# Classify image
llm_results <- llm_image_classification(
  llm_model = "qwen2.5vl", 
  image = test_img, 
  backend = 'ollamar'
)

# Structured output
llm_results |> tibble::as_tibble()
# Returns: image_classification, primary_object, secondary_object, 
#         image_description, image_colors, image_proba_names, image_proba_values
```

**Sentiment Analysis**:
```r
llm_emotion <- llm_image_sentiment(llm_model = "qwen2.5vl", image = test_img)
# Returns: image_sentiment, image_score, sentiment_description, image_keywords
```

**Object Recognition**:
```r
llm_detection <- llm_image_recognition(
  llm_model = "qwen2.5vl", 
  image = test_img,
  recognize_object = "nose",
  backend = "ollamar"
)
# Returns: object_recognized, object_count, object_description, object_location
```

**OCR Text Extraction**:
```r
llm_extract_txt <- llm_image_extract_text(
  llm_model = "qwen2.5vl", 
  image = text_img,
  backend = "ellmer"
)
# Returns: text, confidence_score
```

**Custom Vision Tasks**:
```r
llm_customized <- llm_image_custom(
  llm_model = "qwen2.5vl", 
  image = test_img,
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
# Set API key
Sys.setenv(MISTRAL_API_KEY = "your_api_key")

# Use cloud-hosted model
kuzco::llm_image_classification(
  provider = "mistral", 
  llm_model = "pixtral-12b", 
  image = test_img
)
```

## Research Implications
**Democratization of Computer Vision**: kuzco represents a significant shift toward making computer vision accessible to R users without deep learning expertise. By leveraging LLMs instead of traditional CNN architectures, it removes barriers to entry for researchers and analysts.

**Alternative Paradigm**: Positions LLM-based computer vision as a viable alternative to Keras/PyTorch workflows, particularly valuable for:
- Rapid prototyping and experimentation
- Non-specialist users requiring vision capabilities
- Scenarios where training custom models is impractical
- Research workflows requiring interpretable vision analysis

**Integration Benefits**:
- Seamless R ecosystem integration
- Structured data output compatible with tidyverse workflows
- Support for both local (privacy-preserving) and cloud (high-performance) deployments
- Standardized API design enabling reproducible research

**Methodological Impact**: 
- Bridges traditional statistical computing with modern AI capabilities
- Enables domain experts to apply computer vision without ML engineering overhead
- Supports mixed-method research combining quantitative analysis with visual data

## Q&A Session
<!-- Questions and responses -->

## Questions for Further Investigation
**Technical Performance**:
- How does LLM-based computer vision accuracy compare to traditional CNN approaches?
- What are the computational cost trade-offs between local vs cloud-hosted models?
- How does structured output consistency vary across different LLM backends?

**Integration & Workflow**:
- Best practices for integrating kuzco into existing R analytical workflows?
- How to handle batch processing and large-scale image analysis?
- Integration patterns with R Markdown/Quarto for reproducible visual analysis?

**Model Selection & Optimization**:
- Which LLM models perform best for specific computer vision tasks?
- How to optimize prompts for domain-specific image analysis?
- Trade-offs between model size, accuracy, and inference speed?

**Research Applications**:
- Use cases in academic research where LLM-based CV outperforms traditional approaches?
- How to validate and ensure reproducibility of LLM-based vision analyses?
- Integration with existing statistical analysis pipelines?

**Development & Extensibility**:
- Roadmap for CRAN submission and package maturation?
- Plans for additional computer vision tasks and capabilities?
- Community contribution patterns and package governance?

## Resources & References
### Primary Resources
- **Speaker**: Frank Hull (@frankiethull)
- **Package**: kuzco
- **GitHub**: https://github.com/frankiethull/kuzco
- **Documentation**: https://frankiethull.github.io/kuzco/
- **CRAN**: Not yet published (development version available)
- **Installation**: `devtools::install_github("frankiethull/kuzco")`
- **Stars**: 61 GitHub stars
- **Contributors**: 3 active contributors

### Related Tools & Packages
**Core Dependencies**:
- **ollamar**: R interface to Ollama for local LLM inference
- **ellmer**: R package for LLM interactions with structured outputs

**R Computer Vision Ecosystem**:
- **magick**: ImageMagick R bindings for image processing
- **imager**: Image processing and computer vision
- **OpenImageR**: Image processing and computer vision tasks
- **keras/tensorflow**: Deep learning frameworks for R
- **torch**: PyTorch interface for R

**LLM Integration Packages**:
- **openai**: OpenAI API interface
- **httr2**: HTTP client for API interactions
- **jsonlite**: JSON processing for structured outputs

### Academic References
**Computer Vision + LLM Research**:
- Vision-Language Models (VLMs) literature
- Multimodal AI applications in research
- Structured output generation from language models
- Prompt engineering for vision tasks

**R + AI Integration**:
- Democratization of AI tools in statistical computing
- Reproducible research with AI-assisted analysis
- Mixed-method research incorporating visual data

## Action Items
- [ ] Test kuzco package installation
- [ ] Explore computer vision use cases
- [ ] Document integration approaches
- [ ] Compare with existing CV tools in R

## Notes
- **Status**: Ready for live note-taking
- **Context**: Computer vision accessibility in R
- **Expected Topics**: Image processing, CV workflows, practical applications
- **Conference Day**: 2/2
- **Talk Number**: 5/9

---
*Created: 2025-11-13 | Conference: R+AI 2025*