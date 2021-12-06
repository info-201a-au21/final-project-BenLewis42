# !!!This chart is exactly the same as the second chart in "charts.R".

library(dplyr)
library(ggplot2)
library(tidyverse)
library(tibble)
library(ggmap)
library(maps)
library(mapdata)
data <- read.csv("https://raw.githubusercontent.com/info-201a-au21/final-project-BenLewis42/main/data/California_Fire_Incidents.csv?token=AV6OXKPJZSMPTNO32UGHCRTBUVFD2")


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








