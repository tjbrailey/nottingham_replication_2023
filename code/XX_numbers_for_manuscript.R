###########################################################################
##### Numbers referenced in manuscript

# If we need to calculate a certain statistic to use in the article, here 
# is where we calculate it. Once the manuscript is complete, we will 
# include a comment on the page number that the statistic is used.

# duration of responses by country
df_original %>% 
  dplyr::group_by(country) %>% 
  dplyr::summarise(
    mean = mean(durationinseconds, na.rm = TRUE),
    sd   = sd(durationinseconds, na.rm = TRUE),
    median = median(durationinseconds, na.rm = TRUE),
    n    = dplyr::n())

# global average of duration of response
df_original %>% 
  dplyr::summarise(
    mean = round(mean(durationinseconds, na.rm = TRUE)),
    sd   = round(sd(durationinseconds, na.rm = TRUE)),
    median = round(median(durationinseconds, na.rm = TRUE)),
    n    = dplyr::n())
