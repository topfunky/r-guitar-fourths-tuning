# Helper function to save plots to file
save_plot_to_file <- function(plot, name) {
  # Create plots directory if it doesn't exist
  if (!dir.exists("plots")) {
    dir.create("plots")
  }

  # Save the plot
  filename <- paste0("plots/", tolower(gsub(" ", "_", name)), ".png")
  ggsave(filename, plot, width = 10, height = 6, bg = "white")
}
