library(tidyverse)
library(here)

# specify directory
i_am("code/Cleaned_Final_Dataset.R")

# fetch main survey data
data_main <- readRDS(file = here("data", "GlobalGratitude_Final.Rds"))
data_main <- data_main %>%
  select(StartDate:pageNo)

# fetch the USA_02b (harmonized) survey data
data_USA_02b <- read.csv(file = here("data", "USA_02b_raw_harmonized.csv"))
data_USA_02b <- data_USA_02b %>% 
  select(StartDate:pageNo) %>%
  rename("events_list" = "control_list") 

# fetch the USA_02c survey data
data_USA_02c <- read.csv(file = here("data", "USA_02c.csv"))
data_USA_02c <- data_USA_02c %>% select(StartDate:pageNo)

#match columns
data_main <- data_main %>%
  mutate(across(names(data_USA_02c), ~ {
    # matching character columns
    if (is.character(data_USA_02c[[cur_column()]])) {
      return(as.character(.))
    }
    # matching numeric or integer columns
    else if (is.numeric(data_USA_02c[[cur_column()]])) {
      return(as.numeric(.))
    }
    else {
      return(.)
    }
  }))

# read and combine the CSV files
data <- bind_rows(data_main, data_USA_02c)
data <- bind_rows(data, data_USA_02b)

#clean data
data_cleaned <- data %>% 
  #removed test links
  filter(DistributionChannel != "preview",
         # 4/22/2024 TUR_01 used real link for testing purposes
         ResponseId != "R_42KUGZSS76NgWH7",
         ResponseId != "R_4W4EXfgeyk1rCYF",
         ResponseId != "R_45Z862EIfzYcin4",
         ResponseId != "R_7BhJx9Ci7THupmF",
         ResponseId != "R_42Lv9fg5qi9V9xm",
         ResponseId != "R_2kFa26mh78uevnz",
         ResponseId != "R_4DRThnH8LgbEvM8",
         ResponseId != "R_4r1kAEqQCo1PNn6",
         ResponseId != "R_4GQErqyYDlRWVwZ",
         ResponseId != "R_4SGF0GCHSHIN0ls",
         ResponseId != "R_6Pndj5c7sr1pcU3",
         ResponseId != "R_8lQxsY2ITg7HKh1",         
         ResponseId != "R_8HXsI5PQftiJUYk",
         ResponseId != "R_8iVWI3CN49ACiUp",
         #6/6/2024 Removed USA_01 duplicate data
         ResponseId != "R_6rDfD5u84z6WufT",
         #11/21/2024 Removed DZA_01 test data
         ResponseId != "R_4ioYJK1zR2FgR4R",
         ResponseId != "R_4OvlyOmeTsmLpFn",
         ResponseId != "R_4BA1gbglSYnVyDK")
         
#clean data
data_cleaned <- data_cleaned %>%
  #removed incomplete surveys
  filter(consent == 1,
         Progress >= 95,
         lab != "",
         condition_type != "NA",
         lab != "NA") %>% 
  select(StartDate:pageNo) #Remove non-relevant columns


# change the 'incentive' column from "volunteer" to "paid" for NOR_01 participants after 11/19/2024
data_cleaned <- data_cleaned %>%
  mutate(StartDate = as.POSIXct(StartDate, format = "%m/%d/%Y %H:%M"),
         incentive = if_else(lab == "NOR_01" & StartDate > as.POSIXct("11/19/2024 0:00", format = "%m/%d/%Y %H:%M"),
                             "paid", incentive))

# fix age data where wrong info is inputted
data_cleaned <- data_cleaned %>%
  mutate(age = if_else(age > 99, 2024 - age, age))

#rename interventions and controls
data_cleaned <- data_cleaned %>% 
  mutate(condition = case_when(
    condition == "god.letter" ~ "divine.grat",
    condition == "hk.list"    ~ "naikan",
    condition == "sub"        ~ "mental.sub",
    TRUE ~ condition
  )
  )

saveRDS(data_cleaned, 
        file = here('data',
                    "GlobalGratitude_Final_Cleaned.Rds"))
