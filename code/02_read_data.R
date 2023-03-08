###########################################################################
##### install datasets

# original dataset us for the replication package
df_original <- read.csv(
  paste0(here::here("replication_package"), "/dataset.csv"))

# look at dimensions
df_original_summary <- 
  dplyr::summarise(
    df_original,
    dplyr::across(
      dplyr::everything(),
      ~ c(#expss::var_lab(.),
          class(.), 
          mean(., na.rm = TRUE),
          min(.,  na.rm = TRUE),
          max(.,  na.rm = TRUE), 
          sd(.,   na.rm = TRUE),
          sum(is.na(.))))) %>% 
  dplyr::mutate(check = c(
    #"description", 
    "class", "mean", "min", 
    "max", "sd", "missing")) %>%
  dplyr::select(check, dplyr::everything())
