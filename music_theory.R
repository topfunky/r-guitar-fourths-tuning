source("dependencies.R")

# Load libraries
library(tabr)
library(ggplot2)

source("utils_save_file.R")

# Fourths tuning
tuning <- "e2 a2 d3 g3 c4 f4"

# Define intervals in a major scale
# Each interval is defined by its name and the number of semitones from the root
major_scale_intervals <- list(
  list(
    name = "Root",
    degree = 1,
    semitones = 0,
    symbol = "1"
  ),
  list(
    name = "Major Second",
    degree = 2,
    semitones = 2,
    symbol = "2"
  ),
  list(
    name = "Major Third",
    degree = 3,
    semitones = 4, # 2 semitones up from major second
    symbol = "3"
  ),
  list(
    name = "Perfect Fourth",
    degree = 4,
    semitones = 5, # 1 semitone up from major third
    symbol = "4"
  ),
  list(
    name = "Perfect Fifth",
    degree = 5,
    semitones = 7, # 2 semitones up from perfect fourth
    symbol = "5"
  ),
  list(
    name = "Major Sixth",
    degree = 6,
    semitones = 9, # 2 semitones up from perfect fifth
    symbol = "6"
  ),
  list(
    name = "Major Seventh",
    degree = 7,
    semitones = 11, # 2 semitones up from major sixth
    symbol = "7"
  ),
  list(
    name = "Octave",
    degree = 8,
    semitones = 12, # 1 semitone up from major seventh
    symbol = "8"
  )
)

# Define scale patterns as a data structure.
#
# Each pattern is defined by its name and the intervals relative
# to the major scale.
# Use "♭" for flat (lower by 1 semitone) and "♯" for sharp (raise by 1 semitone)
scale_patterns <- list(
  list(
    name = "Major",
    pattern = c("1", "2", "3", "4", "5", "6", "7")
  ),
  list(
    name = "Natural Minor",
    pattern = c("1", "2", "♭3", "4", "5", "♭6", "♭7")
  ),
  list(
    name = "Harmonic Minor",
    pattern = c("1", "2", "♭3", "4", "5", "♭6", "7")
  ),
  list(
    name = "Melodic Minor",
    pattern = c("1", "2", "♭3", "4", "5", "6", "7")
  ),
  list(
    name = "Phrygian Dominant",
    pattern = c("1", "♭2", "3", "4", "5", "♭6", "♭7")
  ),
  list(
    name = "Dorian",
    pattern = c("1", "2", "♭3", "4", "5", "6", "♭7")
  ),
  list(
    name = "Mixolydian",
    pattern = c("1", "2", "3", "4", "5", "6", "♭7")
  ),
  list(
    name = "Phrygian",
    pattern = c("1", "♭2", "♭3", "4", "5", "♭6", "♭7")
  ),
  list(
    name = "Locrian",
    pattern = c("1", "♭2", "♭3", "4", "♭5", "♭6", "♭7")
  ),
  list(
    name = "Lydian",
    pattern = c("1", "2", "3", "♯4", "5", "6", "7")
  ),
  list(
    name = "Lydian Dominant",
    pattern = c("1", "2", "3", "♯4", "5", "6", "♭7")
  ),
  list(
    name = "Altered",
    pattern = c("1", "♭2", "♭3", "♭4", "♭5", "♭6", "♭7")
  ),
  list(
    name = "Whole Tone",
    pattern = c("1", "2", "3", "♯4", "♯5", "♭7")
  ),

  list(
    name = "Blues",
    pattern = c("1", "♭3", "4", "♭5", "5", "♭7")
  ),
  list(
    name = "Barry Harris Diminished Sixth",
    pattern = c("1", "2", "3", "4", "5", "♯5", "6", "7")
  ),
  list(
    name = "Barry Harris Diminished Minor",
    pattern = c("1", "2", "♭3", "4", "5", "♯5", "6", "7")
  ),
  list(
    name = "Whole Half",
    pattern = c("1", "2", "♭3", "4", "♭5", "♭6", "6", "7")
  )
)

# Define note names and their semitones from C
note_semitones <- list(
  "C" = 0,
  "C♯" = 1,
  "D♭" = 1,
  "D" = 2,
  "D♯" = 3,
  "E♭" = 3,
  "E" = 4,
  "F" = 5,
  "F♯" = 6,
  "G♭" = 6,
  "G" = 7,
  "G♯" = 8,
  "A♭" = 8,
  "A" = 9,
  "A♯" = 10,
  "B♭" = 10,
  "B" = 11
)

# Function to get scale pattern by name
#
# @param scale_name The name of the scale to get the pattern for
# @return A list with the name and pattern of the scale
get_scale_pattern <- function(scale_name) {
  for (pattern in scale_patterns) {
    if (tolower(pattern$name) == tolower(scale_name)) {
      return(pattern)
    }
  }
  return(NULL)
}

# Function to convert scale pattern to semitones
#
# @param pattern A list of strings, each representing an interval
# @return A list of semitones, each corresponding to an interval in the pattern
pattern_to_semitones <- function(pattern) {
  semitones <- numeric(length(pattern))

  for (i in seq_along(pattern)) {
    # Get the base interval (1-7)
    base_degree <- as.numeric(gsub("[♭♯b#]", "", pattern[i]))
    base_interval <- get_interval_by_degree(base_degree)

    if (is.null(base_interval)) {
      stop(paste("Invalid interval in pattern:", pattern[i]))
    }

    # Calculate semitones based on modifiers
    semitones[i] <- base_interval$semitones
    if (grepl("♭", pattern[i]) || grepl("b", pattern[i])) {
      semitones[i] <- semitones[i] - 1
    } else if (grepl("♯", pattern[i]) || grepl("#", pattern[i])) {
      semitones[i] <- semitones[i] + 1
    }
  }

  return(semitones)
}

# Function to get scale intervals by name
#
# Returns a list of intervals, each with degree, semitones, and symbol
# The degree is the position of the interval in the scale, starting at 1 for the root
# The semitones is the number of semitones from the root
# The symbol is the symbol of the interval
# The symbol is a string of the form "1", "2", "3", "4", "5", "6", "7", "8"
# The symbol is the symbol of the interval
get_scale_intervals <- function(scale_name) {
  pattern <- get_scale_pattern(scale_name)
  if (is.null(pattern)) {
    stop(paste("Unknown scale:", scale_name))
  }

  semitones <- pattern_to_semitones(pattern$pattern)
  intervals <- list()

  for (i in seq_along(semitones)) {
    intervals[[i]] <- list(
      degree = i,
      semitones = semitones[i],
      symbol = pattern$pattern[i]
    )
  }

  return(intervals)
}

# Function to transpose a scale to a different key
transpose_scale <- function(scale_name, key) {
  # Get the base scale intervals
  intervals <- get_scale_intervals(scale_name)

  # Get the semitone offset for the new key
  if (!(key %in% names(note_semitones))) {
    stop(paste("Invalid key:", key))
  }
  key_offset <- note_semitones[[key]]

  # Transpose each interval
  transposed <- list()
  for (interval in intervals) {
    transposed[[length(transposed) + 1]] <- list(
      degree = interval$degree,
      semitones = (interval$semitones + key_offset) %% 12,
      symbol = interval$symbol
    )
  }

  return(transposed)
}

get_scale_fretboard_positions <- function(
  scale_name,
  key,
  start_fret = 0,
  end_fret = 12
) {
  # Get the transposed scale
  scale <- transpose_scale(scale_name, key)
  tuning_list <- strsplit(tuning, " ")[[1]]

  tuning_semitones <- sapply(tuning_list, function(note) {
    # Extract the base note (without octave)
    base_note <- gsub("[0-9]", "", note)
    # Convert to uppercase for the note_semitones lookup
    base_note <- toupper(base_note)
    note_semitones[[base_note]]
  })

  # Calculate all possible positions
  positions <- list()
  for (i in seq_along(tuning_semitones)) {
    string <- 7 - i # string 6 for i=1, ..., string 1 for i=6
    string_semitones <- tuning_semitones[i]
    for (fret in start_fret:end_fret) {
      note_semitones_val <- (string_semitones + fret) %% 12
      for (interval in scale) {
        if (interval$semitones == note_semitones_val) {
          positions[[length(positions) + 1]] <- list(
            string = string,
            fret = fret,
            degree = interval$degree,
            symbol = interval$symbol
          )
        }
      }
    }
  }

  return(positions)
}

plot_scale <- function(scale_name, key, start_fret = 0, end_fret = 12) {
  # Get the positions
  positions <- get_scale_fretboard_positions(
    scale_name,
    key,
    start_fret,
    end_fret
  )

  # Extract string and fret positions
  strings <- sapply(positions, function(p) p$string)
  frets <- sapply(positions, function(p) p$fret)
  labels <- sapply(positions, function(p) p$symbol)

  # Create color vectors for all notes
  point_colors <- rep("black", length(strings))
  label_colors <- rep("white", length(strings))

  # ----------------------------------------------------------------------------
  # Set special colors for root, 3rd, 5th, and 7th notes

  # Find root note positions (degree 1)
  root_positions <- which(sapply(positions, function(p) p$degree == 1))

  # Set colors for root notes
  point_colors[root_positions] <- "white"
  label_colors[root_positions] <- "black"

  # Find positions for degrees 3, 5, and 7
  degree_357_positions <- which(sapply(
    positions,
    function(p) p$degree %in% c(3, 5, 7)
  ))

  # Set colors for degrees 3, 5, and 7
  point_colors[degree_357_positions] <- "gray30"
  label_colors[degree_357_positions] <- "white"
  # ----------------------------------------------------------------------------

  # Create the plot
  p <- plot_fretboard(
    string = strings,
    fret = frets,
    labels = labels,
    horizontal = TRUE,
    tuning = tuning,
    show_tuning = TRUE,
    fret_labels = c(3, 5, 7, 9, 12),
    label_color = label_colors,
    point_fill = point_colors
  )

  # Add title
  title <- paste(key, scale_name, "Scale")
  p <- p + ggplot2::ggtitle(title)

  save_plot_to_file(p, title)

  return(p)
}

# Example usage:
# Plot C Phrygian Dominant scale
#   p <- plot_scale("Phrygian Dominant", "C")

get_interval_by_degree <- function(degree) {
  # Validate input
  if (is.null(degree) || is.na(degree) || !is.numeric(degree)) {
    return(NULL)
  }

  for (interval in major_scale_intervals) {
    if (interval$degree == degree) {
      return(interval)
    }
  }
  return(NULL)
}

get_interval_by_semitones <- function(semitones) {
  # Validate input
  if (is.null(semitones) || is.na(semitones) || !is.numeric(semitones)) {
    return(NULL)
  }

  for (interval in major_scale_intervals) {
    if (interval$semitones == semitones) {
      return(interval)
    }
  }
  return(NULL)
}

# Function to get all intervals up to a certain number of semitones
get_intervals_up_to_semitones <- function(max_semitones) {
  # Validate input
  if (
    is.null(max_semitones) || is.na(max_semitones) || !is.numeric(max_semitones)
  ) {
    return(list())
  }

  result <- list()
  for (interval in major_scale_intervals) {
    if (interval$semitones <= max_semitones) {
      result <- c(result, list(interval))
    }
  }
  return(result)
}

# Function to print positions as a markdown table
print_positions_table <- function(positions) {
  # Create header
  cat("| String | Fret | Degree | Symbol |\n")
  cat("|--------|------|--------|--------|\n")

  # Print each position
  for (pos in positions) {
    cat(sprintf(
      "| %d | %d | %d | %s |\n",
      pos$string,
      pos$fret,
      pos$degree,
      pos$symbol
    ))
  }
}
