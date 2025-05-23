# Makefile for r-guitar-perfect-fourths

.PHONY: all deps lilypond run format

all: deps lilypond run

# Install R dependencies
# tabr is installed from GitHub
# remotes is used to install tabr
deps:
	Rscript -e "if (!require('remotes')) install.packages('remotes', repos='https://cloud.r-project.org'); if (!require('ggplot2')) install.packages('ggplot2', repos='https://cloud.r-project.org'); if (!require('tabr')) remotes::install_github('leonawicz/tabr')"

# Install LilyPond using Homebrew
lilypond:
	brew install --cask lilypond

# Run the R script to generate the visualization
run:
	Rscript guitar_scale.R

# Format R code using Air
format:
	air format guitar_scale.R