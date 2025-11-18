# R+AI 2025 Conference Knowledge Base

A comprehensive repository documenting insights, tools, and technologies from the R+AI 2025 conference (November 12-13, 2025). This resource serves as both a learning platform for R and AI integration and a practical guide for implementing cutting-edge R+LLM workflows.

## 🎯 What You'll Find Here

This repository transforms 18 session notes from the R+AI 2025 conference into actionable knowledge for data scientists, researchers, and R practitioners interested in AI augmentation.

### 📊 **Core Resources**
- **Session Notes** - Detailed summaries of all 18 conference presentations
- **Strategic Analysis** - Top 5  insights ranked by importance  
- **Technical Catalog** - 50+ R packages and tools with installation guides
- **Action Items** - Prioritized roadmap for implementing conference discoveries

### 🚀 **Key Discoveries**

The conference revealed critical gaps and opportunities in the R+AI ecosystem:

- **R lacks native LLM orchestration** (no LangChain equivalent) - but solutions are emerging
- **btw + VSCode integration** makes GitHub Copilot genuinely R-aware for the first time
- **Traditional ML still dominates structured data** - GBMs outperform LLMs significantly
- **Proper statistical methodology** is essential for reliable LLM evaluation
- **Multi-agent systems with judge functions** provide systematic quality control

---

## 🔗 Quick Navigation

### 📈 **Strategic Insights**
- **[Top 5 Ideas](./data-public/derived/artefacts/top-ideas.md)** - Most strategically important discoveries
- **[Follow-Up Actions](./data-public/derived/artefacts/follow-up.md)** - Prioritized implementation roadmap
- **[Package Index](./data-public/derived/artefacts/package-index.md)** - Comprehensive tool catalog with rankings

### 📝 **Session Notes** 
Individual session summaries available in [`./data-public/derived/notes-summary/`](./data-public/derived/notes-summary/):

**Day 1 Sessions:**
- [1-01: Joe Cheng Keynote](./data-public/derived/notes-summary/1-01-cheng-keynote.md) - Three responsibility frameworks for LLM integration
- [1-02: Jasmine Daly](./data-public/derived/notes-summary/1-02-daly-me-myself-claude.md) - Consulting practice transformation with AI
- [1-03: Jonathan Pearce](./data-public/derived/notes-summary/1-03-pearce-reviving-forgotten-code.md) - AI-assisted code archaeology
- [1-04: Garrick Aden-Buie](./data-public/derived/notes-summary/1-04-aden-buie-tools-llms-humans-r.md) - **🔥 btw + VSCode integration**
- [1-05: Aga Rucki](./data-public/derived/notes-summary/1-05-rucki-better-r-ai-assistant.md) - Professional R coding assistant
- [1-06: Mohamed El Fodil Ihaddaden](./data-public/derived/notes-summary/1-06-ihaddaden-mini007-framework.md) - Multi-agent orchestration
- [1-07: Max Kuhn](./data-public/derived/notes-summary/1-07-kuhn-analyzing-llm-evaluations.md) - **Statistical rigor for LLM evaluation**
- [1-08: André Charlon](./data-public/derived/notes-summary/1-08-charlon-biomedical-ontology-embeddings.md) - Biomedical knowledge graphs
- [1-09: Umair Durrani](./data-public/derived/notes-summary/1-09-durrani-brand-docs-apps-ggplots.md) - RAG-enhanced creativity

**Day 2 Sessions:**
- [2-01: Ben Maxwell](./data-public/derived/notes-summary/2-01-maxwell-geodl-geospatial.md) - Geospatial deep learning
- [2-02: Russell Conte](./data-public/derived/notes-summary/2-02-conte-deep-learning-records.md) - Automated ensemble modeling
- [2-03: Szilard Pafka](./data-public/derived/notes-summary/2-03-pafka-gbms-llms-chatgpt.md) - **GBMs vs LLMs performance comparison**
- [2-04: Xu Fei](./data-public/derived/notes-summary/2-04-fei-tracking-evolution-r-python-genai.md) - R+Python GenAI evolution
- [2-05: Frank Hull](./data-public/derived/notes-summary/2-05-hull-kuzco-computer-vision.md) - LLM-based computer vision
- [2-06: Troy Hernandez](./data-public/derived/notes-summary/2-06-hernandez-stable-diffusion-r.md) - Pure R generative AI
- [2-07: Selene Muñoz](./data-public/derived/notes-summary/2-07-munoz-cancerclarity-app.md) - Clinical decision support
- [2-08: Mark Hornick & Sherry LaMonica](./data-public/derived/notes-summary/2-08-hornick-lamonica-rag-database.md) - Database-native RAG
- [2-09: Workshop](./data-public/derived/notes-summary/2-09-pastoor-fei-kumar-workshop.md) - Practical R+AI implementation

---


## 💡 Key Takeaways

### 🔧 **Technical Infrastructure**
- **btw** provides first production-ready R+LLM integration with 40+ specialized tools
- **ellmer** offers universal LLM interface supporting 16+ providers
- **mini007** enables multi-agent orchestration with quality control via judge functions
- **vitals** brings proper statistical methodology to LLM evaluation

### 📊 **Strategic Insights**  
- R ecosystem is rapidly catching up to Python for GenAI workflows
- Integration beats isolation - best solutions combine tools strategically
- Statistical foundations remain crucial in the AI era
- Traditional ML (GBMs) still dominates structured data tasks

### 🛠 **Practical Applications**
- btw + VSCode = First truly R-aware AI development environment
- Judge-based multi-agent systems provide systematic quality assurance  
- Database-native RAG eliminates vector database complexity
- Proper experimental design essential for reliable LLM comparisons

---

## 📋 Repository Structure

```
├── data-public/derived/
│   ├── artefacts/           # Synthesized insights and catalogs
│   │   ├── top-ideas.md     # 🌟 5 most important discoveries
│   │   ├── follow-up.md     # 📋 Prioritized action roadmap  
│   │   └── package-index.md # 📦 50+ tools with install guides
│   └── notes-summary/       # Individual session summaries (18 files)
├── ai/                      # AI support system for this project
├── analysis/                # Analytical workflows and templates
└── guides/                  # Usage guides and documentation
```

---

## 🤝 Who Should Use This

### **Data Scientists & Analysts**
- Integrate AI assistance into R workflows effectively
- Understand when to use LLMs vs traditional ML approaches
- Implement proper evaluation frameworks for AI systems

### **R Package Developers**
- Explore cutting-edge R+AI integration patterns
- Study production-ready examples (btw, ellmer, mini007)
- Understand MCP (Model Context Protocol) for tool integration

### **Research Scientists**
- Apply rigorous statistical methodology to LLM evaluation
- Implement reproducible AI-augmented research workflows
- Balance AI assistance with scientific rigor requirements

### **Consultants & Practitioners**
- Transform practice with strategic AI integration
- Implement right-sized enterprise AI infrastructure
- Adopt manager-developer mental models for AI collaboration

---

## 🔗 Essential Links

### **Must-Install Packages**
- **[btw](https://github.com/posit-dev/btw)** - R+LLM integration toolkit
- **[ellmer](https://ellmer.tidyverse.org/)** - Universal LLM interface  
- **[mini007](https://cran.r-project.org/package=mini007)** - Multi-agent orchestration
- **[vitals](https://vitals.tidyverse.org/)** - LLM evaluation framework

### **Key Resources**
- **Conference Program**: [R+AI 2025](https://rconsortium.github.io/RplusAI_website/program.html)
- **Statistical Methodology**: [Max Kuhn's Presentation](https://topepo.github.io/2025-r-ai/)
- **Consulting Insights**: [Me, Myself, and Claude](https://dalyanalytics.github.io/me-myself-claude-talk/)

---

## 📊 Project Status

**Conference**: R+AI 2025 (November 12-13, 2025)  
**Analysis Completed**: November 14, 2025  
**Sessions Documented**: 18 of 18  
**Total Pages**: 100+ pages of structured insights  

This knowledge base represents comprehensive coverage of the R+AI 2025 conference, transformed into actionable guidance for implementing AI-augmented R workflows in research and practice.

---

*Created by conference participants for the R+AI community. All session notes based on live conference attendance and real-time documentation.*
