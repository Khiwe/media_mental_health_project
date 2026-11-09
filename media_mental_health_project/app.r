library(shiny)
library(tidyverse)
library(tidymodels)
library(xgboost)

# Load the trained XGBoost model
model_fit <- readRDS("models/xgb_model.rds")

# Define UI for application
ui <- fluidPage(
  titlePanel("Mental Health & Music Consumption Predictor"),
  
  sidebarLayout(
    sidebarPanel(
      h3("Enter Your Habits"),
      sliderInput("hours_per_day", "Hours Listening to Music Per Day:", min = 0, max = 24, value = 3),
      sliderInput("age", "Age:", min = 10, max = 80, value = 20),
      
      selectInput("frequency_rock", "Rock Listening Frequency:", 
                  choices = list("Never" = 0, "Rarely" = 1, "Sometimes" = 2, "Very Frequently" = 3), selected = 2),
      selectInput("frequency_metal", "Metal Listening Frequency:", 
                  choices = list("Never" = 0, "Rarely" = 1, "Sometimes" = 2, "Very Frequently" = 3), selected = 0),
      selectInput("frequency_classical", "Classical Listening Frequency:", 
                  choices = list("Never" = 0, "Rarely" = 1, "Sometimes" = 2, "Very Frequently" = 3), selected = 1),
      selectInput("frequency_pop", "Pop Listening Frequency:", 
                  choices = list("Never" = 0, "Rarely" = 1, "Sometimes" = 2, "Very Frequently" = 3), selected = 2),
      selectInput("frequency_rap", "Rap Listening Frequency:", 
                  choices = list("Never" = 0, "Rarely" = 1, "Sometimes" = 2, "Very Frequently" = 3), selected = 1),
      
      actionButton("predict", "Predict Risk", class = "btn-primary")
    ),
    
    mainPanel(
      h3("Prediction Results"),
      textOutput("risk_text"),
      verbatimTextOutput("prob_output")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  prediction_data <- eventReactive(input$predict, {
    data.frame(
      hours_per_day = as.numeric(input$hours_per_day),
      age = as.numeric(input$age),
      frequency_rock = as.numeric(input$frequency_rock),
      frequency_metal = as.numeric(input$frequency_metal),
      frequency_classical = as.numeric(input$frequency_classical),
      frequency_pop = as.numeric(input$frequency_pop),
      frequency_rap = as.numeric(input$frequency_rap)
    )
  })
  
  output$risk_text <- renderText({
    req(input$predict)
    preds <- predict(model_fit, prediction_data(), type = "prob")
    risk_prob <- preds$.pred_1
    
    if(risk_prob > 0.5) {
      paste0("⚠️ High Distress Risk Detected (Probability: ", round(risk_prob * 100, 1), "%)")
    } else {
      paste0("✅ Low Distress Risk (Probability: ", round(risk_prob * 100, 1), "%)")
    }
  })
  
  output$prob_output <- renderPrint({
    req(input$predict)
    predict(model_fit, prediction_data(), type = "prob")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)