# 1-07: Analyzing LLM Evaluations

**One-Sentence Summary**: Max Kuhn demonstrates how 51-year-old Generalized Linear Models (specifically cumulative link mixed models and Bayesian methods) solve modern LLM evaluation problems by properly handling hierarchical experimental designs with correlated data, enabling direct probability statements like "there is a 67.3% probability Claude is better than GPT."

**Speaker**: Max Kuhn & Simon Couch (Posit PBC) | [Slides & Code](https://topepo.github.io/2025-r-ai/)

**Importance Rank**: ⭐⭐⭐⭐⭐ (5/5)
- **Tools/Concepts**: ⭐⭐⭐⭐⭐ (vitals package, ordinal::clmm, brms, inspect framework)
- **Immediate Applicability**: ⭐⭐⭐⭐ (vitals R package ready now; complete workflow examples)
- **Novel Techniques**: ⭐⭐⭐⭐⭐ (Proper statistical methodology critiquing ad-hoc LLM evaluation)

## Key Insights from Human Notes

**Statistical Rigor Critique**: Anthropic 2024 manuscript shows "spirit" but is "myopic and not especially good statistical methodology." Classical GLMs provide proper framework for LLM evaluation with hierarchical structures (replicates within queries, scores within raters).

**Bayesian vs. Frequentist Clarity**:
- **Frequentist (torturous)**: "If we repeated experiment many times, parameter would fall in [CI] 95% of time"
- **Bayesian (rational)**: "There is a 67.3% probability that Claude is better than GPT" - direct probability statements about parameters

**vitals Package Integration**: R port of Python Inspect framework providing on-ramp to transition to Inspect, treating LLM evaluations like unit testing with persistent log files. Three-component architecture: Dataset (input/target), Solver (ellmer integration), Scorer (evaluation methods).

## Tools & Resources

**Primary Packages**:
- **vitals**: R package for LLM evaluations | `install.packages("vitals")` or `pak::pak("tidyverse/vitals")` | [vitals.tidyverse.org](https://vitals.tidyverse.org/)
- **ordinal**: Cumulative link mixed models | `ordinal::clmm()` for frequentist analysis
- **brms**: Bayesian regression models using Stan | Flexible priors, rich diagnostics, direct probability statements
- **inspect**: UK AI Security Institute framework | [inspect.aisi.org.uk](https://inspect.aisi.org.uk/) | Python-based with R vitals compatibility

**Key Statistical Methods**:
```r
# Frequentist: Proportional odds model
multiple_mod <- ordinal::clmm(score ~ LLM + (1|id), data = are_eval)

# Bayesian: Same model with probability statements
multiple_bayes <- brm(score ~ LLM + (1|id), family = cumulative, data = are_eval)

# vitals workflow
tsk <- Task$new(dataset, solver, scorer)
tsk$eval()  # Runs solver, scorer, saves to persistent log
```

**Vitals Integration**:
- Works with ellmer for LLM solver integration
- Writes to same log format as Python Inspect
- Three-component architecture: Dataset, Solver, Scorer
- Built-in dataset: `are` (R coding problems for expert-level evaluation)

## Methods & Techniques for Research Analytics

**Applicable Methods**:
1. **Proper Experimental Design**: ANOVA framework for factorial LLM evaluation experiments (models, prompts, replicates)
2. **Hierarchical Modeling**: Random effects for dependent observations (questions, raters, replicates)
3. **Ordinal Outcomes**: Proportional odds models for ordered categories (incorrect/partially correct/correct)
4. **Bayesian Inference**: Direct probability statements for parameter comparisons and practical significance
5. **Unit Testing Paradigm**: vitals treats LLM evaluations like unit tests for systematic assessment

**Research Workflow Applications**:
- Rigorous LLM evaluation for research applications (proper statistical methodology)
- A/B testing LLM configurations with confidence intervals or posterior probabilities
- Systematic assessment of model improvements over time
- Integration with multi-agent evaluation scenarios (connection to sessions 1-05, 1-06)
- Reproducible LLM evaluation workflows with persistent logging

## Priority Follow-Up Actions

**🚨 IMMEDIATE**:
- [ ] Install vitals: `install.packages("vitals")` or `pak::pak("tidyverse/vitals")`
- [ ] Review vitals vignette: `vignette("vitals", package = "vitals")`
- [ ] Reproduce example analysis with Claude/GPT/Gemini dataset from presentation
- [ ] Test vitals with ellmer package for actual LLM evaluation tasks
- [ ] Read Anthropic 2024 paper to understand methodological critiques: https://arxiv.org/pdf/2411.00640

**📋 INVESTIGATE**:
- Compare ordinal::clmm vs. brms approaches on same dataset
- Explore vitals ↔ inspect integration (log file compatibility)
- Test proportional odds assumption on LLM evaluation data
- Read Simon Couch's blog: ["I was wrong about tidymodels and LLMs"](https://www.simonpcouch.com/blog/2025-08-26-predictive/)
- Investigate inspect framework Python integration for R users

**🔗 CONNECT**:
- Max Kuhn's presentation repository: https://github.com/topepo/2025-r-ai
- vitals GitHub: https://github.com/tidyverse/vitals/
- inspect framework: https://github.com/UKGovernmentBEIS/inspect_ai
- UK AI Security Institute resources