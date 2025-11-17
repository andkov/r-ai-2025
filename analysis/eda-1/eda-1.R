rm(list = ls(all.names = TRUE)) # Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.
cat("\014") # Clear the console
# verify root location
cat("Working directory: ", getwd()) # Must be set to Project Directory
# Project Directory should be the root by default unless overwritten

# ---- load-packages -----------------------------------------------------------
# Choose to be greedy: load only what's needed
# Three ways, from least (1) to most(3) greedy:
# -- 1.Attach these packages so their functions don't need to be qualified: 
# http://r-pkgs.had.co.nz/namespace.html#search-path
library(magrittr)
library(ggplot2)   # graphs
library(forcats)   # factors
library(stringr)   # strings
library(lubridate) # dates
library(labelled)  # labels
library(dplyr)     # data wrangling
library(tidyr)     # data wrangling
library(scales)    # format
library(broom)     # for model
library(emmeans)   # for interpreting model results
library(ggalluvial)
library(janitor)  # tidy data
library(testit)   # For asserting conditions meet expected patterns.


# ---- httpgd (VS Code interactive plots) ------------------------------------
# If the httpgd package is installed, try to start it so VS Code R extension
# can display interactive plots. This is optional and wrapped in tryCatch so
# the script still runs when httpgd is absent or fails to start.
if (requireNamespace("httpgd", quietly = TRUE)) {
	tryCatch({
		# Attempt to start httpgd server (API may vary by version); quiet on success
		if (is.function(httpgd::hgd)) {
			httpgd::hgd()
		} else if (is.function(httpgd::httpgd)) {
			httpgd::httpgd()
		} else {
			# Generic call attempt; will be caught if function not found
			httpgd::hgd()
		}
		message("httpgd started (if available). Configure your VS Code R extension to use it for plots.")
	}, error = function(e) {
		message("httpgd detected but failed to start: ", conditionMessage(e))
	})
} else {
	message("httpgd not installed. To enable interactive plotting in VS Code, install httpgd (binary recommended on Windows) or use other devices (svg/png).")
}

# ---- load-sources ------------------------------------------------------------
base::source("./scripts/common-functions.R") # project-level
base::source("./scripts/operational-functions.R") # project-level

# ---- declare-globals ---------------------------------------------------------

local_root <- "./analysis/eda-1/"
local_data <- paste0(local_root, "data-local/") # for local outputs

if (!fs::dir_exists(local_data)) {fs::dir_create(local_data)}

data_private_derived <- "./data-private/derived/eda-1/"
if (!fs::dir_exists(data_private_derived)) {fs::dir_create(data_private_derived)}

prints_folder <- paste0(local_root, "prints/")
if (!fs::dir_exists(prints_folder)) {fs::dir_create(prints_folder)}


# ---- declare-functions -------------------------------------------------------
# base::source(paste0(local_root,"local-functions.R")) # project-level

# ---- load-data --------------------------------------

# ---- inspect-data -------------------------------------
ds_year %>% glimpse()
source("./scripts/silent-mini-eda.R")
silent_mini_eda("ds_year")

# ---- tweak-data-0 -------------------------------------

# ---- inspect-data-0 -------------------------------------

# ---- inspect-data-1 -------------------------------------

# ---- inspect-data-2 -------------------------------------

# ---- g1 -----------------------------------------------------
# Explore mtcars dataset structure
mtcars %>% glimpse()

# Scatter plot: MPG vs Weight, colored by cylinders
g1 <- mtcars %>% 
  ggplot(aes(x = wt, y = mpg, color = factor(cyl), fill = factor(cyl))) +
  stat_ellipse(geom = "polygon", alpha = 0.15, level = 0.95) +
  geom_point(size = 5, alpha = 0.8) +
  geom_smooth(method = "lm", se = FALSE, linewidth = 1) +
  labs(
    title = "Fuel Efficiency vs Vehicle Weight",
    subtitle = "Grouped by number of cylinders (95% confidence ellipses)",
    x = "Weight (1000 lbs)",
    y = "Miles per Gallon",
    color = "Cylinders",
    fill = "Cylinders"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    legend.position = "bottom"
  )

print(g1)

# ---- g2 -----------------------------------------------------
# Distribution of MPG by transmission type
g2 <- mtcars %>% 
  mutate(transmission = factor(am, labels = c("Automatic", "Manual"))) %>% 
  ggplot(aes(x = transmission, y = mpg, fill = transmission)) +
  geom_boxplot(alpha = 0.7) +
  geom_jitter(width = 0.2, alpha = 0.4) +
  labs(
    title = "Fuel Efficiency by Transmission Type",
    x = "Transmission",
    y = "Miles per Gallon"
  ) +
  scale_fill_manual(values = c("Automatic" = "#E69F00", "Manual" = "#56B4E9")) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    legend.position = "none"
  )

print(g2)

# ---- g3 -----------------------------------------------------
# Horsepower vs Quarter Mile Time
g3 <- mtcars %>% 
  ggplot(aes(x = hp, y = qsec, size = wt, color = factor(cyl))) +
  geom_point(alpha = 0.6) +
  labs(
    title = "Performance: Horsepower vs Quarter Mile Time",
    subtitle = "Bubble size represents vehicle weight",
    x = "Horsepower",
    y = "Quarter Mile Time (seconds)",
    color = "Cylinders",
    size = "Weight"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    legend.position = "right"
  )

print(g3)

