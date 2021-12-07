# Overview ----------------------------------------------------------------
# Final Deliverable
# Creating a shiny server

# Loading data ------------------------------------------------------------
# Load packages

library(shiny)
library(dplyr)
library(leaflet)
library(plotly)

# Read data

fire_data <- read.csv('./data/California_Fire_Incidents.csv',
                     stringsAsFactors = FALSE)


# Define shiny server----------------------------------------------------------

server <- function(input, output){
  
  # Render Map
  output$map <- renderLeaflet({
   
    # Legend color set up
    pal <-  colorQuantile(
      palette = "Reds",
      domain = fire_data$AcresBurned,
      n = 5
    )
    
    # Modify Data
    map_data <- fire_data %>%
      filter(Longitude < -110 & Longitude > -130) %>%
      filter(Latitude > 30 & Latitude < 45) %>%
      filter(
        MajorIncident %in% input$selectvar,
        ArchiveYear %in% input$yearvar
      )
    
    # Map Data
    map_plot <- leaflet(map_data) %>%
      addTiles() %>%
      addCircleMarkers(
        lng = ~Longitude,
        lat = ~Latitude,
        color = ~pal(AcresBurned),
        label = ~Counties
      ) %>%
      addLegend("bottomleft", pal = pal, values = ~AcresBurned, 
                layerId = "colorLegend", title="Acres Burned", opacity = 1)
  })
  
  
  
  
  output$chart1 <- renderPlotly({
    
    
    
    
    # p <- plot_ly(x = , y = , type = "bar")
    # 
    # p
    
  })
  
  
  
}