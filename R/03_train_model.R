# Load required libraries
library(tidymodels)
library(xgboost)
library(readr)

# 1. Load the cleaned dataset and ensure target is a factor
df <- read_csv("data/processed/cleaned_survey_data.csv")
df$high_distress <- as.factor(df$high_distress)

# 2. Data Split (80% training, 20% testing)
set.seed(42)
data_split <- initial_split(df, prop = 0.8, strata = high_distress)
train_data <- training(data_split)
test_data  <- testing(data_split)

# 3. Create a preprocessing recipe (including your numeric genre frequencies!)
rec <- recipe(high_distress ~ hours_per_day + age + frequency_rock + frequency_metal + frequency_classical + frequency_pop + frequency_rap, data = train_data) %>%
  step_normalize(all_numeric_predictors())

# 4. Define the XGBoost model specification
xgb_spec <- boost_tree(
  trees = 100,
  tree_depth = 4,
  learn_rate = 0.05
) %>%
  set_engine("xgboost") %>%
  set_mode("classification")

# 5. Combine recipe and model into a workflow, then fit to training data
xgb_workflow <- workflow() %>%
  add_recipe(rec) %>%
  add_model(xgb_spec)

model_fit <- fit(xgb_workflow, data = train_data)

# 6. Evaluate on test data
predictions <- predict(model_fit, test_data, type = "prob")
results <- bind_cols(test_data, predictions)

# Check model performance (ROC-AUC)
roc_auc(results, truth = high_distress, .pred_1)

# 7. Save the trained model artifact to your models folder
saveRDS(model_fit, "models/xgb_model.rds")
print("Model training complete! Saved to models/xgb_model.rds")