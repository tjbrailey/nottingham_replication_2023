###########################################################################
##### install datasets

gc()

# original dataset us for the replication package
df_original <- read.csv(
  paste0(here::here("replication_package"), "/dataset.csv"))

df_original %>% 
  dplyr::summarise(
    ., 
    dplyr::across(
      dplyr::everything(),
      ~ c(class(.), 
          mean(., na.rm = TRUE),
          min(.,  na.rm = TRUE),
          max(.,  na.rm = TRUE), 
          sd(.,   na.rm = TRUE),
          sum(is.na(.))))) %>% 
  dplyr::mutate(check = c(
    "class", "mean", "min", 
    "max", "sd", "missing")) %>%
  dplyr::select(check, dplyr::everything())
