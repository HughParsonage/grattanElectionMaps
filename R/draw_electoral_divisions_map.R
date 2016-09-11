#' Draw an electoral map, with insets.
#'
#' @param .polygonal.data Data including the vertices of all polygons, including a \code{fill} variable to colour the polygons.
#' @param year What elections' boundaries should be used?
#' @param scale_fill_manual_args A list of arguments to pass to \code{scale_fill_manual}.
#' @param polygon_outline_colour The outline of polygons.
#' @param city_inset_scale By how much should the cities' insets be scaled by relative to the Australia plot?
#' @param legend.title What should the legend title (for \code{fill}) be?
#' @return A printed ggplot object.
#' @export
#'

draw_electoral_divisions_map <- function(.polygonal.data,
                                         year = c("2016", "2013", "2010", "2007", "2004"),
                                         scale_fill_manual_args = NULL,
                                         polygon_outline_colour = "black",
                                         city_inset_scale = 12,
                                         legend.title = NULL){

  stopifnot(all(c("lat", "long", "fill", "group") %in% names(.polygonal.data)))

  year <- match.arg(year)

  entire <-
    ggplot2::ggplot(.polygonal.data) +
    ggplot2::geom_polygon(ggplot2::aes_string(x = "long", y = "lat", fill = "fill", group = "group"),
                          color = polygon_outline_colour) +
    ggplot2::coord_map(xlim = aus_extent$xlim,
                       ylim = aus_extent$ylim) +
    ggthemes::theme_map(base_size = 25)

  if (!is.null(scale_fill_manual_args)){
    entire <- entire + do.call(ggplot2::scale_fill_manual, args = scale_fill_manual_args)
  }

  if (is.null(legend.title)){
    entire <- entire + ggplot2::theme(legend.title = ggplot2::element_blank())
  } else {
    entire <- entire + ggplot2::guides(fill = ggplot2::guide_legend(title = legend.title))
  }

  entire <- entire + ggplot2::theme(legend.position = c(0, 1),
                                    legend.justification = c(0, 1),
                                    legend.margin = grid::unit(0, "lines"))

  print(entire, newpage = TRUE)

  print_city_plot(.polygonal.data, "PER", xpos = 0.100, ypos = 0.450, vfactor = 1, scale_fill_manual_args = scale_fill_manual_args, city_inset_scale = city_inset_scale)
  print_city_plot(.polygonal.data, "ADL", xpos = 0.380, ypos = 0.325, vfactor = 1, scale_fill_manual_args = scale_fill_manual_args, city_inset_scale = city_inset_scale)
  print_city_plot(.polygonal.data, "MEL", xpos = 0.525, ypos = 0.130, vfactor = 1, scale_fill_manual_args = scale_fill_manual_args, city_inset_scale = city_inset_scale)
  print_city_plot(.polygonal.data, "SYD", xpos = 0.845, ypos = 0.200, vfactor = 1, scale_fill_manual_args = scale_fill_manual_args, city_inset_scale = city_inset_scale)
  print_city_plot(.polygonal.data, "BNE", xpos = 0.875, ypos = 0.725, vfactor = 1, scale_fill_manual_args = scale_fill_manual_args, city_inset_scale = city_inset_scale)
}
