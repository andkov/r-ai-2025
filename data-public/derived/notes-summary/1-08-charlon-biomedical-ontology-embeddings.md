# 1-08: Biomedical Ontology Dictionary Creation with Embeddings and Local LLMs

**One-Sentence Summary**: Thomas Charlon (Harvard Medical School) presents methods for creating biomedical ontology dictionaries using embedding techniques and local LLM deployment, addressing the challenge of structuring and standardizing medical terminology and knowledge representation in research environments while maintaining privacy and domain-specific accuracy through locally-hosted models.

**Speaker**: Thomas Charlon (Harvard Medical School)

**Importance Rank**: ⭐⭐⭐ (3/5)
- **Tools/Concepts**: ⭐⭐⭐⭐ (Biomedical embeddings; local LLM deployment; ontology creation methods)
- **Immediate Applicability**: ⭐⭐ (Highly specialized domain; requires biomedical context and infrastructure)
- **Novel Techniques**: ⭐⭐⭐ (Domain-specific embedding applications; privacy-preserving AI for medical knowledge)

## Key Insights from Human Notes

**Biomedical Ontology Challenge**: The presentation addresses the complex task of creating structured biomedical ontology dictionaries - systematic organizations of medical terminology, concepts, and their relationships. Traditional manual curation methods (e.g., UMLS, SNOMED CT) are labor-intensive and struggle to keep pace with rapidly evolving medical knowledge. **Embeddings and local LLMs** offer a computational approach to automate and accelerate ontology creation while maintaining domain accuracy and clinical safety standards.

**Local LLM Deployment Advantages**: The emphasis on **local LLM deployment** is critical for biomedical applications due to: (1) **Privacy and Security** - Patient data and proprietary medical knowledge must remain within institutional boundaries (HIPAA compliance); (2) **Domain Specialization** - Local models can be fine-tuned on institution-specific medical terminology and practices; (3) **Cost Control** - Academic medical centers require predictable costs for research infrastructure; (4) **Regulatory Compliance** - Healthcare AI applications often require auditable, controlled deployment environments. This approach enables Harvard Medical School to leverage LLM capabilities while meeting stringent medical research requirements.

**Integration with Biomedical R Ecosystem**: Expected integration points include **Bioconductor** packages for biomedical data analysis, existing R packages for medical text processing and terminology standards, and potential contributions to the biomedical R package ecosystem. The Harvard Medical School affiliation suggests high-quality biomedical research perspective with practical clinical applications in mind.

## Tools & Resources

**Biomedical Ontology Resources** (Expected):
- **UMLS (Unified Medical Language System)**: Comprehensive medical terminology metathesaurus
- **SNOMED CT**: Clinical terminology standard for electronic health records
- **Medical Subject Headings (MeSH)**: NLM controlled vocabulary for indexing articles
- **Gene Ontology (GO)**: Structured representation of gene and protein functions

**R Biomedical Text Processing** (Expected):
- **Bioconductor**: Comprehensive R framework for biomedical data analysis
- **tm**: Text mining framework for R (medical literature processing)
- **text2vec**: Modern text mining framework with embedding support
- **word2vec**: Word embedding implementation for R
- **keras/tensorflow**: Deep learning frameworks for embedding generation

**Local LLM Deployment Tools** (Expected):
- **Ollama**: Local LLM deployment and management
- **llama.cpp**: Efficient local LLM inference
- **huggingface transformers**: Access to biomedical LLMs (BioGPT, PubMedBERT, etc.)
- **R integration**: ellmer, ollamar packages for local LLM connectivity

**Embedding Models for Biomedical Text** (Anticipated):
- **BioWordVec**: Pre-trained word embeddings on PubMed abstracts
- **BioSentVec**: Sentence embeddings for biomedical literature
- **PubMedBERT**: BERT model pre-trained on PubMed abstracts
- **BioBERT**: Biomedical domain-specific BERT variant
- **Clinical BERT**: BERT trained on clinical notes and medical texts

**Performance Considerations**:
- Computational requirements for embedding generation and LLM inference
- GPU resources for academic medical research environments
- Memory optimization for large medical terminology databases
- Scalability for institution-wide biomedical knowledge management

## Methods & Techniques for Research Analytics

**Applicable Methods**:
1. **Embedding-Based Terminology Clustering**: Generating embeddings for medical terms and clustering related concepts
2. **Local LLM Ontology Generation**: Using locally-hosted LLMs to propose term relationships and hierarchies
3. **Domain Adaptation**: Fine-tuning embeddings and LLMs on institution-specific medical terminology
4. **Privacy-Preserving AI**: Implementing AI workflows that maintain HIPAA compliance through local deployment
5. **Validation Against Curated Ontologies**: Comparing AI-generated ontologies to gold-standard resources (UMLS, SNOMED)

**Research Workflow Applications**:
- Standardizing medical terminology across heterogeneous research datasets
- Accelerating literature review through semantic similarity of biomedical concepts
- Integrating clinical notes with structured medical knowledge bases
- Supporting clinical decision support systems with up-to-date medical ontologies
- Enabling cross-institutional research through standardized terminology mappings
- Automating ontology updates as medical knowledge evolves

## Priority Follow-Up Actions

**🚨 IMMEDIATE**:
- [ ] **Obtain presentation materials** (slides, recording, repository links)
- [ ] Research biomedical embedding models (BioWordVec, PubMedBERT, BioBERT)
- [ ] Explore local LLM deployment options (Ollama, llama.cpp) for academic environments
- [ ] Review Bioconductor packages for biomedical text processing

**📋 INVESTIGATE**:
- Integration with major biomedical ontologies (UMLS, SNOMED CT, MeSH)
- Validation methods and quality assurance for AI-generated medical ontologies
- Computational infrastructure requirements for local LLM deployment in research
- Privacy and security considerations for medical AI applications (HIPAA compliance)
- Domain-specific embedding generation techniques for specialized medical fields
- Performance comparison: local vs. cloud-based LLMs for biomedical tasks
- Clinical accuracy validation and safety considerations for AI-generated ontologies

**🔗 CONNECT**:
- Thomas Charlon (Harvard Medical School) for implementation details and case studies
- Bioconductor community for biomedical R package integration
- Medical informatics researchers working on ontology standardization
- Healthcare AI researchers addressing privacy-preserving deployment models
- Clinical terminology standards organizations (UMLS, SNOMED) for validation approaches