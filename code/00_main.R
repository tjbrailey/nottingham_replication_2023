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

# read in datasets
source(paste0(here::here("code"), "/02_read_data.R"))

# run power simulations
source(paste0(here::here("code"), "/03_power_simulation.R"))

# replication code 
source(paste0(here::here("code"), "/04_replicate_analysis.R"))
