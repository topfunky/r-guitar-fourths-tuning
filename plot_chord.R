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

# Helper function to save plots to file
save_plot_to_file <- function(plot, name) {
  # Create plots directory if it doesn't exist
  if (!dir.exists("plots")) {
    dir.create("plots")
  }

  # Save the plot
  filename <- paste0("plots/", tolower(gsub(" ", "_", name)), ".png")
  ggsave(filename, plot, width = 10, height = 6)
}

# A simple function to plot and save a single chord.
# Assumes that there is only one note on each string.
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

  save_plot_to_file(p, chord_name)

  return(p)
}

# Function to plot and save a scale with multiple notes per string
plot_and_save_scale <- function(
  string_positions, # Vector of string numbers (6-1)
  fret_positions, # Vector of fret positions (0-25)
  title = NULL,
  point_fill = "black",
  label_color = "white",
  highlight_positions = NULL, # Vector of indices to highlight
  highlight_color = "white", # Color for highlighted notes
  highlight_label_color = "black" # Color for highlighted note labels
) {
  # Validate inputs
  if (length(string_positions) != length(fret_positions)) {
    stop("string_positions and fret_positions must have the same length")
  }

  if (any(string_positions < 1 | string_positions > 6)) {
    stop("string_positions must be between 1 and 6")
  }

  if (any(fret_positions < 0, na.rm = TRUE)) {
    stop("fret_positions cannot be negative")
  }

  # Create color vectors for all notes
  point_colors <- rep(point_fill, length(fret_positions))
  label_colors <- rep(label_color, length(fret_positions))

  # Set colors for highlighted notes
  if (!is.null(highlight_positions)) {
    point_colors[highlight_positions] <- highlight_color
    label_colors[highlight_positions] <- highlight_label_color
  }

  # Create the plot
  p <- plot_fretboard(
    string = string_positions,
    fret = fret_positions,
    "notes",
    horizontal = TRUE,
    tuning = tuning,
    show_tuning = TRUE,
    fret_labels = c(3, 5, 7, 9, 12),
    label_color = label_colors,
    point_fill = point_colors
  )

  # Add title if provided
  if (!is.null(title)) {
    p <- p + ggtitle(title)
  }

  filename = paste(
    "scale",
    paste(title, collapse = "_"),
    sep = "_"
  )

  save_plot_to_file(p, filename)

  return(p)
}
