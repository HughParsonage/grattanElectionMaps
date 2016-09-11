
# for (year in c("2016", "2013", "2010", "2007", "2004")){
#   assign(paste0("senate_results", year, "1st_prefs_by_division"))
# }

aus_division_elect_map_simple_2016 <- readRDS("data-raw/elect_2016_simple.rds")
data("nat_map", package = "eechidna")
aus_division_elect_map_simple_2013 <- nat_map
aus_division_elect_map_simple_2010 <- readRDS("data-raw/2010-shapefile-simple.rds")
aus_division_elect_map_simple_2007 <- readRDS("data-raw/2007-shapefile-simple.rds")
aus_division_elect_map_simple_2004 <- readRDS("data-raw/2004-shapefile-simple.rds")

devtools::use_data(aus_division_elect_map_simple_2016,
                   aus_division_elect_map_simple_2013,
                   aus_division_elect_map_simple_2010,
                   aus_division_elect_map_simple_2007,
                   aus_division_elect_map_simple_2004)
