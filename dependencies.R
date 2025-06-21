# Implemented as a separate file so it can be sourced by Rscript in
# order to install dependencies before running other scripts.

# Load libraries
options(repos = c(CRAN = "https://cloud.r-project.org"))

# Install remotes if not already installed
if (!require("remotes"))
  install.packages("remotes", repos = "https://cloud.r-project.org")

# Install tabr from GitHub if not available
if (!require("tabr")) remotes::install_github("leonawicz/tabr")
if (!require("ggplot2")) install.packages("ggplot2")
