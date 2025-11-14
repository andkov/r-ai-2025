# 1-03: Reviving Forgotten Code with LLMs

**One-Sentence Summary**: Jonathan Pearce demonstrates practical approaches to understanding, documenting, and modernizing legacy R code using Large Language Models, showcasing how LLMs can help data scientists resurrect "forgotten" analytical code with sparse documentation through systematic pattern recognition, function extraction, test development, and automated documentation generation.

**Speaker**: Jonathan Pearce (Lightspeed Commerce) | [GitHub](https://github.com/Jonathan-Pearce/R_AI_2025) | [Docs](https://jonathan-pearce.github.io/R_AI_2025/)

**Importance Rank**: ⭐⭐⭐⭐ (4/5)
- **Tools/Concepts**: ⭐⭐⭐⭐ (LLM-assisted code archaeology; patient-level ETL patterns; data.table dcast transformations)
- **Immediate Applicability**: ⭐⭐⭐⭐ (Directly applicable to legacy codebase modernization; institutional knowledge recovery)
- **Novel Techniques**: ⭐⭐⭐ (Systematic code revival framework; test-driven legacy modernization)

## Key Insights from Human Notes

**Legacy Code Archaeology Framework**: Pearce's R_AI_2025 repository demonstrates a common healthcare analytics scenario - specialized ETL functions developed for specific projects that contain valuable domain logic but lack comprehensive documentation. The accompanying repository serves as a practical example with **patient-level data transformation utilities** (subsetEvents, getFlags, getCounts, getValues) that illustrate the "code archaeology" challenge where institutional knowledge is embedded in undocumented scripts. These functions showcase **data.table::dcast patterns** for transforming event-level (long format) data to patient-level (wide format), representing broadly applicable patterns likely developed for specific healthcare analytics projects.

**LLM-Assisted Modernization Strategy**: The presentation suggests a systematic framework for code revival: (1) **Pattern Recognition** - Identifying common transformation patterns in legacy code; (2) **Function Extraction** - Breaking monolithic scripts into modular functions; (3) **Documentation Generation** - Using LLMs to generate comprehensive documentation; (4) **Test Development** - Creating unit tests (e.g., tests/testthat/test-isLengthNonZero.R) to verify and document expected behavior; (5) **Standardization** - Applying consistent naming (formatVariableNames, cleanVarNames) and structure conventions. The repository demonstrates this through **10+ utility functions for patient-level ETL**, comprehensive pkgdown documentation website, and unit testing framework with examples.

**Broader Implications for R Community**: The talk addresses code sustainability strategies for maintaining long-term code accessibility, knowledge transfer when original developers leave organizations, AI-assisted refactoring as practical application of LLMs in code modernization, and healthcare data standards with common patterns for patient-level data transformations. The repository represents the "forgotten code" challenge: **undocumented scripts containing valuable logic** that have become difficult to understand, maintain, or extend.

## Tools & Resources

**Core Repository**:
- **GitHub**: https://github.com/Jonathan-Pearce/R_AI_2025 | Patient-level ETL utilities for data.table dcast transformations
- **Documentation**: https://jonathan-pearce.github.io/R_AI_2025/ | pkgdown-generated website with comprehensive function descriptions
- **Installation**: `devtools::install_github("Jonathan-Pearce/R_AI_2025")`

**Key Functions Demonstrated**:
```r
# Time-based filtering
subsetEvents(dt, event_date_var, start_date_var, end_date_var)

# Binary flag creation with isLengthNonZero aggregation
getFlags(dt, dt_flag_var, data_type, time_period)

# Count aggregations
getCounts(dt, dt_count_var, data_type, time_period, fill_value = NA)

# Value aggregations with custom functions
getValues(dt, dt_value_var, dt_name_var, data_type, time_period, 
          FUN_value = "mean", fill_value = NA)

# Missing data handling
ImputeMissingPatients()

# Variable naming standardization
formatVariableNames()
cleanVarNames()
```

**Core Packages**:
- **data.table**: Primary data manipulation framework, especially `dcast` function for wide-format transformations
- **dplyr**: Supporting data manipulation
- **testthat**: Unit testing framework (tests/testthat/)
- **devtools**: Development workflow tools
- **pkgdown**: Documentation website generation

**Repository Structure**:
- R/helper_functions.R (main utility functions)
- tests/testthat/ (unit testing with examples)
- DESCRIPTION (package metadata and dependencies)
- README.md (comprehensive documentation)

## Methods & Techniques for Research Analytics

**Applicable Methods**:
1. **Code Archaeology**: Systematically identifying patterns in undocumented legacy code using LLM analysis
2. **Function Decomposition**: Breaking complex ETL pipelines into small, testable, modular functions
3. **Test-Driven Revival**: Creating unit tests to verify and document expected behavior of legacy code
4. **Automated Documentation**: Using LLMs to generate comprehensive documentation from code patterns
5. **Patient-Level ETL**: data.table::dcast transformations for event-level to patient-level data conversion

**Research Workflow Applications**:
- Modernizing legacy healthcare analytics pipelines with sparse documentation
- Recovering institutional knowledge embedded in undocumented R scripts
- Standardizing variable naming conventions (formatVariableNames, cleanVarNames)
- Implementing reproducible data transformation patterns (subsetEvents, getFlags, getCounts, getValues)
- Missing data imputation in longitudinal patient-level datasets (ImputeMissingPatients)

## Priority Follow-Up Actions

**🚨 IMMEDIATE**:
- [ ] Review R_AI_2025 repository: https://github.com/Jonathan-Pearce/R_AI_2025
- [ ] Study patient-level ETL patterns (subsetEvents, getFlags, getCounts, getValues)
- [ ] Examine unit testing approach: tests/testthat/test-isLengthNonZero.R
- [ ] Explore pkgdown documentation generation workflow

**📋 INVESTIGATE**:
- Obtain presentation slides/recording (noted as "coming soon" on site)
- LLM prompting strategies for code documentation generation
- Test-driven legacy code revival methodology
- data.table::dcast performance optimization for wide-format transformations
- Domain-specific terminology handling in healthcare code archaeology

**🔗 CONNECT**:
- Jonathan Pearce (Data Scientist, Lightspeed Commerce) for code modernization approaches
- Healthcare analytics community for patient-level ETL standardization patterns
- LLM-assisted code documentation best practices
- Legacy code modernization case studies in R community