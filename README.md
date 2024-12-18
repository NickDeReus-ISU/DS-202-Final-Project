Analysis of the Effects of Weather on Mortality in Metropolitan Areas
================

Madhu Avula, Nick DeReus, Jacob Johnson, Brianna Norman

## Introduction

The weather has outstanding impacts on the daily lives of individuals.
It is common knowledge that extreme heat and cold as well as
precipitation, wind, and storms can be dangerous. We want to take those
into account but also attempt to demonstrate more banal long term
effects of seasons and weather.

This project seeks to research the weather’s impact on mortality rates
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
5.  Define which regions are most affected by certain types of weather?
    (Which most vulnerable to heat waves and extreme cold)
6.  Do each of the above trends hold when pnumonia deaths (flu seasons)
    are removed?

## Data

We had to unite multiple datasets to answer these question, one from the
CDC which contains weekly mortality data for a selection of 122 cities
accessed here:
<https://data.cdc.gov/dataset/Deaths-in-122-U-S-cities-1962-2016-122-Cities-Mort/mr8w-325u/about_data>
. The second dataset, accessed here
<https://www.ncdc.noaa.gov/cdo-web/search> contains daily weather
summaries from weather stations from the NOAA, the weather station which
best represents a city from our mortality dataset has to be linked up
with their city and the rest could be dropped.

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

The US Department of Energy released a map breaking the US into regions
at the county level based upon the climate control needs of people in
different areas of the nation. Each region is numbered from 1-8, 1 being
the hottest and 8 being the coolest. This mapping was selected to help
break up the larger dataset by climate region for selection and further
comparison.

<figure>
<img
src="https://github.com/NickDeReus-ISU/DS-202-Final-Project/blob/main/Supporting%20Materials/Climate%20Zones%20Map.jpg"
alt="alt text" />
<figcaption aria-hidden="true">alt text</figcaption>
</figure>

### Data Preperation

Our multiple datasets had to be combined. Due to constraints with the
NOAA data we limited the cities from the 122 in the Mortality dataset to
15 total, 3 from each of the 5 regions from the US Department of Energy
map containing the grand majority of the population, regions 2-6.

Region 2 - Houston, TX - Miami, FL - Phoenix, AZ

Region 3 - Little Rock, AR - Memphis, TN - Fresno, CA

Region 4 - Evansville, IN - Seattle, WA - Wichita, KS

Region 5 - Indianapolis, IN - Colorado Springs, CO - Boston, MA

Region 6 - Minneapolis, MN - Saint Paul, MN - Milwaukee, WI

These cities then had to be paired up with the weather data, which is
tied to specific weather station numbers rather than cities. A table was
made up manually containing the information for each city.

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

    # Imports:
    mortality <- read_csv("Deaths_in_122_U.S._cities_-_1962-2016._122_Cities_Mortality_Reporting_System_20241019.csv")
    all_station_weather <- read_csv("Station_weather_data.csv")
    City_station_numbers <- read_csv("City_station_numbers.csv")

    # Clean the table containing the manually entered city station data which contained empty rows
    City_station_numbers <- City_station_numbers %>% drop_na(city)

    # Rename columns in the weather dataframe
    all_station_weather <- all_station_weather %>% rename_at('city', ~'City')
    all_station_weather <- all_station_weather %>% rename_at('state', ~'State')

Prepare and aggregate weather data, the weather data is daily while the
mortality data is weekly.

    # Expand Date Data
    weather_data_prepped <- all_station_weather2 %>% 
     
      mutate( 
        DATE = mdy(DATE),
        Week = week(DATE),
        Month = month(DATE),
        Year = year(DATE),
    ) %>% 
      
      group_by(STATION, Year, Week)

    # Select Values to be Aggregated
    TAVG_weekly <- weather_data_prepped %>% 
      
      group_by(region, State, City, STATION, Year, Month, Week) %>%
      
      summarize(
        TAVG = mean(TAVG),
        TMAX_Max = max(TMAX),
        TMAX_Mean = mean(TMAX),
        TMIN_Min = min(TMIN),
        TMIN_Mean = mean(TMIN),
        TSUN = mean(TSUN),
        WSFG_Max = max(WSFG),
        WSFG_Mean = mean(WSFG),
        AWND = mean(AWND),
        PRCP_Mean = mean(PRCP),
        PRCP_Sum = sum(PRCP),
        PRCP_Max = max(PRCP),
        SNOW_Mean = mean(SNOW),
        SNOW_Sum = sum(SNOW),
        SNWD_Mean = mean(SNWD),
        SNWD_Max = mean(SNWD),
      )

We then filter and combine our dataframes

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

Finally combine weather and mortality data

    wm_combined <- merge(mortality_small, TAVG_weekly)

### Final Data Shape

### Normalizing Data

There are many circumstances where we must normalize our data because
each city in our data set has a different population and different base
mortality levels. In order to make them directly comparable we typically
find the mean death count for each city for the periods in question then
we find changes in mortality as a % change from that mean per city in
the periods being studied. In the resulting figures, the mean value
appears as 0 and any changes as a percent anomaly from 0.

It isn’t a perfect model, but it allows us to demonstrate the relative
impact of various factors on the mortality rates of each of our cities
and compare them.

## Results

### Basic Observations of from the Dataset

First we explore the general conditions present in our data set, the
annual temperature over time as well as seasonal patterns.

#### Average Annual Temperature Over Time

We find that the locations in our data set have seen a progressive
increase in average temperatures over the time since the beginning of
the time period in 1962. We can’t necessarily use this as evidence to
support global warming because these locations are all likely subject to
strong Heat Island effects, but the experience of people living in these
locations is one of increasing average temperature.

While we have data on temperature highs and lows, we focus on mean
temperatures because it gives us a more complete look at conditions than
either the high or low over the course of a week, which is the length of
each of the recorded events in our mortality data set.

![](README_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

When charted by region, we can see that the increase in average
temperatures is felt across all climate regions, but is most obvious in
Region 6, which is the coolest region.

    ## `summarise()` has grouped output by 'region'. You can override using the
    ## `.groups` argument.

![](README_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

#### Seasonality of Temperature

Our data set as a whole saw strong seasonal temperature swings, from an
average of about 37 degrees Fahrenheit in January to an average of 78 in
July.

![](README_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->

When we explore seasons regionally, we find that region 2 is the warmest
year round, but summer temperatures are remarkably similar in all 6
regions, sitting between 73 and 82 degrees in July while winters see a
range from 60 in region 2 and 28 in region 6 in January.

    ## `summarise()` has grouped output by 'region'. You can override using the
    ## `.groups` argument.

![](README_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

#### Distribution of Daily Average Temperatures

![](README_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

### Seasonal trends in mortality rates

After normalizing death counts across our regions we find that death
rates across our sample set are significantly higher on average during
the winter season and lower in summer and fall months.

![](README_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

When we break down the data regionally we can see that colder regions
have more highly seasonal effects on mortality, but even very warm
regions still suffer higher mortality in the winter months.

We hypothesize that there are behavioral factors behind the increased
winter mortality, but we aren’t able to explore that here. At the very
least we can assume that weather cannot be the only, or even the most
major, factor behind these findings.

![](README_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->

### Correlation between temperature and Mortality

The most deaths occurred during times where the average minimum
temperature was between 45 and 60, which is likely the minimum from the
days with high maximum temperatures. It is expected that colder regions
will see higher mortality counts in lower temperatures when observed
outside of the other regions. \#### Plot of the mean of the minimum
monthly temperature plotted against the total deaths occurring at those
temperatures

    ## Warning: Removed 145 rows containing non-finite outside the scale range
    ## (`stat_bin()`).

![](README_files/figure-gfm/unnamed-chunk-11-1.png)<!-- --> Region 2
sees the highest death counts at maximum temperatures near 90, with
death counts sharply increasing as the max temperature approaches that
value. This region’s mortality rates do not seem as affected by
temperatures below 35, likely due to a generally higher climate and not
seeing temperatures that low. Region 6 confirms the earlier held
suspicion of a colder climate holding a higher mortality rate at lower
temperatures than that of higher climates. This region has two mortality
rate spikes: One where the max temperature approaches 75, and another
where it is close to 30. However, the mortality rate seems to be fairly
consistent at minimum temperatures between 35 and 60 in region 6

    ## Warning: Removed 138 rows containing non-finite outside the scale range
    ## (`stat_bin()`).

![](README_files/figure-gfm/unnamed-chunk-12-1.png)<!-- --> Plot of the
mean of the maximum monthly temperature plotted against the total deaths
occurring at those temperatures, grouped by Region

    ## Warning: Removed 142 rows containing non-finite outside the scale range
    ## (`stat_bin()`).

![](README_files/figure-gfm/unnamed-chunk-13-1.png)<!-- --> Plot of the
mean of the minimum monthly temperature plotted against the total deaths
occurring at those temperatures

### Differences in effects by age group

- **Key Findings**:
  - The **65+ years** age group accounts for the highest percentage of
    total deaths, contributing over 60% of mortality.
  - The **45–64 years** age group is the second most affected, with a
    significant but smaller share.
  - Younger age groups, including **\<1 year**, **1–24 years**, and
    **25–44 years**, have considerably lower mortality percentages.
- **Conclusion**:
  - Older adults (**65+ years**) are the most vulnerable group,
    indicating a need for targeted health interventions.
  - The **45–64 years** group also requires attention, but with lower
    priority compared to seniors.

![](README_files/figure-gfm/unnamed-chunk-14-1.png)<!-- -->

### Effects of Seasonality by Age Group

For this section we normalize the data by breaking it up by city and age
group, finding the mean mortality rate of each age group in each city
and then finding the average deviation from that mean as a proportion.
In this way we can demonstrate the differences in strength of seasonal
signals on the mortality in each age group.

We show that older age groups are the more highly impacted by seasonal
signals, seeing greatly increased mortality rates in the winter compared
to the summer months. This increase in mortality could be due to cold
weather stressing the body, accidents related to winter weather,
seasonal respiratory illness, reduced sunlight and increased sedentary
and indoor living, or other changes in seasonal behavior. Later on, we
explore the effects of extreme heat and cold on mortality.

Interestingly, young people between the ages of 1 and 24 see the
opposite trend as all older age groups. Their greatest mortality rates
occur during the three summer months, which correlates well with school
scheduling. We hypothesize that this increase is due mostly due to
accidents while student age people are out of school and unsupervised,
but that is beyond the scope of this paper.

We would also like to point out that in the regional breakdown, this
increase in mortality for young people is much weaker in region 2 than
the others.

    ## Warning: Using an external vector in selections was deprecated in tidyselect 1.1.0.
    ## ℹ Please use `all_of()` or `any_of()` instead.
    ##   # Was:
    ##   data %>% select(age_groups)
    ## 
    ##   # Now:
    ##   data %>% select(all_of(age_groups))
    ## 
    ## See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
    ## This warning is displayed once every 8 hours.
    ## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
    ## generated.

![](README_files/figure-gfm/unnamed-chunk-15-1.png)<!-- -->
![](README_files/figure-gfm/unnamed-chunk-16-1.png)<!-- -->

### Effects of Extreme Weather Events

    ## `summarise()` has grouped output by 'region', 'City'. You can override using
    ## the `.groups` argument.
    ## `summarise()` has grouped output by 'region'. You can override using the
    ## `.groups` argument.

    ## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
    ## ℹ Please use `linewidth` instead.
    ## This warning is displayed once every 8 hours.
    ## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
    ## generated.

![](README_files/figure-gfm/unnamed-chunk-18-1.png)<!-- -->

    ## `summarise()` has grouped output by 'region'. You can override using the
    ## `.groups` argument.

![](README_files/figure-gfm/unnamed-chunk-18-2.png)<!-- -->

    ## `summarise()` has grouped output by 'region'. You can override using the
    ## `.groups` argument.

![](README_files/figure-gfm/unnamed-chunk-18-3.png)<!-- -->

#### Heat Waves and Extreme Cold Events

For this section we compare the impact of individual events against the
average (expected) morality for the time of the event. To do this we
group all events by city and week, find the mean mortality across the
years of the data set for each week. Then we define heat wave and
extreme cold conditions, weeks with an Average Temperature at or above
85 degrees and weeks with an average temperature at or below 20 degrees
and tag such events. We then find the deviation from the mean as a
proportion for each such event by city. The figures below are the means
of these deviations.

We show that despite increased general mortality in the winter and
reduced general mortality in the summer, that Heat Waves are strongly
associated with an increase from mean mortality while extreme cold is
associated with a decrease.
![](README_files/figure-gfm/unnamed-chunk-19-1.png)<!-- -->

![](README_files/figure-gfm/unnamed-chunk-20-1.png)<!-- -->

- **Key Findings**:
  - **Heat Waves** are associated with a 3.45% increase in mortality
    average
  - In total **Extreme Cold** average deaths is lower by around **22%**
    difference
  - The cities in **Region 2** have no extreme cold events
  - The cities in **Region 6** have no extreme heat events

### The Impact of Flu Season

    ## Warning: Returning more (or less) than 1 row per `summarise()` group was deprecated in
    ## dplyr 1.1.0.
    ## ℹ Please use `reframe()` instead.
    ## ℹ When switching from `summarise()` to `reframe()`, remember that `reframe()`
    ##   always returns an ungrouped data frame and adjust accordingly.
    ## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
    ## generated.

    ## `summarise()` has grouped output by 'region', 'City', 'Month'. You can override
    ## using the `.groups` argument.

![](README_files/figure-gfm/unnamed-chunk-21-1.png)<!-- -->

    ## Warning: Returning more (or less) than 1 row per `summarise()` group was deprecated in
    ## dplyr 1.1.0.
    ## ℹ Please use `reframe()` instead.
    ## ℹ When switching from `summarise()` to `reframe()`, remember that `reframe()`
    ##   always returns an ungrouped data frame and adjust accordingly.
    ## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
    ## generated.

    ## `summarise()` has grouped output by 'region', 'City', 'Month'. You can override
    ## using the `.groups` argument.
    ## `summarise()` has grouped output by 'region'. You can override using the
    ## `.groups` argument.

![](README_files/figure-gfm/unnamed-chunk-22-1.png)<!-- -->
![](README_files/figure-gfm/unnamed-chunk-23-1.png)<!-- -->

- **Key Findings**:
  - The total number of deaths ranges from **400,000-350,000** deaths a
    month
  - The total number of pneumonia & influenza deaths range from
    **30,000-16,000**
  - Controling for flu season doesn’t significantly alter the
    seasonality of mortality.
- **Conclusion for \#6**:
  - The amount of pneumonia & influenza deaths varies between age groups
    but the overall variation between the two charts is minimal and
    still shows similar seasonal trends.

## Conclusions

Our findings support the idea that weather and seasons have a
significant impact on general mortality, with mortality rates trending
higher in the winter and lower in the summer for most age groups and
correlating well with temperature. However, we found that the warmest
areas in our data set experienced similar seasonal trends as colder
regions so much of the seasonal signal may be strictly due to changes in
human activities throughout the year. It should be stated that many of
these changes in activity are or were themselves informed by the
weather.

When investigating extreme weather events, we found that heat waves were
associated with higher than average mortality while extreme cold was
associated with lower than average mortality, which suggests that while
winter weather is generally stressful for the population, more extreme
cold by itself does not currently contribute to increasing mortality,
possibly because people tend to take reasonable steps to protect
themselves during cold events. On the other hand, while summer heat is
associated with lower levels of general mortality, extreme heat was
associated with above average mortality.

We also found that pneumonia and respiratory illness does not have a
large impact on the seasonality of deaths, despite making up a notable
proportion of all deaths.

## References

“Deaths in 122 US Cities, 1962-2016”, CDC,
<https://data.cdc.gov/dataset/Deaths-in-122-U-S-cities-1962-2016-122-Cities-Mort/mr8w-325u/about_data>

Weather station daily summaries, NOAA,
<https://www.ncdc.noaa.gov/cdo-web/search>
