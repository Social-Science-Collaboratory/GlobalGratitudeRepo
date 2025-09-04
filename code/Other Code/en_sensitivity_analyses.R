i_am("code/Figure2.Rmd")

# fetch survey
DF <- readRDS(file = here("data", "GlobalGratitude_Final_Cleaned.Rds")) 

DF <- DF%>% 
  filter(UserLanguage == "EN")


# list of effect size columns and variance columns
effect_size_columns <- c("pa_effect_size", "na_effect_size",
                         "optimistic_effect_size","ls_effect_size",
                         "envy_effect_size", "indebted_effect_size")

variance_columns <- c("pa_var", "na_var", "optimistic_var",
                      "ls_var", "envy_var", "indebted_var")

DF <- DF %>% 
  rowwise() %>% 
  mutate(
    # gratitude
    gratitude_mean = mean(c(grateful, appreciative, thankful), na.rm = TRUE),
    
    # positive affect
    pa_mean = mean(c(happy, satisfied, content, joyful, pleased), na.rm = TRUE),
    
    # optimism
    optimistic_mean = mean(c(optimistic, hopeful), na.rm = TRUE),
    
    # negative affect
    na_mean = mean(c(sad, depressed, anxious, nervous), na.rm = TRUE),
    
    # indebtedness
    indebted_mean = mean(c(indebted, obligated), na.rm = TRUE),
    
    # envy
    envy_mean = mean(c(envious, bitter, jealous), na.rm = TRUE),
    
    # life satisfaction
    ls_mean = mean(c(ls_1, ls_2, ls_3, ls_4, ls_5), na.rm = TRUE),
    
    # sense of self
    ss_mean = mean(c(self_image, self_image_circle), na.rm = TRUE)
    
  ) %>% 
  ungroup() %>% 
  drop_na(gratitude_mean, pa_mean, optimistic_mean, na_mean, 
          indebted_mean, envy_mean, ls_mean, guilty, ladder, ss_mean)

DF <- DF %>%
  mutate(country = case_when(
    lab == "POL_01" ~ "Poland",
    lab == "POL_02" ~ "Poland",
    lab == "DNK_01" ~ "Denmark",
    lab == "TUR_01" ~ "Turkey",
    lab == "MYS_01" ~ "Malaysia",
    lab == "USA_01" ~ "United States",
    lab == "USA_02" ~ "United States",
    lab == "USA_02b" ~ "United States",
    lab == "USA_02c" ~ "United States",
    lab == "NGA_01" ~ "Nigeria",
    lab == "NGA_02" ~ "Nigeria",
    lab == "CAN_01" ~ "Canada",
    lab == "FRA_01" ~ "France",
    lab == "AUS_01" ~ "Australia",
    lab == "CHL_01" ~ "Chile",
    lab == "DEU_01" ~ "Germany",
    lab == "GRC_01" ~ "Greece",
    lab == "HUN_01" ~ "Hungary",
    lab == "ISR_01" ~ "Israel",
    lab == "IRL_01" ~ "Ireland",
    lab == "MEX_01" ~ "Mexico",
    lab == "ITA_01" ~ "Italy",
    lab == "PRT_01" ~ "Portugal",
    lab == "BRA_01" ~ "Brazil",
    lab == "NLD_01" ~ "Netherlands",
    lab == "GBR_01" ~ "United Kingdom",
    lab == "ESP_01" ~ "Spain",
    lab == "ZAF_01" ~ "South Africa",
    lab == "KOR_01" ~ "South Korea",
    lab == "SWE_01" ~ "Sweden",
    lab == "IND_01" ~ "India",
    lab == "COL_01" ~ "Colombia",
    lab == "CHN_01" ~ "China",
    lab == "KAZ_01" ~ "Kazakhstan",
    lab == "NOR_01" ~ "Norway",
    lab == "JPN_01" ~ "Japan",
    lab == "GHA_01" ~ "Ghana",
    lab == "THA_01" ~ "Thailand",
    lab == "MKD_01" ~ "Macedonia",
    TRUE ~ NA_character_
  )) %>%
  filter(!is.na(country))

control_data <- subset(DF, condition_type == "control")
intervention_data <- subset(DF, condition_type == "intervention")

unique_labs <- unique(DF$country)
condition_names <- c("list", "letter", "text", "naikan", "mental.sub", "divine.grat")
variables <- c(
  "pa_mean", "na_mean", "optimistic_mean", "ls_mean", "ladder",
  "envy_mean", "indebted_mean", "gratitude_mean", "guilty", "ss_mean"
)

#Set levels
DF$condition <- factor(DF$condition)  # convert to factor
DF$condition <- factor(DF$condition, levels = c(
  "measure", "events", "int.events",     # Control
  "list", "letter", "text", "naikan", "mental.sub", "divine.grat"  # Intervention
))

DF$condition_type <- factor(DF$condition_type)  # convert to factor
DF$condition_type <- factor(DF$condition_type, levels = c("control", "intervention"))

# Initialize results data frame
unique_country_results_df <- data.frame()

# Function to compute Cohen's d and variance
compute_effect_sizes <- function(lab_name, control_cond, intervention_cond) {
  # Subset data for this contrast
  country_data <- DF %>% filter(country == lab_name)
  control_subset <- country_data %>% filter(condition == control_cond)
  intervention_subset <- country_data %>% filter(condition == intervention_cond)
  
  # Function to calculate variance of Cohen's d
  calc_var <- function(d, n1, n2) {
    se_d <- sqrt((n1 + n2) / (n1 * n2) + d^2 / (2 * (n1 + n2)))
    return(se_d^2)
  }
  
  # Loop through each measure and calculate d and variance
  effects <- sapply(variables, function(measure) {
    d_result <- cohen.d(intervention_subset[[measure]], control_subset[[measure]], pooled = TRUE)
    d_value <- d_result$estimate
    var_value <- calc_var(d_value, nrow(control_subset), nrow(intervention_subset))
    c(d_value, var_value)
  })
  
  # Split effect sizes and variances into named vectors
  effect_sizes <- effects[1, ]
  variances <- effects[2, ]
  
  # Create result row
  result <- data.frame(
    country = lab_name,
    control_condition = control_cond,
    intervention_condition = intervention_cond,
    contrast = paste(control_cond, "vs", intervention_cond),
    as.list(setNames(effect_sizes, paste0(gsub("_mean", "", variables), "_effect_size"))),
    as.list(setNames(variances, paste0(gsub("_mean", "", variables), "_var"))),
    stringsAsFactors = FALSE
  )
  
  return(result)
}

# Loop through countries and contrasts
results_list <- list()

for (lab_name in unique_labs) {
  country_data <- DF %>% filter(country == lab_name)
  control_conditions <- unique(country_data$condition[country_data$condition_type == "control"])
  intervention_conditions <- unique(country_data$condition[country_data$condition_type == "intervention"])
  
  for (control_cond in control_conditions) {
    for (intervention_cond in intervention_conditions) {
      results_list[[length(results_list) + 1]] <- compute_effect_sizes(lab_name, control_cond, intervention_cond)
    }
  }
}

# Combine all results
unique_country_results_df <- do.call(rbind, results_list)

# Output
print(unique_country_results_df)

write.csv(unique_country_results_df, 
          file = here('data',
                      "en_unique_country_effect_sizes.csv"))

####

en_df <- unique_country_results_df %>% 
  select(country:ss_var)

# list of effect size columns and variance columns
effect_size_columns <- c("pa_effect_size", "na_effect_size",
                         "optimistic_effect_size","ls_effect_size",
                         "envy_effect_size", "indebted_effect_size")

variance_columns <- c("pa_var", "na_var", "optimistic_var",
                      "ls_var", "envy_var", "indebted_var")

# Use lapply to fit models for each pair of effect size and variance
m.ic <- lapply(1:length(effect_size_columns), function(i) {
  rma.mv(yi = en_df[[effect_size_columns[i]]],
         V = en_df[[variance_columns[i]]],
         random = list(~ 1 | intervention_condition, ~ 1 | country),
         data = en_df)})

# Store the results with a name reflecting the effect size and variance pair
names(m.ic) <- paste(effect_size_columns)

# evaluate relative importance of variance components for each outcome
lapply(m.ic, function(model){
  model$sigma2[2] / model$sigma2[1]})

# Extract tau values
en_tau_c <- sapply(m.ic, function(model) (model$sigma2[2]))

options(scipen=999)

###

tau_df <- data.frame(
  tau_all = unlist(tau_c),
  tau_eng = unlist(eng_tau_c)
)

tau_df$difference <- tau_df$tau_all - tau_df$tau_eng
tau_df$ratio <- tau_df$tau_eng / tau_df$tau_all

tau_df

write.csv(tau_df, 
          file = here('data',
                      "tau_sensitivity_analyses.csv"))
