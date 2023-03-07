###########################################################################

fxn_regression <- function(formula, cntry){
  
  if(cntry == "pooled"){
    data <- df_original
  } else {
    data <- dplyr::filter(df_original, country == cntry)
  }
  
  form <- as.formula(formula)
  model <- estimatr::lm_robust(
    form,
    clusters = resp,
    data = data)
  
  return(model)
}
