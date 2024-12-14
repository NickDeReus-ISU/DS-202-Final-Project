library(ggplot2)
library(dplyr)
library(readr)
library(tidyverse)

allData <- read.csv("Data Files/combined_TAVGxMortality_Data.csv")

#Create lists of the cities that I'm making observations on
myStatesList <- c('FL', 'CA', 'KS', 'CO')
myCitiesList <- c('Miami', 'Fresno', 'Wichita', 'Colorado Springs')

ourStatesList <- c('FL', 'CA', 'KS', 'CO', 'TX', 'TN', 'WA', 'IN', 'AZ', 'AR', 'IN', 'MA', 'NY', 'MN', 'WI')
ourCitiesList <- c('Miami', 'Fresno', 'Wichita', 'Colorado Springs', 'Pheonix', 'Little Rock', 'Evansville', 'Boston', 'Houston', 'Memphis', 'Seattle', 'Indianapolis', 'Utica', 'Minneapolis', 'Saint Paul', 'Milwaukee')

#Filter data down to focused cities
myCitiesData <- allData %>%
  filter(State %in% myStatesList) %>% filter(City %in% myCitiesList)
head(myCities)

monthlyDeathsSummed<- myCitiesData %>%
  group_by(Month, Year, City) %>%
  summarise(total = sum(All.Deaths))



ggplot(monthlyDeathsSummed, aes(x=Month, y=total, color=City)) + 
  geom_point() + 
  facet_wrap(~Year, scales="free_x") +
  labs(
    title = "Total Deaths by Month",
    x = "Month",
    y = "Total Deaths"
  )

ourCitiesData <- allData %>%
  filter(State %in% ourStatesList) %>% filter(City %in% ourCitiesList)


monthlyDeathsSummed_All <- ourCitiesData %>%
  group_by(Month, Year, City) %>%
  summarise(total = sum(All.Deaths))

monthlyDeathsAvg_All <- ourCitiesData %>%
  group_by(Month, Year, City) %>%
  summarise(total = sum(All.Deaths)) %>%
  group_by(ourCitiesData$region) %>%
  summarise(averageRegionDeaths = mean(All.Deaths))

ourCitiesData %>%
  group_by(Month, Year, City) %>%
  mutate(ourCitiesData$totalDeathsMonthly <- sum(All.Deaths))

monthlyDeathsAvg_All <- ourCitiesData %>%
  group_by(region) %>%
  summarise(averageRegionDeaths = mean(All.Deaths))

head(ourCitiesData)

#How much of an impact does temperature have on mortality? Do different regions experience these impacts differently?

#The higher end of maximum temperatures during a month generally sees more deaths than the lower end of maximum temperatures, being that the total deaths for our observed cities was below 1e+05 at average maximum temperature of 25, whereas the total deaths was closer to 8e+05 when the average maximum temperature was 85.
##Plot of the mean of the maximum monthly temperature plotted against the total deaths occurring at those temperatures
ggplot(ourCitiesData, aes(x=TMAX_Mean, weight=All.Deaths)) + geom_histogram(bins=15)

#The most deaths occurred during times where the average minimum temperature was between 45 and 60, which is likely the minimum from the days with high maximum temperatures. It is expected that colder regions will see higher mortality counts in lower temperatures when observed outside of the other regions.
##Plot of the mean of the minimum monthly temperature plotted against the total deaths occurring at those temperatures
ggplot(ourCitiesData, aes(x=TMIN_Mean, weight=All.Deaths)) + geom_histogram(bins=15)

#Region 2 sees the highest death counts at maximum temperatures near 90, with death counts sharply increasing as the max temperature approaches that value. This region's mortality rates do not seem as affected by temperatures below 35, likely due to a generally higher climate and not seeing temperatures that low.
#Region 6 confirms the earlier held suspicion of a colder climate holding a higher mortality rate at lower temperatures than that of higher climates. This region has two mortality rate spikes: One where the max temperature approaches 75, and another where it is close to 30. However, the mortality rate seems to be fairly consistent at minimum temperatures between 35 and 60 in region 6
##Plot of the mean of the maximum monthly temperature plotted against the total deaths occurring at those temperatures, grouped by Region
ggplot(ourCitiesData, aes(x=TMAX_Mean, weight=All.Deaths)) + geom_histogram(bins=15) + facet_wrap(~region)
##Plot of the mean of the minimum monthly temperature plotted against the total deaths occurring at those temperatures
ggplot(ourCitiesData, aes(x=TMIN_Mean, weight=All.Deaths)) + geom_histogram(bins=15) + facet_wrap(~region)