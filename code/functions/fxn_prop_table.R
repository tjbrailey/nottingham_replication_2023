fxn_prop_table <- function(var){
  df_original %>% 
    dplyr::filter(!is.na(!!sym(var))) %>% 
    dplyr::group_by(country) %>% 
    dplyr::mutate(total_obs = dplyr::n()) %>% 
    dplyr::group_by(country, !!sym(var)) %>% 
    dplyr::summarise(count = dplyr::n(),
                     total_obs = max(total_obs, na.rm = TRUE),
                     prop  = round(count / total_obs, 3)) %>% 
    dplyr::select(country, "measure" = !!sym(var), prop) %>% 
    tidyr::pivot_wider(names_from = country, values_from = prop) 
}
