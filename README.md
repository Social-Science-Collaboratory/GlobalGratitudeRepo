# GlobalGratitudeProject
GitHub repository for the Global Gratitude Project

## Note: 
Please open GlobalGratitudeRepo.Rproj before running any code.

## Code:

### CleanedFinalDataset.Rmd:
- Combined Final_Dataset.Rds, USA_02b_harmonized.csv, and USA_02c.csv.
- Removed test responses and unfinished surveys.
- Fixed issues with embedded data and incorrect age input.
- Create globalgratitude_cleaned_final.Rds.

### CrossCulturalMods.Rmd:
- Compile all cross-cultural moderator data from outside sources.
- Combined GDPpc.csv, hofstede_resmobility.csv, relationalmobility.csv, responsibilism.csv, tightness.csv, and world religiosity.csv.
- Create crossculturalmod.csv.

### EffectSizes.Rmd:
- Calculate Cohen's d effect sizes and variance for comparisons between each gratitude intervention and each control for every country.
- Create unique_country_effect_sizes.csv.

### Figure1.Rmd:
- Create Figure 1.

### Figure2.Rmd:
- Create Figure 2 and prediction_intervals.csv.

### Figure3.Rmd:
- Create Figure 3.

### MixedModels.Rmd:
- Calculate pre-registered analyses, fits a separate mixed-effects model for each outcome variable.
- Create si_table_3.

### SiteDemographics:
- Calculate demographics for each site.
- Create si_table_1.

## Data
### codebook:
- globalgratitude_final_codebook.xlsx: Codebook for globalgratitude_final_cleaned.Rds.
- crossculturalmod_codebook.xlsx: Codebook for crossculturalmod.csv.

### cross-cultural:
- culturaldistance.csv: Original data on cultural distance (Muthukrishna et al., 2020). Data extracted from http://culturaldistance.com/.
- culturaldistance_combined.csv: Cultural distance data combined across years (Muthukrishna et al., 2020)
- GDPpc.csv: Data on gross domestic product (World Bank, 2023). Data extracted from https://data.worldbank.org/indicator/NY.GDP.PCAP.CD.
- hofstede_resmobility_simulated.csv: Simulated data on Hofstede cultural dimensions (individualism, motivation, indulgence, power distance, long-term orientation, and uncertainty avoidance) (The Culture Factor, 2023) and residential mobility (Gallup, 2016). Data manually scraped from https://www.theculturefactor.com/country-comparison-tool and obtained from https://www.gallup.com/analytics/318875/global-research.aspx.
- relationalmobility.csv: Data on the relational mobility measure (Thompson et al., 2018). Data obtained from http://relationalmobility.org/.
- responsibilism_simulated.csv: Simulated data on the responsibilism measure (Talhelm et al., under review). Data obtained directly from author.
- tightness.csv: Data on the tightness-looseness measure (Gelfand et al., 2021). Data obtained from https://osf.io/47pe8/.
- worldreligiosity.csv: Data on world religiosity (Joshanloo & Gebauer, 2019). Data obtained from https://econtent.hogrefe.com/doi/suppl/10.1027/1016-9040/a000382.

### final-data:
- globalgratitude_final_cleaned.Rds: Final dataset used for all data analysis.
- crossculturalmod.csv: Combined dataset with all cross-cultural moderators. Contains simulated data.

### output:
- prediction_interval.csv: Data of prediction intervals for all outcomes.
- si_table_1.csv: Data for Supplemental Table 1.
- si_table_3.csv: Data for Supplemental Table 3.
- unique_country_effect_sizes.csv: Data of pairwise comparisons across all interventions vs. all controls for each site.

### raw-data:
- globalgratitude_final.Rds: raw Qualitrics data from the main survey.
- USA_02b_raw_unharmonized.csv: raw Qualtrics data for USA_02b survey.
- USA_02b_raw_harmonized.csv: raw Qualtrics data for USA_02b survey harmonized with main survey.
- USA_02c.csv: raw Qualtrics data for USA_02c survey.

## quality-checks:
### lab-quality-checks:
- LabSpecificData.Rmd: Generates an Excel workbook with all data for quality checks.
- labspecific_data.csv: Exports data organized by site for quality checks.
- qualitychecks.xlsx: Records quality checks, with survey responses rated “yes”, “no”, or “maybe” for inclusion, along with comments. Sites collected through Prolific were coded by the UCSD and UF teams.
- QualityChecks.Rmd: Produces a summary table of each site’s quality checks. Creates QC_globalgratitude_final_cleaned.Rds.
- qualitychecks_summary.csv: Summarizes the rate of inclusion by country and by practice.

### sensitivity-analyses:
- QC_globalgratitude_final_cleaned.Rds: Dataset of quality checked responses.
- SensitivityAnalyses.Rmd: Conduct sensitivity analyses for only English and quality checked responses to the full dataset. Creates si_table_4_ef.csv and si_table_4_tau.csv.
- si_table_4_ef.csv: Sensitivity analyses of effect sizes.
- si_table_4_tau.csv: Sensitivity analyses of tau.

## figures:
- GlobalGratitude_DataOrganization.drawio: A figure depicting the organization of all files within the repository.