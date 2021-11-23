library(tidyverse)
library(data.table)
     
# Load dataset
fire <- read.csv("https://raw.githubusercontent.com/info-201a-au21/final-project-BenLewis42/main/data/California_Fire_Incidents.csv?token=AV7PTMEAB4EIVDJFBIYWUFLBUVHEG")

# Select relevant data from dataframe
table_data <- 
  fire %>% 
  group_by(ArchiveYear) %>% 
  summarise(annual_fatalities = sum(Fatalities, na.rm = TRUE)) %>% 
  arrange(ArchiveYear) %>%
  rename(Year = ArchiveYear, "CA Wildfire Deaths" = annual_fatalities)
            
# Convert data to table
table <- setDT(table_data)

# The table displays total casualties due to wildfire in California, ordered by
# year. This table serves to display the real human cost of these fires, and
# climate change as a whole.
# The table shows a sharp increase in deaths beginning in 2017, peaking in 2018,
# and decreasing in 2019.