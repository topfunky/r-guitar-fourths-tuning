# Load the plotting utilities
source("utils_plot.R")

# Test save_plot_to_file
test_save_plot_to_file <- function() {
  # Create a simple plot
  p <- ggplot2::ggplot() + ggplot2::geom_point()

  # Test saving with a simple name
  save_plot_to_file(p, "test_plot")
  stopifnot(file.exists("plots/test_plot.png"))

  # Test saving with spaces in name
  save_plot_to_file(p, "test plot with spaces")
  stopifnot(file.exists("plots/test_plot_with_spaces.png"))

  # Clean up test files
  unlink("plots/test_plot.png")
  unlink("plots/test_plot_with_spaces.png")

  print("All save_plot_to_file tests passed!")
}

# Test plot_and_save_chord
test_plot_and_save_chord <- function() {
  # Test basic chord plotting
  p1 <- plot_and_save_chord(
    chord_name = "test_chord",
    fret_positions = c(0, 2, 2, 1, 0, 0)
  )
  stopifnot(
    inherits(p1, "ggplot"),
    file.exists("plots/test_chord.png")
  )

  # Test chord with muted strings
  p2 <- plot_and_save_chord(
    chord_name = "test_chord_muted",
    fret_positions = c(0, NA, 2, 1, 0, NA)
  )
  stopifnot(
    inherits(p2, "ggplot"),
    file.exists("plots/test_chord_muted.png")
  )

  # Test chord with custom colors
  p3 <- plot_and_save_chord(
    chord_name = "test_chord_colors",
    fret_positions = c(0, 2, 2, 1, 0, 0),
    point_fill = "red",
    label_color = "yellow"
  )
  stopifnot(
    inherits(p3, "ggplot"),
    file.exists("plots/test_chord_colors.png")
  )

  # Clean up test files
  unlink("plots/test_chord.png")
  unlink("plots/test_chord_muted.png")
  unlink("plots/test_chord_colors.png")

  print("All plot_and_save_chord tests passed!")
}

# Test plot_and_save_scale
test_plot_and_save_scale <- function() {
  # Test basic scale plotting
  p1 <- plot_and_save_scale(
    string_positions = c(6, 6, 5, 5, 4, 4),
    fret_positions = c(0, 2, 0, 2, 0, 2),
    title = "test_scale"
  )
  stopifnot(
    inherits(p1, "ggplot"),
    file.exists("plots/scale_test_scale.png")
  )

  # Test scale with highlighted notes
  p2 <- plot_and_save_scale(
    string_positions = c(6, 6, 5, 5, 4, 4),
    fret_positions = c(0, 2, 0, 2, 0, 2),
    title = "test_scale_highlighted",
    highlight_positions = c(1, 3, 5),
    highlight_color = "red",
    highlight_label_color = "white"
  )
  stopifnot(
    inherits(p2, "ggplot"),
    file.exists("plots/scale_test_scale_highlighted.png")
  )

  # Test scale with custom labels
  p3 <- plot_and_save_scale(
    string_positions = c(6, 6, 5, 5, 4, 4),
    fret_positions = c(0, 2, 0, 2, 0, 2),
    title = "test_scale_labels",
    note_labels = c("R", "2", "R", "2", "R", "2")
  )
  stopifnot(
    inherits(p3, "ggplot"),
    file.exists("plots/scale_test_scale_labels.png")
  )

  # Test input validation
  tryCatch(
    {
      plot_and_save_scale(
        string_positions = c(6, 6),
        fret_positions = c(0, 2, 0), # Mismatched lengths
        title = "test_scale_error"
      )
      stop("Should have thrown an error for mismatched lengths")
    },
    error = function(e) {
      if (!grepl("must have the same length", e$message)) {
        stop("Wrong error message for mismatched lengths")
      }
    }
  )

  tryCatch(
    {
      plot_and_save_scale(
        string_positions = c(6, 7), # Invalid string number
        fret_positions = c(0, 2),
        title = "test_scale_error"
      )
      stop("Should have thrown an error for invalid string number")
    },
    error = function(e) {
      if (!grepl("must be between 1 and 6", e$message)) {
        stop("Wrong error message for invalid string number")
      }
    }
  )

  tryCatch(
    {
      plot_and_save_scale(
        string_positions = c(6, 6),
        fret_positions = c(0, -1), # Negative fret
        title = "test_scale_error"
      )
      stop("Should have thrown an error for negative fret")
    },
    error = function(e) {
      if (!grepl("cannot be negative", e$message)) {
        stop("Wrong error message for negative fret")
      }
    }
  )

  # Clean up test files
  unlink("plots/scale_test_scale.png")
  unlink("plots/scale_test_scale_highlighted.png")
  unlink("plots/scale_test_scale_labels.png")

  print("All plot_and_save_scale tests passed!")
}

# Run all tests
run_all_tests <- function() {
  print("Running plotting utility tests...")
  test_save_plot_to_file()
  test_plot_and_save_chord()
  test_plot_and_save_scale()
  print("All tests passed!")
}

# Run the tests
run_all_tests()
