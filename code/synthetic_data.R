install.packages("synthpop")
library(synthpop)
library(here)
library(tidyverse)

i_am('code/synthetic_data.R')

#Load data (Hofstede + Residential Mobility)
data <- read.csv(file = here("data/cross-cultural", 
                                  "GlobalGratitude_Hofstede_ResMobility.csv")) %>% 
  select(Matched, resmobility:indulgence) %>% 
  filter(Matched != "")  %>%
  distinct(Matched, .keep_all = TRUE)

country_data <- unique(data$Matched)

set.seed(123)

#create synthetic version
syn_data <- syn(
  data,
  maxfaclevels = 154
)

syn_data <- syn_data$syn
syn_data <- syn_data %>%
  slice(1:length(country_data)) %>%
  mutate(Matched = country_data)

write.csv(syn_data, 
          file = here('data/cross-cultural',
                      "GlobalGratitude_Hofstede_ResMobility_Syn.csv"),
          row.names = F)

#Load data (Responsibilism)
data_2 <- read.csv(file = here("data/cross-cultural", 
                             "GlobalGratitude_Responsibilism.csv")) %>% 
  select(Culture:Responsibilism) %>% 
  filter(Culture != "", Culture != "Total")

country_data_2 <- unique(data_2$Culture)

set.seed(123)

#create synthetic version
syn_data_2 <- syn(
  data_2,
  maxfaclevels = 100
)

syn_data_2 <- (syn_data_2$syn)
syn_data_2 <- syn_data_2 %>%
  slice(1:length(country_data_2)) %>%
  mutate(Culture = country_data_2)

write.csv(syn_data_2, 
          file = here('data/cross-cultural',
                      "GlobalGratitude_Responsibilism_Syn.csv"),
          row.names = F)