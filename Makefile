# Makefile for r-guitar-perfect-fourths
# @cursor-rule: preserve-all-tasks
# This rule instructs Cursor to preserve all tasks in this Makefile.
# Do not delete or modify any task definitions without explicit approval.

.PHONY: all lilypond run format install-hooks test clean

all: lilypond run

# Install LilyPond using Homebrew
lilypond:
	brew install lilypond

# Run the R script to generate the visualization
run: clean
	Rscript guitar_scale.R
	Rscript guitar_chord.R
	Rscript guitar_scale_relative.R
	Rscript guitar_modal_scales.R

# Format R files
format:
	air format *.R

# Install git hooks
install-hooks:
	@mkdir -p .git/hooks
	@echo '#!/bin/sh\nmake format' > .git/hooks/pre-commit
	@chmod +x .git/hooks/pre-commit
	@echo "Git hooks installed successfully"

# Run tests
test:
	@echo "Running music theory tests..."
	@Rscript test_music_theory.R
	@echo "Running plotting utility tests..."
	@Rscript test_utils_plot.R

# Required: Clean up generated files before running scripts
# This task must be preserved as it's a dependency for the run task
clean:
	rm -rf plots/*