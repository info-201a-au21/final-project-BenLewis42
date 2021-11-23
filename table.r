library(tidyverse)
library(data.table)
     
# Load dataset
fire <- read.csv("https://raw.githubusercontent.com/info-201a-au21/final-project-BenLewis42/main/data/California_Fire_Incidents.csv?token=AV7PTMEAB4EIVDJFBIYWUFLBUVHEG")

# Select relevant data from dataframe
table_data <- 
  fire %>% 
  group_by(ArchiveYear) %>% 
  summarise(annual_fatalities = sum(Fatalities, na.rm = TRUE)) %>% 
  rename(Year = ArchiveYear, "CA Wildfire Deaths" = annual_fatalities)
            
# Convert data to table
table <- setDT(table_data)
