# R+AI 2025 Conference Follow-Up
**Technical Adoption & Action Items**  
**Prioritized by Importance & Relevance from Conference Notes**

---

## 🔥 CRITICAL PRIORITY: Game-Changing Integrations

### 1. btw + VSCode Copilot Integration [Session 1-04]
**Why This Matters**: btw provides unmatched R environment understanding (40+ tools, environment inspection, documentation access, package knowledge). Integrating with VSCode transforms it into an R-aware AI development environment.

**Implementation Roadmap**:
- [ ] **Phase 1: btw MCP Server Setup**
  - [ ] Install btw: `install.packages("btw")`
  - [ ] Test `btw_mcp_server()` functionality with R session
  - [ ] Verify btw_tools() exposure via MCP protocol
  - [ ] Document btw's R knowledge capabilities (environment, docs, packages, files, git)

- [ ] **Phase 2: VSCode MCP Client Configuration**
  - [ ] Research VSCode MCP extensions for btw server connection
  - [ ] Configure VSCode as MCP client to connect to `btw_mcp_server()`
  - [ ] Test JSON-RPC 2.0 communication between VSCode and btw
  - [ ] Verify tool discovery and execution from VSCode

- [ ] **Phase 3: GitHub Copilot Enhancement**
  - [ ] Test btw context integration with GitHub Copilot suggestions
  - [ ] Evaluate btw's R environment knowledge enhancing Copilot's R code generation
  - [ ] Create workflows: VSCode Copilot + btw R context → superior R development experience
  - [ ] Document performance and usability improvements

**Expected Outcome**: VSCode becomes R-aware AI development environment with real-time R context from btw's comprehensive knowledge base.

**Resources**:
- **GitHub**: [posit-dev/btw](https://github.com/posit-dev/btw)
- **Website**: [posit-dev.github.io/btw/](https://posit-dev.github.io/btw/)
- **Version**: v1.0.0 (Latest CRAN release)

---

### 2. btw_client() - Core Programming Interface [Session 1-04]
**Why This Matters**: `btw_client()` is the foundational programming interface for building custom R+LLM applications. It creates enhanced ellmer::Chat objects with all btw tools pre-registered.

**Deep Dive Actions**:
- [ ] Test basic `btw_client()` creation with default settings
- [ ] Experiment with different LLM providers via `client` parameter
- [ ] Test tool subset selection with `tools = c("env", "docs", "files")`
- [ ] Create custom btw_client with ellmer providers (OpenAI, Claude, Ollama)
- [ ] Test project context integration (btw.md, AGENTS.md, llms.txt files)
- [ ] Explore hierarchical configuration (R options → project → user settings)
- [ ] Build custom applications using btw_client() as foundation

**Key Features**:
- **Project Context Integration**: Automatically reads `btw.md`, `AGENTS.md`, and `llms.txt` files
- **Tool Registration**: All 40+ btw_tools() automatically available
- **Provider Flexibility**: Works with any ellmer-supported LLM provider
- **Hierarchical Configuration**: Project-level → User-level → R options fallback

**Usage Patterns**:
```r
# Basic usage with default Anthropic
chat <- btw_client()
chat$chat("Describe my data frames")

# Custom provider/model
chat <- btw_client(client = "openai/gpt-4o")

# Specific tool subsets
chat <- btw_client(tools = c("env", "docs", "files"))
```

---

### 3. Strategic Consulting Practice Evolution [Session 1-02]
**Why This Matters**: AI assistance fundamentally shifts consulting from "Can I do it?" to "How to understand client outcomes and constraints". Mental bandwidth is freed for strategic thinking rather than technical execution.

**Practice Transformation**:
- [ ] **Adopt Manager-Developer Mental Model**
  - [ ] Human as Manager: Strategic oversight, requirements definition, quality assurance
  - [ ] AI as Developer: Code generation, implementation, documentation assistance
  - [ ] Human-in-the-Loop: Continuous oversight ensures quality and alignment

- [ ] **Redirect Freed Mental Bandwidth**
  - [ ] Focus on understanding client outcomes and success metrics
  - [ ] Identify constraints and requirements more thoroughly
  - [ ] Elevate thinking to strategic level rather than technical implementation
  - [ ] Develop skills in business context translation

- [ ] **Right-Sized Enterprise Infrastructure**
  - [ ] Study GitHub Actions → Supabase → Quarto → Template system architecture
  - [ ] Implement template-driven development for reusability
  - [ ] Maintain enterprise-grade quality with accelerated timelines

**Key Insight**: "When AI frees up mental bandwidth, you don't get lazy - you get strategic" (personality-dependent)

**Resources**:
- **Speaker**: Jasmine Daly, Daly Analytics
- **Slides**: [Me, Myself, and Claude](https://dalyanalytics.github.io/me-myself-claude-talk/)
- **Packages**: shinyfa, avilstr (weekend-to-CRAN example)

---

## ⭐ HIGH PRIORITY: Core Tools & Frameworks

### 4. ellmer - Universal LLM Chat Framework [Session 1-04]
**Why This Matters**: Foundation for all R+LLM communication. Supports 16+ LLM providers with stateful R6 objects, tool/function calling, and structured data extraction.

**Implementation Tasks**:
- [ ] Install ellmer: `install.packages("ellmer")`
- [ ] Test all 16+ LLM providers (OpenAI, Anthropic, Google, AWS, Azure, Ollama, etc.)
- [ ] Explore tool/function calling capabilities
- [ ] Test structured data extraction features
- [ ] Evaluate streaming and async API usage
- [ ] Create basic chat setup and test interactive console

**Key Features**:
- **16+ LLM Providers**: OpenAI, Anthropic, Google Gemini, AWS Bedrock, Azure OpenAI, Ollama
- **Stateful R6 Objects**: Conversation context persistence across interactions
- **Tool/Function Calling**: Register R functions as LLM tools
- **Structured Data Extraction**: Parse LLM responses into R data structures

**Usage Example**:
```r
# Basic chat setup
chat <- chat_openai("Be terse", model = "gpt-4o-mini")
chat$chat("What is 6 times 7?")

# Interactive console
live_console(chat)

# Image analysis
chat$chat(
  content_image_url("https://example.com/image.png"),
  "Describe this image"
)
```

**Resources**:
- **Website**: [ellmer.tidyverse.org](https://ellmer.tidyverse.org/)
- **GitHub**: [tidyverse/ellmer](https://github.com/tidyverse/ellmer/)

---

### 5. mini007 - Multi-Agent Orchestration Framework [Session 1-06]
**Why This Matters**: Lightweight framework for multi-agent orchestration in R with Judge function for response quality comparison. Built on R6 classes with ellmer integration.

**Implementation Tasks**:
- [ ] Install mini007: `install.packages("mini007")`
- [ ] Test Judge function with multiple agents for response quality comparison
- [ ] Experiment with Human In The Loop (HITL) integration points
- [ ] Test LeadAgent orchestration with task decomposition
- [ ] Create plan visualization using DiagrammeR
- [ ] Compare mini007 vs. manual multi-agent coordination

**Key Features**:
- **Agent Types**: Basic Agent and LeadAgent for orchestration
- **Judge Function**: Multiple agents generate responses, judge selects best
- **HITL Capability**: Human In The Loop at various execution steps
- **Plan Visualization**: DiagrammeR integration for workflow inspection
- **Persistent State**: R6 classes with UUID-based agent identification

**Usage Pattern**:
```r
# Basic Agent Creation
agent <- Agent$new(
  name = "specialized_agent",
  instruction = "You are an expert in X. Answer in Y format.",
  llm_object = ellmer_llm_object
)

# LeadAgent for Orchestration
lead_agent <- LeadAgent$new(name = "orchestrator", llm_object = llm)
lead_agent$register_agents(c(agent1, agent2, agent3))

# Workflow Execution with Judge
plan <- lead_agent$generate_plan(complex_prompt)
lead_agent$visualize_plan()
response <- lead_agent$invoke(complex_prompt)
```

**Resources**:
- **CRAN**: [mini007](https://cran.r-project.org/package=mini007)
- **Version**: 0.2.1 (Published: 2025-11-03)
- **Speaker**: Mohamed El Fodil Ihaddaden (HDI Global SE)

---

### 6. vitals - LLM Evaluation as Unit Testing [Session 1-07]
**Why This Matters**: R-native approach to LLM evaluation that treats testing like unit testing. Provides on-ramp to Python's Inspect framework with compatible log format.

**Implementation Tasks**:
- [ ] Install vitals: `install.packages("vitals")` or `pak::pak("tidyverse/vitals")`
- [ ] Follow getting started vignette: `vignette("vitals", package = "vitals")`
- [ ] Test three-component architecture: Dataset, Solver, Scorer
- [ ] Experiment with Inspect log viewer on vitals-generated logs
- [ ] Test integration with ellmer package for actual LLM evaluation tasks
- [ ] Create custom evaluation workflows for r-ai-2025 project

**Key Features**:
- **Three-Component Architecture**: Dataset (input/target), Solver (ellmer integration), Scorer (evaluation methods)
- **Persistent Log Files**: Treats LLM evaluations like unit testing
- **Inspect Integration**: Writes to same file format as Python Inspect
- **R Port**: Provides on-ramp to transition to Python Inspect framework

**Usage Example**:
```r
library(vitals)
library(ellmer)

# Define dataset with input/target structure
simple_addition <- tibble(
  input = c("What's 2+2?", "What's 2+3?", "What's 2+4?"),
  target = c("4", "5", "6")
)

# Create task with three components
tsk <- Task$new(
  dataset = simple_addition, 
  solver = generate(chat_anthropic(model = "claude-sonnet-4-20250514")), 
  scorer = model_graded_qa()
)

# Evaluate the task
tsk$eval()  # Runs solver, scorer, saves to persistent log
```

**Resources**:
- **Website**: [vitals.tidyverse.org](https://vitals.tidyverse.org/)
- **GitHub**: [tidyverse/vitals](https://github.com/tidyverse/vitals/)
- **Speakers**: Max Kuhn & Simon Couch (Posit PBC)
- **Repository**: [github.com/topepo/2025-r-ai](https://github.com/topepo/2025-r-ai)

---

### 7. Statistical Rigor for LLM Evaluation [Session 1-07]
**Why This Matters**: Proper statistical methodology for comparing LLMs using 51-year-old Generalized Linear Models. Addresses fundamental issues ignored by ad-hoc approaches.

**Implementation Tasks**:
- [ ] Reproduce example analysis with Claude/GPT/Gemini dataset from presentation
- [ ] Compare ordinal::clmm() vs. brms::brm() approaches on same dataset
- [ ] Test proportional odds assumption on LLM evaluation data
- [ ] Develop template for proper LLM evaluation experimental design
- [ ] Evaluate computational requirements for Bayesian approach at scale

**Key Methods**:
- **Proportional Odds Model**: ordinal::clmm() for ordinal outcomes
- **Bayesian Approach**: brms::brm() with Stan backend for probability statements
- **Hierarchical Models**: Random effects for question difficulty
- **Factorial Designs**: Multiple experimental factors (LLM models, prompts, replicates)

**Critical Reading**:
- [ ] Read Anthropic 2024 paper: ["Adding Error Bars to Evals"](https://arxiv.org/pdf/2411.00640)
- [ ] Compare their approach to Max Kuhn's statistical methodology
- [ ] Read Simon Couch's blog: ["I was wrong about tidymodels and LLMs"](https://www.simonpcouch.com/blog/2025-08-26-predictive/)

**Resources**:
- **Slides**: [topepo.github.io/2025-r-ai/](https://topepo.github.io/2025-r-ai/)
- **Packages**: ordinal, brms, tidymodels, vitals
- **Speakers**: Max Kuhn & Simon Couch (Posit PBC)

---

## 📊 MEDIUM PRIORITY: Specialized Applications

### 8. kuzco - Computer Vision Made Easy [Session 2-05]
**Why This Matters**: LLM-based computer vision as alternative to Keras/PyTorch. Democratizes CV for R users without deep learning expertise.

**Implementation Tasks**:
- [ ] Install kuzco: `devtools::install_github("frankiethull/kuzco")`
- [ ] Test image classification with confidence scores
- [ ] Test sentiment analysis of images
- [ ] Test object recognition and OCR text extraction
- [ ] Explore custom vision tasks with user-defined prompts
- [ ] Compare LLM-based CV accuracy vs traditional CNN approaches

**Key Functions**:
- `llm_image_classification()` - Image classification with confidence scores
- `llm_image_sentiment()` - Sentiment analysis of images
- `llm_image_recognition()` - Object detection and recognition
- `llm_image_extract_text()` - OCR text extraction
- `llm_image_custom()` - Fully customizable computer vision tasks
- `kuzco_app()` - Shiny application interface

**Usage Example**:
```r
library(kuzco)

# Image classification
llm_results <- llm_image_classification(
  llm_model = "qwen2.5vl", 
  image = test_img, 
  backend = 'ollamar'
)

# Structured output
llm_results |> tibble::as_tibble()
# Returns: primary_object, secondary_object, description, colors, probabilities
```

**Resources**:
- **GitHub**: [frankiethull/kuzco](https://github.com/frankiethull/kuzco)
- **Documentation**: [frankiethull.github.io/kuzco/](https://frankiethull.github.io/kuzco/)
- **Speaker**: Frank Hull
- **Dependencies**: ollamar, ellmer

---

### 9. Oracle Database-Native RAG [Session 2-08]
**Why This Matters**: Eliminates complexity of separate vector databases by implementing RAG directly within Oracle Database. Enterprise-grade scalability with comprehensive AI profiling capabilities.

**Implementation Tasks**:
- [ ] Analyze Oracle Database vector search capabilities for RAG implementation
- [ ] Document R Consortium data sources and access methods
- [ ] Evaluate performance: database-native vs. external vector storage
- [ ] Test DBMS_CLOUD_AI.GENERATE_EMBEDDINGS() for embedding generation
- [ ] Test DBMS_CLOUD_AI.CHAT() for completion
- [ ] Create AI profiles for monitoring and alignment

**Key Features**:
- **AI Profiles**: Named configurations with provider, credentials, and model settings
- **DBMS_CLOUD_AI**: Native AI integration package for embeddings and chat completions
- **Vector Search**: Native vector similarity search with AI profile integration
- **SQL Integration**: Standard SQL queries for RAG operations
- **Performance Optimization**: Database-level optimizations for large-scale retrieval

**AI Profile Configuration**:
```r
# Create AI profile
ai_profile_config <- list(
  profile_name = "R_CONSORTIUM_RAG_PROFILE",
  provider = "OPENAI",
  credential_name = "OPENAI_CRED",
  vector_index_name = "R_CONSORTIUM_VECTOR_IDX",
  model = "gpt-4",
  embedding_model = "text-embedding-ada-002",
  enable_sources = TRUE
)
```

**Resources**:
- **Speakers**: Mark Hornick & Sherry LaMonica (Oracle)
- **Package**: ROracle - Oracle Database interface for R
- **Focus**: R Consortium data analysis with RAG

---

### 10. weathR - Weather Data Integration [Session 1-04]
**Why This Matters**: Easy access to U.S. National Weather Service data with integration for geospatial analysis and visualization.

**Implementation Tasks**:
- [ ] Install weathR: `install.packages("weathR")`
- [ ] Test core functions: `point_data()`, `point_forecast()`, `station_forecast()`, `stations_near()`
- [ ] Test geospatial integration with `sf` and `tmap` packages
- [ ] Create weather data visualization workflows with `ggplot2`
- [ ] Explore ASOS/AWOS station quality advantages
- [ ] Experiment with weathR data + btw context gathering

**Core Functions**:
- `point_data()` - NWS metadata for specific coordinates
- `point_forecast()` - Weather forecasts by latitude/longitude
- `station_forecast()` - Forecasts by ASOS/AWOS station ID
- `stations_near()` - Find weather stations near coordinates

**Usage Example**:
```r
# Get forecast for Central Park, NYC
point_forecast(lat = 40.768, lon = -73.976) %>%
  select(time, temp) %>%
  ggplot(aes(x = time, y = temp)) + 
  geom_point() + geom_smooth()
```

**Resources**:
- **GitHub**: [JeffreyFowler/weathR](https://github.com/JeffreyFowler/weathR)
- **CRAN**: `install.packages("weathR")`
- **Author**: Jeffrey Fowler

---

## 🔬 RESEARCH & EXPLORATION

### 11. Inspect Framework Integration [Session 1-07]
**Why This Matters**: Python-based framework from UK AI Security Institute provides comprehensive evaluation capabilities with VS Code integration and sandboxing.

**Exploration Tasks**:
- [ ] Install Python Inspect: `pip install inspect-ai`
- [ ] Test vitals ↔ inspect log file compatibility
- [ ] Experiment with Inspect log viewer on vitals-generated logs
- [ ] Test VS Code extension for authoring and debugging
- [ ] Explore sandboxing system for running untrusted model code
- [ ] Investigate multi-agent evaluation primitives

**Key Features**:
- **Comprehensive Evaluation**: Coding, agentic tasks, reasoning, knowledge, behavior, multi-modal
- **VS Code Integration**: Dedicated extension for authoring and debugging
- **Sandboxing System**: Docker, Kubernetes for running untrusted model code
- **Agent Evaluation**: Multi-agent primitives and external agent integration

**Resources**:
- **Website**: [inspect.aisi.org.uk](https://inspect.aisi.org.uk/)
- **GitHub**: [UKGovernmentBEIS/inspect_ai](https://github.com/UKGovernmentBEIS/inspect_ai)
- **Organization**: UK AI Security Institute

---

### 12. MCP (Model Context Protocol) Deep Dive [Session 1-04]
**Why This Matters**: Open-source standard for connecting AI applications to external systems. Acts like "USB-C for AI applications".

**Research Tasks**:
- [ ] Test `btw_mcp_server()` - Start MCP server with all btw_tools()
- [ ] Test `btw_mcp_session()` - Connect MCP server to specific R session
- [ ] Configure Claude Desktop JSON configuration with btw MCP server
- [ ] Configure Claude Code CLI setup (`claude mcp add r-btw`)
- [ ] Configure Continue IDE MCP integration in config file
- [ ] Test tool discovery (`tools/list`) and execution (`tools/call`) via MCP
- [ ] Test real-time notifications for dynamic tool updates
- [ ] Test dual transport modes (STDIO local vs HTTP remote)

**MCP Core Primitives**:
1. **Tools** - All 40+ btw_tools() exposed as executable functions
2. **Resources** - R environment data, file contents, documentation
3. **Prompts** - Project context from btw.md, llms.txt files

**Configuration Examples**:
```json
// Claude Desktop configuration
{
  "mcpServers": {
    "r-btw": {
      "command": "Rscript",
      "args": ["-e", "btw::btw_mcp_server()"]
    }
  }
}
```

**Resources**:
- **Package**: mcptools - [posit-dev.github.io/mcptools/](https://posit-dev.github.io/mcptools/)
- **Protocol**: JSON-RPC 2.0 for client-server communication

---

### 13. Posit LLM Ecosystem Exploration [Session 1-04]
**Why This Matters**: Comprehensive suite of R+AI tools from Posit for various LLM integration scenarios.

**Exploration Tasks**:
- [ ] **chatlas**: Python equivalent of ellmer
- [ ] **ragnar**: [ragnar.tidyverse.org](https://ragnar.tidyverse.org/) - Retrieval Augmented Generation
- [ ] **shinychat**: [posit-dev.github.io/shinychat/](https://posit-dev.github.io/shinychat/) - LLM-powered Shiny chatbots
- [ ] Evaluate comprehensive integration potential with existing workflows

**Resources**:
- All packages available through Posit development repositories
- Documentation at respective tidyverse.org subdomains

---

## 📝 DOCUMENTATION & LEARNING

### 14. Critical Reading List
**Prioritized by Impact & Relevance**:

1. [ ] **Anthropic (2024)**: ["Adding Error Bars to Evals: A Statistical Approach to Language Model Evaluations"](https://arxiv.org/pdf/2411.00640)
   - Max Kuhn's critique: "Not wrong but myopic and not especially good statistical methodology"
   - Compare with proper experimental design approaches

2. [ ] **Simon Couch Blog**: ["I was wrong about tidymodels and LLMs"](https://www.simonpcouch.com/blog/2025-08-26-predictive/)
   - Co-presenter's insights on tidymodels integration with LLM workflows
   - Valuable perspective on predictive modeling with LLMs

3. [ ] **Max Kuhn Presentation**: [topepo.github.io/2025-r-ai/](https://topepo.github.io/2025-r-ai/)
   - Complete statistical methodology for LLM evaluation
   - Code examples with Claude/GPT/Gemini datasets

4. [ ] **Jasmine Daly Slides**: [Me, Myself, and Claude](https://dalyanalytics.github.io/me-myself-claude-talk/)
   - Practical consulting insights
   - Manager-developer mental model for AI collaboration

---

### 15. Package Documentation Deep Dives
**Focus on Implementation Details**:

1. [ ] **btw**: [posit-dev.github.io/btw/](https://posit-dev.github.io/btw/)
   - Function reference for all 40+ tools
   - Project context configuration guides
   - MCP integration patterns

2. [ ] **ellmer**: [ellmer.tidyverse.org](https://ellmer.tidyverse.org/)
   - Provider configuration for 16+ LLM services
   - Tool/function calling examples
   - Structured data extraction patterns

3. [ ] **mini007**: [CRAN Reference Manual](https://cran.r-project.org/web/packages/mini007/refman/mini007.html)
   - Agent architecture and design patterns
   - LeadAgent orchestration workflows
   - Judge function implementation details

4. [ ] **vitals**: [vitals.tidyverse.org](https://vitals.tidyverse.org/)
   - Getting started vignette
   - Dataset/Solver/Scorer architecture
   - Inspect log format compatibility

---

## 🎯 PROJECT INTEGRATION

### 16. r-ai-2025 Workflow Enhancement
**Apply Conference Learnings to Current Project**:

- [ ] **btw Integration**
  - [ ] Test btw + VSCode integration with existing r-ai-2025 project workflow
  - [ ] Create project-level btw.md file for workspace integration
  - [ ] Configure R options (btw.client, btw.tools) for VSCode environment
  - [ ] Document btw integration findings and implementation recommendations

- [ ] **ellmer Adoption**
  - [ ] Test ellmer integration with current LLM workflows
  - [ ] Evaluate provider flexibility for different use cases
  - [ ] Implement structured data extraction for analytical workflows

- [ ] **vitals Evaluation Framework**
  - [ ] Create custom evaluation workflows for r-ai-2025 project
  - [ ] Test LLM performance across different models and prompts
  - [ ] Implement proper statistical analysis of evaluation results

- [ ] **Strategic Practice Evolution**
  - [ ] Adopt manager-developer mental model for AI-assisted development
  - [ ] Create template-driven development system for reusability
  - [ ] Document right-sized infrastructure patterns

---

## 🚀 ADVANCED TOPICS

### 17. Multi-Modal Integration Patterns
**Combining Tools for Enhanced Workflows**:

- [ ] **btw + ellmer + mini007**: Multi-agent R development with environment context
- [ ] **vitals + brms**: Statistical evaluation with proper Bayesian inference
- [ ] **kuzco + btw**: Computer vision with R environment integration
- [ ] **Oracle RAG + vitals**: Evaluation of RAG system performance
- [ ] **weathR + ellmer**: Weather data analysis with LLM assistance

---

### 18. AI Alignment & Safety Considerations
**Based on Oracle RAG Insights [Session 2-08]**:

- [ ] **Data Governance Profiles**: Track what data is retrieved and how it influences outputs
- [ ] **Bias Detection Profiling**: Monitor retrieval patterns for systematic biases
- [ ] **Content Safety Profiling**: Ensure retrieved content aligns with safety guidelines
- [ ] **Audit Trail Profiling**: Comprehensive logging for transparency and accountability

---

## 📊 CONFERENCE IMPACT ASSESSMENT

### 19. Document Game-Changers
**High-Impact Discoveries from Conference**:

- [ ] **btw's R Knowledge Superiority**
  - [ ] Compare btw's R environment understanding vs GitHub Copilot's generic R knowledge
  - [ ] Catalog btw's 40+ tools and their R-specific capabilities
  - [ ] Assess potential for transforming R development workflow in VSCode

- [ ] **Strategic Consulting Transformation**
  - [ ] Quantify time savings from AI-accelerated development
  - [ ] Evaluate code quality improvements with AI assistance
  - [ ] Document productivity gains from unified development environment

- [ ] **Statistical Rigor Revolution**
  - [ ] Impact of proper experimental design on LLM evaluation
  - [ ] Advantages of Bayesian probability statements over frequentist CI
  - [ ] Value of hierarchical models for correlated data

---

## 📅 IMPLEMENTATION TIMELINE

### Phase 1: Immediate (This Week)
1. btw installation and testing
2. ellmer provider testing
3. vitals installation and basic testing
4. Read critical papers (Anthropic, Simon Couch blog)

### Phase 2: Short-term (Next 2 Weeks)
1. btw + VSCode MCP integration
2. mini007 multi-agent testing
3. Statistical evaluation methodology implementation
4. r-ai-2025 workflow integration

### Phase 3: Medium-term (Next Month)
1. Oracle RAG exploration
2. kuzco computer vision testing
3. Inspect framework integration
4. Comprehensive documentation

### Phase 4: Long-term (Next Quarter)
1. Advanced multi-modal integration patterns
2. AI alignment and safety implementations
3. Conference impact assessment
4. Community contribution and sharing

---

## 🔗 QUICK REFERENCE LINKS

### Essential GitHub Repositories
- **btw**: [posit-dev/btw](https://github.com/posit-dev/btw)
- **ellmer**: [tidyverse/ellmer](https://github.com/tidyverse/ellmer/)
- **mini007**: [cran/mini007](https://github.com/cran/mini007)
- **vitals**: [tidyverse/vitals](https://github.com/tidyverse/vitals/)
- **kuzco**: [frankiethull/kuzco](https://github.com/frankiethull/kuzco)
- **weathR**: [JeffreyFowler/weathR](https://github.com/JeffreyFowler/weathR)

### Essential Documentation Sites
- **ellmer**: [ellmer.tidyverse.org](https://ellmer.tidyverse.org/)
- **btw**: [posit-dev.github.io/btw/](https://posit-dev.github.io/btw/)
- **vitals**: [vitals.tidyverse.org](https://vitals.tidyverse.org/)
- **kuzco**: [frankiethull.github.io/kuzco/](https://frankiethull.github.io/kuzco/)
- **inspect**: [inspect.aisi.org.uk](https://inspect.aisi.org.uk/)

### Essential Presentation Materials
- **Max Kuhn**: [topepo.github.io/2025-r-ai/](https://topepo.github.io/2025-r-ai/)
- **Jasmine Daly**: [Me, Myself, and Claude](https://dalyanalytics.github.io/me-myself-claude-talk/)

---

**Document Created**: 2025-11-14  
**Conference**: R+AI 2025 (November 12-13, 2025)  
**Source**: Human conference notes from all sessions  
**Priority Method**: Perceived importance and relevance from human annotations

---

*This document prioritizes action items based on explicit markers in human notes ("🔥 GAME-CHANGER", "CRITICAL", "PRIORITY") and the depth of technical detail captured, reflecting genuine conference engagement and perceived value.*
