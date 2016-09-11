

yearcd <-
  data.table::data.table(year = c("2016", "2013", "2010", "2007", "2004"),
                         code = c(20499, 17496, 15508, 13745, 12246))

cities_coords <-
  list(MEL = c(143.8, 146.0, -38.5, -37.00),
       SYD = c(150.05, 151.5, -34.5, -33.2),
       PER = c(115.3, 116.4, -32.3, -31.5),
       ADL = c(137.6, 139.25, -35.6, -34.28),
       BNE = c(152.4, 153.7, -28.2, -26.047))

devtools::use_data(yearcd, cities_coords, internal = TRUE, overwrite = TRUE)
