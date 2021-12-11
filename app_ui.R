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
setBackgroundImage <- function(src = NULL, shinydashboard = FALSE) {
  if (isTRUE(shinydashboard)) {
    el <- ".content-wrapper"
  } else {
    el <- "body"
  }
  css <- paste0(
    el, " {background: url(", src, ") no-repeat center center fixed;
           -webkit-background-size: cover;
           -moz-background-size: cover;
           -o-background-size: cover;
           background-size: cover;}"
  )
  tags$head(tags$style(HTML(css)))
}

intro <- tabPanel(
  mainPanel("Introduction"),
  fluidPage(
    tags$div(
      h2("California Wildfires (2013-2019)"),
      h6("Across the United States, there has been a large increase in the number of natural disasters, and a significant amount of this can be 
        attributed to climate change. Our group decided to investigate wildfires, specifically in California. This dataset offers many interesting
        possibilities, and our group decided to analyze the places affected, the number of structures destroyed, and the equipment used in the containment
        of these wildfires. With this project, we hope to find some general trends for the last few years of Californian fires, and help raise awareness
         of the significance of some of these recent changes.", style = ("font-size:16px")),
      h6("To do our analysis, we use the dataset \"California WildFires (2013-2019)\", which 
         records all Californian wildifire incidents during 2013-2019. These records are sourced directly from the Californian 
         government.", style = ("font-size:16px")),
      h3("In our analysis, we will look into the following variables."),
      p("AcresBurned: Acres of land affected by wildfires", style = ("font-size:16px")),
      p("AirTankers: # of AirTankers used", style = ("font-size:16px")),
      p("ArchiveYear: Year the data was archived", style = ("font-size:16px")),
      p("Dozers: # of Dozers used", style = ("font-size:16px")),
      p("Engines: # of Fire Engines used", style = ("font-size:16px")),
      p("Helicopters: # of Helicopters used", style = ("font-size:16px")),
      p("StructuresDestroyed: # of structures destroyed", style = ("font-size:16px")),
      h3("We will answer these three questions:"),
      p("1. In the last decade or so, how were wildfires distributed geospatially, and how has this distribution changed over time?", style = ("font-size:16px")),
      p("2. What equipment has been used in wildfire containment, and how has this changed over time?", style = ("font-size:16px")),
      p("3. How destructive are these fires, and what are the general trends of this destruction?", style = ("font-size:16px")),
      style = ("background-color: white")
    ),
    setBackgroundImage("fire2.jpg")
  )
)

  
#Summary
summary <- tabPanel(
  mainPanel("Summary"),
  fluidPage(
    tags$div(
      h2("Takeaways"),
      h4("Structures Destroyed and Acres Burned, Answer to Q3"),
      p("By looking at fire damage data, we found a positive relationship between the amount of acres burned by a fire 
        and the amount of structures that fire destroyed. In general, if a wildfire is huger in scale (more acres burned), 
        then more buildings will be destroyed in this incident (more serious destruction). We also found dramatic increases in both the amount of 
        acres burned and structures destroyed, in most wildfire incidents during 2016-2017.", style = "font-size:16px"),
      h4("Dozers Engine, and Helicopter Deployment, Answer to Q2"),
      p("When analyzing this data, we found that Engines were, overall, the most common equipment used to combat the fires.
        In 2013 and 2018, we found two peaks of equipment usage, which means that the number of equipment usage in these two 
        years is much huger than that in other years. One possible reason is that there were 
        more fire incidents in 2013 and 2018. Through checking our map recording wildfire incidents, this reasoning 
        makes sense, because compared with other years, there are more wildfire incidents recorded on the map (major + minor).", style = "font-size:16px"),
      h4("Areas Impacted by Wildfires, Answer to Q1"),
      p("In terms of the areas affected by wildfires, we found that minor wildfires had a sharp increase from 2016-2018. Regarding the major wildfires, 
        we noticed that during recent years, 2016-2018, most major wildfires were located around coastal areas in California. Thus, it would 
        be a good choice for local governments in these areas to invest more in firefighters and extinguishing equipments. 
        In general, from 2015 to 2018, we can see increase of both major and minor wildfire incidents in California, which means that 
        wildfire problem is becoming serious in California during recent years.", style = "font-size:16px"),
      h2("Conclusion"),
      p("In conclusion, our data analysis found a dramatic increase in the number of wildfires in California,
        causing significant damage to the state. This points to the continuing, destructive trends of wilfire, 
        and how important swift action is needed in order to limit this damage. If these trends continue, fire damage will likely only increase,
        leading to economic hardship, damage to the state's natural environment, and even further loss of life.", style = "font-size:16px"),
      style = ("background-color: white")
    )
  )
)  


# Second Page --------------------------------------------------------------
# Includes:

chart1_panel <- tabPanel(
  "Fire Damage Visualization",
  titlePanel(
    fluidPage(
      tags$div(
        p("Fire Damage by Year"),
        style = ("background-color: white")
      )
    )
  ),
  
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("chart1_year", label = h3("Year to Chart"), min = 2013, 
                  max = 2019, value = 2016, step = 1, sep = "")
      
    ),
    
    mainPanel(
      plotlyOutput("chart1")
      
    )
  ),
  
  fluidPage(
    p(),
    tags$div(
      p("In this chart, We visualizes the # of buildings destroyed (y-axis), and 
        the acres burned (x-axis) in each wildfire incident from 2013 to 2019, 
        with a scatter plot. This plot displays the relationship between acres burned (the scale of each wildfire) 
        and buildings destroyed in each wildfire (how destructive each wildfire is), and the increase in total
        damage in the latter half of the decade.", style = "font-size:16px"),
      style = ("background-color: white")
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
  titlePanel(
    fluidPage(
      tags$div(
        p("Equipment Usage In Each Incident"),
        style = ("background-color: white")
      )
    )
  ),
  sidebarLayout(
    plot_sidebar,
    plot_main
  ),
  fluidPage(
    p(),
    tags$div(
      p("In this chart, We visualizes the total number of equipment used to extinguish 
        wildfires (y-axis) in each year (x-axis). There 
        are three types of equipment measured: Dozers, Engines, and 
        Helicopters. This raises interesting questions about changes in fire containment over the years,
        as well as potential economic impact.", style = "font-size:16px"),
      style = ("background-color: white")
    )
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
  titlePanel(
    fluidPage(
      tags$div(
        p("Map of Fire Incidents and their Amount of Acres Burned"),
        style = ("background-color: white")
      )
    )
  ),
  
  # A `sidebarLayout()` that contains...
  sidebarLayout(

    # The `map_sidebar_content`
    map_sidebar_content,
    
    # The `map_main_content`
    map_main_content
  ),
  
  fluidPage(
    p(),
    tags$div(
      p("In this chart, We visualize the geospatial distribution of each wildfire 
        from 2013 to 2019 with a map of California. We display fires with a larger radius of damage 
        with a darker red color. This allows for a broader view on CA wildfires, and raises questions on both their 
        distribution and their change over time.", style = "font-size:16px"),
      p("Note: in this map, you can choose to see \"major\" or \"minor\" wildfire 
        incidents. \"major\" or \"minor\" are types that California government uses 
        to classify wildfires. In genenral, if the # of injuries, Acres Burned, and 
        # of firefights & equipments involved are over a threshold, then this wildfire 
        will be classified as \"major\" incident, vice versa. Unfortunately, California 
        government does not publicize specific values of threshold it chooses.", style = "font-size:16px"),
      style = ("background-color: white")
    )
  )
)

# Fifth Page --------------------------------------------------------------
# Includes:
  # A Conclusion of the project and 3+ takeaways with some visuals/graphics

# Creating UI

ui <- navbarPage("California Wildfire Analysis",
                 intro,
                 chart1_panel,
                 chart2_panel,
                 plot_panel,
                 summary
                 
)

               
