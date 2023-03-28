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
  candemmg_rc = factor(candemmg_rc),
  canagedecade = canage/10,
  distance = round( (dissummN-1)/(7-1)*(5-1)+1, 2) 
)


table(df_original$cancom_rc)

table(df_original$dissumm, df_original$dissummN, useNA = 'always')
table(df_original$distance)



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




## subset by country
unique(df_original$country)
CZdds <- df_original %>% filter(country == "CZ")
UKdds <- df_original %>% filter(country == "UK")
USdds <- df_original %>% filter(country == "US")
MXdds <- df_original %>% filter(country == "MX")
SKdds <- df_original %>% filter(country == "SK")

## cancom
target_dist_marginal_US <- list(candemmg_rc = c("0"=0.5, "1" = 0.5),
                                cancom_rc = c("1" = 0.2 , "2" =0.2 , "3" = 0.2, "4" = 0.2, "5" = 0.2),
                                dissummN = c("1" = 0.161, "2"=0.135 , "3"=0.208 , "4"=0.265 , "5"=0.1 , "6"= 0.0663, "7"=0.069 ),
                                partymmain = c("Neither like nor dislike candidate's party" = 0.243  , 
                                               "Like candidate's party somewhat" = 0.214  ,          
                                               "Dislike candidate's party somewhat"  = 0.123  , 
                                               "Dislike candidate's party a great deal"  = 0.23  , 
                                               "Like candidate's party a great deal" =0.277),
                                canage_grp = c("40-49"  =0.2  ,  "50-59"=0.2 , "60-62" = 0.2, "63-66" =0.2 ,"67-75" = 0.2),
                                cangender = c("Male"=0.8,   "Female"=0.2),
                                background = c("Company Founder/Director" = 0.4,"Civil Servant" =0.1,            "Lawyer" =0.3,      "Political Career" =0.1,         "Self-employed" =0.1)
)


## Get design frequencies from Appendix A (Table A1, A2, A3) of Supplemental Materials @fred22-supplemental
unique(USdds$background)
unique(USdds$canbackground)
table(USdds$canbackground, USdds$background)



df_original$canagedecadeC <- as.character(df_original$canagedecade)
table_sa1_canage10 <- fxn_prop_table("canagedecadeC")

df_original$distance <- as.character(df_original$distance)

table_sa1_distance <- fxn_prop_table("distance")


table_sa1_empi <- dplyr::bind_rows(
  table_sa1_dissumm, table_sa1_distance,table_sa1_partymmain,  table_sa1_age, table_sa1_canage10) %>% 
  dplyr::mutate(dplyr::across(dplyr::everything(), 
                              ~ ifelse(is.na(.), "", .)))


table_sa1_tex <- xtable::xtable(dplyr::rename(table_sa1_empi,
                                              "Attribute Category" = "measure"))
xtable::align(table_sa1_tex) <- "lp{7cm}ccccc"
xtable::print.xtable(
  table_sa1_tex, tabular.environment = "longtable", floating = FALSE, 
  booktabs = TRUE,
  file = here::here("exhibits", "tables", "table_sa1_replication_emperiMarg.tex"))  





unique(USdds$dissummN)
class(USdds$dissummN)
unique(USdds$partymmain)
unique(USdds$canbackground)
unique(USdds$background)

## appendix D, ACME plot Figure D6: AMCE-plot showing effects of the included attributes on voter support. 

f <- support_rc ~ candemmg_rc +cancom_rc + distance + partymmain + canage_grp + cangender 

sort(unique(USdds$canagedecade))

target_dist_marginal_US_AppD <- list(candemmg_rc = c("0"=0.5, "1" = 0.5),
                                     cancom_rc = c("1" = 0.2 , "2" =0.2 , "3" = 0.2, "4" = 0.2, "5" = 0.2),
                                     distance = c("1" = 0.14, "1.67"=0.118 , "2.33" =0.181 ,  "3"=0.231 , "3.67"=0.087 , "4.33"=0.055 , "5"= 0.06 ),
                                     partymmain = c("Neither like nor dislike candidate's party" = 0.243  , 
                                                    "Like candidate's party somewhat" = 0.214  ,          
                                                    "Dislike candidate's party somewhat"  = 0.123  , 
                                                    "Dislike candidate's party a great deal"  = 0.23  , 
                                                    "Like candidate's party a great deal" =0.277),
                                     canage_grp = c("40-49"  =0.2  ,  "50-59"=0.2 , "60-62" = 0.2, "63-66" =0.2 ,"67-75" = 0.2),
                                     cangender = c("Male"=0.8,   "Female"=0.2)
)


f <- support_rc ~ candemmg_rc +cancom_rc + distance + partymmain + canage_grp + cangender 
f1 <- support_rc ~ candemmg_rc +cancom_rc + distance + partymmain + canage_grp + cangender +pairID +respondentid

##  US:
## get model matrix for complete cases
llm <- lm( f  , data = USdds)
summary(llm)
str(llm)

library(data.table)
cc <- na.omit(as.data.table( USdds), cols = all.vars(f1) )
names(cc)
fvars <- all.vars(f1)
library(tidyverse)
ccc <- cc %>% dplyr::select(matches(fvars ) )

ccc <- ccc %>% filter(pairID %in%  names(which(table(ccc$pairID)==2) ) )

library(purrr)
names(ccc)
ccc$candemmg_rc <- as.factor(ccc$candemmg_rc)
ccc$cancom_rc <- as.factor(ccc$cancom_rc)
ccc$distance <- as.factor(ccc$distance)
ccc$partymmain <- as.factor(ccc$partymmain)
ccc$canage_grp   <- as.factor(ccc$canage_grp  )
ccc$cangender <- as.factor(ccc$cangender)
#ccc$canagedecade   <- as.factor(ccc$canagedecade  )



library(factorEx)
out_design_mar <- 
  design_pAMCE(formula = support_rc ~ candemmg_rc  + cancom_rc  +distance + partymmain + canage_grp + cangender ,
               #factor_name = c("candemmg_rc", "cancom_rc"),
               data = ccc,
               pair_id = ccc$pairID,
               cluster_id = ccc$respondentid,
               target_dist  = target_dist_marginal_US_AppD[1:6], target_type = "marginal")
summary(out_design_mar)
table(ccc$pairID)

# TODO: write out the table

pdf("pus.pdf", width = 10, height = 10)
plot(out_design_mar, factor_name = c("candemmg_rc", "cancom_rc", "distance" , "partymmain" , "canage_grp" , "cangender"), main = "pAMCE for the US", mar = 22, xlim  = c(-1.0,1.5))
dev.off()




target_dist_marginal_CZ_AppD <- list(candemmg_rc = c("0"=0.5, "1" = 0.5),
                                     cancom_rc = c("1" = 0.2 , "2" =0.2 , "3" = 0.2, "4" = 0.2, "5" = 0.2),
                                     distance = c("1" = 0.114, "1.67"=0.139 , "2.33" =0.176 ,  "3"=0.194 , "3.67"=0.092 , "4.33"=0.052 , "5"= 0.034 ),
                                     partymmain = c("Neither like nor dislike candidate's party" = 0.194  , 
                                                    "Like candidate's party somewhat" = 0.135  ,          
                                                    "Dislike candidate's party somewhat"  = 0.14  , 
                                                    "Dislike candidate's party a great deal"  = 0.268 , 
                                                    "Like candidate's party a great deal" =0.064),
                                     canage_grp = c("43-57" =0.333, "58-67" =0.333, "68-77" = 0.333),
                                     cangender = c("Male"=0.917,   "Female"=0.083)
)


f <- support_rc ~ candemmg_rc +cancom_rc + distance + partymmain + canage_grp + cangender 
f1 <- support_rc ~ candemmg_rc +cancom_rc + distance + partymmain + canage_grp + cangender + pairID + respondentid


##  CZ:
## get model matrix for complete cases
llm <- lm( f  , data = CZdds)
summary(llm)
str(llm)

library(data.table)
cc <- na.omit(as.data.table( CZdds), cols = all.vars(f1) )
names(cc)
fvars <- all.vars(f1)
library(tidyverse)
ccc <- cc %>% dplyr::select(matches(fvars ) )

ccc <- ccc %>% filter(pairID %in%  names(which(table(ccc$pairID)==2) ) )

library(purrr)
names(ccc)
ccc$candemmg_rc <- as.factor(ccc$candemmg_rc)
ccc$cancom_rc <- as.factor(ccc$cancom_rc)
ccc$distance <- as.factor(ccc$distance)
ccc$partymmain <- as.factor(ccc$partymmain)
ccc$canage_grp   <- as.factor(ccc$canage_grp  )
ccc$cangender <- as.factor(ccc$cangender)
#ccc$canagedecade   <- as.factor(ccc$canagedecade  )




library(factorEx)
out_design_mar <- 
  design_pAMCE(formula = support_rc ~ candemmg_rc  + cancom_rc  +distance + partymmain + canage_grp + cangender ,
               #factor_name = c("candemmg_rc", "cancom_rc"),
               data = ccc,
               pair_id = ccc$pairID,
               cluster_id = ccc$respondentid,
               target_dist  = target_dist_marginal_CZ_AppD[1:6], target_type = "marginal")
summary(out_design_mar)
table(ccc$pairID)

pdf("pcz.pdf", width = 10, height = 10)
pcz <- plot(out_design_mar, factor_name = c("candemmg_rc", "cancom_rc", "distance" , "partymmain" , "canage_grp" , "cangender"), main = "pAMCE for the Czech Republic", mar = 22, xlim  = c(-1.0,1.5))
dev.off()




#### UK:

f <- support_rc ~ candemmg_rc +cancom_rc + distance + partymmain + canage_grp + cangender 

f1 <- support_rc ~ candemmg_rc +cancom_rc + distance + partymmain + canage_grp + cangender + pairID + respondentid


target_dist_marginal_UK_AppD <- list(candemmg_rc = c("0"=0.5, "1" = 0.5),
                                     cancom_rc = c("1" = 0.2 , "2" =0.2 , "3" = 0.2, "4" = 0.2, "5" = 0.2),
                                     distance = c("1" = 0.133, "1.67"=0.145 , "2.33" =0.201 ,  "3"=0.223 , "3.67"=0.092 , "4.33"=0.051 , "5"= 0.045 ),
                                     partymmain = c("Neither like nor dislike candidate's party" = 0.206  , 
                                                    "Like candidate's party somewhat" = 0.242  ,          
                                                    "Dislike candidate's party somewhat"  = 0.143  , 
                                                    "Dislike candidate's party a great deal"  = 0.205 , 
                                                    "Like candidate's party a great deal" =0.012),
                                     canage_grp = c("44-53" =0.333, "54-57" =0.333, "58-61" =0.33) ,
                                     cangender = c("Male"=0.714,   "Female"=0.286)
)


##  UK
## get model matrix for complete cases
llm <- lm( f  , data = UKdds)
summary(llm)
str(llm)

library(data.table)
cc <- na.omit(as.data.table( UKdds), cols = all.vars(f1) )
names(cc)
fvars <- all.vars(f1)
library(tidyverse)
ccc <- cc %>% dplyr::select(matches(fvars ) )

ccc <- ccc %>% filter(pairID %in%  names(which(table(ccc$pairID)==2) ) )

library(purrr)
names(ccc)
ccc$candemmg_rc <- as.factor(ccc$candemmg_rc)
ccc$cancom_rc <- as.factor(ccc$cancom_rc)
ccc$distance <- as.factor(ccc$distance)
ccc$partymmain <- as.factor(ccc$partymmain)
ccc$canage_grp   <- as.factor(ccc$canage_grp  )
ccc$cangender <- as.factor(ccc$cangender)
#ccc$canagedecade   <- as.factor(ccc$canagedecade  )




library(factorEx)
out_design_mar <- 
  design_pAMCE(formula = support_rc ~ candemmg_rc  + cancom_rc  +distance + partymmain + canage_grp + cangender ,
               #factor_name = c("candemmg_rc", "cancom_rc"),
               data = ccc,
               pair_id = ccc$pairID,
               cluster_id = ccc$respondentid,
               target_dist  = target_dist_marginal_UK_AppD[1:6], target_type = "marginal")
summary(out_design_mar)
table(ccc$pairID)


pdf("puk.pdf", width = 10, height = 10)
plot(out_design_mar, factor_name = c("candemmg_rc", "cancom_rc", "distance" , "partymmain" , "canage_grp" , "cangender"), main = "pAMCE for the UK", mar = 22, xlim  = c(-1.0,1.5))
dev.off()





##############################
f <- support_rc ~ candemmg_rc +cancom_rc + distance + partymmain + canagedecade + cangender 
f1 <- support_rc ~ candemmg_rc +cancom_rc + distance + partymmain + canagedecade + cangender + pairID + respondentid


target_dist_marginal_MX_AppD <- list(candemmg_rc = c("0"=0.5, "1" = 0.5),
                                     cancom_rc = c("1" = 0.2 , "2" =0.2 , "3" = 0.2, "4" = 0.2, "5" = 0.2),
                                     distance = c("1" = 0.158, "1.67"=0.11 , "2.33" =0.109 ,  "3"= 0.268 , "3.67"=0.087 , "4.33"=0.053 , "5"= 0.087 ),
                                     partymmain = c("Neither like nor dislike candidate's party" = 0.222  , 
                                                    "Like candidate's party somewhat" = 0.141  ,          
                                                    "Dislike candidate's party somewhat"  = 0.143  , 
                                                    "Dislike candidate's party a great deal"  = 0.281 , 
                                                    "Like candidate's party a great deal" =0.09),
                                     canagedecade = c("3.9" =0.031, "4" =0.031, "4.4" =0.063, "4.5" =0.031, "4.6" =.031, "4.7"= 0.031,  "4.8" =0.031, "4.9" =0.063, "5" =0.094, "5.1"=0.031, "5.2" =0.094, "5.3"= 0.031,"5.4" =0.031, "5.5" =0.031, "5.6"= 0.063, "5.7"= 0.094, "5.8"= 0.031, "6"= 0.031, "6.1"=0.063, "6.2"=0.031, "6.9"=0.062),
                                     cangender = c("Male"=0.938,   "Female"=0.062)
)

##  MX:
## get model matrix for complete cases
llm <- lm( f  , data = MXdds)
summary(llm)
str(llm)

library(data.table)
cc <- na.omit(as.data.table( MXdds), cols = all.vars(f1) )
names(cc)
fvars <- all.vars(f1)
library(tidyverse)
ccc <- cc %>% dplyr::select(matches(fvars ) )

ccc <- ccc %>% filter(pairID %in%  names(which(table(ccc$pairID)==2) ) )

library(purrr)
names(ccc)
ccc$candemmg_rc <- as.factor(ccc$candemmg_rc)
ccc$cancom_rc <- as.factor(ccc$cancom_rc)
ccc$distance <- as.factor(ccc$distance)
ccc$partymmain <- as.factor(ccc$partymmain)
#ccc$canage_grp   <- as.factor(ccc$canage_grp  )
ccc$cangender <- as.factor(ccc$cangender)
ccc$canagedecade   <- as.factor(ccc$canagedecade  )




library(factorEx)
out_design_mar <- 
  design_pAMCE(formula = support_rc ~ candemmg_rc  + cancom_rc  +distance + partymmain + canagedecade + cangender ,
               #factor_name = c("candemmg_rc", "cancom_rc"),
               data = ccc,
               pair_id = ccc$pairID,
               cluster_id = ccc$respondentid,
               target_dist  = target_dist_marginal_MX_AppD[1:6], target_type = "marginal")
 summary(out_design_mar)
table(ccc$pairID)


pdf("pmx.pdf", width = 10, height = 10)
plot(out_design_mar, factor_name = c("candemmg_rc", "cancom_rc", "distance" , "partymmain" , "canagedecade" , "cangender"), main = "pAMCE for Mexico", mar = 22, xlim  = c(-1.0,1.5))
dev.off()




target_dist_marginal_SK_AppD <- list(candemmg_rc = c("0"=0.5, "1" = 0.5),
                                     cancom_rc = c("1" = 0.2 , "2" =0.2 , "3" = 0.2, "4" = 0.2, "5" = 0.2),
                                     distance = c("1" = 0.1, "1.67"=0.088 , "2.33" =0.16 ,  "3"=0.147 , "3.67"=0.068 , "4.33"=0.041 , "5"= 0.025 ),
                                     partymmain = c("Neither like nor dislike candidate's party" = 0.21  , 
                                                    "Like candidate's party somewhat" = 0.122  ,          
                                                    "Dislike candidate's party somewhat"  = 0.075  , 
                                                    "Dislike candidate's party a great deal"  = 0.137 , 
                                                    "Like candidate's party a great deal" =0.063),
                                     canagedecade = c("4.9" =0.056, "5.4"=0.056, "5.5"=0.111, "5.6"=0.056, "5.9"= 0.056, "6"= 0.111,    "6.2" =0.056, "6.3"=0.056, "6.4"=0.056, "6.5"=0.056, "6.6" =0.056, "6.7" =0.056,  "6.8" =0.056, "7.2" =0.056, "7.3" =0.056, "7.7" =0.056),
                                     cangender = c("Male"=0.944,   "Female"=0.056)
)


##  SK:
## get model matrix for complete cases
llm <- lm( f  , data = SKdds)
summary(llm)
str(llm)

f <- support_rc ~ candemmg_rc +cancom_rc + distance + partymmain + canagedecade + cangender 
f1 <- support_rc ~ candemmg_rc +cancom_rc + distance + partymmain + canagedecade + cangender + pairID + respondentid


library(data.table)
cc <- na.omit(as.data.table( SKdds), cols = all.vars(f1) )
names(cc)
fvars <- all.vars(f1)
library(tidyverse)
ccc <- cc %>% dplyr::select(matches(fvars ) )

ccc <- ccc %>% filter(pairID %in%  names(which(table(ccc$pairID)==2) ) )

library(purrr)
names(ccc)
ccc$candemmg_rc <- as.factor(ccc$candemmg_rc)
ccc$cancom_rc <- as.factor(ccc$cancom_rc)
ccc$distance <- as.factor(ccc$distance)
ccc$partymmain <- as.factor(ccc$partymmain)
#ccc$canage_grp   <- as.factor(ccc$canage_grp  )
ccc$cangender <- as.factor(ccc$cangender)
ccc$canagedecade   <- as.factor(ccc$canagedecade  )




library(factorEx)
out_design_mar <- 
  design_pAMCE(formula = support_rc ~ candemmg_rc  + cancom_rc  +distance + partymmain + canagedecade + cangender ,
               #factor_name = c("candemmg_rc", "cancom_rc"),
               data = ccc,
               pair_id = ccc$pairID,
               cluster_id = ccc$respondentid,
               target_dist  = target_dist_marginal_SK_AppD[1:6], target_type = "marginal")
summary(out_design_mar)
table(ccc$pairID)
str(out_design_mar)

pdf("psk.pdf", width = 10, height = 10)
plot(out_design_mar, factor_name = c("candemmg_rc", "cancom_rc", "distance" , "partymmain" , "canagedecade" , "cangender"), main = "pAMCE for South Korea", mar = 22, xlim  = c(-1.0,1.5))
dev.off()
 








f <- support_rc ~ candemmg_rc +cancom_rc + distance + partymmain + canagedecade + cangender 
f1 <- support_rc ~ candemmg_rc +cancom_rc + distance + partymmain + canagedecade + cangender + pairID + respondentid

##  MX:
## get model matrix for complete cases
llm <- lm( f  , data = MXdds)
summary(llm)
str(llm)

library(data.table)
cc <- na.omit(as.data.table( MXdds), cols = all.vars(f1) )
names(cc)
fvars <- all.vars(f1)
library(tidyverse)
ccc <- cc %>% dplyr::select(matches(fvars ) )

ccc <- ccc %>% filter(pairID %in%  names(which(table(ccc$pairID)==2) ) )

library(purrr)
names(ccc)
 ccc$candemmg_rc <- as.factor(ccc$candemmg_rc)
 ccc$cancom_rc <- as.factor(ccc$cancom_rc)
 ccc$distance <- as.factor(ccc$distance)
 ccc$partymmain <- as.factor(ccc$partymmain)
# ccc$canage_grp   <- as.factor(ccc$canage_grp  )
 ccc$cangender <- as.factor(ccc$cangender)
 ccc$canagedecade   <- as.factor(ccc$canagedecade  )
 
 
 # target_dist_marginal_US_AppD$distance <- as.numeric(target_dist_marginal_US_AppD$distance)

 df1 <- ccc[,1:7] %>%  map(function(s) {
	sort(unique(s))} )

df2 <- target_dist_marginal_MX_AppD %>%  map(function(s) {
	sort(names(s))} )









      
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

target_dist_marginal
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



### Appendix C:    reg support candemmg cancom distance partymmain canagedecade cangender if country == "CZ", cluster(resp)



f <- support_rc ~  candemmg_rc*cancom_rc +dissummN + partymmain+ canage_grp + +cangender +   background +pairID + respondentid



library(cregg)


