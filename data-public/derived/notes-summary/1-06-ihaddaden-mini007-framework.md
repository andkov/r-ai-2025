# 1-06: mini007 - A Lightweight Framework for Multi-Agent Orchestration in R

**One-Sentence Summary**: Mohamed El Fodil Ihaddaden presents mini007, a lightweight R6-based framework for multi-agent orchestration built on ellmer LLM connectivity, featuring automatic task decomposition, agent-to-agent result chaining, **Judge functionality for best response selection**, Human In The Loop (HITL) capability, and plan visualization with DiagrammeR - providing native R infrastructure for coordinating specialized AI agents across complex workflows.

**Speaker**: Mohamed El Fodil Ihaddaden (HDI Global SE) | [CRAN](https://cran.r-project.org/package=mini007) | [Docs](https://cran.r-project.org/web/packages/mini007/refman/mini007.html)

**Importance Rank**: ⭐⭐⭐⭐⭐ (5/5)
- **Tools/Concepts**: ⭐⭐⭐⭐⭐ (R6 multi-agent framework; Judge function for response selection; HITL integration; LeadAgent orchestration)
- **Immediate Applicability**: ⭐⭐⭐⭐⭐ (CRAN package v0.2.1; production-ready; works with any ellmer-supported model)
- **Novel Techniques**: ⭐⭐⭐⭐⭐ (Judge-based quality control; visual workflow planning; agent broadcasting for model comparison)

## Key Insights from Human Notes

**⭐ CRITICAL Judge Function Innovation**: The **Judge functionality for best response selection** is the standout feature - send a prompt to multiple agents, let the LeadAgent evaluate all proposals and select the best response. This pattern enables **systematic quality assurance** (multiple agents generate responses, judge selects best), **model comparison** (systematic evaluation across different LLMs), **decision transparency** (full proposals + rationale for selection), and **cost optimization** (test multiple approaches, deploy only the best). The judge function addresses a fundamental challenge in multi-agent systems: determining which agent's output is most appropriate for a given task.

**R6-Based Multi-Agent Architecture**: mini007 implements a two-tier agent system: (1) **Agent** - Basic agent with name, instruction, and LLM object; (2) **LeadAgent** - Orchestrates complex tasks by decomposing and delegating to specialized agents. Key architectural features include **memory and identity** for each agent via UUID and message history, **built-in task decomposition** and delegation via LLM, **agent-to-agent orchestration** with result chaining, **compatibility** with any chat model supported by ellmer, and **Human In The Loop (HITL)** capability at various execution steps. Each agent is an extension of an ellmer LLM object with persistent state management through R6 classes.

**⚠️ MISSED BEGINNING** - Joined talk in progress; need to review opening section from recording/slides for complete context on framework motivation and initial use cases.

## Tools & Resources

**Core Package**:
- **CRAN**: https://cran.r-project.org/package=mini007 (v0.2.1, Published: 2025-11-03)
- **GitHub Mirror**: https://github.com/cran/mini007
- **Documentation**: https://cran.r-project.org/web/packages/mini007/refman/mini007.html
- **Installation**: `install.packages("mini007")`

**Key Dependencies**:
- **R6** (≥ 2.6.1): R6 classes for persistent state management
- **ellmer**: LLM integration and connectivity
- **DiagrammeR** (≥ 1.0.11): Plan visualization before execution
- **cli, checkmate, uuid**: CLI interfaces, validation, and unique agent identifiers

**Core Framework Patterns**:
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

# Workflow Execution
plan <- lead_agent$generate_plan(complex_prompt)
lead_agent$visualize_plan()  # DiagrammeR visualization
response <- lead_agent$invoke(complex_prompt)
```

**⭐ Critical Judge Function Pattern**:
```r
# Send prompt to multiple agents, let LeadAgent judge best response
best_response <- lead_agent$judge_and_choose_best_response(prompt)
# Returns: proposals from all agents + chosen_response selected by judge
```

**Advanced Agent Capabilities**:
- Message history management (clear, summarize, export/import)
- Budget control with configurable policies (abort/warn/ask on exceed)
- R code generation and execution from natural language
- Tool integration via ellmer framework
- Broadcasting for model comparison across multiple agents
- Conversation state persistence across R sessions

## Methods & Techniques for Research Analytics

**Applicable Methods**:
1. **Multi-Agent Task Decomposition**: LeadAgent automatically breaks complex prompts into specialized agent tasks
2. **Judge-Based Quality Control**: Multiple agents generate proposals; LeadAgent selects best response based on evaluation criteria
3. **Visual Workflow Planning**: DiagrammeR plan visualization before execution for transparent process inspection
4. **Human In The Loop (HITL)**: Configurable checkpoints for human validation at workflow steps
5. **Agent Broadcasting**: Send same prompt to multiple agents, compare outputs systematically
6. **Persistent Agent State**: R6-based memory management across sessions via export/import

**Research Workflow Applications**:
- Coordinating specialized agents for literature review (search agent, summarization agent, synthesis agent)
- Quality-assured data analysis (multiple analytical approaches, judge selects best interpretation)
- Model comparison and selection (broadcasting prompts across different LLMs, systematic evaluation)
- Complex research pipelines with task decomposition (data preparation → analysis → visualization → reporting)
- Hybrid human-AI workflows with HITL validation at critical decision points
- Reproducible multi-agent analyses with conversation state persistence

## Priority Follow-Up Actions

**🚨 IMMEDIATE**:
- [ ] Install mini007: `install.packages("mini007")`
- [ ] **Test judge function** with multiple agents for response quality comparison
- [ ] Experiment with plan visualization (lead_agent$visualize_plan())
- [ ] Review CRAN documentation: https://cran.r-project.org/web/packages/mini007/refman/mini007.html
- [ ] **PRIORITY**: Review missed opening section from slides/recording

**📋 INVESTIGATE**:
- How judge evaluates and ranks multiple agent responses (evaluation criteria)
- Custom judging criteria implementation possibilities
- Performance comparison: judge vs. simple voting/averaging approaches
- HITL integration points and workflow design patterns
- Agent broadcasting strategies for systematic model comparison
- Budget control policies and cost optimization techniques
- Integration with Pawel Rucki's "One Agent = One Package" pattern (1-05)

**🔗 CONNECT**:
- Mohamed El Fodil Ihaddaden (HDI Global SE, mini007 author) for framework deep-dive
- Garrick Aden-Buie (btw/MCP author, 1-04) for agent communication protocol integration
- Pawel Rucki (Roche, 1-05) for package-based agent specialization patterns
- ellmer package maintainers for LLM integration optimization