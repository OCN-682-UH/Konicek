# Shiny monster movies
#Nov 18 2024

# Load packages

library(shiny)
library(bslib)
library(tidyverse)

# Get the data

monster_movies <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-10-29/monster_movies.csv')


# Define UI

ui <- page_sidebar(
  sidebar = sidebar(
    # Select variable for y-axis
    selectInput(
      inputId = "y",
      label = "Y-axis:",
      choices = c("average_rating", "num_votes", "year", "runtime_minutes"),
      selected = "num_votes"
    ),
    # Select variable for x-axis
    selectInput(
      inputId = "x",
      label = "X-axis:", 
      choices = c("average_rating", "num_votes", "year", "runtime_minutes"),
      selected = "average_rating"
    )
  ),
  textInput(inputId = "title", # new Id is title
            label = "This Shiny is SPOOKY!", #
            value = "Distribution of popular movies"), # starting title
  # Output: Show scatterplot
  card(plotOutput(outputId = "scatterplot")),
  
)
  

# Define server

server <- function(input, output, session) {
  output$scatterplot <- renderPlot({
    ggplot(data = monster_movies, aes_string(x = input$x, y = input$y)) +
      geom_point()
  })
}

# Create a Shiny app object

shinyApp(ui = ui, server = server)