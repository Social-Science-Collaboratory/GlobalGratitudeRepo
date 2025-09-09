## --------------------------------------------------------------------------------------
# setup.R
## --------------------------------------------------------------------------------------

# install + load
pkg_install_load <- function(pkgs) {
  to_install <- pkgs[!(pkgs %in% installed.packages()[, "Package"])]
  if (length(to_install)) install.packages(to_install, quiet = TRUE)
  invisible(lapply(pkgs, require, character.only = TRUE))
}

# download packages
core_pkgs <- c(
  # tidyverse + data management
  "tidyverse", "stringr", "synthpop", "here", "openxlsx", "readr",
  # country/global
  "countrycode", "rnaturalearth", "rnaturalearthdata", "ggspatial",
  # visualization
  "effsize", "metafor", "scales", "ggtext", "cowplot", "ggExtra", "ggrepel", "gridExtra",
  # analysis
  "psych", "lavaan", "semTools", "BayesFactor", "lme4", "lmerTest", "emmeans", "gtools"
)

pkg_install_load(core_pkgs)

# global options
options(
  scipen = 999,                         
  digits = 3,
  # behavior
  dplyr.summarise.inform = FALSE,
  repos = c(CRAN = "https://cloud.r-project.org"),
  # stringsAsFactors is FALSE by default (R >= 4.0); keep explicit for clarity:
  stringsAsFactors = FALSE
)