library(tidyverse)
library(stringr)
library(tidyr)
library(rvest)
library(dplyr)
library(readxl)


url <- read_html("https://en.wikipedia.org/wiki/FIFA_World_Cup")

World_Cup <- url %>% html_nodes('table') %>%
  .[[4]] %>%
  html_table(header=FALSE, fill=TRUE) %>% slice(-1*1:2)%>%
  select(1:6)%>% magrittr::set_colnames(c("Year","Hosts","Venues/Cities","Totalattendance",
                                          "Matches","Averageattendance")) %>%
  select(Year,Hosts,Matches,Totalattendance,Averageattendance) %>%
  mutate_at( vars(Matches,Totalattendance,Averageattendance), str_remove_all, ',') %>%
  mutate_at( vars(Matches,Totalattendance,Averageattendance), str_remove, '\\[[0-9]+\\]') %>%
  mutate_at( vars(Matches,Totalattendance,Averageattendance), as.numeric) %>% drop_na() %>%
  slice(-n())



usethis::use_data(World_Cup,overwrite = TRUE)
