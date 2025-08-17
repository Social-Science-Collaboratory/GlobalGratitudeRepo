# GlobalGratitudeProject
GitHub repository for the Global Gratitude Project

## Code:
### USA_02b_Harmonize.R:
- Harmonized USA_02b with the rest of the data

### Cleaned_Final_Dataset.R:
- Combined Final_Dataset.Rmd, USA_02b_harmonized.csv, and USA_02c.csv
- Removed test responses and unfinished surveys
- Fixed issues with embedded data and incorrect age input

### factoranalysis.R:
- Conducted factor analysis on dependent variables

### Figure1.Rmd:
- Code to create Figure 1

### Figure2.Rmd:
- Code to create Figure 2

### Figure3.Rmd:
- Code to create Figure 3

### GlobalGratitude_CrossCulturalMods.Rmd
- Compile all cross-cultural moderator data from outside sources
- Combined GlobalGratitude_GDPpc.csv, GlobalGratitude_Hofstede_ResMobility.csv, GlobalGratitude_RelationalMobility.csv, GlobalGratitude_Responsibilism.csv, GlobalGratitude_Tightness.csv, and GlobalGratitude_World Religiosity.csv

### GlobalGratitude_LabSpecificData.Rmd
- Create Excel Workbook with country data separated for quality checks

### GlobalGratitude_MixedModels.Rmd
- Created mixed models for each dependent variable

### Site Demographics
- Calculated data for Supplemental Table 1

### GlobalGratitude_Visualizations.Rmd
- Calculated country-level effect sizes, practice-level effect sizes, and overall effect sizes for each dependent variable
- Calculated data for Supplemental Table 2

##bData
### Codebook:
- GlobalGratitudeCodebook.xlsx: Codebook for GlobalGratitude_Final_Cleaned.Rds

### Raw:
- GlobalGratitude_Final.Rds: raw Qualitrics data for main survey
- USA_02b_raw_unharmonized.csv: raw Qualtrics data for USA_02b survey
- USA_02b_raw_harmonized.csv: raw Qualtrics data for USA_02b survey harmonized with main survey
- USA_02c.csv: raw Qualtrics data for USA_02c survey

### Quality Checks:
- GlobalGratitude_LabSpecificData.xlsx: Each lab conducted quality checks for their data collection sites. Each response was rate "yes", "no", or "maybe" for inclusion with comments. The sites collected through Prolific were coded by the UCSD and UF team.
- summary_data: Summarizes the rate of inclusion by country and practice.

### Cultural Moderators:
- culturaldistance_table.csv: Original data for cultural distance (Muthukrishna et al., 2020)
- culturaldistance_table_combined.csv: Cultural distance data combined across years (Muthukrishna et al., 2020)
- GlobalGratitude_GDPpc.csv: Data on gross domestic product (World Bank, 2023)
- GlobalGratitude_Hofstede_ResMobility.csv: Data on Hofstede cultural dimensions (individualism, motivation, indulgence, power distance, long-term orientation, and uncertainty avoidance) (The Culture Factor, 2023) and residential mobility (Gallup, 2016)
- GlobalGratitude_RelationalMobility.csv: Cultural data on the relational mobility measure (Thompson et al., 2018)
- GlobalGratitude_Responsibilism.csv: Cultural data on the responsibilism measure (Talhelm et al., under review)
- GlobalGratitude_Tightness.csv: Cultural data on the tightness measure (Gelfand et ., 2021)
- GlobalGratitude_World Religiosity.csv: Cultural data on religiosity (Gallup, 2016)

### Effect Sizes:
- overall_effect_sizes.csv: Effect sizes for each dependent variable across all interventions and all control conditions
- overall_country_effect_sizes.csv: Effect sizes for each dependent variable across all interventions and all control conditions for each country
- unique_cond_effect_sizes.csv: Effect sizes for each dependent variable across each interention and each control
- unique_country_effect_sizes.csv: Effect sizes for each dependent variable across each interention and each control for each country