#Actually run the simulation or just load the data and look at it?
run_sim <- TRUE
# Max number of respondents fixed at 2700
num_resp <- 250000
# Number of iterations (breaks in sample size)
num_iter <- 100
# Number of simulations to run per iteration
num_sims <- 10

library(magrittr)
library(ggplot2)

# Two treatment variables producing a cross-product of 7x7
treatments1 <- c(
  "military",
  "MOI",
  "president",
  "MOJ", 
  "parliament",
  "municipality",
  "government")

treatments2 <- c(
  "exprop.firm",
  "exprop.income",
  "permit.reg",
  "contracts.supply",
  "permit.export",
  "permit.import",
  "reforms")

total_treat <- length(c(treatments1, treatments2))

# Full combination of treatment groups
grid_pair <- as.matrix(expand.grid(treatments1, treatments2))

print(head(grid_pair))

# If using Windows, parallelfunc comes from parallesugar,
# otherwise the standard mclapply is used
if(.Platform$OS.type == "windows") {
  parallelfunc <- parallelsugar::mclapply_socket
} else {
  parallelfunc <- parallel::mclapply
}

###########################################################################
##### Begin simulation

if(run_sim == TRUE) {
  file.create(paste0(
    here::here("code", "logs"), "/output_log.txt"), showWarnings = FALSE)
  
  # Need to randomize over the simulations so that parallelization 
  # works correctly on windows
  sampled_seq <- sample(seq(100, num_resp, length.out = num_iter))
  
  # begin simulation
  all_sims <- parallelfunc(sampled_seq, function(x) {
    
    out_probs <- 1:num_sims
    #x <- sampled_seq[1]
    cat(paste0("Now running simulation on data sample size ", x),
        file = "output_log.txt", sep = "\n", append = TRUE)
    print(paste0("Now running simulation on data sample size ", x))
    
    # simulate dataset
    #######################################################################
    
    #j <- 1
    out_data <- lapply(1:num_sims, function(j) {
      
      total_probs <- sapply(1:x, function(x) {
        treat_rows <- sample(1:nrow(grid_pair), 4)
        treatments_indiv <- c(grid_pair[treat_rows, ])
        return(treatments_indiv)
      })
      
      by_resp <- t(total_probs)
      by_resp <- dplyr::as_tibble(by_resp)
      
      names(by_resp) <- c(
        paste0("actor.", 1:4, "_cluster", c(1, 1, 2, 2)), 
        paste0("gift.", 1:4, "_cluster", c(1, 1, 2, 2)))
      
      by_resp$respondent <- paste0("Respondent_", 1:nrow(by_resp))
      by_resp <- tidyr::gather(
        by_resp, attribute, indicator, -respondent) %>% 
        tidyr::separate(
          attribute, into = c("attribute", "cluster"), sep = "_") %>% 
        tidyr::separate(
          attribute, into = c("attribute", "task")) %>% 
        tidyr::spread(attribute, indicator)
      
      # Assign true coefficients for treatments
      #Beta_js
      set.seed(as.numeric(paste(x, j, sep = "")))
      coefs <- dplyr::tibble(
        coef_val = rnorm(
          n = length(c(treatments1, treatments2)), 
          mean = 0, sd = 1),
        treat_label = c(treatments1,treatments2))
      
      # Create cluster covariance in the errors
      sigma_matrix <- matrix(2, nrow = 4, ncol = 4)
      diag(sigma_matrix) <- 4
      
      # Add on the outcome as a normal draw, treatment coefficients, 
      # interaction coefficient, group errors/interaction by respondent
      by_resp <- tidyr::gather(
        by_resp, treatment, appeal_type, actor, gift) %>% 
        dplyr::left_join(coefs, by = c("appeal_type" = "treat_label"))
      
      # Record interaction coefficient (true estimate of interest)
      
      set.seed(as.numeric(paste(x, j, sep = "")))
      true_effect <- rnorm(n = 1, mean = 0.5, sd = 0.3)
      
      set.seed(as.numeric(paste(x, j, sep = "")))
      by_resp <- dplyr::select(by_resp, -treatment) %>% 
        tidyr::spread(appeal_type, coef_val) %>%  
        dplyr::group_by(respondent) %>% 
        dplyr::mutate(
          error = MASS::mvrnorm(
            1, mu = rep(0, 4), 
            Sigma = sigma_matrix)) %>% 
        dplyr::ungroup()
      
      # interaction coefficient only in function if military==TRUE
      by_resp <- dplyr::mutate(
        by_resp, int_coef = true_effect * rbinom(
          n = dplyr::n(), prob = 0.2, size = 1),
        int_coef = dplyr::if_else(military != 0, int_coef, 0))
      
      by_resp <- lapply(by_resp, function(x) {
        if(is.double(x)) {
          x[is.na(x)] <- 0
        }
        return(x)
      }) %>% 
        dplyr::as_data_frame()
      
      # To make the outcome, need to turn the dataset long
      # However, we now need to drop the reference categories
      # Drop one dummy from actor/gift to prevent 
      # multicollinearity = reforms + government combination
      out_var <- tidyr::gather(
        by_resp,var_name, var_value, -respondent, -task, -cluster) %>% 
        dplyr::filter(!(var_name %in% c("reforms","government"))) %>% 
        dplyr::group_by(respondent,task) %>% 
        dplyr::summarize(outcome = sum(var_value) + 5)
      
      combined_data <- dplyr::left_join(
        out_var, by_resp, by = c("respondent", "task"))
      
      # Re-estimate with a blocking variable (post-stratification variable)
      combined_data$Q <- c(rep(1, floor(nrow(combined_data)/2)),
                           rep(0, ceiling(nrow(combined_data)/2)))
      
      combined_data$outcome <- dplyr::if_else(
        combined_data$Q == 1, combined_data$outcome + 1,
        combined_data$outcome)
      
      # # Create data predictor matrix and estimate coefficients 
      # from the simulated dataset
      to_lm <- dplyr::ungroup(combined_data) %>% 
        dplyr::select(contracts.supply:reforms, int_coef, Q)
      
      to_lm <- dplyr::mutate(
        to_lm, 
        dplyr::across(
          dplyr::everything(), ~dplyr::if_else(. != 0, 1, .))) %>% 
        dplyr::mutate(outcome = combined_data$outcome)
      
      #No post-stratification
      # I don"t estimate a constituent term for int_coef because it is 
      # assumed to be zero
      results <- lm(outcome ~ contracts.supply + exprop.firm + 
                      exprop.income + military + MOI + MOJ + municipality +
                      parliament + permit.export + permit.import +
                      permit.reg + president + 
                      int_coef:military, data = to_lm)
      
      results_clust <- multiwayvcov::cluster.vcov(
        results,cluster = combined_data$respondent)
      
      pvals_adj <- lmtest::coeftest(
        results, vcov. = results_clust)[-1,4] < 0.05
      pvals_orig <- lmtest::coeftest(results)[-1,4] < 0.05
      
      total_sig_orig <- mean(pvals_orig)
      total_sig_adj <- mean(pvals_adj)
      
      int_sig_orig <- pvals_orig["military:int_coef"]
      int_sig_adj <- pvals_adj["military:int_coef"]
      
      # Now run the poststratification model
      results_ps <- lm(outcome ~ contracts.supply + exprop.firm + 
                         exprop.income + military + MOI + MOJ + 
                         municipality + parliament + permit.export + 
                         permit.import + permit.reg + president + 
                         int_coef:military + Q, data = to_lm)
      
      results_clust <- multiwayvcov::cluster.vcov(
        results, cluster = combined_data$respondent)
      
      pvals_adj <- lmtest::coeftest(
        results_ps, vcov. = results_clust)[-1,4] < 0.05
      pvals_orig <- lmtest::coeftest(results_ps)[-1,4] < 0.05
      
      total_sig_orig_blocker <- mean(pvals_orig)
      total_sig_adj_blocker <- mean(pvals_adj)
      
      int_sig_orig_blocker <- pvals_orig["military:int_coef"]
      int_sig_adj_blocker <- pvals_adj["military:int_coef"]
      
      out_results <- dplyr::data_frame(
        int_sig_adj,int_sig_orig,int_sig_adj_blocker,int_sig_orig_blocker,
        total_sig_adj,total_sig_orig,total_sig_adj_blocker,
        total_sig_orig_blocker,abs_true_effect = abs(true_effect),
        true_effect = true_effect,
        est_effect = coef(results)["military:int_coef"],
        est_effect_ps = coef(results)["military:int_coef"])
    })
    
    # end of DGP
    #######################################################################
    
    # bind all datasets together
    out_data <- dplyr::bind_rows(out_data)
    
    return(out_data)
  }, 
  
  mc.cores = parallel::detectCores(), mc.preschedule = FALSE)
  
  # save the data for inspection
  all_sims_data <- dplyr::bind_rows(all_sims) %>% 
    dplyr::mutate(
      sample_size = rep(sampled_seq,each = num_sims),
      iter = rep(1:num_sims, times = num_iter))
}

# run simulation
run_sim <- FALSE
if(run_sim == TRUE) {
  saveRDS(object = all_sims_data, file = "all_sims_data.rds")
} else {
  all_sims_data <- readRDS("all_sims_data.rds")
}

###########################################################################
##### plot outputs

# add in different calculations
all_sims_data <- 
  dplyr::group_by(all_sims_data,sample_size)  %>% 
  dplyr::mutate(
    sigeffVorig=ifelse(int_sig_orig,
                       est_effect,
                       NA),
    sigeffVadj=ifelse(int_sig_adj,est_effect,NA),
    sigeffVps_orig=ifelse(int_sig_orig_blocker,est_effect_ps,NA),
    sigeffVps_adj=ifelse(int_sig_adj_blocker,est_effect_ps,NA),
    powerVorig=int_sig_orig & (true_effect>0),
    powerVadj=int_sig_adj & (true_effect>0),
    powerVps_orig=int_sig_orig_blocker & (true_effect > 0),
    powerVps_adj=int_sig_adj_blocker & (true_effect > 0),
    SerrVorig=ifelse(int_sig_orig,1-(sign(est_effect)==sign(true_effect)),NA),
    SerrVadj=ifelse(int_sig_adj,1-(sign(est_effect)==sign(true_effect)),NA),
    SerrVps_orig=ifelse(int_sig_orig_blocker,
                        1-(sign(est_effect_ps)==sign(true_effect)),NA),
    SerrVps_adj=ifelse(int_sig_adj_blocker,
                       1-(sign(est_effect_ps)==sign(true_effect)),NA),
    MerrVorig=ifelse(int_sig_orig,abs(est_effect)/abs_true_effect,NA),
    MerrVadj=ifelse(int_sig_adj,abs(est_effect)/abs_true_effect,NA),
    MerrVps_orig=ifelse(int_sig_orig_blocker,abs(est_effect_ps)/abs_true_effect,NA),
    MerrVps_adj=ifelse(int_sig_adj_blocker,abs(est_effect_ps)/abs_true_effect,NA))

long_data <- 
  dplyr::select(all_sims_data,matches('V|sample|iter')) %>% 
  tidyr::gather(effect_type,result,-sample_size,-iter) %>% 
  tidyr::separate(effect_type,into=c('estimate','estimation'),sep='V') %>% 
  dplyr::mutate(estimate=factor(
    estimate,levels=c('sigeff','power','Serr','Merr'),
    labels=c('Mean\nSignificant\nEffect',
             'Mean\nPower',
             'S-Error\nRate',
             'M-Error\nRate')),
    estimation=factor(
      estimation,levels=c('adj','orig','ps_adj','ps_orig'),
      labels=c('No Post-Stratification\nClustered Errors\n',
               'No Post-Stratification\nUn-clustered Errors\n',
               'Post-Stratification\nClustered Errors\n',
               'Post-Stratification\nUn-clustered Errors\n')))

long_data_treatment <-
  dplyr::select(
  all_sims_data,matches('total|iter|sample')) %>% 
  tidyr::gather(effect_type,result,-sample_size,-iter) %>%
  dplyr::mutate(effect_type=factor(effect_type,levels=c(
    'total_sig_adj',
    'total_sig_orig',
    'total_sig_adj_blocker',
    'total_sig_orig_blocker'),
    labels=c(
      'No Post-Stratification\nClustered Errors\n',
      'No Post-Stratification\nUn-clustered Errors\n',
      'Post-Stratification\nClustered Errors\n',
      'Post-Stratification\nUn-clustered Errors\n')))

# Plot a sample of the data (too big to display all of it)

long_data %>% dplyr::ungroup() %>% 
  dplyr::slice(1:10) %>% 
  dplyr::select(-estimation) %>% 
  dplyr::mutate(estimate=stringr::str_replace(estimate,"\\n"," ")) %>% 
  knitr::kable(.) %>% 
  kableExtra::kable_styling(font_size = 8)

g_title <- guide_legend(title='')
dplyr::filter(long_data,grepl('No Post',estimation)) %>% 
  ggplot(aes(y=result,x=sample_size,linetype=estimation)) +
  theme_minimal() + stat_smooth(colour='red') +
  xlab('Sample Size') + ylab("") +
  facet_wrap(~estimate,scales='free') + theme(panel.grid.minor.y = element_blank(),
                                              panel.grid.major.y = element_blank()) +
  scale_color_brewer(palette='Accent') + guides(colour=g_title,linetype=g_title) +
  theme(legend.position = 'bottom')
ggsave(plot = last_plot(), filename = paste0(here::here("exhibits", "figures"), "/c_u_se_nps_power.pdf"))

g_title <- guide_legend(title='')
dplyr::filter(long_data,grepl('Un-clustered',estimation)) %>% 
  ggplot(aes(y=result,x=sample_size,linetype=estimation)) +
  theme_minimal() + stat_smooth(colour='red') +
  xlab('Sample Size') + ylab("") +
  facet_wrap(~estimate,scales='free') + theme(panel.grid.minor.y = element_blank(),
                                              panel.grid.major.y = element_blank()) +
  scale_color_brewer(palette='Accent') + guides(colour=g_title,linetype=g_title) +
  theme(legend.position = 'bottom')
ggsave(plot = last_plot(), filename = paste0(here::here("exhibits", "figures"), "/u_se_nps_ps_power.pdf"))

g_title <- guide_legend(title='')
dplyr::filter(long_data,!grepl('Un-clustered',estimation)) %>% 
  ggplot(aes(y=result,x=sample_size,linetype=estimation)) +
  theme_minimal() + stat_smooth(colour='red') +
  xlab('Sample Size') + ylab("") +
  facet_wrap(~estimate,scales='free') + theme(panel.grid.minor.y = element_blank(),
                                              panel.grid.major.y = element_blank()) +
  scale_color_brewer(palette='Accent') + guides(colour=g_title,linetype=g_title) +
  theme(legend.position = 'bottom')
ggsave(plot = last_plot(), filename = paste0(here::here("exhibits", "figures"), "/cse_nps_ps_power.pdf"))

g_title <- guide_legend(title='')
ggplot(long_data_treatment,aes(y=result,x=sample_size,linetype=effect_type,colour=effect_type)) +
  theme_minimal() + stat_smooth() +
  xlab('Sample Size') + ylab("") +
  theme(panel.grid.minor.y = element_blank(),
        panel.grid.major.y = element_blank()) +
  scale_color_brewer(palette='Dark2') + guides(linetype=g_title,colour=g_title) +
  theme(legend.position = 'bottom')
ggsave(plot = last_plot(), filename = paste0(here::here("exhibits", "figures"), "/horserace.pdf"))
