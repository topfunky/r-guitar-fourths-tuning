options(repos = c(CRAN = "https://cloud.r-project.org"))

# Install remotes if not already installed
if (!require("remotes")) install.packages("remotes")

# Install tabr from GitHub if not available
if (!require("tabr")) remotes::install_github("leonawicz/tabr")
if (!require("ggplot2")) install.packages("ggplot2")

# Load libraries
library(tabr)
library(ggplot2)

# Define the tuning (EADGCF)
tuning <- "e2 a2 d3 g3 c4 f4"


# Define the A major scale notes
a_major_scale <- c("a", "b", "c#", "d", "e", "f#", "g#")

plot_fretboard(
  string = 6:1,
  fret = c(5, 4, 2, 1, 0, 0),
  "notes",
  horizontal = TRUE,
  tuning = tuning,
  show_tuning = TRUE,
  fret_labels = c(3, 5, 7, 9, 12),
  label_color = "white",
  point_fill = "dodgerblue",
)

string <- 6:1
fret <- 1:12

# p <- plot_fretboard(
#   string,
#   fret,
#   "notes",
#   show_tuning = TRUE,
#   fret_labels = c(3, 5, 7, 9, 12),
#   show_tuning = TRUE,
#   horizontal = TRUE
# ) +
#   ggtitle("A Major Scale")

# Save the plot
ggsave("a_major_scale.png", p, width = 10, height = 6)
