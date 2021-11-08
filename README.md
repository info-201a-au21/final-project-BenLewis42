# Final Project: Investigate Wildfire In West US
## Domain of interest
1. **Interested field and reason**
   <br> **Answer:** 
   <br> The field we are investigating is wildfires in the western United States. We are interested in this domain because nowadays increasing wildfires are strongly associated with climate change, which is a large threat to our environment and our own health. The high frequency and magnitude of wildfires near Washington are much of a concern to us and so, we would like to learn more about the currently existing trends related to wildfires that may be linked to the climate change crisis.
2. **Examples of related data analysis project**
   <br> **Answer:**
   - [Projects - Climate Adaptation Science Centers (cascprojects.org)](https://cascprojects.org/#/project/4f8c64d2e4b0546c0c397b46/5956a1b5e4b0d1f9f050d917)
     <br> Description: A project conducted by our fellow University of Washington researchers on the effects of climate change on wildfire patterns in Washington. The project released an interactive story map, detailing the correlations with increasing climate change attributes and increasing wildfires.
   - [Impact of anthropogenic climate change on wildfire across western US forests | PNAS](https://www.pnas.org/content/113/42/11770)
     <br> Description: This data study investigates how human-driven actions enhance western US wildfires through increasing climate change. Utilizing ecological metrics that enable more wildfires, researchers established that humans are responsible for impacting these metrics.
   - [Climate Change Indicators: Wildfires | US EPA](https://www.epa.gov/climate-indicators/climate-change-indicators-wildfires)
     <br> The EPA released this project using data from National Interagency Fire Center and the MTBS multi-agency project to create informative visualizations about the extent and magnitude of wildfires across the United States over the last 3 decades.
3. **Data driven questions**
   <br> **Answer:**
   - What are 15 counties influenced most by the wildfire? Answer this by visualizing the number of wildfires happened in counties.
   - How is the Acres Burned Data distributed each year? How is the distribution changed over years? Visualize the distribution the skewness of data through box plots.
   - How are wildfires distributed geospatially? Make an interactive map including this geospatial data to help our users better understand the distribution of each wildfire.
   - How much has the frequency and magnitude of wildfires increased over the last decade?
   - What effect do higher temperatures have on the characteristics of wildfires?
   - What locations in the western United States are more susceptible to wildfires?
   - How destructive are wildfires over time and in particular regions?
   - How has the economic burden of wildfire risen over the years?


## Dataset for research
1. [**California Fire Incidents**](https://www.kaggle.com/ananthu017/california-wildfire-incidents-20132020)
   - **description:** For each wildfire incident, there is a canonical url from the CA government storing the detailed information about this incident. The author of this dataset, “ARES”, collected each incident information by the url, and summarized them into this dataset. This dataset contains information about each wildfire happened from 2013 to 2020 in California. For each wildfire, it provides information such as “how many Acres are burned” (AcresBured), “when is this incident happened” (ArchiveYear), and “geospatial data of each incident” (Longitude & Latitude).
   - **number of rows:** 1636
   - **number of columns:** 40
   - **Question(s) to answer:**
     - What are 15 counties influenced most by the wildfire? Answer this by visualizing the number of wildfires happened in counties.
     - How is the Acres Burned Data distributed each year? How is the distribution changed over years? Visualize the distribution the skewness of data through box plots.
     - How are wildfires distributed geospatially? Make an interactive map including this geospatial data to help our users better understand the distribution of each wildfire.

2. [**Climate Change: Earth Surface Temperature Data**](https://www.kaggle.com/berkeleyearth/climate-change-earth-surface-temperature-data)
   - **description:** The data has been compiled by climate science non-profit Berkeley earth from a variety of temperature archives. The temperatures were primarily collected from historical reports and digital thermometer data.
   - **number of rows:** 577,462
   - **number of columns:** 4
   - **Question(s) to answer:**
    <br> The dataset can be used to see change in temperature over time, both globally and in specific countries. We can also compare different countries and areas, and make future predictions.

3. [**USA Total Wildfires, Acres Affects & Suppression Costs**](https://www.kaggle.com/kkhandekar/total-wildfires-acres-affected-1983-2020)
   - **description:** The data was collected by the Federal Wildfires Agencies. The data starts being collected in 1983, as that was when they started keeping track on the official data of wildfires. The data is about the aces affected and the total cost that wildfires incurred.
   - **number of rows:** 25
   - **number of columns:** 5
   - **Question(s) to answer:**
    <br> This data can be used to answer questions about the total cost of the wildfires, the trend of the costs on a per year basis, and the trends of how many acres are affected on a per year basis.