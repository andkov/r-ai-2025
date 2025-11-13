# mini007 - A Lightweight Framework for Multi-Agent Orchestration in R

**Speaker:** Mohamed El Fodil Ihaddaden (HDI Global SE)  
**Time:** 1:05-1:40 PM  
**Date:** November 12, 2025  
**Session:** 1-06  

## Abstract/Summary

*[To be filled during talk - official description of the presentation]*

## Conference Context

This presentation follows Pawel Rucki's "Building a Better R AI Assistant: A Multi-Agent Approach" and precedes Max Kuhn's "Analyzing LLM Evaluations", completing the multi-agent systems trilogy within the broader AI tooling sequence. This session bridges individual AI tools (1-04) and practical multi-agent implementations (1-05) with a dedicated orchestration framework.

## Key Points & Analysis

**⚠️ MISSED BEGINNING** - Joined talk in progress, need to review opening section from recording/slides

*[Live notes during presentation]*

### Main Concepts

**Framework Overview: mini007**
- Lightweight and extensible framework for multi-agent orchestration in R
- Built on R6 classes with persistent state management
- Integrates with ellmer package for LLM connectivity
- **Core Architecture**: Two main agent types:
  - **Agent**: Basic agent with name, instruction, and LLM object
  - **LeadAgent**: Orchestrates complex tasks by decomposing and delegating to specialized agents

**Key Features Discovered:**
- 🧠 Memory and identity for each agent via UUID and message history
- ⚙️ Built-in task decomposition and delegation via LLM
- 🔄 Agent-to-agent orchestration with result chaining
- 🌐 Compatible with any chat model supported by ellmer
- 🧑 Human In The Loop (HITL) capability at various execution steps

### Technical Approach

**R6-Based Architecture**
- Each agent is an extension of an ellmer LLM object
- Persistent state management through R6 classes
- UUID-based agent identification for tracking and coordination

**Multi-Agent Workflow Pattern**
- LeadAgent receives complex prompts and generates execution plans
- Automatic task decomposition into specialized agent prompts
- Sequential agent orchestration with result chaining
- Plan visualization using DiagrammeR package

### Implementation Details

**Core Agent Capabilities:**
- Message history management (clear, summarize, export/import)
- Budget control with configurable policies (abort/warn/ask on exceed)
- R code generation and execution from natural language
- Tool integration via ellmer framework
- Broadcasting for model comparison across multiple agents

**Advanced Features:**
- Human In The Loop (HITL) at configurable workflow steps
- **⭐ Judge functionality for best response selection** - CRITICAL FEATURE
- Plan visualization before execution
- Conversation state persistence across R sessions

## Technical Content

### Code Examples

*[Code snippets, functions, or technical demonstrations]*

### Methods & Tools

**R Package Ecosystem Integration**
*[Specific R packages, dependencies, or R-native implementation details]*

**Framework Architecture**
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

**Key Design Patterns:**
- Agent registration and delegation
- Plan generation before execution
- Visual workflow inspection
- Result chaining between agents
- HITL integration points
- **Judge-based response evaluation and selection**

**Critical Judge Function Pattern:**
```r
# Send prompt to multiple agents, let LeadAgent judge best response
best_response <- lead_agent$judge_and_choose_best_response(prompt)
# Returns: proposals from all agents + chosen_response selected by judge
```

### Architecture & Design

*[Multi-agent orchestration patterns, communication protocols, or framework structure]*

## Research Implications

### For R Ecosystem

- **Native R Integration**: First comprehensive multi-agent framework built specifically for R
- **R6 Architecture**: Leverages R's object system for persistent agent state
- **Seamless LLM Integration**: Works with any ellmer-supported model provider

### Multi-Agent Systems

- **Judge-Based Quality Control**: Novel approach to response selection using AI evaluation
- **Hybrid Orchestration**: Combines automated delegation with human oversight (HITL)
- **Visual Workflow Planning**: DiagrammeR integration for transparent process inspection

### Framework Development

**Judge Function Innovation**: 
- **Quality Assurance**: Multiple agents generate responses, judge selects best
- **Model Comparison**: Systematic evaluation across different LLMs
- **Decision Transparency**: Full proposals + rationale for selection
- **Cost Optimization**: Test multiple approaches, deploy only the best

## Q&A Session

### Questions Asked

*[Questions from audience and speaker responses]*

### Key Discussion Points

*[Important clarifications, technical details, or implementation considerations]*

## Questions for Further Investigation

**Judge Function Deep Dive:**
- How does the judge evaluate and rank multiple agent responses?
- What criteria does the LeadAgent use for response selection?
- Can custom judging criteria be implemented?
- Performance comparison: judge vs. simple voting/averaging approaches
- Integration with HITL for human validation of judge decisions

**Framework implementation details, comparison with other orchestration systems, R-specific advantages**

## Resources & References

### Speaker Information
- **Mohamed El Fodil Ihaddaden** - HDI Global SE  
- Author and maintainer of mini007 package
- Presentation materials: [To be added from conference]
- Contact: [To be added]

### Framework & Tools
- **mini007**: Lightweight Framework for Orchestrating Multi-Agent Large Language Models
  - CRAN: https://cran.r-project.org/package=mini007
  - GitHub Mirror: https://github.com/cran/mini007
  - Version: 0.2.1 (Published: 2025-11-03)
  - Documentation: [Reference manual](https://cran.r-project.org/web/packages/mini007/refman/mini007.html)
- **Key Dependencies**: 
  - R6 (≥ 2.6.1) - for R6 classes and persistent state
  - ellmer - for LLM integration
  - DiagrammeR (≥ 1.0.11) - for plan visualization
  - cli, checkmate, uuid - for CLI, validation, and unique IDs
- **Related Orchestration Frameworks**: [Comparison resources to be added]

### Additional Resources
*[Documentation, tutorials, examples, or related frameworks]*

## Action Items

- **PRIORITY**: Review missed opening section of talk (slides/recording)  
- ✅ **COMPLETED**: Found mini007 framework - CRAN package available since 2025-11-03
- **TODO**: Install and test mini007 package: `install.packages("mini007")`
- **TODO**: Test judge function with multiple agents for response quality comparison
- **TODO**: Experiment with HITL (Human In The Loop) integration points
- **TODO**: Compare mini007 performance vs. manual multi-agent coordination
- Evaluate framework for potential R AI orchestration use cases
- Compare mini007 with other R multi-agent approaches mentioned in sequence

*[Additional post-conference follow-up tasks, framework evaluation, or implementation planning]*

## Notes

- **Status:** Ready for live note-taking ✅
- **Context:** Completes multi-agent systems trilogy (1-04 → 1-05 → 1-06)
- **Framework Focus:** Lightweight orchestration specifically for R environments
- **Technical Depth:** Expected to show practical implementation of multi-agent coordination

---
*Session 1-06 notes created 2025-11-12 1:00 PM*