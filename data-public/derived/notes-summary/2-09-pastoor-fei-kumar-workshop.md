# 2-09: Workshop: From Prompts to Agents: Building & Evaluating R + LLM Workflows

**One-Sentence Summary**: A2-AI's comprehensive 2-hour workshop covers end-to-end agent development in R from prompt engineering through multi-agent orchestration, evaluation frameworks, and production deployment, revealing modern R development stack (rig + rv + renv) and CLAUDE.md AI assistant configuration patterns from enterprise-scale projects (Positron IDE).

**Speakers**: Devin Pastoor, Xu Fei & Aathira Anil Kumar (A2-AI) | [Workshop Materials TBD]

**Importance Rank**: ⭐⭐⭐⭐⭐ (5/5)
- **Tools/Concepts**: ⭐⭐⭐⭐⭐ (R6 agents, rig+rv stack, CLAUDE.md patterns, multi-agent orchestration)
- **Immediate Applicability**: ⭐⭐⭐⭐⭐ (Complete development framework; production deployment strategies)
- **Novel Techniques**: ⭐⭐⭐⭐⭐ (AI assistant configuration system; enterprise-scale agent patterns)

## Key Insights from Human Notes

**Modern R Development Stack Revealed**:
- **rig** (R Installation Manager): System-wide R version management (Rust-based, 829 stars)
  - Commands: `rig add release`, `rig list`, `rig default 4.4`
  - macOS menu bar app, creates quick links (R-4.1, R-4.4)
- **rv** (A2-Ai Package Manager): Declarative `rproject.toml` approach, **25x faster than renv**
  - Resolves full dependency tree before installation (prevents version conflicts)
  - Captures metadata at install time (not retroactively like renv)
- **Complete workflow**: `rig add release` → `rv init project` → `rv sync`

**AI Assistant Configuration System** (Enterprise-Scale Patterns):
- **CLAUDE.md**: Project root file with context, commands, architecture, critical requirements
- **.claude/ directory**: Modular task-specific documentation (`.claude/launch-positron.md`, `.claude/build-system.md`)
- **Production Examples**: A2-AI rv package (https://github.com/A2-ai/rv/blob/main/CLAUDE.md), Positron IDE (https://github.com/posit-dev/positron)
- **Key Patterns**: Non-blocking protocols, daemon management, upstream compatibility, communication standards

**Agent Architecture Framework**:
```r
# R6Agent base class with tools, memory, LLM integration
agent <- R6Agent$new(name, description, client, tools)
agent$execute_task(task, context)  # Returns structured results

# Multi-agent coordination
coordinator <- AgentCoordinator$new()
coordinator$add_agent(data_agent)
coordinator$execute_workflow(workflow_spec)
```

## Tools & Resources

**Modern R Stack**:
- **rig**: `https://github.com/r-lib/rig` | Rust-based R installation manager
- **rv**: `https://github.com/a2-ai/rv` | Docs: https://a2-ai.github.io/rv-docs/
- **renv**: Traditional alternative (iterative vs. declarative approach)

**Configuration Example** (`rproject.toml`):
```toml
[project]
name = "my-agent-project"
r_version = "4.4"  # Managed by rig

[dependencies]
"httr2"
"jsonlite"
"R6"
{ name = "tidyverse", install_suggestions = false }
```

**AI Assistant Configuration**:
- **CLAUDE.md patterns**: https://github.com/A2-ai/rv/blob/main/CLAUDE.md
- **Modular system**: https://github.com/posit-dev/positron/tree/main/.claude
- **Enterprise examples**: Positron IDE non-blocking launch, daemon management
- **Claude Agent Tools**: https://docs.anthropic.com/claude/docs/agents-and-tools/

**Core R Packages for Agents**:
- **R6**: Object-oriented programming | Encapsulated agent classes
- **httr2**: HTTP client for API calls
- **jsonlite**: JSON processing for LLM interactions
- **future/promises**: Parallel and asynchronous programming
- **testthat**: Testing framework for agent evaluation

## Methods & Techniques for Research Analytics

**Applicable Methods**:
1. **R6 Agent Architecture**: Encapsulated agent classes with tools, memory, and LLM client integration
2. **Multi-Agent Orchestration**: AgentCoordinator for workflow execution with shared state management
3. **Evaluation Framework**: AgentEvaluator with test cases, quality metrics, and automated reporting
4. **Production Deployment**: ProductionAgentManager with monitoring, performance metrics, and error handling
5. **Declarative Dependencies**: rv's rproject.toml for reproducible agent environments

**Research Workflow Applications**:
- Specialized agents for data preprocessing, analysis, visualization, and reporting
- Multi-agent workflows coordinating complex analytical pipelines
- Systematic evaluation of agent performance with automated testing
- Production-ready agent deployment with monitoring and scaling
- AI assistant configuration for R development environments (CLAUDE.md patterns)

## Priority Follow-Up Actions

**🚨 IMMEDIATE**:
- [ ] Install rig: https://github.com/r-lib/rig (system-wide R version management)
- [ ] Install rv: https://github.com/a2-ai/rv (declarative package management)
- [ ] Create CLAUDE.md for current R projects using A2-AI/Positron patterns
- [ ] Test R6 agent architecture with simple data analysis agent
- [ ] Review Devin Pastoor's GitHub: https://github.com/dpastoor (369 repos)

**📋 INVESTIGATE**:
- rv vs. renv: declarative vs. iterative trade-offs for agent projects
- CLAUDE.md modular system (`.claude/` directory patterns from Positron)
- Non-blocking agent protocols for maintaining AI session availability
- AgentEvaluator testing frameworks for research analytics agents
- Production deployment patterns (Docker, monitoring, scaling)

**🔗 CONNECT**:
- A2-AI leadership: Devin Pastoor (CTPO) | https://a2-ai.com/leadership/devin-pastoor
- Workshop repository (when available) for complete code examples
- Claude Agent Skills documentation for tool integration
- Modern R development community (rig, rv, R-infra organization)