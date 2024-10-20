Analysis of the Effects of Weather on Mortality in Metropolitan Areas
================

Madhu Avula, Nick DeReus, Jacob Johnson, Brianna Norman

# This document will eventually contain the final report of this project. For now it is a place for thoughts and structuring

## Introduction

The weather has outstanding impacts on the daily lives of individuals,
this project seeks to research the weather’s impact on mortality rates
to better understand the necessity and impact of weather resilience as
well as the potential dangers of ongoing climate change.

We shall endeavor to answer the following questions:

1.  Are there seasonal trends in mortality rates? Do different regions
    experience these impacts differently?

2.  How much of an impact does temperature have on mortality? Do
    different regions experience these impacts differently?

3.  Are different age groups affected differently? What age groups are
    most at risk?

4.  Which kinds of weather events have the greatest impacts on
    mortality? (Extreme heat, cold, ice, flooding)

5.  

## Data

We had to unite multiple datasets to answer these question, one from the
CDC which contains weekly mortality data for a selection of 122 cities
accessed here:
<https://data.cdc.gov/dataset/Deaths-in-122-U-S-cities-1962-2016-122-Cities-Mort/mr8w-325u/about_data>
. The second dataset contains daily weather summaries from weather
stations from all over the US, the weather station which best represents
a city from our mortality dataset has to be linked up with their city
and the rest could be dropped.

### Data Values and Structure

#### Deaths in 122 US Cities

- Year -
- WEEK -
- Week Ending Date -
- State -
- City -
- Pnemeumonia Deaths -
- All Deaths -
- \<1 year (all cause deaths) -
- 1-24 years (all cause deaths) -
- 25-44 years (al lcause deaths) -
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
