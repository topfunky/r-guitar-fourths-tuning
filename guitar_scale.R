# Source the utils_plot.R file
source("utils_plot.R")

# Define fret positions for each string in C major scale
string_6_frets <- c(0, 1, 3, 5, 7, 8, 10, 12, 13, 15) # Low E string
string_5_frets <- c(0, 2, 3, 5, 7, 8, 10, 12, 14, 15) # A string
string_4_frets <- c(0, 2, 3, 5, 7, 9, 10, 12, 14, 15) # D string
string_3_frets <- c(0, 2, 4, 5, 7, 9, 10, 12, 14) # G string
string_2_frets <- c(0, 0, 2, 4, 5, 7, 9, 11, 12, 14) # C string
string_1_frets <- c(0, 2, 4, 6, 7, 9, 11, 12, 14) # F string

# Define root note positions (C) for each string
root_6_frets <- c(8) # Low E string
root_5_frets <- c(3, 15) # A string
root_4_frets <- c(10) # D string
root_3_frets <- c(5) # G string
root_2_frets <- c(0, 12) # C string
root_1_frets <- c(7) # F string

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

# Find indices of root notes in the combined arrays
root_indices <- c(
  which(string_1_frets %in% root_1_frets),
  length(string_1_frets) + which(string_2_frets %in% root_2_frets),
  length(string_1_frets) +
    length(string_2_frets) +
    which(string_3_frets %in% root_3_frets),
  length(string_1_frets) +
    length(string_2_frets) +
    length(string_3_frets) +
    which(string_4_frets %in% root_4_frets),
  length(string_1_frets) +
    length(string_2_frets) +
    length(string_3_frets) +
    length(string_4_frets) +
    which(string_5_frets %in% root_5_frets),
  length(string_1_frets) +
    length(string_2_frets) +
    length(string_3_frets) +
    length(string_4_frets) +
    length(string_5_frets) +
    which(string_6_frets %in% root_6_frets)
)

# Define scales list with the combined data
scales <- list(
  list(
    name = "C major",
    frets = all_frets,
    strings = all_strings,
    root_positions = root_indices
  )
)

# Plot and save each scale
for (scale in scales) {
  plot_and_save_scale(
    string_positions = scale$strings,
    fret_positions = scale$frets,
    title = scale$name,
    highlight_positions = scale$root_positions,
    highlight_color = "white",
    highlight_label_color = "black"
  )
}
