## preliminary test for Notts Replication Games
# Frederiksen, K. V. S. (2022). Does Competence Make Citizens Tolerate Undemocratic Behavior? American Political Science Review, 116(3), 1147–1153. https://doi.org/10.1017/S0003055422000119
# https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/NGFLRO



rm(list = ls())

library(tidyverse)
library(magrittr)
library(readr)
library(haven)
library(readstata13)

###########################################################################
##### Read functions 

source(paste0(here::here("code", "functions"), "/plot_functions.R"))

source(paste0(here::here("code", "functions"), "/regression_functions.R"))

source(paste0(here::here("code", "functions"), "/fxn_prop_table.R"))


dir()


setwd(dirname(rstudioapi::getActiveDocumentContext()$path)) # only for Rstudio
getwd()

?readr
df_original <- read_csv("dataset.csv")
names(df_original)

## Get empirical marginal distributions for variables used in AMCE

## a hack to deal with row_join() giving error combining characters and ints
df_original$ageC <- as.character(df_original$age)
table_sa1_age <- fxn_prop_table("ageC")
glimpse(table_sa1_age)
table(df_original$ageC, useNA = 'always')

table(df_original$redi, useNA = 'always')

# Closeness on policy issues b/t respondent and candidate, `dissumm`
table(df_original$dissumm, useNA = 'always')
unique(df_original$dissumm, useNA = 'always')

table_sa1_dissumm <- fxn_prop_table("dissumm")
glimpse(table_sa1_dissumm)
table(table_sa1_dissumm, useNA = 'always')

# Party main
table(df_original$partymmain, useNA = 'always')
table_sa1_partymmain <- fxn_prop_table("partymmain")
table(table_sa1_partymmain, useNA = 'always')


table_sa1 <- dplyr::bind_rows(
   table_sa1_dissumm, table_sa1_partymmain,  table_sa1_age) %>% 
  dplyr::mutate(dplyr::across(dplyr::everything(), 
                              ~ ifelse(is.na(.), "", .)))


table_sa1_tex <- xtable::xtable(dplyr::rename(table_sa1,
                                              "Attribute Category" = "measure"))
xtable::align(table_sa1_tex) <- "lp{7cm}ccccc"
xtable::print.xtable(
  table_sa1_tex, tabular.environment = "longtable", floating = FALSE, 
  booktabs = TRUE,
  file = here::here("exhibits", "tables", "table_sa1_replication_emperiMarg.tex"))  


## Data prep
unique(df_original$dissumm)
class(df_original$dissumm)
table(df_original$dissumm, useNA = 'always')

table(df_original$partymmain, useNA = 'always')

unique(df_original$support)
class(df_original$support)

df_original$dissummN <- as.numeric(df_original$dissumm)
table(df_original$dissummN,df_original$dissumm)

df_original %<>% dplyr::mutate(
  dissummN = dplyr::case_when(
    dissumm == "Completely Aligned Positions" ~ 1,
    dissumm == "Completely Diverting Positions" ~ 7,
    TRUE ~ as.numeric(dissumm)
  ),
  distance = (dissummN-1)/(7-1)*(5-1)+1, ##align distance with other continuous measures,
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

table(df_original$dissumm, df_original$dissummN, useNA = 'always')
table(df_original$distance)

data.frame(dissumm =df_original$dissumm, dissummN =df_original$dissummN)

table(df_original$cancom_rc)
class(df_original$cancom_rc)
levels(df_original$cancom_rc)
table(df_original$support_rc)
table(df_original$candemmg_rc)

# Age
df_original %<>% 
	dplyr::mutate(
		# create age categories
		canage_grp = dplyr::case_when(
			country == "US" & canage %in% c(40:49) ~ "40-49",
			country == "US" & canage %in% c(50:59) ~ "50-59",
			country == "US" & canage %in% c(60:62) ~ "60-62",
			country == "US" & canage %in% c(63:66) ~ "63-66",
			country == "US" & canage %in% c(67:75) ~ "67-75",
			country == "CZ" & canage %in% c(43:57) ~ "43-57",
			country == "CZ" & canage %in% c(58:67) ~ "58-67",
			country == "CZ" & canage %in% c(68:77) ~ "68-77",
			country == "UK" & canage %in% c(44:53) ~ "44-53",
			country == "UK" & canage %in% c(54:57) ~ "54-57",
			country == "UK" & canage %in% c(58:61) ~ "58-61"))

df_original %<>% 
	dplyr::mutate(pairID = paste(respondentid,task , sep = "_" )
	)
table_sa1_age <- fxn_prop_table("canage_grp")

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

sort(names(df_original))

# Democratic behaviour
table_sa1_dem <- fxn_prop_table("dem")

# Reputation: Economy
table_sa1_eco <- fxn_prop_table("eco")

# Reputation: Corruption
table_sa1_cor <- fxn_prop_table("cor")

table(df_original$cor, df_original$cancor)

table_sa1 <- dplyr::bind_rows(
	table_sa1_age, table_sa1_gender, table_sa1_background,
	table_sa1_party, table_sa1_redi, table_sa1_soc,
	table_sa1_dem, table_sa1_eco, table_sa1_cor)


## subset by country
unique(df_original$country)
CZdds <- df_original %>% filter(country == "CZ")
UKdds <- df_original %>% filter(country == "UK")
USdds <- df_original %>% filter(country == "US")
MXdds <- df_original %>% filter(country == "MX")
SKdds <- df_original %>% filter(country == "SK")

## Get design frequencies from Appendix A (Table A1, A2, A3) of Supplemental Materials @fred22-supplemental

f <- support_rc ~  candemmg_rc*cancom_rc +dissumm + partymmain+ canage_grp + cangender +    canbackground +pairID + respondentid

unique(USdds$dissummN)
class(USdds$dissummN)
unique(USdds$partymmain)

## cancom
target_dist_marginal_US <- list(candemmg_rc = c("0"=0.5, "1" = 0.5),
                                cancom_rc = c("1" = 0.2 , "2" =0.2 , "3" = 0.2, "4" = 0.2, "5" = 0.2),
                                dissummN = c("1" = 0.14, "2"=0.118 , "3"=0.181 , "4"=0.231 , "5"=0.087 , "6"= 0.055, "7"=0.06 ),
                                partymmain = c(),
                                canage_grp = c("40-49"  =0.2  ,  "50-59"=0.2 , "60-62" = 0.2, "63-66" =0.2 ,"67-75" = 0.2),
                                cangender = c("Male"=0.8,   "Female"=0.2),
                                canbackground = c("Company Founder/Director" = 0.4,"Civil Servant" =0.1,            "Lawyer" =0.3,      "Political Career" =0.1,         "Self-employed" =0.1)
)

## get model matrix for complete cases
llm <- lm( support_rc ~  candemmg_rc*cancom_rc +dissummN + partymmain+ canage_grp + cangender +cangender +    canbackground  , data = USdds)

str(llm)


f <- support_rc ~  candemmg_rc*cancom_rc +dissummN + partymmain+ canage_grp + cangender +cangender +    canbackground +pairID + respondentid
library(data.table)
cc <- na.omit(as.data.table( USdds), cols = all.vars(f) )
fvars <- all.vars(f)
library(tidyverse)
ccc <- cc %>% dplyr::select(matches(fvars ) )
library(psych)

table(ccc$pairID)==2
names(which(table(ccc$pairID)==2) )
names(table(ccc$pairID)==2)
ccc <- ccc %>% filter(pairID %in%  names(which(table(ccc$pairID)==2) ) )


library(factorEx)
sort(names(USdds))
out_design_mar <- 
	design_pAMCE(formula = support_rc ~  candemmg_rc*cancom_rc +dissummN + partymmain+ canage_grp + cangender +cangender +    canbackground   ,
				 factor_name = c("candemmg_rc", "cancom_rc"),
				 data = ccc,
				 pair_id = ccc$pairID,
				 cluster_id = ccc$respondentid,
				 target_dist  = target_dist_marginal_US, target_type = "marginal")
summary(out_design_mar)
table(ccc$pairID)

      
unique(UKdds$background)
## UK
target_dist_marginal_UK <- list(candemmg_rc = c(),
                                cancom_rc = c(),
                                dissummN = c("1" = 0.133, "2"=0.145 , "3"=0.201 , "4"=0.223 , "5"=0.1 , "6"= 0.051, "7"=0.045 ),

                                partymmain = c(),
                                canage_grp = c(),
                                cangender = c("Male"=0.714 ,  "Female"=0.286),
                                canbackground = c("Political Career" = 0.222, "Lawyer" =0.222,           "Banker" =0.222,           "Journalist"=0.222,       "Civil Servant"=0.111 )
)
                                

unique(CZdds$background)
## CZ
target_dist_marginal_CZ <- list(candemmg_rc = c(),
                                cancom_rc = c(),
								dissummN = c("1" = 0.133, "2"=0.145 , "3"=0.201 , "4"=0.223 , "5"=0.1 , "6"= 0.051, "7"=0.045 ),
								partymmain = c(),
                                canage_grp = c(),
                                cangender = c("Male"=0.917 ,  "Female"=0.083),
                                canbackground = c( "Political Career" = 0.083, "Journalist" =0.25,       "Professor" = 0.5,        "Actor/actress" =0.167  )
)


unique(MXdds$background)
## MX
unique(MXdds$canage)
target_dist_marginal_MX <- list(candemmg_rc = c(),
                                cancom_rc = c(),
								dissummN = c("1" = 0.158, "2"=0.11 , "3"=0.109 , "4"=0.268 , "5"=0.087 , "6"= 0.053, "7"=0.087 ),
								partymmain = c(),
                                canage_grp = c(),
                                cangender = c("Male"=0.938 ,  "Female"=0.062),
                                canage =c("39" = 0.031, "40" =0.031, "44" =0.063, "45" =0.031, "46" =0.031, "47" =0.031, "48" =0.031, "49" =0.063, "50" =0.094, "51" =0.031, "52" =0.094, "53" =0.031, "54" =0.031, "55" =0.031, "56" =0.063, "57" =0.094, "58" =0.031, "60" =0.031, "61" =0.063, "62" =0.031, "69" = 0.062),
                                canbackground = c("Engineer"                "Lawyer"                  "Accountant"       "Self-employed"           "Civil Servant"           "Journalist"        "Business Administration" "Professional Sports"     "Academic"  )
)

Accountant (0.125), Business administration (0.062), Civil servant (0.094), Engineer (0.125), Self-employed (0.094), Journalist (0.031), Lawyer (0.406), Academic (0.031), Professional sports (0.031)

unique(SKdds$background)
## SK
target_dist_marginal_SK <- list(candemmg_rc = c(),
                                cancom_rc = c(),
								dissummN = c("1" = 0.1, "2"=0.088 , "3"=0.16 , "4"=0.147 , "5"=0.068 , "6"= 0.041, "7"=0.025 ),
								partymmain = c(),
                                canage_grp = c(),
                                cangender = c("Male"=0.944 ,  "Female"=0.056),
                                canage =c("49" = 0.056, "54" =0.056, "55" =0.111, "56" =0.056, "59" =00.056, "60" =0.111, "62" =0.056, "63" =0.056, "64" =0.056, "65" =0.056, "66" =0.056, "67" =0.056, "68" =0.056, "72" =0.056, "73" =0.056, "77" =0.056),
                                canbackground = c("Engineer" =0.056,        "Journalist" =0.056,       "Company Director" =0.056, "Lawyer" =0.389,      "Self-employed"=0.167,    "Civil Servant" =0.056,    "Political Career" =0.111, "Professor" =0.056,       "Army General" =0.056)
)






# # https://github.com/naoki-egami/factorEx
# library(devtools)
# install_github("naoki-egami/factorEx", dependencies=TRUE)


## Load the package and data
library(factorEx)
data("OnoBurden")

OnoBurden_data_pr <- OnoBurden$OnoBurden_data_pr # randomization based on marginal population design
names(OnoBurden_data_pr)
table(OnoBurden_data_pr$pair_id)

# we focus on target profile distributions based on Democratic legislators. 
# See de la Cuesta, Egami, and Imai (2019+) for details.
target_dist_marginal <- OnoBurden$target_dist_marginal
names(target_dist_marginal)
target_dist_marginal$gender
str(target_dist_marginal$gender)

names(target_dist_marginal$party)

out_design_mar <- 
	design_pAMCE(formula = Y ~ gender + age + family + race + experience + party + pos_security,
				 factor_name = c("gender", "age", "experience"),
				 data = OnoBurden_data_pr,
				 pair_id = OnoBurden_data_pr$pair_id,
				 cluster_id = OnoBurden_data_pr$id,
				 target_dist  = target_dist_marginal, target_type = "marginal")
summary(out_design_mar)

plot(out_design_mar, factor_name = c("gender", "experience"))

# diagnose_pAMCE(out_design_mar, factor_name = c("gender", "experience"))
decompose_pAMCE(out_design_mar, effect_name=c("gender","Factor"))


unique(USdds$background)

library(cregg)

