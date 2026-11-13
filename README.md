# Entertainment Consumption & Well-Being Analyzer

An end-to-end data science and machine learning pipeline investigating the statistical and behavioral relationship between media consumption habits (music audio preferences, daily streaming hours) and self-reported mental health metrics (anxiety and depression distress levels). Built with R (`tidyverse`, `tidymodels`, `xgboost`), structured with a modular Cookiecutter architecture, and deployed as an interactive Shiny web application.

---

## Features

### Data Ingestion & Engineering Pipeline
- **Automated Column Sanitization**: Standardizes raw survey column names into clean, lowercase snake_case using `janitor`.
- **Numeric Bounds Validation**: Validates daily music listening hours (`hours_per_day`), clamping out-of-range anomalies and imputing medians.
- **Ordinal Text Encoding**: Programmatically transforms frequency-based categorical text columns (`Never`, `Rarely`, `Sometimes`, `Very frequently`) into clean numeric scores across music genres using `across()` and `case_when()`.
- **Missing Value Imputation**: Automatically fills remaining numeric missing values with robust column medians.

### Machine Learning & Risk Modeling
- **Classification Target Engineering**: Derives a binary risk classifier (`high_distress`) based on clinical thresholds for self-reported anxiety and depression scores.
- **Tidymodels Workflow Integration**: Standardized recipe preprocessing with feature normalization and an optimized XGBoost classification engine (`boost_tree`).
- **Train-Test Splitting**: Stratified 80/20 data partitioning to ensure robust evaluation and generalization.
- **Model Serialization**: Exports trained models into lightweight `.rds` binary artifacts for rapid inference.

### Interactive Decision Support Dashboard
- **Shiny Web Application (`app.R`)**: Live, user-facing dashboard allowing individuals to input their daily listening hours, age, and genre preferences.
- **Real-Time Risk Scoring**: Instant probability calculation and risk assessment badge (`⚠️ High Distress Risk Detected` vs `✅ Low Distress Risk`) powered by the serialized XGBoost model.

---

## 📊 Model Performance & Insights

- **Baseline Metrics**: The XGBoost classifier achieves an ROC-AUC of ~0.53 and an accuracy of ~57% using music listening hours, age, and genre frequencies. 
- **Data Science Key Takeaway**: This project highlights a vital empirical lesson in feature engineering: self-reported mental health distress cannot be robustly predicted by music preferences alone. While the pipeline architecture and MLOps deployment are fully functional, the features lack strong mathematical correlation to the target variable. 
- **Future Iterations (Project 2)**: Transitioning toward behavioral and lifestyle metrics (such as sleep duration, daily stress, and physical activity) which possess higher predictive potential for well-being.

---

## Tech Stack

- **Language**: [R](https://www.r-project.org/) (Version 4.x)
- **Data Wrangling & Manipulation**: [Tidyverse](https://www.tidyverse.org/) (`dplyr`, `tidyr`, `readr`), [`janitor`](https://sfirke.github.io/janitor/)
- **Machine Learning**: [`tidymodels`](https://www.tidymodels.org/), [`xgboost`](https://xgboost.readthedocs.io/)
- **Deployment & Interactivity**: [Shiny](https://shiny.posit.co/)
- **Architecture**: Cookiecutter Data Science standardized folder structure

---

## Getting Started

### Prerequisites
- R (Version 4.0 or higher)
- RStudio (recommended)

### Installation
Clone the repository and open the RStudio project file (`media_mental_health_project.Rproj`):
```bash
git clone <repository-url>
cd media_mental_health_project
