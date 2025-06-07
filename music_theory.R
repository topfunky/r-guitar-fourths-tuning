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

# Example usage:
# Get the major third interval
# third <- get_interval_by_degree(3)
# print(third$name)  # "Major Third"
# print(third$semitones)  # 4

# Get all intervals up to the perfect fifth
# intervals_up_to_fifth <- get_intervals_up_to_semitones(7)
# for (interval in intervals_up_to_fifth) {
#   print(paste(interval$name, ":", interval$semitones, "semitones"))
# }
