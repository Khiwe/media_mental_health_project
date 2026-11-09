# Load required libraries
library(tidyverse)
library(tidymodels)
library(readr)
# 1. Load the raw dataset
survey_results = read.csv('/Users/khiwe/Documents/School/DS Project/media_mental_health_project/data/raw/mxmh_survey_results.csv')
# 2. Clean column names to lowercase snake_case
clean_results = survey_results
clean_results
clean_results = clean_names(clean_results)
c_w1=case_when(clean_results$hours_per_day < 0~0,
          clean_results$hours_per_day>24~median(clean_results$hours_per_day, na.rm = T),
          T~clean_results$hours_per_day
          )
clean_results = clean_results%>%
  mutate(hours_per_day = c_w1)
# 3. Handle missing values and convert genre text frequencies to numeric scores
# Mapping: Never = 0, Rarely = 1, Sometimes = 2, Very frequently = 3
clean_results = clean_results %>%
  mutate(
    across(starts_with('frequency_'),
           ~case_when(. == "Never"~0,
                     . == "Rarely"~1,
                     . == "Sometimes"~2,
                     . == "Very frequently"~3,
                     T~NA_real_)
    )
  )

# Fill numeric NAs with medians

# Convert text frequency columns into numeric ordinal values
# 4. Create a binary target variable for your classifier
# 5. Export the processed dataset