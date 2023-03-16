###########################################################################
##### Main code file
###
### Running this file will run all cleaning and analysis code
###
#####
###########################################################################

###########################################################################
##### Preliminaries

rm(list = ls())

gc()

library(ggplot2)
library(magrittr)

###########################################################################
##### Source code

# install packages
source(paste0(here::here("code"), "/01_install_packages.R"))

# read in functions
source(paste0(here::here("code"), "/02_read_functions.R"))

# read in datasets
source(paste0(here::here("code"), "/03_read_data.R"))

# run power simulations
#source(paste0(here::here("code"), "/04_power_simulation.R")) # no dependencies

# replication code 
source(paste0(here::here("code"), "/05_replicate_analysis.R"))

# extension of analysis (robustness, sensitivity)
source(paste0(here::here("code", "/06_extend_analysis.R")))
