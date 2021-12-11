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
  
  
  
  # Render chart1
  output$chart1 <- renderPlotly({
    
    structure_data <- fire_data %>% 
      filter(ArchiveYear == input$chart1_year) %>%
      filter(!is.na(StructuresDestroyed)) %>%
      filter(!is.na(AcresBurned)) %>%
      select(StructuresDestroyed, AcresBurned)

    
    p <- ggplot(structure_data, aes(y = StructuresDestroyed, x = AcresBurned)) + 
      geom_point() +
      scale_x_log10(limits = c(1, 500000)) + 
      scale_y_log10(limits = c(1, 20000)) +
      labs(x = "Acres Burned", y = "Structures Destroyed", title = "Destruction and Burn Area of CA Wildfires")
  
    
    p <- ggplotly(p)
    
    return(p)
    
    
    
  })
  
  
  
  # Render chart2
  c_d_e_year <- reactive({
    fire_data %>%
      filter(ArchiveYear >= input$year_s[1] & ArchiveYear <= input$year_s[2]) %>%
      select(Dozers, Engines, Helicopters, PersonnelInvolved, ArchiveYear)%>%
      na.omit()%>%
      group_by(ArchiveYear)%>%
      summarise_all(sum)
  })
  
  output$plot_all <- renderPlotly({
    equip_plot_all <- ggplot(data = c_d_e_year()) +
      geom_line(aes(y = Dozers, x = ArchiveYear, colour = "Dozers")) +
      geom_line(aes(y = Engines, x = ArchiveYear, colour = "Engines")) +
      geom_line(aes(y = Helicopters, x = ArchiveYear, colour = "Helicopters")) +
      labs(x = "Year", y = "Number of Used", title = "Number of Dozers, Engines & Helicopters Used") +
      scale_color_manual(
        name = "Number of",
        values = c("Dozers" = "red", "Engines" = "blue", "Helicopters" = "green")
      )
    equip_plot_all <- ggplotly(equip_plot_all)
    return(equip_plot_all)
  })
  output$plot <- renderPlotly({
    equip_plot <- ggplot(data = c_d_e_year()) +
      geom_line(aes(y = !!as.name(input$equip_type), x = ArchiveYear)) +
      labs(x = "Year", y = "Number Used", title = "Number of Dozers, Engines & Helicopters Used")
    equip_plotly <- ggplotly(equip_plot)
    return(equip_plotly)
  })
}