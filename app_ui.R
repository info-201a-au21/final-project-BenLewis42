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
  h2("California Wildfires (2013-2018)"),
  h6("Throughout the US, there has been a large increase in the number of natural disasters, and a lot of this can be 
    attributed to climate change. Our group decided to investigate wildifires, specifically in California. There has been a
    plethora of trends in regards to the California wildfires, however my group decided to analyze the places affected,
    the number of structures destroyed, and the equipment used to treat the wildfires. The purpose of this 
     analyzation is to determine how major of an effect wildfires have had on the state of California.", style = ("font-size:16px")),
    
   h3(" The questions we are seeking to answer are:"),
   p("1. How were the wildfires distributed geospatially? As well as the trends in the number of them each year.", style = ("font-size:16px")),
    p("2. What was the trend in the number of doziers, engines, and helicopters used to fight these wildfires per year?", style = ("font-size:16px")),
    p("3. How has the number of structures destroyed by wildfires changed per year?", style = ("font-size:16px")),
  img(src = "fires.jpg")
  )

  
#Summary
summary <- tabPanel(
  mainPanel("Summary"),
  h2("Takeaways"),
  h4("Structures Destroyed via Wildfires"),
  p("When looking at the data representing the structures destroyed from wildfires, I found that 2018 had the fire 
    that destroyed the most structures, with almost 20 thousand. Additionally, When we looked at the trends each year
    there was a constant increase in the total number of structures destroyed each year from 2013-2018.", style = "font-size:16px"),
  h4("Doziers, Engines, and Helicopters Used per Year"),
  p("When analyzing this data, we found that engines were the most common form of technology used to combat the fires.
    In 2018, the most equipment was used with over 750 engines, 250 doziers, and over 60 helicopters. The important part
    of this analyzation was, similar to the structures, the amount of engines, doziers, and helicopters increased every 
    year from 2013-2018.", style = "font-size:16px"),
  h4("Areas Impacted by Wildfires in California"),
  p("In terms of the areas affected by wildfires, we found that minor wildfires had a sharp increase from 2016-2017, and
    the quantity of these minor wildfires stayed at the same rate for 2017, 2018, and 2019. For the major wildfires, one major trend
    we noticed was the fact that in 2017, most of the major wildfires were located in Southern California,
    while in 2018, most of the major wildfires occured in northern California.", style = "font-size:16px"),
  h4("Conclusion"),
  p("In conclusion, from our data analysis, there has been an increasing number of wildfires in California,
    and with each year, the increasing number of wildfires have had a large negative effect on the infrastructure 
    in California. This points to the continuing trend of climate change, and how if something isn't done soon
    to combat this, wildfire damage to the state of California will only increase. Action needs to be taken soon to 
    limit this ongoing trend before the state of California goes under even more financial stress and loss of 
    natural land.", source = "font-size:16px")
)
    


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
    value = c(2013, 2019)
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
  "Number of Equipments Used Visualization",
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

               
