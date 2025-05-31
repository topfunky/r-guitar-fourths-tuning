# Source the plot_chord.R file
source("plot_chord.R")


# Define some example scales
# Format: list(name, fret_positions)
# Note: Use NA in fret_positions to indicate a muted string
# Fret positions are from 6th string to 1st string
scales <- list(
  list(
    name = "A7sus4(13)",
    frets = c(5, 6, 5, 7, 6, 2, 3),
    strings = c(1, 2, 3, 4, 5, 6, 6)
  ),
  list(
    name = "E Major",
    frets = c(0, 2, 2, 1, 0, 0),
    strings = c(1, 2, 3, 4, 5, 6) 
  ),
  list(
    name = "E Minor",
    frets = c(0, 2, 2, 0, 0, 0),
    strings = c(1, 2, 3, 4, 5, 6)
  )
)

# Plot and save each scale
for (scale in scales) {
  plot_and_save_scale(
    string_positions = scale$strings,
    fret_positions = scale$frets,
    title = scale$name
  )
}
