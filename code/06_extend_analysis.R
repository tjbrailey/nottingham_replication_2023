###########################################################################
##### Extension of analysis (robustness, sensitivity)

###########################################################################
##### Robustness to response times

summary(df_original$durationinseconds)

ggplot(data = dplyr::filter(
  df_original,
  durationinseconds <= 5000)) + 
  geom_histogram(mapping = aes(x = durationinseconds)) + 
  theme_minimal() + 
  theme(aspect.ratio = 1)

ggplot(data = dplyr::filter(
  df_original,
  durationinseconds <= 5000)) + 
  geom_histogram(mapping = aes(x = durationinseconds)) + 
  facet_wrap(. ~ country) + 
  labs(
    x = "Time Taken (Seconds)", y = "Frequency", 
    title = "Distribution of Time Taken to Complete the Experiment") + 
  theme_bw() + 
  theme(aspect.ratio = 1)
ggsave(plot = last_plot(),
       filename = here::here(
         "exhibits", "figures", "time_taken_distribution.pdf"),
       width = 10, 
       height = 10)

# create vector of quantiles of respondent duration
vec_durations_q <- quantile(df_original$durationinseconds, 
                            probs = c(seq(0, 1, 0.1)))

# create subsets
df_original_10pct <- dplyr::filter(
  df_original, 
  durationinseconds >= vec_durations_q[2] & 
    durationinseconds <= vec_durations_q[10])

df_original_20pct <- dplyr::filter(
  df_original, 
  durationinseconds >= vec_durations_q[3] & 
    durationinseconds <= vec_durations_q[9])

df_original_30pct <- dplyr::filter(
  df_original, 
  durationinseconds >= vec_durations_q[4] & 
    durationinseconds <= vec_durations_q[8])

df_original_40pct <- dplyr::filter(
  df_original, 
  durationinseconds >= vec_durations_q[5] & 
    durationinseconds <= vec_durations_q[7])

# run regressions over different subsets
response_times_10pct <- lapply(
  X = seq_along(vec_table_a1_columns),
  FUN = function(y){
    out <- fxn_regression(
      data = df_original_10pct,
      formula = "support_rc ~ candemmg_rc2 + cancom_rc2", 
      cntry = vec_table_a1_columns[y])
    return(out)})

response_times_20pct <- lapply(
  X = seq_along(vec_table_a1_columns),
  FUN = function(y){
    out <- fxn_regression(
      data = df_original_20pct,
      formula = "support_rc ~ candemmg_rc2 + cancom_rc2", 
      cntry = vec_table_a1_columns[y])
    return(out)})

response_times_30pct <- lapply(
  X = seq_along(vec_table_a1_columns),
  FUN = function(y){
    out <- fxn_regression(
      data = df_original_30pct,
      formula = "support_rc ~ candemmg_rc2 + cancom_rc2", 
      cntry = vec_table_a1_columns[y])
    return(out)})

response_times_40pct <- lapply(
  X = seq_along(vec_table_a1_columns),
  FUN = function(y){
    out <- fxn_regression(
      data = df_original_40pct,
      formula = "support_rc ~ candemmg_rc2 + cancom_rc2", 
      cntry = vec_table_a1_columns[y])
    return(out)})

response_times_100pct <- lapply(
  X = seq_along(vec_table_a1_columns),
  FUN = function(y){
    out <- fxn_regression(
      data = df_original,
      formula = "support_rc ~ candemmg_rc2 + cancom_rc2", 
      cntry = vec_table_a1_columns[y])
    return(out)})

my_list <- list()
for(i in c(10, 20, 30, 40, 100)){
my_list[[as.character(i)]] <- lapply(X = 1:6, FUN = function(x){
  estimate <- get(paste0("response_times_", i, "pct"))[[x]]$coefficients
  std_error <- get(paste0("response_times_", i, "pct"))[[x]]$std.error
  conf_low <- get(paste0("response_times_", i, "pct"))[[x]]$conf.low
  conf_high <- get(paste0("response_times_", i, "pct"))[[x]]$conf.high
  out <- data.frame(
    "subset" = i,
    "outcome" = vec_table_a1_columns[x], 
    "estimate" = estimate,
    "std_error" = std_error,
    "conf_high" = conf_high,
    "conf_low" = conf_low)
  out %<>% tibble::rownames_to_column(var = "coef")
  return(out)
})
}

df_response_times <- dplyr::bind_rows(my_list)

ggplot(data = dplyr::filter(df_response_times, coef != "(Intercept)"),
       mapping = aes(x = estimate, y = coef, colour = factor(subset))) + 
  geom_point() + 
  geom_errorbar(mapping = aes(xmin = conf_low, xmax = conf_high)) + 
  geom_vline(xintercept = 0, linetype = "dashed") + 
  facet_wrap(. ~ outcome) +
  scale_color_manual(values = c(
    "10" = "#999999",    
    "20" = "#E69F00",
    "30" = "#56B4E9",
    "40" = "#CC79A7",
    "100" = "#F0E442"),
    labels = c(
      "10" = "10th percentiles dropped",
      "20" = "20th percentiles dropped", 
      "30" = "30th percentiles dropped", 
      "40" = "40th percentiles dropped", 
      "100" = "Full dataset")) + 
  labs(x = "Point estimate", 
       y = "Coefficient", 
       color = "Restriction") +
  theme_bw() +
  theme(aspect.ratio = 1,
        legend.position = "bottom")
ggsave(plot = last_plot(),
       filename = here::here(
         "exhibits", "figures", "estimates_by_time_taken.pdf"),
       width = 10,
       height = 10)

###########################################################################
##### Robustness to alternative specifications

# ordered logistic regression
reg_olog1 <- MASS::polr(as.factor(support) ~ candemmg + cancom, data = df_original)

#  brant test 
brant::brant(reg_olog1) # fails

# multinomial logit
reg_mlog1 <- nnet::multinom(as.factor(support) ~ candemmg + cancom, 
                            data = df_original)

# tabulate outcome
reg_mlog1 %>% 
  gtsummary::tbl_regression(exponentiate = TRUE) %>% 
  gtsummary::as_kable_extra(tbl, format = "latex")

# example candidate
eg <- dplyr::filter(df_original, country == "CZ", respondentid %in% 4:5)

###########################################################################
##### dropping inattentive subsets

inattentive <- lapply(
  X = seq_along(vec_table_a1_columns),
  FUN = function(y){
    out <- fxn_regression(
      data = dplyr::filter(
        df_original,
        correctatte == "Attentive"),
      formula = "support_rc ~ candemmg_rc2 + cancom_rc2", 
      cntry = vec_table_a1_columns[y])
    estimate <- out$coefficients
    std_error <- out$std.error
    conf_low <- out$conf.low
    conf_high <- out$conf.high
    out <- data.frame(
      "outcome" = vec_table_a1_columns[y],
      "estimate" = estimate,
      "std_error" = std_error,
      "conf_high" = conf_high,
      "conf_low" = conf_low)
    out %<>% tibble::rownames_to_column(var = "coef")
    return(out)})

df_inattentive <- dplyr::bind_rows(inattentive)

ggplot(data = dplyr::filter(df_inattentive, coef != "(Intercept)"),
       mapping = aes(x = estimate, y = coef)) + 
  geom_point() + 
  geom_errorbar(mapping = aes(xmin = conf_low, xmax = conf_high)) + 
  geom_vline(xintercept = 0, linetype = "dashed") + 
  facet_wrap(. ~ outcome) +
  labs(x = "Point estimate", 
       y = "Coefficient") +
  theme_bw() +
  theme(aspect.ratio = 1,
        legend.position = "bottom")

ggsave(plot = last_plot(),
       filename = here::here(
         "exhibits", "figures", "attentive.pdf"),
       width = 10,
       height = 10)

###########################################################################
##### Fatigue

# binary
df_original %>% 
  dplyr::group_by(country, respondentid, task) %>% 
  dplyr::summarise(
    diff = abs(dplyr::first(support_rc) - dplyr::last(support_rc)),
    diff = ifelse(diff > 0, 1, diff)) %>% 
  dplyr::group_by(country, task) %>% 
  dplyr::summarise(
    mean = mean(diff, na.rm = TRUE)) %>% 
  ggplot(., mapping = aes(x = task, y = mean, color = country)) +
  geom_line() + 
  theme_bw() +
  labs(x = "Task Number", y = "Mean Difference in Choice\nBetween Candidates") +
  theme(aspect.ratio = 1, 
        legend.position = "bottom")

# non-binary
df_original %>% 
  dplyr::group_by(country, respondentid, task) %>% 
  dplyr::summarise(
    diff = abs(dplyr::first(support_rc) - dplyr::last(support_rc))) %>% 
  dplyr::group_by(country, task) %>% 
  dplyr::summarise(
    mean = mean(diff, na.rm = TRUE)) %>% 
  ggplot(., mapping = aes(x = task, y = mean, color = country)) +
  geom_line() + 
  theme_bw() +
  labs(x = "Task Number", y = "Mean Difference in Choice\nBetween Candidates") +
  theme(aspect.ratio = 1, 
        legend.position = "bottom")

df_original %>% 
  dplyr::group_by(respondentid, task) %>% 
  dplyr::summarise(
    diff = abs(dplyr::first(support_rc) - dplyr::last(support_rc))) %>% 
  dplyr::group_by(task) %>% 
  dplyr::summarise(
    mean = mean(diff, na.rm = TRUE)) %>%
  ggplot(., mapping = aes(x = task, y = mean)) +
  geom_line() + 
  theme_bw() +
  labs(x = "Task Number", y = "Mean Difference in Choice\nBetween Candidates") +
  theme(aspect.ratio = 1, 
        legend.position = "bottom")

estimatr::lm_robust(
  support_rc ~ candemmg_rc2 * cancom_rc2, 
  data = dplyr::filter(df_original, task == 5))

  