# Implemented as a separate file so it can be sourced by Rscript in
# order to install dependencies before running other scripts.

# Load libraries
options(repos = c(CRAN = "https://cloud.r-project.org"))

if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}

if (!requireNamespace("tabr", quietly = TRUE)) {
  remotes::install_github("leonawicz/tabr")
}

if (!require("ggplot2")) install.packages("ggplot2")
