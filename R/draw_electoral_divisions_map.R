


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

  cities_coords <-
    list(MEL = c(143.8, 146.0, -38.5, -37.00),
         SYD = c(150.05, 151.5, -34.5, -33.2),
         PER = c(115.3, 116.4, -32.3, -31.5),
         ADL = c(137.6, 139.25, -35.6, -34.28),
         BNE = c(152.4, 153.7, -28.2, -26.047))
}
