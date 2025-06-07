# Source the utils_plot.R file
source("utils_plot.R")


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
