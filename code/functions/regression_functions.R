###########################################################################

fxn_regression <- function(data, formula, cntry){
  
  if(cntry == "pooled"){
    dat <- data
  } else {
    dat <- dplyr::filter(data, country == cntry)
  }
  
  form <- as.formula(formula)
  model <- estimatr::lm_robust(
    form,
    clusters = resp,
    data = dat)
  
  return(model)
}
