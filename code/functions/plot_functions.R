###########################################################################
#####

# plot marginal effects
mm_plot <- function(data, title, legend = FALSE){
  plot1 <- ggplot(
    data = data, 
    mapping = aes(
      x = as.numeric(group), 
      y = predicted, 
      color = x)) +
    geom_line(linewidth = 1) + 
    geom_point(size = 1) + 
    geom_errorbar(
      mapping = aes(
        ymin = conf.low, 
        ymax = conf.high), 
      width = 0.2) + 
    geom_hline(
      yintercept = 2, 
      color = "darkred") +  
    scale_color_manual(
      labels = c(
        `0` = "Undemocratic",
        `1` = "Democratic"),
      values = c(
        `0` = "grey",
        `1` = "black")) + 
    scale_y_continuous(
      limits = c(2, 3.5)) +
    labs(
      x = "",
      y = "",
      color = "",
      shape = "",
      title = title) + 
    theme_minimal() + 
    theme(axis.text.x = element_blank(), 
          text = element_text(size = 15))
  
  if(legend == FALSE){
    plot1 <- plot1 + theme(legend.position = "none")
  } else{
    plot1 <- plot1 + theme(legend.position = c(0.2, 0.9))
  }
  
  return(plot1)
  
}

# plot contrasts
mm_c_plot <- 
  function(data, title){
    plot1 <- ggplot(
      data = data, 
      mapping = aes(
        x = index, 
        y = estimate)) + 
      geom_point(size = 1) + 
      geom_errorbar(
        mapping = aes(
          ymin = conf_low, 
          ymax = conf_high), 
        width = 0.2) + 
      geom_hline(
        yintercept = 0, 
        linetype = "dashed",
        color = "darkred") +
      scale_y_continuous(
        limits = c(-0.2, 0.2)) + 
      scale_x_continuous(
        labels = seq(1, 5, 1)) + 
      labs(
        x = "",
        y = "") + 
      theme_minimal() + 
      theme(text = element_text(size = 15))
    
    if(!is.null(title)){
      plot1 <- plot1 + ggtitle(title)
    } else{
      plot1 <- plot1
    }
    return(plot1)
  }
