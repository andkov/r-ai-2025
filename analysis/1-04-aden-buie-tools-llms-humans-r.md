# 1-04: Tools for LLMs and Humans who use R
**Speaker:** Garrick Aden-Buie (Posit)  
**Time:** 11:55 AM - 12:30 PM (Day 1, Session 4)  
**Conference:** R+AI 2025, November 12, 2025

## Abstract/Summary
*[To be filled during/after presentation - official description if available]*

## Conference Context
- **Session:** 4th presentation of Day 1
- **Track:** Tools and frameworks session
- **Previous:** 1-03 Jonathan Pearce - "Reviving Forgotten Code with LLMs" 
- **Next:** 1-05 Pawel Rucki - "Building a Better R AI Assistant: A Multi-Agent Approach"
- **Speaker Background:** Garrick Aden-Buie is a software engineer at Posit, known for work on Shiny, xaringan, and various R packages

## Key Points & Analysis

### Live Notes from Garrick's Presentation

**🔥 GAME-CHANGING INSIGHT: VSCode MCP Integration**
- **Garrick confirmed:** You can connect to btw MCP in VSCode by setting up an MCP server
- **This is HUGE:** btw has exceptional R knowledge base - environment inspection, package docs, function help, project context
- **Strategic Value:** btw's R expertise + VSCode Copilot = Revolutionary R development experience
- **MCP server acts as bridge** between VSCode and R session via btw_mcp_server()

**Implementation Pathway (PRIORITY FOR CONFERENCE FOLLOW-UP):**
1. Start btw MCP server: `btw_mcp_server()`
2. Configure VSCode to connect to MCP server  
3. VSCode gains access to all btw_tools() via MCP protocol
4. Real-time R environment integration enhances GitHub Copilot suggestions
5. **Result:** VSCode becomes R-aware AI development environment

**Why This Matters:**
- **btw's R Knowledge:** 40+ specialized tools covering environment, documentation, packages, files, git
- **Real-time Context:** Live R session data available to VSCode AI tools
- **Enhanced Copilot:** GitHub Copilot suggestions informed by actual R environment state
- **Seamless Workflow:** No context switching between R console and VSCode


## Technical Content

### R+LLM Package Ecosystem Deep Dive

#### 1. ellmer - Tidyverse LLM Chat Framework
**Core Purpose:** Universal R interface for Large Language Models
**GitHub:** [tidyverse/ellmer](https://github.com/tidyverse/ellmer/)
**Website:** [ellmer.tidyverse.org](https://ellmer.tidyverse.org/)
**Installation:** `install.packages("ellmer")`

**Key Features:**
- **16+ LLM Providers:** OpenAI, Anthropic, Google Gemini, AWS Bedrock, Azure OpenAI, Ollama, etc.
- **Stateful R6 Objects:** Conversation context persistence across interactions
- **Multiple Interaction Modes:** Console chat, programmatic API, streaming/async
- **Tool/Function Calling:** Register R functions as LLM tools
- **Structured Data Extraction:** Parse LLM responses into R data structures
- **Authentication:** Environment variables, OAuth, cloud provider IAM integration

**Usage Patterns:**
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

#### 2. btw - Complete R+LLM Integration Toolkit
**Core Purpose:** Bridge R environments with LLM workflows
**GitHub:** [posit-dev/btw](https://github.com/posit-dev/btw)
**Website:** [posit-dev.github.io/btw/](https://posit-dev.github.io/btw/)
**Version:** v1.0.0 (Latest CRAN release)

**Three Primary Workflows:**
1. **Copy-paste:** `btw()` - Gather R context for external LLMs
2. **Interactive:** `btw_app()` - Full AI assistant in IDE  
3. **Programmatic:** `btw_client()`, `btw_tools()` - Build applications

**CRITICAL: btw_client() - The Core Programming Interface**
`btw_client()` creates an enhanced ellmer::Chat object with all btw tools pre-registered. This is the foundational function for building custom R+LLM applications.

**Key btw_client() Features:**
- **Project Context Integration:** Automatically reads `btw.md`, `AGENTS.md`, and `llms.txt` files
- **Tool Registration:** All 40+ btw_tools() automatically available
- **Provider Flexibility:** Works with any ellmer-supported LLM provider
- **Hierarchical Configuration:** Project-level → User-level → R options fallback
- **Custom Tool Extension:** Mix btw_tools() with custom ellmer::tool() definitions

**btw_client() Configuration Hierarchy:**
1. **Function arguments** (highest priority)
2. **R options** (`btw.client`, `btw.tools`)
3. **Project-level btw.md** file
4. **User-level btw.md** file (lowest priority)

**Essential btw_client() Usage Patterns:**
```r
# Basic usage with default Anthropic
chat <- btw_client()
chat$chat("Describe my data frames")

# Custom provider/model
chat <- btw_client(client = "openai/gpt-4o")

# Specific tool subsets
chat <- btw_client(tools = c("env", "docs", "files"))

# Custom ellmer client
custom_chat <- chat_ollama(model = "llama3.1:8b")
chat <- btw_client(client = custom_chat)

# Skip all tools for minimal setup
chat <- btw_client(tools = FALSE)
```

**40+ Specialized Tools:**
- **Environment:** Describe data frames, environments, objects
- **Documentation:** Package help, vignettes, CRAN search
- **Files:** Read/write, code search, project navigation
- **Git:** Status, diff, commit, branch management
- **IDE:** Current editor integration, session management
- **Web:** URL reading, external resource access

**CRITICAL: Model Context Protocol (MCP) Integration**

**What is MCP?**
Model Context Protocol (MCP) is an open-source standard for connecting AI applications to external systems. It acts like "USB-C for AI applications" - providing a standardized way to connect AI tools to data sources, tools, and workflows.

**btw MCP Server Architecture:**
- **btw_mcp_server()** - Exposes all btw_tools() via MCP protocol
- **btw_mcp_session()** - Connects MCP server to specific R session
- **Dual Transport Support** - STDIO (local) and HTTP (remote) protocols
- **Real-time Notifications** - Dynamic tool updates to connected clients

**MCP Core Primitives (btw provides):**
1. **Tools** - All 40+ btw_tools() exposed as executable functions
2. **Resources** - R environment data, file contents, documentation
3. **Prompts** - Project context from btw.md, llms.txt files

**MCP Configuration Examples:**
```r
# Start MCP server with all btw tools
btw_mcp_server()

# Subset of tools only
btw_mcp_server(tools = btw_tools(c("env", "docs", "files")))

# Connect to specific R session
btw_mcp_session()  # Run in target R session
```

**External AI Tool Integration:**
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

```bash
# Claude Code CLI setup
claude mcp add -s "user" r-btw -- Rscript -e "btw::btw_mcp_server()"
```

```json
// Continue IDE configuration
{
  "experimental": {
    "modelContextProtocolServers": [
      {
        "transport": {
          "name": "r-btw",
          "type": "stdio", 
          "command": "Rscript",
          "args": ["-e", "btw::btw_mcp_server()"]
        }
      }
    ]
  }
}
```

**MCP Protocol Features:**
- **JSON-RPC 2.0** - Standard protocol for client-server communication
- **Capability Negotiation** - Dynamic feature discovery and compatibility
- **Tool Discovery** - `tools/list` → `tools/call` execution pattern
- **Real-time Updates** - Notification system for dynamic tool changes
- **Session Management** - Multiple R session support via btw_mcp_session()

#### 3. weathR - National Weather Service API Interface
**Core Purpose:** Easy access to U.S. National Weather Service data
**GitHub:** [JeffreyFowler/weathR](https://github.com/JeffreyFowler/weathR)
**CRAN:** `install.packages("weathR")`
**Author:** Jeffrey Fowler

**Core Functions:**
- **`point_data()`** - NWS metadata for specific coordinates
- **`point_forecast()`** - Weather forecasts by latitude/longitude
- **`station_forecast()`** - Forecasts by ASOS/AWOS station ID
- **`stations_near()`** - Find weather stations near coordinates

**Data Integration Capabilities:**
- **Geospatial:** Works with `sf` package for spatial data
- **Visualization:** Integration with `ggplot2`, `tmap` for maps
- **Time Series:** Forecast data with proper time formatting
- **Quality Assurance:** Focus on official NWS ASOS/AWOS stations

**Example Workflows:**
```r
# Get forecast for Central Park, NYC
point_forecast(lat = 40.768, lon = -73.976) %>%
  select(time, temp) %>%
  ggplot(aes(x = time, y = temp)) + 
  geom_point() + geom_smooth()

# Find nearest weather stations to Denver
stations_near(lat = 39.733, lon = -104.982) %>%
  tm_shape() + tm_dots(col = "euc_dist")
```

### Integration Potential
These three packages represent complementary aspects of R tooling:
- **ellmer:** Foundation for LLM communication
- **btw:** R environment integration with LLMs
- **weathR:** Domain-specific data acquisition

Combined usage scenarios:
- Use **weathR** to gather weather data
- Apply **btw** to describe data structures to LLMs
- Leverage **ellmer** for custom weather analysis workflows


## Research Implications
*[Broader significance for R community, AI integration, methodology]*


## Q&A Session
*[Questions from audience and speaker responses]*


## Questions for Further Investigation

### btw Package Architecture
- How does btw compare to other R+LLM integration tools?
- What are the performance implications of different btw workflows?
- How does the tool selection system work (`btw_tools(c("docs", "files"))`)?
- What's the relationship between btw, ellmer, and mcptools packages?

### MCP Architecture & Security
- How does btw_mcp_server() handle multiple concurrent client connections?
- What are the security implications of exposing R environment via MCP?
- How does MCP protocol versioning work with btw compatibility?
- What's the performance overhead of MCP vs direct btw_client() usage?
- How does btw_mcp_session() manage R session state across MCP calls?

### Integration Patterns  
- How does btw.md project configuration impact MCP tool behavior?
- What are best practices for MCP server configuration in different IDEs?
- How does btw handle authentication for different LLM providers via MCP?
- What are the security considerations for MCP server exposure to external tools?
- How to manage MCP server lifecycle in production environments?

### Workflow Optimization
- When to use copy-paste vs interactive vs programmatic approaches?
- How to optimize context gathering for different R object types?
- What are the token/context limits and optimization strategies?
- How does btw handle large data structures and environment descriptions?

### Extension Development
- How to create custom tools that integrate with btw's framework?
- What are the patterns for building domain-specific R+LLM applications?
- How to extend btw for specific research or analysis workflows?
- Integration possibilities with existing R package ecosystems?

### btw_client() Architecture & Integration
- How does btw_client() configuration hierarchy work (args → R options → btw.md)?
- What are the performance implications of pre-registering all 40+ btw_tools()?
- How to optimize btw_client() for different use cases (analysis vs development)?
- What's the memory footprint of btw_client() with full tool registration?
- How to extend btw_client() with custom ellmer::tool() definitions?

### VSCode MCP Integration (Garrick's Method)
- How to configure VSCode as MCP client to connect to btw_mcp_server()?
- What VSCode MCP extensions are needed for btw MCP server integration?
- How does VSCode discover and interact with btw_tools() via MCP protocol?
- What's the optimal VSCode MCP client configuration for btw server?
- How to handle authentication and permissions for VSCode → btw MCP connection?
- Can VSCode MCP client support real-time btw tool notifications?

### VSCode Copilot + btw Integration
- How does btw MCP server integration complement GitHub Copilot in VSCode?
- Can btw MCP tools enhance GitHub Copilot's R-specific capabilities?
- What's the optimal R options setup for btw_client() in VSCode workspace?
- How to create VSCode tasks that leverage btw MCP server programmatically?
- How to set up project-level btw.md files for consistent VSCode experience?
- What are the performance implications of VSCode MCP + btw server integration?


## Resources & References

### Speaker Links
- **Garrick Aden-Buie Profile:** [Posit Team Page](https://posit.co/about/team/)
- **GitHub:** [gadenbuie](https://github.com/gadenbuie)
- **Twitter/X:** [@grrrck](https://twitter.com/grrrck)

### btw Package - Complete R+LLM Toolkit
- **GitHub Repository:** [posit-dev/btw](https://github.com/posit-dev/btw)
- **Package Website:** [posit-dev.github.io/btw/](https://posit-dev.github.io/btw/)
- **CRAN:** [cloud.r-project.org/package=btw](https://cloud.r-project.org/package=btw)
- **Function Reference:** [Complete API Documentation](https://posit-dev.github.io/btw/reference/)
- **Latest Release:** v1.0.0 (Released November 2025 - Initial CRAN submission)

### Core btw Capabilities
1. **Copy-paste workflow:** `btw()` - Gather R context for external LLMs
2. **Interactive chat:** `btw_app()` - Full AI assistant in IDE
3. **Developer toolkit:** `btw_client()`, `btw_tools()` - Build LLM-powered applications
4. **Model Context Protocol:** `btw_mcp_server()` - Expose R to external AI tools

### Related R+LLM Ecosystem Packages
- **ellmer:** [ellmer.tidyverse.org](https://ellmer.tidyverse.org/) - Universal LLM chat framework (16+ providers)
- **mcptools:** [posit-dev.github.io/mcptools/](https://posit-dev.github.io/mcptools/) - Model Context Protocol toolkit
- **weathR:** [JeffreyFowler/weathR](https://github.com/JeffreyFowler/weathR) - U.S. National Weather Service API interface

### Additional Posit LLM Tools
- **chatlas:** [Python equivalent of ellmer](https://github.com/posit-dev/chatlas)
- **vitals:** [vitals.tidyverse.org](https://vitals.tidyverse.org/) - LLM evaluation framework
- **ragnar:** [ragnar.tidyverse.org](https://ragnar.tidyverse.org/) - Retrieval Augmented Generation
- **shinychat:** [posit-dev.github.io/shinychat/](https://posit-dev.github.io/shinychat/) - LLM-powered Shiny chatbots

### Documentation Links
- **Installation Guide:** Multiple methods (CRAN, r-universe, GitHub)
- **Function Categories:** Core, Project Context, Environment Description, Tasks/Agents, Tools
- **MCP Configuration:** Claude Desktop, Claude Code, Continue IDE integration
- **Contributing:** [GitHub Issues](https://github.com/posit-dev/btw/issues), Code of Conduct

## Action Items

### 🚨 CONFERENCE FOLLOW-UP PRIORITY #1
- [ ] **CRITICAL: Integrate btw's Excellent R Knowledge Base with VSCode Copilot**
  - [ ] **Primary Goal:** Leverage btw's comprehensive R environment understanding within VSCode + GitHub Copilot workflow
  - [ ] **Key Value:** btw provides unmatched R context (40+ tools, environment inspection, documentation access, package knowledge)
  - [ ] **Integration Strategy:** Use btw MCP server as bridge between R session and VSCode AI tools
  - [ ] **Expected Outcome:** Transform VSCode into R-aware AI development environment with real-time R context

### 🎯 IMMEDIATE IMPLEMENTATION ROADMAP
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

### MUST DO - btw Package Deep Dive
- [ ] **Install btw package:** `install.packages("btw")` or development version from GitHub
- [ ] **Test core functions:**
  - [ ] `btw()` - Context gathering for copy-paste workflow
  - [ ] `btw_app()` - Interactive chat interface in IDE
  - [ ] `btw_tools()` - Available tool registration system
- [ ] **CRITICAL: btw_client() Deep Dive:**
  - [ ] Test basic `btw_client()` creation with default settings
  - [ ] Experiment with different LLM providers via `client` parameter
  - [ ] Test tool subset selection with `tools = c("env", "docs", "files")`
  - [ ] Create custom btw_client with ellmer providers (OpenAI, Claude, Ollama)
  - [ ] Test project context integration (btw.md, AGENTS.md, llms.txt files)
  - [ ] Explore hierarchical configuration (R options → project → user settings)
  - [ ] Build custom applications using btw_client() as foundation
- [ ] **Explore project context features:**
  - [ ] `use_btw_md()` - Create project-specific configuration
  - [ ] `edit_btw_md()` - Modify project context files
- [ ] **CRITICAL: Model Context Protocol (MCP) Integration:**
  - [ ] Test `btw_mcp_server()` - Start MCP server with all btw_tools()
  - [ ] Test `btw_mcp_session()` - Connect MCP server to specific R session
  - [ ] Configure Claude Desktop JSON configuration with btw MCP server
  - [ ] Configure Claude Code CLI setup (`claude mcp add r-btw`)
  - [ ] Configure Continue IDE MCP integration in config file
  - [ ] Test tool discovery (`tools/list`) and execution (`tools/call`) via MCP
  - [ ] Test real-time notifications for dynamic tool updates
  - [ ] Test dual transport modes (STDIO local vs HTTP remote)
  - [ ] Verify R environment access from external AI tools
  - [ ] Test MCP capability negotiation and protocol version compatibility

### btw Function Categories to Investigate
- [ ] **Core Functions:** btw(), btw_this(), btw_client(), btw_app(), btw_tools()
- [ ] **Project Context:** use_btw_md(), edit_btw_md(), btw_task_create_btw_md()
- [ ] **R Object Description:** btw_this() methods for data.frame, environment, character
- [ ] **Tasks/Agents:** btw_task_create_readme(), btw_task_create_btw_md()
- [ ] **40+ Tools:** Environment, Documentation, Files, Git, GitHub, IDE, Search, Session, Web tools

### Technical Integration Testing
- [ ] **Test ellmer integration:** Register btw_tools() with different chat clients
- [ ] **MCP Configuration:**
  - [ ] Claude Desktop JSON configuration
  - [ ] Claude Code CLI setup  
  - [ ] Continue IDE configuration file
- [ ] **Tool Subset Testing:** btw_tools(c("docs", "files")) selective tool registration
- [ ] **Session Management:** btw_mcp_session() for specific R session access

### CRITICAL: VSCode MCP Integration (Garrick's Confirmed Method)
- [ ] **PRIORITY: btw MCP Server + VSCode Setup:**
  - [ ] Start btw MCP server: `btw_mcp_server()` in R session
  - [ ] Research VSCode MCP client configuration for btw server connection
  - [ ] Test VSCode → btw MCP server communication via JSON-RPC 2.0
  - [ ] Configure VSCode MCP extension to discover btw_tools()
  - [ ] Test real-time R environment access from VSCode via MCP
  - [ ] Verify all 40+ btw_tools() available in VSCode through MCP
  - [ ] Test btw MCP notifications for dynamic VSCode tool updates
- [ ] **btw_client() + VSCode Copilot Integration:**
  - [ ] Test btw_client() initialization within VSCode R terminal  
  - [ ] Configure R options (btw.client, btw.tools) for VSCode environment
  - [ ] Create project-level btw.md file for VSCode workspace integration
  - [ ] Test btw_client() with GitHub Copilot's suggested LLM providers
  - [ ] Explore btw_client(tools = "ide") for VSCode-specific functionality
- [ ] **Advanced Integration Patterns:**
  - [ ] Research VSCode MCP extension development for btw integration
  - [ ] Test MCP protocol JSON-RPC 2.0 compatibility with VSCode extensions
  - [ ] Evaluate Continue IDE integration as VSCode MCP bridge
  - [ ] Explore btw() context gathering for VSCode Copilot prompts
  - [ ] Document tool definition patterns for VSCode Copilot + btw integration
  - [ ] Test btw_app() launching from within VSCode R sessions
  - [ ] Evaluate btw IDE tools (btw_tool_ide_read_current_editor) with VSCode
  - [ ] Create workflow: VSCode → btw MCP server → enhanced R analysis workflows

### Advanced Exploration
- [ ] **Review complete function reference:** All 40+ btw_tool_* functions
- [ ] **Package ecosystem analysis:** ellmer, mcptools dependencies
- [ ] **Compare with other R+AI tools:** Integration capabilities assessment
- [ ] **Real-world workflow testing:** Copy-paste vs interactive vs programmatic approaches

### R Package Ecosystem Exploration
- [ ] **ellmer Deep Dive:**
  - [ ] Test all 16+ LLM providers (OpenAI, Anthropic, Google, AWS, Azure, Ollama, etc.)
  - [ ] Explore tool/function calling capabilities
  - [ ] Test structured data extraction features
  - [ ] Evaluate streaming and async API usage
- [ ] **weathR Integration Testing:**
  - [ ] Install and test core functions: `point_data()`, `point_forecast()`, `station_forecast()`, `stations_near()`
  - [ ] Test geospatial integration with `sf` and `tmap` packages
  - [ ] Create weather data visualization workflows with `ggplot2`
  - [ ] Explore ASOS/AWOS station quality advantages
- [ ] **Cross-Package Integration:**
  - [ ] Test btw + ellmer integration patterns
  - [ ] Experiment with weathR data + btw context gathering
  - [ ] Evaluate ellmer + btw + weathR combined workflows

### CONFERENCE IMPACT ASSESSMENT
- [ ] **Document btw's R Knowledge Superiority:**
  - [ ] Compare btw's R environment understanding vs GitHub Copilot's generic R knowledge
  - [ ] Catalog btw's 40+ tools and their R-specific capabilities
  - [ ] Assess potential for transforming R development workflow in VSCode
- [ ] **VSCode + btw Integration Business Case:**
  - [ ] Quantify time savings from btw's R context in VSCode
  - [ ] Evaluate code quality improvements with btw-enhanced Copilot
  - [ ] Document productivity gains from unified R development environment

### Follow-up Research
- [ ] Review speaker's other R packages and contributions (xaringan, Shiny work)
- [ ] **PRIORITY:** Test btw + VSCode integration with existing r-ai-2025 project workflow
- [ ] Evaluate comprehensive Posit LLM ecosystem (chatlas, vitals, ragnar, shinychat)
- [ ] Document btw integration findings and implementation recommendations
- [ ] Assess weather data integration potential for research applications
- [ ] **Create btw + VSCode integration guide** for R community

## Notes
- **Status:** Ready for note-taking
- **Created:** 2025-11-12 (pre-session setup)
- **Context:** Session 1-04 of R+AI 2025 conference
- **Focus Areas:** Tools, LLM integration with R, developer experience

---
*Live conference notes - R+AI 2025*