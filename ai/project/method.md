# Methodology (Template)

Describe the analytical approach, standards, and reproducibility guardrails for this project.

## Process

### Pre-conference

AI scaned the (program)[https://rconsortium.github.io/RplusAI_website/program.html] of the R+AI 2025 conference to identify  talks and any supplied materials. The slides of individual talks were promised by the organizers, but were not available at the time of writing. A few authors distributed their talks in conference chat, but those were few. 

Human user created a Conference Noter persona (see ai/personas/conference-noter.md)  to assist the human in taking notes during the live conference sessions and to organize the notes afterward.


### During the conference

The human user was participating in the R+AI conference and was taking notes in the chat with copilot (Conference Noter persona), who was creating the text notes in ./data-public/raw/conference-notes.md

In their present state (./data-public/raw/conference-notes), the notes represent an amalgam of ai pre-structured text, human input during the talks, and AI responding to the  human's input, often containing instructions to look something up, remember, or mark for later, or indicate importance. Every talk started with a clean chat session with a Converence Noter persona. 

### Post-conference

Human user instructed AI to summarize and standardize each note into a common format (./data-public/derived/note-summary/*.md), extracting key points, resources, and action items. 

Specifically, using the Prompt Engineer persona, the human transformed initial chat session into a structured RICECO-type prompt stored in ./analysis/notes-summary.md


### Analytical Artefacts

Using Conference Noter person, the human user instructed AI to create the following artefacts:

- ./data-public/derived/artefacts/package-index.md - Comprehensive catalog of R packages mentioned at the conference, ranked by utility with installation instructions and key features
- ./data-public/derived/artefacts/follow-up.md - Prioritized action items and technical implementation roadmap based on conference discoveries
- ./data-public/derived/artefacts/top-ideas.md - Five most strategically important insights from the conference for research analytics workflows



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