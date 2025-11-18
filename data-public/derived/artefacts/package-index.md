# Conference Package Index: R+AI 2025

Ranked by potential usefulness for research analytics workflows.

---

## Tier 1: Essential Infrastructure (⭐⭐⭐⭐⭐)

### btw
- **Type**: R/LLM Integration Toolkit
- **Status**: CRAN v1.0.0
- **Install**: `install.packages("btw")`
- **Links**: [GitHub](https://github.com/posit-dev/btw) | [Docs](https://posit-dev.github.io/btw/)
- **Key Features**: 40+ R environment tools, VSCode MCP integration, GitHub Copilot R-awareness
- **Functions**: `btw_client()`, `btw_mcp_server()`, `btw_app()`, `btw_tools()`
- **Priority**: **Immediate - VSCode integration essential**
- **Session**: 1-04 (Aden-Buie)

### ellmer
- **Type**: Universal LLM Interface
- **Status**: Production-ready
- **Install**: `install.packages("ellmer")`
- **Links**: [ellmer.tidyverse.org](https://ellmer.tidyverse.org/)
- **Key Features**: 16+ provider support (OpenAI, Anthropic, Ollama, Google), streaming, tool calling, structured data extraction
- **Use Cases**: Foundation for btw, mini007, brandthis, kuzco
- **Session**: 1-04, 1-09, 2-05

### mini007
- **Type**: Multi-Agent Orchestration
- **Status**: CRAN v0.2.1
- **Install**: `install.packages("mini007")`
- **Links**: [CRAN](https://cran.r-project.org/package=mini007) | [Docs](https://cran.r-project.org/web/packages/mini007/refman/mini007.html)
- **Key Features**: R6 agents, LeadAgent orchestration, Judge function, HITL, plan visualization (DiagrammeR)
- **Use Cases**: Multi-agent task decomposition, quality control, model comparison
- **Session**: 1-06 (Ihaddaden)

### vitals
- **Type**: LLM Evaluation Framework
- **Status**: Production-ready
- **Install**: `install.packages("vitals")` or `pak::pak("tidyverse/vitals")`
- **Links**: [vitals.tidyverse.org](https://vitals.tidyverse.org/)
- **Key Features**: Unit testing paradigm for LLMs, inspect framework compatibility, persistent logging
- **Components**: Dataset, Solver (ellmer), Scorer
- **Session**: 1-07 (Kuhn)

### rig
- **Type**: R Installation Manager
- **Status**: Production (829 stars)
- **Install**: Binary from [GitHub](https://github.com/r-lib/rig)
- **Key Features**: System-wide R version management, Rust-based, macOS menu bar app
- **Commands**: `rig add release`, `rig list`, `rig default 4.4`
- **Session**: 2-04, 2-09

### rv
- **Type**: Declarative Package Manager
- **Status**: Development
- **Install**: `install.packages("rv")` (check availability)
- **Links**: [GitHub](https://github.com/a2-ai/rv) | [Docs](https://a2-ai.github.io/rv-docs/)
- **Key Features**: 25x faster than renv, rproject.toml, full dependency tree resolution
- **Session**: 2-04, 2-09

---

## Tier 2: Specialized AI Tools (⭐⭐⭐⭐)

### ragnar
- **Type**: RAG Workflows
- **Status**: Production-ready
- **Install**: `install.packages("ragnar")`
- **Links**: [ragnar.tidyverse.org](https://ragnar.tidyverse.org/)
- **Key Features**: Document processing (MarkItDown), semantic chunking, vector embeddings + BM25 (DuckDB), tool registration
- **Use Cases**: Knowledge stores for design packages (paletteer, ggsci), grounded LLM suggestions
- **Session**: 1-09 (Durrani)

### brandthis
- **Type**: RAG-Enhanced Branding
- **Status**: Development
- **Install**: `remotes::install_github("durraniu/brandthis")`
- **Links**: [GitHub](https://github.com/durraniu/brandthis) | [Docs](https://durraniu.github.io/brandthis/)
- **Key Features**: Multi-modal inputs (text + images), `_brand.yml` generation, Shiny app validation
- **Functions**: `create_brand()`, `suggest_color_scales()`, `run_brand_app()`
- **Session**: 1-09 (Durrani)

### kuzco
- **Type**: LLM-Based Computer Vision
- **Status**: Development
- **Install**: `devtools::install_github("frankiethull/kuzco")`
- **Links**: [GitHub](https://github.com/frankiethull/kuzco) | [Docs](https://frankiethull.github.io/kuzco/)
- **Key Features**: Classification, sentiment, recognition, OCR, custom workflows; local (Ollama) + cloud support
- **Functions**: `llm_image_classification()`, `llm_image_sentiment()`, `llm_image_recognition()`, `llm_image_extract_text()`, `kuzco_app()`
- **Session**: 2-05 (Hull)

### NumericEnsembles
- **Type**: Automated Ensemble Modeling
- **Status**: CRAN April 2025
- **Install**: `install.packages("NumericEnsembles")`
- **Links**: [numericensembles.com](https://www.numericensembles.com/) | [GitHub](https://github.com/InfiniteCuriosity/NumericEnsembles)
- **Key Features**: 40 models (23 individual + 17 ensembles), one-line usage, 26 auto-plots + 6 tables
- **Models**: BayesGLM, BayesRNN, XGBoost, Neuralnet, RF, SVM, etc.
- **Session**: 2-02 (Conte)

### ClassificationEnsembles
- **Type**: Automated Classification
- **Status**: CRAN April 2025
- **Install**: `install.packages("ClassificationEnsembles")`
- **Links**: [GitHub](https://github.com/InfiniteCuriosity/ClassificationEnsembles)
- **Key Features**: 25 classification models, 26 plots + 5 tables + 25 confusion matrices
- **Session**: 2-02 (Conte)

### LogisticEnsembles
- **Type**: Automated Logistic Regression
- **Status**: CRAN April 2025
- **Install**: `install.packages("LogisticEnsembles")`
- **Links**: [logisticensembles.com](https://www.logisticensembles.com/) | [GitHub](https://github.com/InfiniteCuriosity/LogisticEnsembles)
- **Key Features**: 24 logistic models, BayesRNN integration, 25 plots + 7 tables
- **Session**: 2-02 (Conte)

### diffuseR
- **Type**: Stable Diffusion (R-Native)
- **Status**: Development
- **Install**: `devtools::install_github("cornball-ai/diffuseR")`
- **Links**: [GitHub](https://github.com/cornball-ai/diffuseR) | [Models](https://github.com/cornball-ai/diffuseR-TS/)
- **Key Features**: Zero Python dependency, TorchScript models, txt2img + img2img, GPU/CPU support, SD 2.1 + SDXL
- **Prerequisites**: torch package with version-specific installation
- **Session**: 2-06 (Hernandez)

---

## Tier 3: Domain-Specific Tools (⭐⭐⭐)

### geodl
- **Type**: Geospatial Semantic Segmentation
- **Status**: CRAN v0.3.0
- **Install**: `install.packages("geodl")`
- **Links**: [CRAN](https://cran.r-project.org/package=geodl) | [GitHub](https://github.com/maxwell-geospatial/geodl) | [Docs](https://wvview.org/geodl/index.html)
- **Key Features**: UNet architectures, pure R/C++ (torch + terra), attention gates, ASPP, multi-spectral data
- **Use Cases**: Satellite imagery, land cover mapping, patient-level ETL transformations
- **Session**: 2-01 (Maxwell)

### avilstr
- **Type**: Weekend-to-CRAN Example Package
- **Status**: CRAN
- **Install**: `install.packages("avilstr")`
- **Key Features**: AI-assisted rapid development demonstration
- **Session**: 1-02 (Daly)

### shinyfa
- **Type**: Shiny File Analysis
- **Status**: Development
- **Key Features**: AI-assisted Shiny package development example
- **Session**: 1-02 (Daly)

### weathR
- **Type**: National Weather Service API
- **Status**: CRAN
- **Install**: `install.packages("weathR")`
- **Key Features**: Weather data retrieval for R workflows
- **Session**: 1-04 (Aden-Buie)

---

## Tier 4: Statistical & ML Foundation (⭐⭐⭐⭐)

### xgboost
- **Type**: Gradient Boosting
- **Status**: Production (CRAN)
- **Install**: `install.packages("xgboost")`
- **Key Features**: Industry-standard GBM, GPU support, structured data excellence
- **Use Cases**: Tabular data prediction, time series forecasting components
- **Session**: 2-02, 2-03

### lightgbm
- **Type**: Gradient Boosting
- **Status**: Production (CRAN)
- **Install**: `install.packages("lightgbm")`
- **Key Features**: Microsoft framework, large dataset optimization, categorical feature handling
- **Session**: 2-03

### catboost
- **Type**: Gradient Boosting
- **Status**: Production (CRAN)
- **Install**: `install.packages("catboost")`
- **Key Features**: Yandex framework, native categorical handling, minimal tuning
- **Session**: 2-03

### ordinal
- **Type**: Ordinal Regression
- **Status**: CRAN
- **Install**: `install.packages("ordinal")`
- **Key Features**: `clmm()` for cumulative link mixed models, LLM evaluation
- **Session**: 1-07

### brms
- **Type**: Bayesian Regression
- **Status**: CRAN
- **Install**: `install.packages("brms")`
- **Key Features**: Stan backend, direct probability statements, LLM evaluation
- **Session**: 1-07

### SuperLearner
- **Type**: Ensemble Learning
- **Status**: CRAN v2.0-29
- **Install**: `install.packages("SuperLearner")`
- **Links**: [GitHub](https://github.com/ecpolley/SuperLearner)
- **Key Features**: 284 stars, dozens of algorithms, hyperparameter optimization, custom loss functions
- **Session**: 2-02

---

## Tier 5: Supporting Infrastructure (⭐⭐⭐)

### torch
- **Type**: Deep Learning Framework
- **Status**: CRAN
- **Install**: Version-specific (see diffuseR notes)
- **Key Features**: R libtorch backend, GPU/CPU support, TorchScript compatibility
- **Used By**: geodl, diffuseR
- **Session**: 2-01, 2-06

### terra
- **Type**: Raster Processing
- **Status**: CRAN
- **Install**: `install.packages("terra")`
- **Key Features**: Efficient C++ backend, memory-optimized large rasters
- **Session**: 2-01

### data.table
- **Type**: High-Performance Data Manipulation
- **Status**: CRAN
- **Install**: `install.packages("data.table")`
- **Key Features**: `dcast()` for wide-format transformations, patient-level ETL
- **Session**: 1-03

### R6
- **Type**: Object-Oriented Programming
- **Status**: CRAN (≥ 2.6.1)
- **Install**: `install.packages("R6")`
- **Key Features**: Encapsulation, persistent state, agent architecture foundation
- **Used By**: mini007, agent frameworks
- **Session**: 1-06, 2-09

### DiagrammeR
- **Type**: Graph Visualization
- **Status**: CRAN (≥ 1.0.11)
- **Install**: `install.packages("DiagrammeR")`
- **Key Features**: Plan visualization for multi-agent workflows
- **Session**: 1-06

### ROracle
- **Type**: Oracle Database Interface
- **Status**: CRAN
- **Install**: `install.packages("ROracle")`
- **Key Features**: Oracle Database 23c integration, AI Profile support, DBMS_CLOUD_AI
- **Session**: 2-08

### ollamar
- **Type**: Ollama R Interface
- **Status**: Development
- **Install**: Check availability
- **Key Features**: Local LLM inference, suggested outputs
- **Used By**: kuzco
- **Session**: 2-05

### paws
- **Type**: AWS Services Integration
- **Status**: CRAN
- **Install**: `install.packages("paws")`
- **Key Features**: AWS API access from R
- **Session**: 2-04

---

## Development Stack & Tools

### tidymodels
- **Type**: Modeling Framework
- **Status**: CRAN
- **Install**: `install.packages("tidymodels")`
- **Key Features**: Unified ML interface, GBM integrations

### caret
- **Type**: ML Training Framework
- **Status**: CRAN
- **Install**: `install.packages("caret")`
- **Key Features**: Unified interface, hyperparameter tuning

### renv
- **Type**: Environment Management
- **Status**: CRAN
- **Install**: `install.packages("renv")`
- **Key Features**: Iterative dependency tracking (alternative to rv)

### devtools
- **Type**: Development Tools
- **Status**: CRAN
- **Install**: `install.packages("devtools")`
- **Key Features**: Package development workflow

### testthat
- **Type**: Unit Testing
- **Status**: CRAN
- **Install**: `install.packages("testthat")`
- **Key Features**: Automated testing, agent evaluation

---

## Python Packages Mentioned

### LangChain
- **Type**: LLM Orchestration (Python)
- **Status**: Production
- **Note**: R orchestration gap identified - no direct R equivalent
- **Session**: 2-04

### inspect
- **Type**: LLM Evaluation Framework (Python)
- **Status**: Production
- **Links**: [inspect.aisi.org.uk](https://inspect.aisi.org.uk/)
- **R Integration**: vitals provides R port and log compatibility
- **Session**: 1-07

### diffusers
- **Type**: HuggingFace Diffusion Library (Python)
- **Status**: Production
- **R Port**: diffuseR provides R-native alternative
- **Session**: 2-06

---

## Package Mentions by Session

**Session 1-01 (Cheng)**: QueryChat, Databot, Positron  
**Session 1-02 (Daly)**: shinyfa, avilstr  
**Session 1-03 (Pearce)**: data.table, dplyr, testthat, devtools, pkgdown  
**Session 1-04 (Aden-Buie)**: btw, ellmer, weathR  
**Session 1-05 (Rucki)**: Proprietary (not open source)  
**Session 1-06 (Ihaddaden)**: mini007, R6, ellmer, DiagrammeR  
**Session 1-07 (Kuhn)**: vitals, ordinal, brms  
**Session 1-08 (Charlon)**: Bioconductor, text2vec, word2vec  
**Session 1-09 (Durrani)**: brandthis, ellmer, ragnar, paletteer, ggsci  
**Session 2-01 (Maxwell)**: geodl, torch, terra, tmap  
**Session 2-02 (Conte)**: NumericEnsembles, ClassificationEnsembles, LogisticEnsembles, ForecastingEnsembles, SuperLearner  
**Session 2-03 (Pafka)**: xgboost, lightgbm, catboost  
**Session 2-04 (Fei)**: btw, rig, rv, paws, vitals  
**Session 2-05 (Hull)**: kuzco, ollamar, ellmer  
**Session 2-06 (Hernandez)**: diffuseR, torch  
**Session 2-07 (Muñoz)**: shiny, plotly, DT, openai  
**Session 2-08 (Hornick/LaMonica)**: ROracle, DBI  
**Session 2-09 (Pastoor/Fei/Kumar)**: rig, rv, renv, R6, httr2, jsonlite

---

## Priority Installation Queue

### Immediate (High Value, Production-Ready)
1. `install.packages("btw")` - **Essential VSCode integration**
2. `install.packages("ellmer")` - **Foundation for all LLM work**
3. `install.packages("mini007")` - **Multi-agent orchestration**
4. `install.packages("vitals")` - **LLM evaluation**
5. Install `rig` binary - **R version management**
6. `install.packages("xgboost")` - **Forecasting applications**

### Secondary (Specialized Use Cases)
7. `remotes::install_github("durraniu/brandthis")` - **Branding automation**
8. `devtools::install_github("frankiethull/kuzco")` - **Computer vision**
9. `install.packages("NumericEnsembles")` - **Automated modeling**
10. `install.packages("ragnar")` - **RAG workflows**

### Domain-Specific (As Needed)
11. `install.packages("geodl")` - **When spatial projects arise**
12. `devtools::install_github("cornball-ai/diffuseR")` - **Image generation needs**
13. `install.packages("ordinal")` + `install.packages("brms")` - **Advanced LLM evaluation**

---

**Last Updated**: 2025-11-14  
**Conference**: R+AI 2025 (November 12-13, 2025)  
**Source**: Conference notes from 18 sessions
