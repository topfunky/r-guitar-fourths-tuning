# Source the plot_chord.R file
source("plot_chord.R")

# Define fret positions for each string in C major scale
string_1_frets <- c(0, 1, 3, 5, 7, 8, 10, 12, 13, 15) # Low E string
string_2_frets <- c(0, 2, 3, 5, 7, 8, 10, 12, 14, 15) # A string
string_3_frets <- c(0, 2, 3, 5, 7, 9, 10, 12, 14, 15) # D string
string_4_frets <- c(0, 2, 4, 5, 7, 9, 10, 12, 14) # G string
string_5_frets <- c(0, 0, 2, 4, 5, 7, 9, 11, 12, 14) # C string
string_6_frets <- c(0, 2, 4, 6, 7, 9, 11, 12, 14) # F string

# Combine all fret positions
all_frets <- c(
  string_1_frets,
  string_2_frets,
  string_3_frets,
  string_4_frets,
  string_5_frets,
  string_6_frets
)

# Generate corresponding string numbers
all_strings <- c(
  rep(1, length(string_1_frets)),
  rep(2, length(string_2_frets)),
  rep(3, length(string_3_frets)),
  rep(4, length(string_4_frets)),
  rep(5, length(string_5_frets)),
  rep(6, length(string_6_frets))
)

# Define scales list with the combined data
scales <- list(
  list(
    name = "C major",
    frets = all_frets,
    strings = all_strings
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
