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

plot_and_save_chord <- function(
  chord_name,
  string_positions,
  fret_positions,
  title = NULL,
  point_fill = "dodgerblue",
  label_color = "white"
) {
  # Create the plot
  p <- plot_fretboard(
    string = string_positions,
    fret = fret_positions,
    "notes",
    horizontal = TRUE,
    tuning = tuning,
    show_tuning = TRUE,
    fret_labels = c(3, 5, 7, 9, 12),
    label_color = label_color,
    point_fill = point_fill
  )

  # Add title if provided
  if (!is.null(title)) {
    p <- p + ggtitle(title)
  }

  # Create plots directory if it doesn't exist
  if (!dir.exists("plots")) {
    dir.create("plots")
  }

  # Save the plot
  filename <- paste0("plots/", tolower(gsub(" ", "_", chord_name)), ".png")
  ggsave(filename, p, width = 10, height = 6)

  return(p)
}

# Define some example chords
# Format: list(name, string_positions, fret_positions)
chords <- list(
  list(
    name = "A Major",
    strings = 6:1,
    frets = c(5, 4, 2, 1, 0, 0)
  ),
  list(
    name = "E Major",
    strings = 6:1,
    frets = c(0, 0, 1, 1, 1, 0)
  ),
  list(
    name = "D Major",
    strings = 6:1,
    frets = c(2, 3, 2, 0, 0, 0)
  )
)

# Plot and save each chord
for (chord in chords) {
  plot_and_save_chord(
    chord_name = chord$name,
    string_positions = chord$strings,
    fret_positions = chord$frets,
    title = chord$name
  )
}
