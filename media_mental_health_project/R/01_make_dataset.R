# Load required libraries
library(tidyverse)
library(janitor)

# 1. Load the raw dataset
raw_data <- read_csv("data/raw/mxmh_survey_results.csv")

# 2. Clean column names to lowercase snake_case
df_clean <- raw_data %>%
  clean_names()

# 3. Handle missing values and convert genre text frequencies to numeric scores
# Mapping: Never = 0, Rarely = 1, Sometimes = 2, Very frequently = 3
df_clean <- df_clean %>%
  filter(!is.na(anxiety) & !is.na(depression)) %>%
  mutate(
    # Fill numeric NAs with medians
    across(where(is.numeric), ~replace_na(., median(., na.rm = TRUE))),
    
    # Convert text frequency columns into numeric ordinal values
    across(starts_with("frequency_"), ~ case_when(
      . == "Never" ~ 0,
      . == "Rarely" ~ 1,
      . == "Sometimes" ~ 2,
      . == "Very frequently" ~ 3,
      TRUE ~ 0 # default fallback
    ))
  )

# 4. Create a binary target variable for your classifier
df_clean <- df_clean %>%
  mutate(
    high_distress = if_else(anxiety >= 7 | depression >= 7, 1, 0),
    high_distress = as.factor(high_distress)
  )

# 5. Export the processed dataset
write_csv(df_clean, "data/processed/cleaned_survey_data.csv")

print("Data cleaning & genre encoding complete! Saved to data/processed/cleaned_survey_data.csv")