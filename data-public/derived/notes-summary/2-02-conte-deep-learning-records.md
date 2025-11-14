# 2-02: How Deep Learning Helps Build Results that Beat Prior Records

**One-Sentence Summary**: Russ Conte presents four CRAN packages (NumericEnsembles, ClassificationEnsembles, LogisticEnsembles, ForecastingEnsembles - all released April 2025) that automatically build comprehensive ensemble models combining traditional methods with deep learning approaches (BayesRNN, XGBoost, Neuralnet, SVM), with **NumericEnsembles achieving one-line code** that builds 40 models (23 individual + 17 ensembles), beats all top Kaggle Boston Housing scores from 20 years in under 1 minute, and automatically generates 26 plots + 6 tables for complete analysis.

**Speaker**: Russ Conte (@InfiniteCuriosity) | russconte@mac.com | (708) 691-8339 | [DataScienceForBusiness.com](http://datascienceforbusiness.com/)

**Importance Rank**: ⭐⭐⭐⭐ (4/5)
- **Tools/Concepts**: ⭐⭐⭐⭐⭐ (40-model automated ensembles; BayesRNN integration; one-line record-breaking; 26 auto-plots)
- **Immediate Applicability**: ⭐⭐⭐⭐ (CRAN packages ready; minimal setup; complete automation)
- **Novel Techniques**: ⭐⭐⭐ (Automated ensemble orchestration; deep learning integration with traditional methods)

## Key Insights from Human Notes

**⚠️ Video Quality Issue**: Conference video was blurry, code examples not clearly visible during live session. **Follow-up required**: Watch clearer YouTube version at https://www.youtube.com/watch?v=csGcnGJ2t0U (18:44 min) for detailed code demonstrations and examples.

**Record-Breaking One-Line Performance**: **NumericEnsembles** achieves results beating all top Kaggle Boston Housing scores from past 20 years using **just one line of code**, completing setup in 10 seconds and running in under 1 minute. **ClassificationEnsembles** achieves **100% accuracy** on Dry Beans Dataset with deep learning classification methods. **LogisticEnsembles** uses BayesRNN model to achieve results **beating all previously published results** on Pima Indians Dataset. All processes are **completely automated**, require **minimal setup time**, and leverage **deep learning methods** (BayesRNN, XGBoost, Neuralnet, SVM) to achieve superior performance compared to traditional-only approaches.

**Comprehensive Automated Outputs**: Each ensemble package automatically generates extensive analysis outputs: **26 plots** (model performance SSE/MAE/MSE/Bias, best model diagnostics Q-Q/residuals/predicted vs actual, data exploration correlation/histograms/boxplots/pairwise scatter, performance comparisons accuracy/overfitting/duration/train vs holdout), **6-7 comprehensive tables** (correlation of ensemble, head of ensemble, data summary, correlation of data, RMSE/means/fitting summaries, head of data frame, 24-25 confusion matrices), and **grand summary table** sorted by accuracy with best model at top. This eliminates manual plotting and reporting workflows entirely.

## Tools & Resources

**Core CRAN Packages** (All Released April 2025):
- **NumericEnsembles**: https://www.numericensembles.com/ | GitHub: https://github.com/InfiniteCuriosity/NumericEnsembles
  - 40 models (23 individual: BayesGLM, BayesRNN, BoostRF, Cubist, Earth, Elastic, GAM, Gradient Boosted, KNN, Lasso, Linear, Neuralnet, PCR, PLS, RF, Ridge, RPart, SVM, Tree, XGBoost + 17 ensembles)
  - **One-line usage**: `Numeric(data = MASS::Boston, colnum = 14, numresamples = 2, ...)`
  - 26 auto-generated plots + 6 tables + grand summary
- **LogisticEnsembles**: https://www.logisticensembles.com/ | GitHub: https://github.com/InfiniteCuriosity/LogisticEnsembles
  - 24 logistic models (13 individual: Cubist, FDA, GAM, GLM, Lasso, Linear, LDA, PDA, QDA, RF, Ridge, SVM, Trees + 11 ensembles)
  - 25 plots + 7 tables + 24 confusion matrices
  - Example dataset: Lebron (included)
- **ClassificationEnsembles**: GitHub: https://github.com/InfiniteCuriosity/ClassificationEnsembles
  - 25 classification models (15 individual: C50, Bagged Cart, Bagged RF, Naive Bayes, SVM, Trees, Linear, PLS, PDA, RPart + 10 ensembles)
  - 26 plots + 5 tables + 25 confusion matrices
  - Example dataset: ISLR::Carseats
- **ForecastingEnsembles**: GitHub: https://github.com/InfiniteCuriosity/ForecastingEnsembles
  - Time series forecasting with ensemble methods

**Supporting Repositories**:
- **EnsemblesData**: https://github.com/InfiniteCuriosity/EnsemblesData (datasets)
- **CodeExamples**: https://github.com/InfiniteCuriosity/CodeExamples (working examples)
- **INFORMS_2025_presentation**: https://github.com/InfiniteCuriosity/INFORMS_2025_presentation (slides)

**Related Package**:
- **SuperLearner** (v2.0-29): https://github.com/ecpolley/SuperLearner (284 stars)
  - Original ensemble learning framework (Polley & van der Laan)
  - Dozens of algorithms with hyperparameter optimization, custom loss functions, multicore parallelization

**Basic Usage Pattern**:
```r
library(NumericEnsembles)
Numeric(data = MASS::Boston, colnum = 14, numresamples = 2,
        remove_VIF_above = 5.00, scale_all_predictors_in_data = "N",
        predict_on_new_data = "N", use_parallel = "Y",
        train_amount = 0.60, test_amount = 0.20, validation_amount = 0.20)

# For new data prediction:
Numeric(data = Boston_housing, colnum = 14, numresamples = 25,
        predict_on_new_data = "Y", ...) # Then provide new dataset when prompted
```

## Methods & Techniques for Research Analytics

**Applicable Methods**:
1. **Automated Ensemble Orchestration**: 40 models built, trained, cross-validated, and evaluated automatically
2. **Deep Learning Integration**: BayesRNN, Neuralnet, SVM integrated seamlessly with traditional methods
3. **Parallel Processing**: `use_parallel = "Y"` for efficient multi-model training
4. **Comprehensive Diagnostics**: 26 auto-generated plots covering performance, diagnostics, data exploration
5. **New Data Prediction**: `predict_on_new_data = "Y"` for applying trained ensembles to totally new datasets

**Research Workflow Applications**:
- Rapid model exploration with minimal code (one function call for 40 models)
- Benchmark comparison across traditional and deep learning methods simultaneously
- Automated reporting with publication-ready plots and tables
- Ensemble model selection with grand summary sorted by accuracy
- Time series forecasting with ForecastingEnsembles (when available)
- Classification tasks with automatic confusion matrices and ROC curves
- Logistic regression with comprehensive diagnostic plots and F1 scores

## Priority Follow-Up Actions

**🚨 IMMEDIATE**:
- [ ] **Watch YouTube version**: https://www.youtube.com/watch?v=csGcnGJ2t0U (18:44 min) for clear code examples
- [ ] Install NumericEnsembles: `install.packages("NumericEnsembles")`
- [ ] Test Boston Housing example to reproduce record-breaking results
- [ ] Review official documentation: https://www.numericensembles.com/
- [ ] Review LogisticEnsembles: https://www.logisticensembles.com/

**📋 INVESTIGATE**:
- How BayesRNN and deep learning models integrate with traditional ensemble methods
- Automatic hyperparameter optimization techniques across 40 diverse models
- Computational requirements for parallel processing across all models
- Cross-validation strategies ensuring robust performance estimates
- New data prediction workflow and pre-trained model reuse
- Comparison with SuperLearner package approach and performance
- INFORMS 2025 presentation slides: https://github.com/InfiniteCuriosity/INFORMS_2025_presentation

**🔗 CONNECT**:
- Russ Conte directly: russconte@mac.com or (708) 691-8339 for implementation guidance
- Monitor upcoming packages: TimeSeriesEnsembles, SentimentAnalysisEnsembles, ClusterAnalysisEnsembles
- Follow @InfiniteCuriosity on GitHub for new ensemble package releases
- DataScienceForBusiness.com for updates and new developments