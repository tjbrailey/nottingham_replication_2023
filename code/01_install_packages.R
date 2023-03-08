###########################################################################
##### Install packages required for replication and analysis


# call packages
vec_packages <- c(
  "here",
  "magrittr",
  "knitr",
  "ggplot2",
  "dplyr",
  "tidyr",
  "remotes",
  "MASS",
  "grDevices",
  "haven",
  "kableExtra",
  "htmltools",
  "estimatr",
  "cobalt",
  "cjpowR",
  "parallelsugar")

# install packages if not already installed
fxn_package_check <- lapply(
  vec_packages, 
  FUN = function(x) {
    if (!require(x, character.only = TRUE)){
      # if calling packages not on cran
      if(x %in% c("cjpowR", "parallelsugar")){
        devtools::install_github("m-freitag/cjpowR")
        devtools::install_github('nathanvan/parallelsugar')}
      # install packages from cran
      install.packages(x, dependencies = TRUE) 
      # load packages into workspace
      library(x, character.only = TRUE)}})

rm(fxn_package_check, vec_packages)
