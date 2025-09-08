library(countrycode)
library(tidyverse)
library(here)

# specify directory
i_am("code/GlobalGratitude_CrossCulturalMods.R")

# main data country_code
DF_main <- 
  readRDS(file = here("data/final-data", 
                      "GlobalGratitude_Final_Cleaned.Rds"))

DF_main <- DF_main %>%
  mutate(
    country_code = str_sub(lab, 1, 3)) %>%
  filter(!is.na(country_code))

sampled <- unique(DF_main$country_code)

#relational mobility
DF_relation <- read.csv(file = here("data/cross-cultural", 
                                    "GlobalGratitude_RelationalMobility.csv"))
DF_relation <- DF_relation %>%
  rename("country_name" = "COUNTRY") %>% 
  rename("relational_mobility" = "RMOBLM") %>% 
  mutate(country_name = ifelse(country_name == "USA", 
                               "United States", 
                               country_name)) %>% 
  mutate(country_code = countrycode(country_name, 
                                    origin = "country.name", 
                                    destination = "iso3c")) %>% 
  select(country_code, country_name, 
         relational_mobility) 
  
#responsibilism
DF_respon <- read.csv(file = here("data/cross-cultural", 
                                  "GlobalGratitude_Responsibilism.csv"))
DF_respon <- DF_respon %>% 
  rename("country_name" = "Culture") %>% 
  rename("responsibilism" = "Responsibilism") %>%
  select(country_name:responsibilism) %>% 
  filter(country_name != "", 
         country_name != "Total") %>% 
  mutate(country_code = countrycode(country_name, 
                                    origin = "country.name", 
                                    destination = "iso3c")) %>% 
  mutate(country_name = ifelse(country_name == "UK", 
                               "United Kingdom", 
                               country_name))  %>% 
  mutate(country_name = ifelse(country_name == "Macedonia", 
                               "North Macedonia", 
                               country_name)) 

#GDP
DF_GDP <- read.csv(file = here("data/cross-cultural", 
                               "GlobalGratitude_GDPpc.csv"))

DF_GDP <- DF_GDP %>%
  rename("country_code" = "Country.Code") %>%
  select(country_code, X2011:X2020) %>%
  mutate(country_name = countrycode(country_code, 
                                    origin = "iso3c", 
                                    destination = "country.name")) %>% 
  mutate(mean_GDP = rowMeans(select(., X2011:X2020), 
                             na.rm = TRUE)) %>%
  select(country_code, country_name, mean_GDP)

DF_GDP <- DF_GDP %>%
  filter(country_name != "NA")

#tightness-looseness
DF_tight <- read.csv(file = here("data/cross-cultural", 
                                 "GlobalGratitude_Tightness.csv")) %>%
  rename(country_name = Country) %>%
  mutate(country_code = countrycode(country_name, 
                                    origin = 'country.name', 
                                    destination = 'iso3c')) %>% 
  select(tightness = Tightness, 
         country_code,
         country_name)

#hofstede
DF_indcol <- read.csv(file = here("data/cross-cultural", 
                                  "GlobalGratitude_Hofstede_ResMobility.csv"))
DF_indcol <- DF_indcol %>%
  mutate(country_code = countrycode(Matched, 
                                    origin = 'country.name', 
                                    destination = 'iso3c')) %>%
  mutate(country_name = countrycode(country_code, 
                                    origin = "iso3c", 
                                    destination = "country.name")) %>%
  select(resmobility:country_name)

#religiosity
DF_relig <- read.csv(file = here("data/cross-cultural", 
                                 "GlobalGratitude_WorldReligiosity.csv")) %>%
  rename("country_name" = "country") %>% 
  mutate(country_code = countrycode(country_name, 
                                    origin = 'country.name', 
                                    destination = 'iso3c')) %>%
  select(X2011:X2014, country_name, country_code) %>%
  mutate(
    relig_mean = rowMeans(
      cbind(X2011, X2012, X2013, X2014),
      na.rm = TRUE)) %>%
  select(country_code, country_name, relig_mean) %>%
  mutate(country_name = ifelse(country_name == "Macedonia", 
                               "North Macedonia", country_name)) 


#combine datasets
DF_combined <- DF_relation %>%
  full_join(DF_respon, by = c("country_name", "country_code")) %>%
  full_join(DF_tight, by = c("country_name", "country_code")) %>%
  full_join(DF_relig, by = c("country_name", "country_code")) %>%
  full_join(DF_GDP, by = c("country_name", "country_code")) %>%
  full_join(DF_indcol, by = c("country_name", "country_code")) %>%
  filter(!is.na(country_name))

DF_combined$sample <- ifelse(DF_combined$country_code %in% sampled, 
                             "yes", 
                             "no") 

DF_combined <- DF_combined %>%
  mutate(country_name = ifelse(country_name == "North Macedonia", 
                               "Macedonia", 
                               country_name)) 

write.csv(DF_combined, 
          file = here('data/final processed data',
                      "GlobalGratitude_CrossCulturalMod.csv"),
          row.names = F)