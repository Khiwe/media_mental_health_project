# Entertainment Consumption & Well-Being Profiler

An associative analytics and risk modeling pipeline investigating the relationship between media consumption habits (music audio features, movie sentiment) and self-reported mental health metrics.

## Project Structure
```text
├── README.md          <- Top-level README for developers using this project.
├── data
│   ├── external       <- Data from third party sources (Spotify, IMDb APIs).
│   ├── interim        <- Intermediate data that has been transformed.
│   ├── processed      <- The final, canonical data sets for modeling.
│   └── raw            <- The original, immutable data dump.
├── docs               <- Project documentation.
├── models             <- Trained and serialized models, model predictions, or model summaries.
├── notebooks          <- Jupyter notebooks. Naming convention is a number, user initials, and description.
├── references         <- Data dictionaries, manuals, and all other explanatory materials.
├── reports            <- Generated analysis as HTML, PDF, LaTeX, etc.
│   └── figures        <- Generated graphics and figures to be used in reporting.
├── requirements.txt   <- The requirements file for reproducing the analysis environment.
├── Dockerfile         <- Container specification file for deployment.
└── src                <- Source code for use in this project.
    ├── __init__.py    <- Makes src a Python module.
    ├── data           <- Scripts to download or generate data.
    ├── features       <- Scripts to turn raw data into features for modeling.
    ├── models         <- Scripts to train models and make predictions.
    └── visualization  <- Scripts to create exploratory and results-oriented visualizations.
```
