# Load the music theory code
source("music_theory.R")

# Test the major scale intervals data structure
test_major_scale_intervals <- function() {
  # Test structure of intervals
  stopifnot(
    length(major_scale_intervals) == 8,
    all(sapply(major_scale_intervals, function(x) all(c("name", "degree", "semitones", "symbol") %in% names(x))))
  )

  # Test degrees are sequential
  degrees <- sapply(major_scale_intervals, function(x) x$degree)
  stopifnot(all(degrees == 1:8))

  # Test semitones follow major scale pattern
  semitones <- sapply(major_scale_intervals, function(x) x$semitones)
  expected_semitones <- c(0, 2, 4, 5, 7, 9, 11, 12)
  stopifnot(all(semitones == expected_semitones))

  # Test symbols are correct
  symbols <- sapply(major_scale_intervals, function(x) x$symbol)
  expected_symbols <- as.character(1:8)
  stopifnot(all(symbols == expected_symbols))

  print("All major_scale_intervals tests passed!")
}

# Test get_interval_by_degree
test_get_interval_by_degree <- function() {
  # Test getting root
  root <- get_interval_by_degree(1)
  stopifnot(
    root$name == "Root",
    root$semitones == 0,
    root$symbol == "1"
  )

  # Test getting major third
  third <- get_interval_by_degree(3)
  stopifnot(
    third$name == "Major Third",
    third$semitones == 4,
    third$symbol == "3"
  )

  # Test getting octave
  octave <- get_interval_by_degree(8)
  stopifnot(
    octave$name == "Octave",
    octave$semitones == 12,
    octave$symbol == "8"
  )

  # Test invalid degrees
  stopifnot(
    is.null(get_interval_by_degree(0)),
    is.null(get_interval_by_degree(9)),
    is.null(get_interval_by_degree(-1)),
    is.null(get_interval_by_degree(NA)),
    is.null(get_interval_by_degree(NULL))
  )

  print("All get_interval_by_degree tests passed!")
}

# Test get_interval_by_semitones
test_get_interval_by_semitones <- function() {
  # Test getting root
  root <- get_interval_by_semitones(0)
  stopifnot(
    root$name == "Root",
    root$degree == 1,
    root$symbol == "1"
  )

  # Test getting perfect fourth
  fourth <- get_interval_by_semitones(5)
  stopifnot(
    fourth$name == "Perfect Fourth",
    fourth$degree == 4,
    fourth$symbol == "4"
  )

  # Test getting major seventh
  seventh <- get_interval_by_semitones(11)
  stopifnot(
    seventh$name == "Major Seventh",
    seventh$degree == 7,
    seventh$symbol == "7"
  )

  # Test invalid semitones
  stopifnot(
    is.null(get_interval_by_semitones(13)),
    is.null(get_interval_by_semitones(-1)),
    is.null(get_interval_by_semitones(NA)),
    is.null(get_interval_by_semitones(NULL))
  )

  print("All get_interval_by_semitones tests passed!")
}

# Test get_intervals_up_to_semitones
test_get_intervals_up_to_semitones <- function() {
  # Test getting intervals up to perfect fourth
  intervals <- get_intervals_up_to_semitones(5)
  stopifnot(
    length(intervals) == 4,
    intervals[[1]]$name == "Root",
    intervals[[2]]$name == "Major Second",
    intervals[[3]]$name == "Major Third",
    intervals[[4]]$name == "Perfect Fourth"
  )

  # Test getting all intervals
  all_intervals <- get_intervals_up_to_semitones(12)
  stopifnot(
    length(all_intervals) == 8,
    all_intervals[[8]]$name == "Octave"
  )

  # Test getting no intervals
  no_intervals <- get_intervals_up_to_semitones(-1)
  stopifnot(length(no_intervals) == 0)

  # Test getting intervals at exact semitone values
  fourth_intervals <- get_intervals_up_to_semitones(5)
  stopifnot(
    length(fourth_intervals) == 4,
    fourth_intervals[[4]]$semitones == 5
  )

  # Test getting intervals between semitones
  between_intervals <- get_intervals_up_to_semitones(6)
  stopifnot(
    length(between_intervals) == 4,
    between_intervals[[4]]$semitones == 5
  )

  print("All get_intervals_up_to_semitones tests passed!")
}

# Run all tests
run_all_tests <- function() {
  print("Running music theory tests...")
  test_major_scale_intervals()
  test_get_interval_by_degree()
  test_get_interval_by_semitones()
  test_get_intervals_up_to_semitones()
  print("All tests passed!")
}

# Run the tests
run_all_tests()