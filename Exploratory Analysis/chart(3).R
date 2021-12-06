# !!!This chart is exactly the same as the third chart in "charts.R".

library(dplyr)
library(ggplot2)
library(tidyverse)
library(tibble)
library(ggmap)
library(maps)
library(mapdata)
data <- read.csv("https://raw.githubusercontent.com/info-201a-au21/final-project-BenLewis42/main/data/California_Fire_Incidents.csv?token=AV6OXKPJZSMPTNO32UGHCRTBUVFD2")


# map of the wildfires that occured in California in the data set.


fires_location <- data %>%
  select(Latitude, Longitude)

fires_location <- subset(fires_location, Longitude < 0 & Latitude < 42.5 & Latitude > 30)

states <- map_data("state")
ca_df <- subset(states, region == "california")
gg_ca <- ggplot(data = ca_df, mapping = aes(x = long, y = lat)) + 
  coord_fixed(1.3) + 
  geom_polygon(color = "black", fill = "gray") +
  geom_point(data = fires_location, aes(x = Longitude, y = Latitude))+
  ggtitle("Map of California Wildfires (2013-2019)")











