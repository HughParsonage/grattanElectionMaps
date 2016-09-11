

yearcd <-
  data.table::data.table(year = c("2016", "2013", "2010", "2007", "2004"),
                         code = c(20499, 17496, 15508, 13745, 12246))

cities_coords <-
  list(MEL = c(143.8, 146.0, -38.5, -37.00),
       SYD = c(150.35, 152.1, -34.5, -32.4),
       PER = c(115.3, 116.4, -32.3, -31.5),
       ADL = c(137.6, 139.25, -35.6, -34.28),
       BNE = c(152.4, 153.7, -28.2, -26.047))

cities_abbrev <-
  list(MEL = "Melbourne",
       SYD = "Greater Sydney",
       PER = "Perth",
       ADL = "Adelaide",
       BNE = "Greater Brisbane")

aus_extent <-
  # lat longs of Australia.
  list(xlim = c(113, 163),
       ylim = c(-52, -5)) # lat = -9.8 -45 sufficient, but not for extra plots

devtools::use_data(yearcd,
                   cities_coords,
                   cities_abbrev,
                   aus_extent,
                   #
                   internal = TRUE, overwrite = TRUE)
