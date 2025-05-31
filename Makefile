# Makefile for r-guitar-perfect-fourths

.PHONY: all deps lilypond run format install-hooks

all: install-hooksdeps lilypond run

# Install R dependencies
# tabr is installed from GitHub
# remotes is used to install tabr
deps:
	Rscript -e "if (!require('remotes')) install.packages('remotes', repos='https://cloud.r-project.org'); if (!require('ggplot2')) install.packages('ggplot2', repos='https://cloud.r-project.org'); if (!require('tabr')) remotes::install_github('leonawicz/tabr')"

# Install LilyPond using Homebrew
lilypond:
	brew install lilypond

# Run the R script to generate the visualization
run:
	Rscript guitar_scale.R

# Format R files
format:
	air format *.R

# Install git hooks
install-hooks:
	@mkdir -p .git/hooks
	@echo '#!/bin/sh\nmake format' > .git/hooks/pre-commit
	@chmod +x .git/hooks/pre-commit
	@echo "Git hooks installed successfully"