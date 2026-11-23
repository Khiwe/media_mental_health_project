# Entertainment Consumption & Well-Being Profiler

An end-to-end data science pipeline investigating the relationship between media consumption habits (such as music genre preferences, streaming hours, and audio exposure) and self-reported mental health metrics (anxiety and depression distress levels).

---

## 📂 Project Directory Structure

```text
media_mental_health_project/
├── README.md                  <- Top-level documentation for this repository
├── requirements.txt           <- Python dependencies and environment specs
├── Dockerfile                 <- Containerization specification for deployment
├── media_mental_health_project.Rproj <- RStudio project file
├── app.R                      <- Interactive Shiny web application for live predictions
├── data/
│   ├── raw/                   <- Immutable raw survey data (mxmh_survey_results.csv)
│   ├── interim/               <- Intermediate transformed datasets
│   └── processed/             <- Cleaned, canonical datasets ready for modeling
├── models/
│   └── xgb_model.rds          <- Serialized trained XGBoost classifier artifact
├── notebooks/                 <- Exploratory analysis notebooks
├── reports/
│   └── figures/               <- Generated diagnostic plots and visual assets
└── src/                       <- Modular source code pipeline
    ├── data/                  <- Data ingestion and cleaning scripts (01_make_dataset.R)
    ├── features/              <- Feature engineering modules
    ├── models/                <- Model training (03_train_model.R) and inference scripts
    └── visualization/         <- Script files for generating EDA and model evaluation plots
```

---

## 🚀 Getting Started & Pipeline Execution

To run this project locally and reproduce the entire machine learning pipeline, follow these steps inside your RStudio or terminal environment:

### 1. Prerequisites
Ensure you have **R** installed along with the core tidyverse and tidymodels packages:
```R
install.packages(c("tidyverse", "tidymodels", "janitor", "xgboost", "shiny"))
```

### 2. Run the Data Pipeline
Execute the data cleaning and feature engineering script to parse raw survey files, clean column names into snake_case, handle missing values, and encode text frequencies into numeric ordinal features:
```R
source("R/01_make_dataset.R")
```

### 3. Train the Machine Learning Model
Run the model training script to split the data (80/20 train-test), apply recipe normalizations, train an optimized XGBoost classification model (`tidymodels`), evaluate performance metrics (ROC-AUC), and export the serialized model artifact:
```R
source("R/03_train_model.R")
```

### 4. Launch the Interactive Shiny Web App
Start the local Shiny dashboard to interact with the trained model in real-time and test predictions based on custom user inputs (listening hours, age, and genre preferences):
```R
shiny::runApp("app.R")
```

---

## 📊 Model Performance & Insights
* **Target Metric:** Binary classification predicting high mental health distress (`high_distress` derived from anxiety/depression scores $\ge 7$).
* **Evaluation:** Evaluated using ROC-AUC and confusion matrices via `tidymodels`.
* **Note on Predictive Power:** While music listening habits and genre preferences provide an excellent foundational dataset for testing end-to-end pipeline architecture, behavioral audio metrics alone exhibit limited direct correlation to clinical psychological distress (yielding modest baseline validation accuracy). This emphasizes the importance of data quality and feature engineering for future iterations.

---

## 🛠️ Tech Stack
* **Language:** R
* **Data Wrangling:** Tidyverse (`dplyr`, `tidyr`), `janitor`
* **Machine Learning:** Tidymodels, XGBoost
* **Deployment:** Shiny (Interactive Web UI)
* **Architecture:** Modular Cookiecutter Data Science Template