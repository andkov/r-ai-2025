# 1-09: Brand your docs, apps, and ggplots using LLMs

**One-Sentence Summary**: brandthis package demonstrates RAG-enhanced creative AI by combining ellmer (15+ LLM providers), ragnar (knowledge stores with paletteer/ggsci packages), and multi-modal inputs (text + images) to generate consistent `_brand.yml` files driving Quarto, R Markdown, Shiny, and ggplot2 branding from single declarative specifications.

**Speaker**: Umair Durrani (Presage Group Inc.) | [Demo](https://dru.quarto.pub/brandthis-demo/) | [Slides](https://dru.quarto.pub/brandthis/#/title-slide)

**Importance Rank**: ⭐⭐⭐ (3/5)
- **Tools/Concepts**: ⭐⭐⭐⭐⭐ (brandthis, ellmer, ragnar three-package architecture)
- **Immediate Applicability**: ⭐⭐⭐ (Specialized branding use case; interactive Shiny app)
- **Novel Techniques**: ⭐⭐⭐⭐ (RAG-powered design recommendations; knowledge store integration)

## Key Insights from Human Notes

**Three-Package Architecture Innovation**:
- **ellmer**: LLM integration with 15+ providers (OpenAI, Anthropic, Gemini) - streaming, tool calling, structured data extraction
- **ragnar**: RAG workflows - document processing (MarkItDown), semantic chunking, vector embeddings + BM25 search (DuckDB), tool registration
- **brandthis**: Orchestrates ellmer chat sessions with ragnar knowledge stores for multi-modal brand generation (text + image inputs)

**Knowledge Store Strategy**: ragnar indexes paletteer and ggsci packages in DuckDB, enabling LLM-driven retrieval of similar palettes and intelligent ggplot2 scale suggestions. Eliminates guessing by grounding design suggestions in established libraries.

**Judge-Based Quality Control**: Interactive Shiny app (`run_brand_app()`) provides validation and refinement loop - human-in-the-loop ensures brand consistency before deployment across Quarto, R Markdown, Shiny, and ggplot2.

## Tools & Resources

**Three-Package Stack**:
- **ellmer**: `install.packages("ellmer")` | [ellmer.tidyverse.org](https://ellmer.tidyverse.org/) | 16+ provider support
- **ragnar**: `install.packages("ragnar")` | [ragnar.tidyverse.org](https://ragnar.tidyverse.org/) | Complete RAG implementation
- **brandthis**: `remotes::install_github("durraniu/brandthis")` | [GitHub](https://github.com/durraniu/brandthis) | [Docs](https://durraniu.github.io/brandthis/)

**Key Functions**:
```r
# Personal branding
brandthis::create_brand(
  prompt = "My name is John Doe",
  img = "image_url.jpg",
  type = "personal",
  chat_fn = ellmer::chat_github
)

# Company branding with multiple images
brandthis::create_brand(
  "Company name is Walmart",
  img = c("logo.png", "palette.jpeg", "font.png"),
  type = "company",
  chat_fn = ellmer::chat_google_gemini
)

# Color palette suggestions from ragnar knowledge stores
brandthis::suggest_color_scales(brand, "paletteer")

# Interactive validation
brandthis::run_brand_app()
```

**R Ecosystem Integration**:
- **bslib**: Bootstrap theming (createBranding app base)
- **paletteer/ggsci**: Indexed in ragnar knowledge stores
- **ggplot2**: Compatible visualization (<4.0.0 required)
- **brand.yml**: Posit branding specification consumed by Quarto/R Markdown/Shiny

## Methods & Techniques for Research Analytics

**Applicable Methods**:
1. **RAG-Enhanced Branding**: Knowledge stores provide context from curated palette databases for grounded suggestions
2. **Multi-Modal LLM Processing**: Text prompts + image analysis for comprehensive brand extraction
3. **Declarative Branding**: Single `_brand.yml` file drives consistent theming across all R outputs
4. **Interactive Validation**: Shiny app enables preview and refinement before deployment

**Research Workflow Applications**:
- Consistent professional branding across research reports (Quarto/R Markdown)
- Automated ggplot2 theme creation matching institutional or project branding
- Interactive dashboards (Shiny) with unified brand identity
- Multi-format publication outputs with consistent visual identity
- RAG-powered design decisions reduce aesthetic inconsistencies

## Priority Follow-Up Actions

**🚨 IMMEDIATE**:
- [ ] Install brandthis: `remotes::install_github("durraniu/brandthis")`
- [ ] Setup API key in .Renviron (GOOGLE_API_KEY or OPENROUTER_API_KEY)
- [ ] Test interactive app: `brandthis::run_brand_app()`
- [ ] Explore complete demo: https://dru.quarto.pub/brandthis-demo/

**📋 INVESTIGATE**:
- How ellmer/ragnar/brandthis three-package architecture handles provider failures
- Performance implications of RAG retrieval during brand generation
- Embedding models optimal for design similarity matching in ragnar knowledge stores
- Integration with existing organizational branding guidelines
- Quality control for AI-generated design in professional contexts

**🔗 CONNECT**:
- Talk resources: https://github.com/durraniu/talk_resources_brandthis
- Broader Posit AI ecosystem: ellmer, ragnar, vitals, shinychat, mcptools
- bslib package for advanced Bootstrap theming
- Acknowledgments: Garrick Aden-Buie (bslib), Tomasz Kalinowski (quartohelp)