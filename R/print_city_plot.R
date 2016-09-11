#' Print inset of city
#'
#' @param city A city code.
#' @param xpos, ypos The positions in \code{npc} that the inset is the be drawn.
#' @param vfactor By how much should the city inset be scaled \strong{relative to other cities}.
#' @note This function must not be called directly.

print_city_plot <- function(city, xpos, ypos, vfactor){
  pr <- plot_region(city)
  vp <- grid::viewport(width = pr$vwidth * vfactor,
                       height = pr$vheight * vfactor ,
                       x = xpos,
                       y = ypos)
  print(pr$p, newpage = FALSE, vp = vp)
}
