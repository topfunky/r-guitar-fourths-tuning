# Source the plot_chord.R file
source("plot_chord.R")


# Define some example scales
# Format: list(name, fret_positions)
# Note: Use NA in fret_positions to indicate a muted string
# Fret positions are from 6th string to 1st string
scales <- list(
  list(
    name = "C major",
    frets = c(
      0, 1, 3, 5, 7, 8, 10, 12, 13,  # String 6
      3, 5, 7, 8, 10, 12, 14,  # String 5
      10, 12, 14, 15,  # String 4
      5, 7, 9, 10, 12, 14, 16,  # String 3
      0, 2, 4, 5, 7, 9, 11,  # String 2
      5, 7, 9, 10, 12, 14, 16  # String 1
    ),
    strings = c(
      1, 1, 1, 1, 1, 1, 1, 1, 1, # String 1 Low E
      2, 2, 2, 2, 2, 2, 2,  # String 2 Low A
      3, 3, 3, 3,  # String 3 Low D
      4, 4, 4, 4, 4, 4, 4,  # String 4 Low G
      5, 5, 5, 5, 5, 5, 5,  # String 5 High C
      6, 6, 6, 6, 6, 6, 6  # String 6 High E
    )
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
