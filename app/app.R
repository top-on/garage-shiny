# SHINY APP FOR TRAFFIC DATA

library(shiny)
library(dplyr)
library(lubridate)
library(RSQLite)
library(ggplot2)

dir()

# LOAD DATA ----
load("data/df.Rdata")

# PREPROCESS ----
df_processed <-
  df %>%
  mutate(., free = as.numeric(free)) %>%
  mutate(., datetime = as_datetime(df$datetime, tz = "Europe/Berlin")) %>%
  mutate(., time = hms::as.hms(datetime))


# USER INTERFACE ----
ui <- fluidPage(

  titlePanel("Need a parking spot ?"),

  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "garage_name",
                  label = "Choose a car park:",
                  choices = unique(df_processed$name),
                  selected = "Parkhaus Karstadt")
    ),
    mainPanel(
      plotOutput(outputId = "time_series_plot")
    )
  ),
  
  theme = "custom.css"
)

# SERVER ----
server <- function(input, output) {

  output$time_series_plot <- renderPlot({

    df_processed %>%
      filter(., name == input$garage_name) %>% 
      ggplot(data = ., aes(x = time, y = free)) +
      geom_line(aes(group = date), alpha = .3) +
      theme_bw() +
      xlab("Time of day") +
      ylab("Free spots") +
      ggtitle(paste0("Free parking spots per day for car park '",
                     input$name, "'")) +
      theme(text = element_text(size = 20))
  })
}

# RUN APP ----
shinyApp(ui = ui, server = server)
