#' Print inset of city
#'
#' @param .polygonal.data Polygonal data of the entire Australian map.
#' @param city A city code.
#' @param xpos The x-positions (in \code{npc}) that the inset is the be drawn.
#' @param ypos The y-position.
#' @param vfactor By how much should the city inset be scaled \strong{relative to other cities}.
#' @param ... Passed to \code{\link{plot_region}}.
#' @note This function must not be called directly.

print_city_plot <- function(.polygonal.data, city, xpos, ypos, vfactor, ...){
  pr <- plot_region(.polygonal.data, city, ...)
  vp <- grid::viewport(width = pr$vwidth * vfactor,
                       height = pr$vheight * vfactor ,
                       x = xpos,
                       y = ypos)
  print(pr$p, newpage = FALSE, vp = vp)
}
