# Makefile for r-guitar-perfect-fourths
# @cursor-rule: preserve-all-tasks
# This rule instructs Cursor to preserve all tasks in this Makefile.
# Do not delete or modify any task definitions without explicit approval.

.PHONY: all lilypond run format install-hooks test clean dependencies act

all: lilypond run

# Run the GitHub Actions workflow locally
act:
	act -W .github/workflows/test.yml --container-architecture linux/amd64

# Install LilyPond on macOS with Homebrew
lilypond:
	brew install lilypond
	brew install lilypond-font-manager

# Install R language dependencies
dependencies:
	Rscript dependencies.R

# Run the R script to generate the visualization
run: clean
	Rscript guitar_chord.R
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