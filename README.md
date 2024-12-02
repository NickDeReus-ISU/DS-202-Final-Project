Analysis of the Effects of Weather on Mortality in Metropolitan Areas
================

Madhu Avula, Nick DeReus, Jacob Johnson, Brianna Norman

# Rough Draft

## Introduction

The weather has outstanding impacts on the daily lives of individuals,
this project seeks to research the weather’s impact on mortality rates
to better understand the necessity and impact of weather resilience as
well as the potential dangers of ongoing climate change.

We shall endeavor to answer the following questions:

1. Are there seasonal trends in mortality rates? Do different regions experience these impacts differently?
2. How much of an impact does temperature have on mortality? Do different regions experience these impacts differently?
3. Are different age groups affected differently? What age groups are most at risk?
4. Which kinds of weather events have the greatest impacts on mortality? (Extreme heat, cold, ice, flooding)
5. Define which regions are most affected by certain types of weather? (Which most vulnerable to heat waves and extreme cold)
6. Do each of the above trends hold when pnumonia deaths (flu seasons) are removed?

## Data

We had to unite multiple datasets to answer these question, one from the
CDC which contains weekly mortality data for a selection of 122 cities
accessed here:
<https://data.cdc.gov/dataset/Deaths-in-122-U-S-cities-1962-2016-122-Cities-Mort/mr8w-325u/about_data>
. The second dataset, accessed here <https://www.ncdc.noaa.gov/cdo-web/search> contains daily weather summaries from weather
stations from the NOAA, the weather station which best represents
a city from our mortality dataset has to be linked up with their city
and the rest could be dropped.

### Data Values and Structure

#### Deaths in 122 US Cities

- Year -
- WEEK -
- Week Ending Date -
- State -
- City -
- Pneumonia.and.Influenza.Deaths
- All.Deaths -
- \<1 year (all cause deaths) -
- 1-24 years (all cause deaths) -
- 25-44 years (all cause deaths) -
- 45-64 years (all cause deaths) -
- 65+ years (all cause deaths) -

#### NOAA CDO Daily Summaries

This dataset is quite detailed, but we’re mostly interested in three
variables:

1.  TAVG - Average temperature.
2.  TMAX - Maximum Temperature.
3.  TMIN - Minimum Temperature.

- STATION - Identifying weather station code
- NAME - Weather station name
- DATE - Date of summary
- WT03 - Thunder
- WT04 - Ice pellets, sleet, snow pellets, or small hail”
- PRCP - Precipitation
- WT05 - Hail (may include small hail)
- WSFM - Fastest mile wind speed
- WT06 - Glaze or rime
- WT07 - Dust, volcanic ash, blowing dust, blowing sand, or blowing
  obstruction
- WT08 - Smoke or haze
- SNWD - Snow depth
- WT09 - Blowing or drifting snow
- WDF1 - Direction of fastest 1-minute wind
- WDF2 - Direction of fastest 2-minute wind
- WDF5 - Direction of fastest 5-second wind
- WT10 - Tornado, waterspout, or funnel cloud”
- PGTM - Peak gust time
- WT11 - High or damaging winds
- TMAX - Maximum temperature
- WT13 - Mist
- FRGT - Top of frozen ground layer
- WSF2 - Fastest 2-minute wind speed
- FMTM - Time of fastest mile or fastest 1-minute wind
- ACMH - Average cloudiness midnight to midnight from manual
  observations
- WSF5 - Fastest 5-second wind speed
- SNOW - Snowfall
- WDFG - Direction of peak wind gust
- WT14 - Drizzle
- ACSH - Average cloudiness sunrise to sunset from manual observations
- WT15 - Freezing drizzle
- WT16 - Rain (may include freezing rain, drizzle, and freezing
  drizzle)”
- WT17 - Freezing rain
- WT18 - Snow, snow pellets, snow grains, or ice crystals
- WT19 - Unknown source of precipitation
- WSF1 - Fastest 1-minute wind speed
- AWND - Average wind speed
- WT21 - Ground fog
- WSFG - Peak gust wind speed
- WT22 - Ice fog or freezing fog
- WT01 - Fog, ice fog, or freezing fog (may include heavy fog)
- WESD - Water equivalent of snow on the ground
- WT02 - Heavy fog or heaving freezing fog (not always distinguished
  from fog)
- PSUN - Daily percent of possible sunshine for the period
- TAVG - Average Temperature.
- TMIN - Minimum temperature
- WDFM - Fastest mile wind direction
- TSUN - Total sunshine for the period

#### Department of Energy Climate Regions

The US Department of Energy released a map breaking the US into regions at the county level based upon the climate control needs of people in different areas of the nation. Each region is numbered from 1-8, 1 being the hottest and 8 being the coolest. This mapping was selected to help break up the larger dataset by climate region for selection and further comparison.


![alt text](https://github.com/NickDeReus-ISU/DS-202-Final-Project/blob/main/Supporting%20Materials/Climate%20Zones%20Map.jpg)


### Data Preperation

Our multiple datasets had to be combined. Due to constraints with the NOAA data we limited the cities from the 122 in the Mortality dataset to 15 total, 3 from each of the 5 regions from the US Department of Energy map containing the grand majority of the population, regions 2-6.

Region 2
 - Houston, TX
 - Miami, FL
 - Phoenix, AZ
   
Region 3
 - Little Rock, AR
 - Memphis, TN
 - Fresno, CA
   
Region 4
 - Evansville, IN
 - Seattle, WA
 - Wichita, KS
   
Region 5
 - Indianapolis, IN
 - Colorado Springs, CO
 - Boston, MA
   
Region 6
 - Minneapolis, MN
 - Saint Paul, MN
 - Milwaukee, WI
 
These cities then had to be paired up with the weather data, which is tied to specific weather station numbers rather than cities. A table was made up manually containing the information for each city.

| city             | state | station     | region |
|------------------|-------|-------------|--------|
| Houston          | TX    | USW00012918 | 2      |                                                                                        
| Miami            | FL    | USW00012839 | 2      |                                                                                        
| Phoenix          | AZ    | USC00029464 | 2      |
| Little Rock      | AR    | USW00003930 | 3      |                                                                                        
| Memphis          | TN    | USW00013893 | 3      |                                                                                        
| Fresno           | CA    | USW00093193 | 3      |                                                                                        
| Evansville       | IN    | USW00093817 | 4      |                                                                                        
| Seattle          | WA    | USW00024233 | 4      |                                                                                        
| Wichita          | KS    | USW00003928 | 4      |                                                                                        
| Indianapolis     | IN    | USW00093819 | 5      |                                                                                        
| Colorado Springs | CO    | USW00093037 | 5      |                                                                                        
| Boston           | MA    | USW00014739 | 5      |                                                                                        
| Minneapolis      | MN    | USW00014922 | 6      |                                                                                        
| Saint Paul       | MN    | USW00014922 | 6      |                                                                                        
| Milwaukee        | WI    | USW00014839 | 6      |                                                                                        

With that prepared, we clean our data:
```{r}
# Imports:
mortality <- read_csv("Deaths_in_122_U.S._cities_-_1962-2016._122_Cities_Mortality_Reporting_System_20241019.csv")
all_station_weather <- read_csv("Station_weather_data.csv")
City_station_numbers <- read_csv("City_station_numbers.csv")

# Clean the table containing the manually entered city station data which contained empty rows
City_station_numbers <- City_station_numbers %>% drop_na(city)

# Rename columns in the weather dataframe
all_station_weather <- all_station_weather %>% rename_at('city', ~'City')
all_station_weather <- all_station_weather %>% rename_at('state', ~'State')

```
Prepare and aggregate weather data, the weather data is daily while the mortality data is weekly.

```{r}
weather_data_prepped <- all_station_weather %>% mutate( 
  DATE = mdy(DATE),
  Week = week(DATE),
  Month = month(DATE),
  Year = year(DATE),
) %>% 
  group_by(STATION, Year, Week)

TAVG_weekly <- aggregate(TAVG ~ (region+State+City+STATION+Year+Month+Week), weather_data_prepped, mean)
```
We then filter and combine our dataframes

```{r}
# Filter the mortality in 122 cities data by city 
mortality_small <- mortality %>% filter(City %in% City_station_numbers$city)

# Merge all_station_weather with city_station_data, adding city and region information to the weather data.
all_station_weather2 <- merge(all_station_weather, mutate(City_station_numbers, STATION = station), by = 'STATION')

# Mutate mortality data, renaming region and adding detailed date information we can use to filter.
mortality_small <- mortality_small %>% mutate(
  Date = mdy(`Week Ending Date`),
  Week = week(Date),
  Month = month(Date),
  Year = year(Date),
) %>% rename_at('REGION', ~'CDC_Region')
```
Finally combine weather and mortality data

```{r}
wm_combined <- merge(mortality_small, TAVG_weekly)
```



## Results
### Seasonal trends in mortality rates 
#### Regional Differences

### Correlation between temperature and Mortality 
#### Regional Effects

### Differences in effects by age group

### The effect of various weather events on mortality
#### Regional Effects

### Relative Vulnerability to Weather Events by Region

### Controlling for Flu season

## Conclusion

## References
"Deaths in 122 US Cities, 1962-2016", CDC, <https://data.cdc.gov/dataset/Deaths-in-122-U-S-cities-1962-2016-122-Cities-Mort/mr8w-325u/about_data>

Weather station daily summaries, NOAA, <https://www.ncdc.noaa.gov/cdo-web/search>
