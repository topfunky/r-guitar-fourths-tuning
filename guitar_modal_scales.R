# Source required files
source("utils_plot.R")
source("music_theory.R")

# Define the key to use for all scales
key <- "C"

# Get all scale patterns
for (scale_pattern in scale_patterns) {
  scale_name <- scale_pattern$name

  # Create the plot
  p <- plot_scale(scale_name, key)

  # Print progress
  cat(sprintf("Rendered %s scale\n", scale_name))
}
