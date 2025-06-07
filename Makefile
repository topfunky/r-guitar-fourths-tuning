# Makefile for r-guitar-perfect-fourths

.PHONY: all deps lilypond run format install-hooks test

all: deps lilypond run

# Install R dependencies
# tabr is installed from GitHub
# remotes is used to install tabr
deps:
	Rscript -e "if (!require('remotes')) install.packages('remotes')"
	Rscript -e "if (!require('tabr')) remotes::install_github('leonawicz/tabr')"
	Rscript -e "if (!require('ggplot2')) install.packages('ggplot2')"
	Rscript -e "if (!require('styler')) install.packages('styler')"

# Install LilyPond using Homebrew
lilypond:
	brew install lilypond

# Run the R script to generate the visualization
run: clean
	Rscript guitar_scale.R
	Rscript guitar_chord.R
	Rscript guitar_scale_relative.R

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