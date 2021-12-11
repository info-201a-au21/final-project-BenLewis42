# Overview -----------------------------------------------------------------
# Final Deliverable
# Creating an UI

# Load packages and source--------------------------------------------------

library(shiny)
library(leaflet)
library(plotly)

# First Page ---------------------------------------------------------------
# Includes:
  # An Introduction of the project and dataset as well as some visuals
intro <- tabPanel(
  mainPanel("Introduction"),
  h2("California Wildfires (2013-2019)"),
  h6("Across the United States, there has been a large increase in the number of natural disasters, and a significant amount of this can be 
    attributed to climate change. Our group decided to investigate wildfires, specifically in California. This dataset offers many interesting
    possibilities, and our group decided to analyze the places affected, the number of structures destroyed, and the equipment used in the containment
    of these wildfires. With this project, we hope to find some general trends for the last few years of Californian fires, and help raise awareness
     of the significance of some of these recent changes.", style = ("font-size:16px")),
    
   h3("We will answer these three questions:"),
   p("1. In the last decade or so, how were wildfires distributed geospatially, and how has this distribution changed over time?", style = ("font-size:16px")),
    p("2. What equipment has been used in wildfire containment, and how has this changed over time?", style = ("font-size:16px")),
    p("3. How destructive are these fires, and what are the general trends of this destruction?", style = ("font-size:16px")),
  img(src = "fires.jpg")
  )

  
#Summary
summary <- tabPanel(
  mainPanel("Summary"),
  h2("Takeaways"),
  h4("Structures Destroyed and Acres Burned"),
  p("By looking at fire damage data, we found a positive relationship between the amount of acres burned by a fire 
    and the amount of structures that fire destroyed. We also found dramatic increases in both the total amount of 
    acres burned and structures destroyed from 2013 to 2018, with a decrease in 2019. In general, 2017 and 2018 had 
    amuch greater destruction by wildfires than any other years.", style = "font-size:16px"),
  h4("Dozers Engine, and Helicopter Deployment"),
  p("When analyzing this data, we found that engines were, overall, the most common equipment used to combat the fires.
    In 2018 the most equipment was used, with over 750 engines, 250 dozers, and 60 helicopters being deployed. Our primary finding was that, 
    similar to the trends in fire destruction, equipment use significant increased from 2014 to 2018, peaking in 2018", style = "font-size:16px"),
  h4("Areas Impacted by Wildfires"),
  p("In terms of the areas affected by wildfires, we found that minor wildfires had a sharp increase from 2016-2017, and
    the quantity of these minor wildfires stayed at the same rate for 2017, 2018, and 2019. Regarding the major wildfires, 
    we noticed that in 2017, most were located in Southern California,
    while in 2018, most of the major wildfires occured in Northern California.", style = "font-size:16px"),
  h2("Conclusion"),
  p("In conclusion, our data analysis found a dramatic increase in the number of wildfires in California,
    causing significant damage to the state. This points to the continuing, destructive trends of climate change, 
    and how important swift action is needed in order to limit this damage. If these trends continue, fire damage will likely only increase,
    leading to economic hardship, damage to the state's natural environment, and even further loss of life.", source = "font-size:20px")
)
    


# Second Page --------------------------------------------------------------
# Includes:

chart1_panel <- tabPanel(
  "Fire Damage Visualization",
  titlePanel("Fire Damage by Year"),
  
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("chart1_year", label = h3("Year to Chart"), min = 2013, 
                  max = 2019, value = 2016, step = 1, sep = "")
      
    ),
    
    mainPanel(
      plotlyOutput("chart1")
      
    )
  )
)


# Third Page --------------------------------------------------------------
# Includes:

plot_sidebar <- sidebarPanel(
  selectInput(
    inputId = "equip_type",
    label = "Equipment Type",
    choices = list("All",
                   "Dozers" = "Dozers",
                   "Engines" = "Engines",
                   "Helicopters" = "Helicopters"),
    selected = "All"
  ),
  sliderInput(
    inputId = "year_s",
    label = "Year",
    min = 2013,
    max = 2019,
    value = c(2013, 2019),
    sep = ""
  )
)


plot_main <- mainPanel(
  conditionalPanel(
    condition = "input.equip_type == 'All'",
    plotlyOutput(outputId = "plot_all")
  ),
  conditionalPanel(
    condition = "input.equip_type != 'All'",
    plotlyOutput(outputId = "plot")
  )
)

chart2_panel <- tabPanel(
  "Equipment Usage Visualization",
  sidebarLayout(
    plot_sidebar,
    plot_main
  )
)








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

ui <- navbarPage("",
                 intro,
                 chart1_panel,
                 chart2_panel,
                 plot_panel,
                 summary
                 
)

               
