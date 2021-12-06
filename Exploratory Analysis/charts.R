library(dplyr)
library(ggplot2)
library(tidyverse)
library(tibble)
library(ggmap)
library(maps)
library(mapdata)
data <- read.csv("https://raw.githubusercontent.com/info-201a-au21/final-project-BenLewis42/main/data/California_Fire_Incidents.csv?token=AV6OXKPJZSMPTNO32UGHCRTBUVFD2")


# BarGraph about the total number of acres affected by wildfires each year

acres_and_year <- data %>%
  select(AcresBurned, ArchiveYear)%>%
  na.omit()%>%
  group_by(ArchiveYear)%>%
  summarise_all(sum)

gg_bar <- ggplot(acres_and_year, aes(x=ArchiveYear, y=AcresBurned))+
  geom_col()+
  xlab("Year")+
  ylab("Number of Acres Burned") +
  ggtitle("Number of Acres Burned from California Wildfires")


# Line graph of the number of doziers, helicopters, and engines used per year
c_d_e_year <- data %>%
  select(Dozers, Engines, Helicopters, PersonnelInvolved, ArchiveYear)%>%
  na.omit()%>%
  group_by(ArchiveYear)%>%
  summarise_all(sum)



gg_line <- ggplot(c_d_e_year, aes(x=ArchiveYear)) +
  geom_line(aes(y=Dozers, color = "Dozers"))+
  geom_line(aes(y=Engines, color = "Engines"))+
  geom_line(aes(y=Helicopters, color = "Helicopters"))+
  labs(color="Ways of Dealing With Fire")+
  ggtitle("# of Dozers, Engines & Helicopters Used")+
  xlab("Year") +
  ylab("# Used")


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

                                  
   







  
