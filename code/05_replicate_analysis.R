###########################################################################
##### Replication of analysis

table(df_original$cancom)
table(df_original$support)
table(df_original$candemmg)
table(df_original$resp)

df_original %<>% dplyr::mutate(
  support_rc = dplyr::case_when(
    support == "Very unlikely" ~ 1,
    support == "Somewhat unlikely" ~ 2,
    support == "Neither likely nor unlikely" ~ 3,
    support == "Somewhat likely" ~ 4,
    support == "Very likely" ~ 5,
    TRUE ~ NA_real_),
  #support_rc = factor(support_rc),
  cancom_rc = dplyr::case_when(
    cancom == "Very incompetent" ~ 1,
    cancom == "Moderately incompetent" ~ 2,
    cancom == "Neither competent nor incompetent" ~ 3,
    cancom == "Moderately competent" ~ 4,
    cancom == "Very competent" ~ 5,
    TRUE ~ NA_real_),
  cancom_rc = relevel(
    as.factor(cancom_rc),
    ref = "1"),
  candemmg_rc = dplyr::case_when(
    candemmg == "Democratic" ~ 1,
    candemmg == "Undemocratic" ~ 0,
    TRUE ~ NA_real_),
  candemmg_rc = factor(candemmg_rc))

table(df_original$cancom_rc)
class(df_original$cancom_rc)
levels(df_original$cancom_rc)
table(df_original$support_rc)
table(df_original$candemmg_rc)

###########################################################################
##### Figure 1

### pooled model

df_original_sub <- dplyr::filter(df_original, !is.na(support_rc))

# run regression
reg_f1_1 <- lm(
  support_rc ~ candemmg_rc * cancom_rc,
  data = df_original_sub)

texreg::screenreg(reg_f1_1)

# calculate marginal effects
reg_f1_1_me <- ggeffects::ggeffect(
  model = reg_f1_1, 
  terms = c("candemmg_rc [0:1]", 
            "cancom_rc [1:5 by = 1]"))

# calculate contrasts
reg_f1_1_emm <- emmeans::emmeans(
  object = reg_f1_1,
  specs = ~ candemmg_rc * cancom_rc, 
  vcov = sandwich::vcovCL(
    x = reg_f1_1, 
    cluster = df_original_sub$resp))

reg_f1_1_c <- emmeans::contrast(
  object = reg_f1_1_emm, 
  interaction = TRUE) %>%
  as.data.frame(.) %>% 
  dplyr::filter(candemmg_rc_eff == "0 effect") %>%
  dplyr::mutate(
    conf_low = estimate - (1.96 * SE),
    conf_high = estimate + (1.96 * SE),
    index = dplyr::row_number()) %>% 
  dplyr::filter(cancom_rc_eff != "3 effect")

mm_pooled <- mm_plot(reg_f1_1_me, title = "Pooled", legend = TRUE)
mm_pooled

mm_c_pooled <- mm_c_plot(reg_f1_1_c, title = NULL)
mm_c_pooled

### country subsets

# countries to loop over
vec_countries <- sort(unique(df_original$country))

# store plots
list_plots <- lapply(
  X = seq_along(vec_countries), 
  FUN = function(x){
    
    # create data subset
    df_original_sub <- dplyr::filter(
      df_original, 
      country == vec_countries[x])
    
    # run regression
    reg_f1_s <- lm(
      support_rc ~ candemmg_rc * cancom_rc,
      clusters = resp, 
      data = dplyr::filter(
        df_original, 
        country == vec_countries[x]))
    
    # calculate marginal effects
    reg_f1_s_me <- ggeffects::ggeffect(
      model = reg_f1_s, 
      terms = c("candemmg_rc", 
                "cancom_rc [1:5 by = 1]"))
    
    # calculate contrasts
    reg_f1_s_emm <- emmeans::emmeans(
      reg_f1_s, 
      ~ candemmg_rc * cancom_rc, 
      type = "response")
    
    reg_f1_s_c <- emmeans::contrast(
      reg_f1_s_emm, interaction = TRUE) %>%
      as.data.frame(.) %>% 
      dplyr::filter(candemmg_rc_eff == "0 effect") %>%
      dplyr::mutate(
        conf_low = estimate - 1.96 * SE,
        conf_high = estimate + 1.96 * SE,
        index = dplyr::row_number()) %>% 
      dplyr::filter(cancom_rc_eff != "3 effect")
    
    # progress
    print(paste("Done with", vec_countries[x]))
    
    # save
    plots <- list()
    plots[["marginals"]] <- mm_plot(reg_f1_s_me, vec_countries[x])
    plots[["contrasts"]] <- mm_c_plot(reg_f1_s_c, title = NULL)
    
    return(plots)
    
  })

### Combine all subpanels into final exhibit
figure1 <- cowplot::plot_grid(
  mm_pooled, 
  list_plots[[1]]$marginals, 
  list_plots[[2]]$marginals, 
  
  mm_c_pooled, 
  list_plots[[1]]$contrasts, 
  list_plots[[2]]$contrasts,
  
  list_plots[[3]]$marginals, 
  list_plots[[4]]$marginals, 
  list_plots[[5]]$marginals, 
  
  list_plots[[3]]$contrasts, 
  list_plots[[4]]$contrasts, 
  list_plots[[5]]$contrasts, 
  
  ncol = 3, 
  rel_heights = c(1, 1/2, 1, 1/2, 1, 1/2, 1, 1/2), 
  rel_widths = c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))

figure1 
# save plot
ggsave(
  plot = figure1, 
  filename = paste0(
    here::here("exhibits", "figures"), "/figure1_replication.pdf"),
  height = 15, width = 15)

###########################################################################
##### Figure 1 -- but only using the first two profiles/ tasks

### pooled model

df_original_sub <- dplyr::filter(df_original, !is.na(support_rc))

# run regression
reg_f1_1t2 <- lm(
  support_rc ~ candemmg_rc * cancom_rc,
  data = filter(df_original_sub, task <=2) )

texreg::screenreg(reg_f1_1t2)

# calculate marginal effects
reg_f1_1_meT2 <- ggeffects::ggeffect(
  model = reg_f1_1t2, 
  terms = c("candemmg_rc [0:1]", 
            "cancom_rc [1:5 by = 1]"))

# calculate contrasts
reg_f1_1_emmT2 <- emmeans::emmeans(
  object = reg_f1_1t2,
  specs = ~ candemmg_rc * cancom_rc, 
  vcov = sandwich::vcovCL(
    x = reg_f1_1t2, 
    cluster = df_original_sub$resp))

reg_f1_1_cT2 <- emmeans::contrast(
  object = reg_f1_1_emmT2, 
  interaction = TRUE) %>%
  as.data.frame(.) %>% 
  dplyr::filter(candemmg_rc_eff == "0 effect") %>%
  dplyr::mutate(
    conf_low = estimate - (1.96 * SE),
    conf_high = estimate + (1.96 * SE),
    index = dplyr::row_number()) %>% 
  dplyr::filter(cancom_rc_eff != "3 effect")

mm_pooledT2 <- mm_plot(reg_f1_1_meT2, title = "Pooled", legend = TRUE)
mm_pooledT2

mm_c_pooledT2 <- mm_c_plot(reg_f1_1_cT2, title = NULL)
mm_c_pooledT2

### country subsets

# countries to loop over
vec_countries <- sort(unique(df_original$country))

# store plots
list_plotsT2 <- lapply(
  X = seq_along(vec_countries), 
  FUN = function(x){
    
    # create data subset
    df_original_sub <- dplyr::filter(
      df_original, 
      country == vec_countries[x])
    
    # run regression
    reg_f1_s <- lm(
      support_rc ~ candemmg_rc * cancom_rc,
      clusters = resp, 
      data = dplyr::filter(
        df_original, 
        country == vec_countries[x]))
    
    # calculate marginal effects
    reg_f1_s_me <- ggeffects::ggeffect(
      model = reg_f1_s, 
      terms = c("candemmg_rc", 
                "cancom_rc [1:5 by = 1]"))
    
    # calculate contrasts
    reg_f1_s_emm <- emmeans::emmeans(
      reg_f1_s, 
      ~ candemmg_rc * cancom_rc, 
      type = "response")
    
    reg_f1_s_c <- emmeans::contrast(
      reg_f1_s_emm, interaction = TRUE) %>%
      as.data.frame(.) %>% 
      dplyr::filter(candemmg_rc_eff == "0 effect") %>%
      dplyr::mutate(
        conf_low = estimate - 1.96 * SE,
        conf_high = estimate + 1.96 * SE,
        index = dplyr::row_number()) %>% 
      dplyr::filter(cancom_rc_eff != "3 effect")
    
    # progress
    print(paste("Done with", vec_countries[x]))
    
    # save
    plots <- list()
    plots[["marginals"]] <- mm_plot(reg_f1_s_me, vec_countries[x])
    plots[["contrasts"]] <- mm_c_plot(reg_f1_s_c, title = NULL)
    
    return(plots)
    
  })

### Combine all subpanels into final exhibit
figure1t2 <- cowplot::plot_grid(
  mm_pooled, 
  list_plots[[1]]$marginals, 
  list_plots[[2]]$marginals, 
  
  mm_c_pooled, 
  list_plots[[1]]$contrasts, 
  list_plots[[2]]$contrasts,
  
  list_plots[[3]]$marginals, 
  list_plots[[4]]$marginals, 
  list_plots[[5]]$marginals, 
  
  list_plots[[3]]$contrasts, 
  list_plots[[4]]$contrasts, 
  list_plots[[5]]$contrasts, 
  
  ncol = 3, 
  rel_heights = c(1, 1/2, 1, 1/2, 1, 1/2, 1, 1/2), 
  rel_widths = c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))

figure1t2 
# save plot
ggsave(
  plot = figure1t2, 
  filename = paste0(
    here::here("exhibits", "figures"), "/figure1_replication2task.pdf"),
  height = 15, width = 15)



###########################################################################
##### Appendix A

df_original$cancom_rc2 <- relevel(df_original$cancom_rc, ref = "3")
df_original$candemmg_rc2 <- relevel(df_original$candemmg_rc, ref = "1")

vec_table_a1_columns <- c("pooled", vec_countries)

### A1
list_table_a1 <- lapply(
  X = seq_along(vec_table_a1_columns),
  FUN = function(y){
    out <- fxn_regression(
      data = df_original, 
      formula = "support_rc ~ candemmg_rc2 + cancom_rc2", 
      cntry = vec_table_a1_columns[y])
    return(out)})

texreg::texreg(
  l = list(
    list_table_a1[[1]],
    list_table_a1[[2]],
    list_table_a1[[3]],
    list_table_a1[[4]],
    list_table_a1[[5]],
    list_table_a1[[6]]),
  custom.model.names = c(
    "Pooled", "CZ", "MX", "SK", "UK", "US"),
  custom.coef.map = list(
    "candemmg_rc20" = "Undemocratic behavior",
    "cancom_rc21" = "Very incompetent",
    "cancom_rc22" = "Incompetent",
    "cancom_rc24" = "Competent",
    "cancom_rc25" = "Very Competent",
    "(Intercept)" = "Constant"), 
  center = TRUE, 
  caption = paste0(
    "Average effects of undemocratic behavior and", 
    "competence in the Czech Republic, Mexico, South Korea, the United",
    "Kingdom, and the United States. Candidate support is the dependent",
    "variable in all models."), 
  float.pos = "!htbp", 
  label = "table_a1",
  caption.above = TRUE, 
  include.ci = FALSE,  
  file = paste0(
    here::here("exhibits", "tables"), "/table_a1_replication.tex")
  )

### A2 
list_table_a2 <- lapply(
  X = seq_along(vec_table_a1_columns),
  FUN = function(y){
    out <- fxn_regression(
      data = df_original,
      formula = "support_rc ~ candemmg_rc2 * cancom_rc2", 
      cntry = vec_table_a1_columns[y])
    return(out)})

texreg::texreg(
  l = list(
    list_table_a2[[1]],
    list_table_a2[[2]],
    list_table_a2[[3]],
    list_table_a2[[4]],
    list_table_a2[[5]],
    list_table_a2[[6]]),
  custom.model.names = c(
    "Pooled", "CZ", "MX", "SK", "UK", "US"),
  custom.coef.map = list(
    "candemmg_rc20" = "Undemocratic behavior",
    "cancom_rc21" = "Very incompetent",
    "cancom_rc22" = "Incompetent",
    "cancom_rc23" = "Competent",
    "cancom_rc24" = "Very competent",
    "candemmg_rc20:cancom_rc21" = "Undemocratic x Very incompetent",
    "candemmg_rc20:cancom_rc22" = "Undemocratic x Incompetent",
    "candemmg_rc20:cancom_rc24" = "Undemocratic x Competent",
    "candemmg_rc20:cancom_rc25" = "Undemocratic x Very competent"),
  center = TRUE, 
  caption = paste0(
    "Effects of undemocratic behavior interacted by, candidate competence",
    "in the Czech Republic, Mexico, South Korea, the United Kingdom, and",
    "the United States. Candidate support is the dependent variable in", 
    "all models."),
  float.pos = "!htbp", 
  label = "table_a2",
  caption.above = TRUE,   
  include.ci = FALSE, 
  file = paste0(
    here::here("exhibits", "tables"), "/table_a2_replication.tex"))

###########################################################################
##### Appendix B

###########################################################################
##### Supplementary materials

### Table A1

# Age
df_original %<>% 
  dplyr::mutate(
    # create age categories
    age_grp = dplyr::case_when(
      country == "US" & age %in% c(40:49) ~ "40-49",
      country == "US" & age %in% c(50:59) ~ "50-59",
      country == "US" & age %in% c(60:62) ~ "60-62",
      country == "US" & age %in% c(63:66) ~ "63-66",
      country == "US" & age %in% c(67:75) ~ "67-75",
      country == "CZ" & age %in% c(43:57) ~ "43-57",
      country == "CZ" & age %in% c(58:67) ~ "58-67",
      country == "CZ" & age %in% c(68:77) ~ "68-77",
      country == "UK" & age %in% c(44:53) ~ "44-53",
      country == "UK" & age %in% c(54:57) ~ "54-57",
      country == "UK" & age %in% c(58:61) ~ "58-61"))

table_sa1_age <- fxn_prop_table("age_grp")

# Gender
table_sa1_gender <- fxn_prop_table("gender")

# Profession
table_sa1_background <- fxn_prop_table("background")

# Party 
table_sa1_party <- fxn_prop_table("party")

# Redistribution
table_sa1_redi <- fxn_prop_table("redi")

# Morality policy
table_sa1_soc <- fxn_prop_table("soc")

# Democratic behaviour
table_sa1_dem <- fxn_prop_table("dem")

# Reputation: Economy
table_sa1_eco <- fxn_prop_table("eco")

# Reputation: Corruption
table_sa1_cor <- fxn_prop_table("cor")

# Closeness on policy issues b/t respondant and candidate, `dissemm`
table_sa1_dissemm <- fxn_prop_table("dissemm")

table_sa1 <- dplyr::bind_rows(
  table_sa1_age, table_sa1_gender, table_sa1_background,
  table_sa1_party, table_sa1_redi, table_sa1_soc,
  table_sa1_dem, table_sa1_eco, table_sa1_cor, table_sa1_dissemm) %>% 
  dplyr::mutate(dplyr::across(dplyr::everything(), 
                              ~ ifelse(is.na(.), "", .)))

table_sa1_tex <- xtable::xtable(dplyr::rename(table_sa1,
                                              "Attribute Category" = "measure"))
xtable::align(table_sa1_tex) <- "lp{7cm}ccccc"
xtable::print.xtable(
  table_sa1_tex, tabular.environment = "longtable", floating = FALSE, 
  booktabs = TRUE,
  file = here::here("exhibits", "tables", "table_sa1_replication.tex"))  

save(table_sa1, file = paste0(
  here::here("exhibits", "tables"), "/table_sa1_replication.rdata"))
