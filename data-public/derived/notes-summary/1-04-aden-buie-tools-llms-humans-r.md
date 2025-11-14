# 1-04: Tools for LLMs and Humans who use R

**One-Sentence Summary**: btw package bridges R environments with LLM workflows through 40+ specialized tools and Model Context Protocol integration, with GAME-CHANGING VSCode MCP capability giving GitHub Copilot access to btw's comprehensive R knowledge base (environment inspection, package docs, live session context).

**Speaker**: Garrick Aden-Buie (Posit) | [GitHub: @gadenbuie](https://github.com/gadenbuie)

**Importance Rank**: ⭐⭐⭐⭐⭐ (5/5)
- **Tools/Concepts**: ⭐⭐⭐⭐⭐ (btw, ellmer, MCP integration, weathR packages)
- **Immediate Applicability**: ⭐⭐⭐⭐⭐ (VSCode integration ready now; btw CRAN v1.0.0)
- **Novel Techniques**: ⭐⭐⭐⭐⭐ (MCP protocol for R environments; btw_client() foundation)

## Key Insights from Human Notes

**🔥 GAME-CHANGER**: VSCode can connect to btw via MCP integration (Garrick confirmed), giving GitHub Copilot access to btw's exceptional R knowledge base:
- 40+ tools covering environment, docs, packages, files, git
- Real-time R session data enhances AI suggestions
- Transforms VSCode into R-aware AI development environment

**Critical Discovery**: `btw_client()` is the foundational programming interface - creates enhanced ellmer::Chat objects with all btw tools pre-registered for building custom R+LLM applications. Hierarchical configuration (function args → R options → project → user settings) enables flexible integration.

**MCP Revolution**: Model Context Protocol acts like "USB-C for AI applications," exposing all btw_tools() via standardized protocol. STDIO (local) and HTTP (remote) transports enable integration with Claude Desktop, Claude Code, Continue IDE, and VSCode.

## Tools & Resources

**Primary Packages**:
- **btw** (v1.0.0): R+LLM integration toolkit | `install.packages("btw")` | [posit-dev/btw](https://github.com/posit-dev/btw) | [docs](https://posit-dev.github.io/btw/)
- **ellmer**: Universal R interface for 16+ LLM providers | [ellmer.tidyverse.org](https://ellmer.tidyverse.org/)
- **weathR**: National Weather Service API interface | `install.packages("weathR")`

**Key Functions**:
- `btw_client()` - Core programming interface with all btw tools
- `btw_mcp_server()` - Exposes R tools via Model Context Protocol
- `btw_app()` - Interactive AI assistant in IDE
- `btw()` - Context gathering for copy-paste workflow
- `btw_tools()` - 40+ specialized R tools (environment, docs, files, git, IDE, web)

**MCP Configuration Examples**:
```json
// Claude Desktop
{"mcpServers": {"r-btw": {"command": "Rscript", "args": ["-e", "btw::btw_mcp_server()"]}}}

// Continue IDE
{"experimental": {"modelContextProtocolServers": [{"transport": {"name": "r-btw", "type": "stdio", ...}}]}}
```

## Methods & Techniques for Research Analytics

**Applicable Methods**:
1. **Context-Aware Code Generation**: Real-time R environment data enhances AI suggestions for data analysis workflows
2. **Tool-Augmented LLM Workflows**: 40+ specialized btw tools provide environment inspection, documentation access, package management
3. **Multi-Provider LLM Strategy**: Switch between OpenAI, Anthropic, Ollama, Google for different analytical tasks
4. **Programmatic AI Integration**: Build custom analytics assistants using btw_client() as foundation

**Research Workflow Applications**:
- Environment inspection tools for documenting analytical decisions and reproducibility
- Automated documentation generation from R sessions for research papers
- Interactive data exploration with AI assistance via btw_app()
- Git integration for version-controlled reproducible research workflows
- MCP-enabled VSCode environment with GitHub Copilot R-awareness

## Priority Follow-Up Actions

**🚨 IMMEDIATE**:
- [ ] Install btw: `install.packages("btw")`
- [ ] Test VSCode MCP integration with btw_mcp_server()
- [ ] Experiment with btw_client() for custom R+LLM applications
- [ ] Configure ellmer with multiple LLM providers (OpenAI, Anthropic, Ollama)
- [ ] Create project-level btw.md file for workspace integration

**📋 INVESTIGATE**:
- VSCode MCP client configuration for btw server connection
- btw_client() configuration hierarchy (R options → project → user settings)
- Performance implications of 40+ pre-registered tools
- Integration patterns with existing r-ai-2025 workflows
- ellmer provider comparison (OpenAI, Anthropic, Google, Ollama) for different tasks

**🔗 CONNECT**:
- Garrick's other R packages (xaringan, Shiny work) for ecosystem understanding
- btw community and GitHub issues for best practices
- mcptools and related Posit LLM ecosystem (chatlas, vitals, ragnar, shinychat)