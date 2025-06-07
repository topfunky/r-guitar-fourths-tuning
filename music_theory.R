source("utils_save_file.R")

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

# Define scale patterns
# Each pattern is defined by its name and the intervals relative
# to the major scale.
# Use "♭" for flat (lower by 1 semitone) and "#" for sharp (raise by 1 semitone)
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
    name = "Diminished",
    pattern = c("1", "2", "♭3", "4", "♭5", "♭6", "7")
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
get_scale_pattern <- function(scale_name) {
  for (pattern in scale_patterns) {
    if (tolower(pattern$name) == tolower(scale_name)) {
      return(pattern)
    }
  }
  return(NULL)
}

# Function to convert scale pattern to semitones
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

# Function to get fretboard positions for a scale
get_scale_fretboard_positions <- function(
  scale_name,
  key,
  start_fret = 0,
  end_fret = 12
) {
  # Get the transposed scale
  scale <- transpose_scale(scale_name, key)

  # Define the tuning (EADGCF)
  tuning <- c("E2", "A2", "D3", "G3", "C4", "F4")
  tuning_semitones <- sapply(tuning, function(note) {
    # Extract the base note (without octave)
    base_note <- gsub("[0-9]", "", note)
    note_semitones[[base_note]]
  })

  # Calculate all possible positions
  positions <- list()
  for (string in 1:6) {
    string_semitones <- tuning_semitones[string]
    for (fret in start_fret:end_fret) {
      note_semitones <- (string_semitones + fret) %% 12
      for (interval in scale) {
        if (interval$semitones == note_semitones) {
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

# Function to plot a scale on the fretboard
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

  # Create the plot
  p <- plot_fretboard(
    string = strings,
    fret = frets,
    labels = labels,
    horizontal = TRUE,
    tuning = "e2 a2 d3 g3 c4 f4",
    show_tuning = TRUE,
    fret_labels = c(3, 5, 7, 9, 12),
    label_color = "white",
    point_fill = "black"
  )

  # Add title
  title <- paste(key, scale_name, "Scale")
  p <- p + ggtitle(title)

  save_plot_to_file(p, title)

  return(p)
}

# Example usage:
# Plot C Phrygian Dominant scale
#   p <- plot_scale("Phrygian Dominant", "C")

# Function to get interval by degree
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

# Function to get interval by semitones
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
