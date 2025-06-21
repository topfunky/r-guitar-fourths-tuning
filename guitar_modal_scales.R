# Source required files
source("utils_plot.R")
source("music_theory.R")

# Define the key to use for all scales
key <- "C"

# Get all scale patterns
for (scale_pattern in scale_patterns) {
  scale_name <- scale_pattern$name

  # Print progress
  cat(sprintf("🎸 Rendering %s scale in %s\n", scale_name, key))

  # Create the plot
  p <- plot_scale(scale_name, key)
}

# DEBUG
cat("🎸 DEBUG E Major scale\n")
p <- plot_scale("Major", "E")
