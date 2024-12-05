library(ggplot2)
library(dplyr)
library(readr)
library(tidyverse)

allData <- read.csv("Data Files/combined_TAVGxMortality_Data.csv")
head(allData)

#Create lists of the cities that I'm making observations on
myStatesList <- c('FL', 'CA', 'KS', 'CO')
myCitiesList <- c('Miami', 'Fresno', 'Wichita', 'Colorado Springs')

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

#Deaths seem to be higher on average in the Winter Months
#Theory: Higher deaths in colder climates in winter, higher in warmer in summer. TODO


myCitiesData %>% mutate(Month=month(Week.Ending.Date,label = T),Year=year(Week.Ending.Date)) %>% group_by(Year,Month) %>% summarise(All.Deaths=sum(All.Deaths,na.rm=T))
?month

ggplot(myCitiesData, aes(x=Month, y=All.Deaths)) + geom_point() + facet_wrap(~Year, scales="free_x")