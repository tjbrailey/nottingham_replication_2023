

df_original %>% 
  dplyr::group_by(country) %>% 
  dplyr::summarise(
    mean = mean(durationinseconds, na.rm = TRUE),
    sd   = sd(durationinseconds, na.rm = TRUE),
    median = median(durationinseconds, na.rm = TRUE),
    n    = dplyr::n())

df_original %>% 
  dplyr::summarise(
    mean = round(mean(durationinseconds, na.rm = TRUE)),
    sd   = round(sd(durationinseconds, na.rm = TRUE)),
    median = round(median(durationinseconds, na.rm = TRUE)),
    n    = dplyr::n())
