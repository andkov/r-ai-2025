# Methodology (Template)

Describe the analytical approach, standards, and reproducibility guardrails for this project.

## Process

### During the conference

AI scaned the program of the R+AI 2025 conference to identify relevant talks and materials.
https://rconsortium.github.io/RplusAI_website/program.html

The human user was participating in the R+AI conference and was taking notes in the chat with copilot, who was creating the text notes in ./data-public/raw/conference-notes.md

In their present state (./data-public/raw/conference-notes), the notes represent an amalgam of ai pre-structured text, human input during the talks, and AI responding to the  human's input, often containing instructions to look something up, remember, or mark for later, or indicate importance. Every talk started with a clean chat session with a Converence Noter persona. 

### Post-conference

Human user instructed AI to summarize and standardize each note into a common format (./data-public/derived/note-summary/*.md), extracting key points, resources, and action items.






## Analytical Approach

- Semantic analysis
- Knowledge and skil organization
- Resource cataloging

## Reproducibility Standards

- Version control of code and configuration
- Deterministic outputs where feasible
- Clear environment setup instructions

## Documentation & Reporting

- Use Quarto/Markdown notebooks for analyses when helpful
- Document major decisions in `ai/memory-human.md`
- Keep `README.md` current with run instructions

---
*Replace template bullets with project-specific methodology details.*