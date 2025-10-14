############################################################
# Assignment Title: Spatial Epidemiology Homework 1
# Author: Group 4
# Question: 1
############################################################

rm(list = ls()) 


# packages ----------------------------------------------------------------
require(pacman)
pacman::p_load(tidyverse, here, sf,
               tmap, spdep, nimble, coda, INLA,
               cowplot, stats4, formatR, readxl, rootSolve)

#load data
sp_epi_df <- read_excel("raw_data/DDK - 2022.xlsx" )

################################################################################
################################################################################
#####  Overall for the standard population
################################################################################
#######============Define age and sex groups
groups <- c(
  "male_50_54", "male_55_59", "male_60_64", "male_65_69", "male_70_74",
  "female_50_54", "female_55_59", "female_60_64", "female_65_69", "female_70_74"
)

# Create a tidy data frame for results & Specify column indices for Y and N values
rate <- data.frame(group = groups)
Y_cols <- c(12, 14, 16, 18, 20, 13, 15, 17, 19, 21)
N_cols <- c(2, 4, 6, 8, 10, 3, 5, 7, 9, 11)

# Compute sums for each group
rate$Y <- sapply(Y_cols, function(i) sum(sp_epi_df[[i]], na.rm = TRUE))
rate$N <- sapply(N_cols, function(i) sum(sp_epi_df[[i]], na.rm = TRUE))

# Calculate rate (handling division by zero)
rate$rate <- ifelse(rate$N > 0, rate$Y / rate$N, NA)

# View the resulting table
print(rate)

