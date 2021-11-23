library(tidyverse)

# load dataset
fire <- read.csv("https://raw.githubusercontent.com/info-201a-au21/final-project-BenLewis42/main/data/California_Fire_Incidents.csv?token=AV7PTMEAB4EIVDJFBIYWUFLBUVHEG")

# Q1: From 2013 to 2020, what is the average Acres of land affected by wildfires
# per year? Store this value in `avg_burn`. This avg_burn value will give our
# users an impressive description about how huge the influence caused by wildfire
# is.
total_burn <- fire %>%
  group_by(ArchiveYear) %>%
  summarise(total = sum(AcresBurned, na.rm = TRUE)) %>%
  select(ArchiveYear, total)
avg_burn <- mean(total_burn$total)

# Q2: From 2013 to 2020, which county in California suffers wildfires most
# frequently? Store this value in `county_mfreq`. This county_mfreq can help us
# identify the location influenced most by the wildfire; with the precise location,
# we can do some further analysis about this place, exploring possible reasons
# causing the influence, and possible improvements can be done to lower influence.
county_mfreq <- fire %>%
  group_by(Counties) %>%
  summarise(count_f = n()) %>%
  filter(count_f == max(count_f)) %>%
  pull(Counties)

# Q3: From 2013 to 2020, in which year, California suffers wildfires most
# frequently? Store this value in `year_mfreq`. This year_mfreq can help us
# identify the year influenced most by the wildfire; with this information,
# we can do some further analysis about other data in this year, such as average
# temperature, exploring possible reasons causing more than normal wildfires,
# and possible improvements can be done to eliminate these causes.
year_mfreq <- fire %>%
  group_by(ArchiveYear) %>%
  summarise(count_y = n()) %>%
  filter(count_y == max(count_y)) %>%
  pull(ArchiveYear)

# Q4: From 2013 to 2020, among all wildfire incidents, what is the proportion that
# professional fire-extinguishing machines are used to extinguish wildfire? Calculate
# the proportion for AirTankers and store it in `air_pro`. Calculate the proportion
# for Dozers and store it in `doz_pro`. Calculate the proportion for Engines and 
# store it in `eng_pro`. These proportions are a good indicator, showing whether
# enough resources are used in wildfire extinguishing and preventing. This can
# give our users a deep impressions about whether California state has enough
# resources currently to cope with wildfire incidents and how to improve in the
# future.
total_wild <- nrow(fire)
air_used <- fire %>%
  filter(!is.na(AirTankers))
air_used <- nrow(air_used)
air_pro <- air_used / total_wild

doz_used <- fire %>%
  filter(!is.na(Dozers))
doz_used <- nrow(doz_used)
doz_pro <- doz_used / total_wild

eng_used <- fire %>%
  filter(!is.na(Engines))
eng_used <- nrow(eng_used)
eng_pro <- eng_used / total_wild

# Q5: Compare 2013 and 2019 data, how is the average labor participated in
# extinguishing wildfire changed? Calculate this value by the change of average
# value of `PersonnelInvolved` from 2013 to 2019, and store it in `avg_lchange`.
# This is an important indicator about whether we have enough labors
# (especially firefighters) in California to cope with wildfires, and is this
# situation changed better or worse? This is a very good inpiration for analysis
# in the future and reminding our users how serious the situation is.
labor_2013 <- fire %>%
  group_by(ArchiveYear) %>%
  summarise(avg = mean(PersonnelInvolved, na.rm = TRUE)) %>%
  filter(ArchiveYear == 2013) %>%
  pull(avg)
labor_2019 <- fire %>%
  group_by(ArchiveYear) %>%
  summarise(avg = mean(PersonnelInvolved, na.rm = TRUE)) %>%
  filter(ArchiveYear == 2019) %>%
  pull(avg)
avg_lchange <- (labor_2019 - labor_2013) / labor_2013

# store summary in a list
summary_info <- list()
summary_info$total_burn <- total_burn
summary_info$county_mfreq <- county_mfreq
summary_info$year_mfreq <- year_mfreq
summary_info$air_pro <- air_pro
summary_info$doz_pro <- doz_pro
summary_info$eng_pro <- eng_pro
summary_info$avg_lchange <- avg_lchange