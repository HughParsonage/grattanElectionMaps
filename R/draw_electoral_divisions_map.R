#' Draw an electoral map, with insets.
#'
#' @param .polygonal.data Data including the vertices of all polygons, including a \code{fill} variable to colour the polygons.
#' @param year What elections' boundaries should be used?
#' @param scale_fill_manual_args A list of arguments to pass to \code{scale_fill_manual}.
#' @param city_inset_scale By how much should the cities' insets be scaled by relative to the Australia plot?
#' @param legend.title What should the legend title (for \code{fill}) be?
#' @return A printed ggplot object.
#' @export
#'

draw_electoral_divisions_map <- function(.polygonal.data,
                                         year = c("2016", "2013", "2010", "2007", "2004"),
                                         scale_fill_manual_args = NULL,
                                         city_inset_scale = 15,
                                         legend.title = NULL){

  stopifnot(all(c("lat", "long", "fill", "group") %in% names(.polygonal.data)))

  year <- match.arg(year)

  entire_extent <-
    # lat longs of Australia.
    list(xlim = c(113, 158),
         ylim = c(-50, -7)) # lat = -9.8 -45 sufficient, but not for extra plots

  entire <-
    ggplot2::ggplot(.polygonal.data) +
    ggplot2::geom_polygon(ggplot2::aes_string(x = "long", y = "lat", fill = "fill.f", group = "group"),
                          color = theGrey) +
    ggplot2::coord_map(xlim = entire_extent$xlim, ylim = entire_extent$ylim) +
    ggplot2::scale_fill_manual(values = rev(c("black", gpalx(7), "white")), drop = FALSE) +
    ggthemes::theme_map(base_size = 25)

  if (is.null(legend.title)){
    entire <- entire + ggplot2::theme(legend.title = ggplot2::element_blank())
  } else {
    entire <- entire + ggplot2::guides(fill = ggplot2::guide_legend(title = legend.title))
  }

  entire <- entire + ggplot2::theme(legend.position = c(0, 1),
                                    legend.justification = c(0, 1),
                                    legend.margin = grid::unit(0, "lines"))

  print(entire, newpage = TRUE)

  print_city_plot("PER", xpos = 0.10, ypos = 0.45, vfactor = 1)
  print_city_plot("ADL", xpos = 0.38, ypos = 0.325, vfactor = 1)
  print_city_plot("MEL", xpos = 0.55, ypos = 0.10, vfactor = 1)
  print_city_plot("SYD", xpos = 0.85, ypos = 0.20, vfactor = 1)
  print_city_plot("BNE", xpos = 0.875, ypos = 0.75, vfactor = 1)
}
