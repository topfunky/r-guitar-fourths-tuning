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
  fret_positions,
  title = NULL,
  point_fill = "dodgerblue",
  label_color = "white"
) {
  # Filter out muted strings (where fret is NA)
  active_strings <- !is.na(fret_positions)
  active_string_positions <- (6:1)[active_strings]
  active_fret_positions <- fret_positions[active_strings]

  # Create the plot
  p <- plot_fretboard(
    string = active_string_positions,
    fret = active_fret_positions,
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
# Format: list(name, fret_positions)
# Note: Use NA in fret_positions to indicate a muted string
# Fret positions are from 6th string to 1st string
chords <- list(
  list(
    name = "A7sus4(13)",
    frets = c(5, NA, 5, 7, 6, NA)
  ),
  list(
    name = "E Major",
    frets = c(0, 2, 2, 1, 0, 0)
  ),
  list(
    name = "E Minor",
    frets = c(0, 2, 2, 0, 0, 0)
  )
)

# Plot and save each chord
for (chord in chords) {
  plot_and_save_chord(
    chord_name = chord$name,
    fret_positions = chord$frets,
    title = chord$name
  )
}
