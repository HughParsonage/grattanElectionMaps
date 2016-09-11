#' Plot region of Australia
#'
#' @param city Which city to plot
#' @param coord_lines Plot grid lines at 0.1 intervals.
#' @param inset_scale Scale relative to Australia.
#' @importFrom magrittr %>%
#' @return A list of three elements, \code{vwidth} the width of the inset on the device, \code{vheight} the height of the inset on the device, and \code{p} the plot.
#' @note This function should not be called directly. It is intended to be used to plot insets on a map generated through \code{\link{draw_electoral_divisions_map}}.

plot_region <- function(city, coord_lines = c("none", "latlon", "lat", "lon"), inset_scale = 15){
  coord_lines <- match.arg(coord_lines)

  xlim1 <- cities_coords[[city]][1]
  xlim2 <- cities_coords[[city]][2]
  ylim1 <- cities_coords[[city]][3]
  ylim2 <- cities_coords[[city]][4]

  lon_lines <- seq(from = ceiling(10 * xlim1) / 10, to = floor(10 * xlim2) / 10, by = .1)
  lat_lines <- seq(from = ceiling(10 * ylim1) / 10, to = floor(10 * ylim2) / 10, by = .1)

  the_divisions_to_plot <-
    .polygonal.data %>%
    # Exclude Lord Howe Island and Norfolk Island
    # (When plotting Division of Sydney or Division of Fraser/Fenner)
    dplyr::filter(long < 154) %>%
    dplyr::group_by(ELECT_DIV) %>%
    dplyr::mutate(include.it = all(dplyr::between(long, xlim1, xlim2), dplyr::between(lat, ylim1, ylim2))) %>%
    dplyr::ungroup %>%
    dplyr::filter(include.it)

  # Now we have determined the divisions, choose the minimal
  # rectangular map of Earth that includes all points
  xlim <- c(min(the_divisions_to_plot$long),
            max(the_divisions_to_plot$long))
  ylim <- c(min(the_divisions_to_plot$lat),
            max(the_divisions_to_plot$lat))

  xlength <- diff(xlim)
  ylength <- diff(ylim)

  xlim <- c(xlim[1] - 0.025 * xlength,
            xlim[2] + 0.025 * xlength)
  ylim <- c(ylim[1] - 0.025 * ylength,
            ylim[2] + 0.025 * ylength)

  pp <-
    ggplot2::ggplot(the_divisions_to_plot) +
    ggplot2::geom_polygon(ggplot2::aes_string(x = "long", y = "lat", fill = "fill.f", group = "group"),
                          color = "black")

  if (coord_lines != "none"){
    if (grepl("lon", coord_lines, fixed = TRUE)){
      pp <-
        pp +
        ggplot2::geom_vline(xintercept = lon_lines) +
        ggplot2::annotate("label",
                 x = lon_lines,
                 label = as.character(lon_lines),
                 y = min(lat_lines) + 0.15 * (max(lat_lines) - min(lat_lines))) +
        ggplot2::annotate("label",
                 y = lat_lines,
                 x = min(lon_lines) + 0.15 * (max(lon_lines) - min(lon_lines)),
                 label = as.character(lat_lines))
    }

    if (grepl("lat", coord_lines, fixed = TRUE)){
      pp <-
        pp +
        ggplot2::geom_hline(yintercept = lat_lines) +
        ggplot2::annotate("label",
                          y = lat_lines,
                          x = min(lon_lines) + 0.15 * (max(lon_lines) - min(lon_lines)),
                          label = as.character(lat_lines))
    }
  }

  pp <-
    pp +
    ggplot2::coord_map(xlim = xlim, ylim = ylim) +
    ggplot2::scale_fill_manual(values = rev(c("black", gpalx(7), "white")), drop = FALSE) +
    ggthemes::theme_map(base_size = 25) +
    ggplot2::theme(legend.position = "none")

  list(
    vwidth = 15 * xlength / lapply(entire_extent, diff)$xlim,
    vheight = 15 * ylength / lapply(entire_extent, diff)$ylim,
    p = pp)
}
