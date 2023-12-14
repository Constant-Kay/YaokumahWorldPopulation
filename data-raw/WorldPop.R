library(tidyverse)
library(ggplot2)
library(stringr)
library(tidyr)
library(rvest)
library(dplyr)
library(readxl)



ESTIMATES_data1 <- read_excel( 'data-raw/World_Population.xlsx', sheet="ESTIMATES", skip = 16)%>%
  select('Region, subregion, country or area *',matches("^\\d{4}")) %>%
  rename("Country_Name" = "Region, subregion, country or area *") %>% slice(-(1:26))


names_to_remove <- c("Middle Africa","Southern Africa","Western Africa",
                     "NORTHERN AFRICA AND WESTERN ASIA","Northern Africa","Western Asia",
                     "CENTRAL AND SOUTHERN ASIA","Central Asia","Southern Asia",
                     "EASTERN AND SOUTH-EASTERN ASIA","Eastern Asia","South-Eastern Asia",
                     "LATIN AMERICA AND THE CARIBBEAN","Caribbean","Central America",
                     "South America","AUSTRALIA/NEW ZEALAND",
                     "OCEANIA (EXCLUDING AUSTRALIA AND NEW ZEALAND)",
                     "Melanesia","Micronesia","Polynesia",
                     "EUROPE AND NORTHERN AMERICA","EUROPE","Eastern Europe",
                     "Northern Europe","Southern Europe","Western Europe","NORTHERN AMERICA")

WorldPopulation <- ESTIMATES_data1[!(ESTIMATES_data1$`Country_Name` %in%
                                       names_to_remove),] %>%
  drop_na()

countries <- WorldPopulation$Country_Name

selected_countries <- WorldPopulation %>%
  filter(`Country_Name` %in% countries)

WorldPopulation <- selected_countries %>%
  pivot_longer(
    `1950`:`2020`,
    names_to  = 'Years',
    values_to = 'Populations')



WorldPopulation <- WorldPopulation %>% mutate(Year = as.integer(Years),
                                              Population = as.numeric(Populations)) %>%
  select(Country_Name,Year,Population) %>%
  pivot_wider( names_from=Year, values_from=Population ) %>% as.tibble()



usethis::use_data(WorldPopulation,overwrite = TRUE)


