# Overview -----------------------------------------------------------------
# Final Deliverable
# Creating an UI

# Load packages and source--------------------------------------------------

library(shiny)
library(leaflet)

# First Page ---------------------------------------------------------------
# Includes:
  # An Introduction of the project and dataset as well as some visuals

# Second Page --------------------------------------------------------------
# Includes:

chart1_panel <- tabPanel(
  "Chart 1",
  titlePanel("Fire Damage by Year"),
  
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("chart1_year", label = h3("Year to Chart"), min = 2013, 
                  max = 2019, value = 2016, step = 1, sep = "")
      
    ),
    
    mainPanel(
      p("Display here")
      
    )
  )
)







# Third Page --------------------------------------------------------------
# Includes:
  # A ?? plot










# Fourth Page --------------------------------------------------------------

# Defines a variable `map_sidebar_content` that is a `sidebarPanel()` for the
# 4th page that contains:
  # Widget 1: Selection if the fire was a major or minor incident
  # Widget 2: Slider for the year

map_sidebar_content <- sidebarPanel(
  # First Widget
  selectInput(
    "selectvar", label = h3("Type of Incidents to Display"),
    choices = c("Major" = "True", "Minor" = "False")
  ),

  # Second Widget
  sliderInput("yearvar", label = h3("Year to Map"), min = 2013, 
              max = 2019, value = 2016, step = 1, sep = "")
)

# Defines a variable `map_main_content` that is a `mainPanel()` for the
# 4th page that contains the `leafletOutput()` of the map

map_main_content <- mainPanel(leafletOutput("map"))

# Creates a variable `map_panel` that stores a `tabPanel()` for the map page

plot_panel <- tabPanel(
  "Map",
  titlePanel("Map of Fire Incidents and their Amount of Acres Burned"),
  
  # A `sidebarLayout()` that contains...
  sidebarLayout(

    # The `map_sidebar_content`
    map_sidebar_content,
    
    # The `map_main_content`
    map_main_content
  )
)

# Fifth Page --------------------------------------------------------------
# Includes:
  # A Conclusion of the project and 3+ takeaways with some visuals/graphics

# Creating UI

ui <- navbarPage("Final", 
                 chart1_panel,
                 plot_panel
                 
)
               