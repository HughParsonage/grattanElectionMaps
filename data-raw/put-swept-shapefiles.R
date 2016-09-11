
# for (year in c("2016", "2013", "2010", "2007", "2004")){
#   assign(paste0("senate_results", year, "1st_prefs_by_division"))
# }
library(broom)
library(magrittr)
library(data.table)
library(dplyr)
library(dtplyr)

aus_division_elect_map_simple_2016 <-
{
  elect_2016 <- readRDS("data-raw/elect_2016_simple.rds")
  elect_2016@data$id <- seq_along(nrow(elect_2016@data))
  Electoral_divisions_by_id <-
    readRDS("data-raw/elect_div_by_id.rds") %>%
    setnames(old = "ELECT_DIV2", new = "ELECT_DIV")
  elect_2016_swept <-
    broom::tidy(elect_2016)
  # readRDS("data-raw/elect_2016_detailed.rds")
  swept_map <- merge(elect_2016_swept, Electoral_divisions_by_id, by = "id") %>%
    as.data.table
  swept_map
}

data("nat_map", package = "eechidna")
aus_division_elect_map_simple_2013 <-
  nat_map %>%
  mutate(ELECT_DIV = gsub("[^A-Z]", "", toupper(ELECT_DIV))) %>%
  select(-STATE) %>%
  as.data.table

aus_division_elect_map_simple_2010 <-
{
  simple_elect <-
    readRDS("data-raw/2010-shapefile-simple.rds")

  name_by_id <-
    simple_elect@data %>%
    select(ELECT_DIV, id = rmapshaperid)

  swept_map <-
    simple_elect %>%
    broom::tidy(.) %>%
    as.data.table %>%
    mutate(id = as.integer(id)) %>%
    merge(name_by_id, by = "id") %>%
    mutate(ELECT_DIV = gsub("[^A-Z]", "", toupper(ELECT_DIV)))

  swept_map
}
aus_division_elect_map_simple_2007 <-
{
  simple_elect <-
    # simplify 2007 shapefile
    readRDS("data-raw/2007-shapefile-simple.rds")

  name_by_id <-
    simple_elect@data %>%
    select(ELECT_DIV = NAME_2007, id = rmapshaperid)

  swept_map <-
    simple_elect %>%
    broom::tidy(.) %>%
    as.data.table %>%
    mutate(id = as.integer(id)) %>%
    merge(name_by_id, by = "id") %>%
    mutate(ELECT_DIV = gsub("[^A-Z]", "", toupper(ELECT_DIV)))

  swept_map
}
aus_division_elect_map_simple_2004 <-
{
  simple_elect <-
    # simplify 2007 shapefile
    readRDS("data-raw/2004-shapefile-simple.rds")

  name_by_id <-
    simple_elect@data %>%
    select(ELECT_DIV = NAME_2004, id = rmapshaperid)

  swept_map <-
    simple_elect %>%
    broom::tidy(.) %>%
    as.data.table %>%
    mutate(id = as.integer(id)) %>%
    merge(name_by_id, by = "id") %>%
    mutate(ELECT_DIV = gsub("[^A-Z]", "", toupper(ELECT_DIV)))

  swept_map
}

devtools::use_data(aus_division_elect_map_simple_2016,
                   aus_division_elect_map_simple_2013,
                   aus_division_elect_map_simple_2010,
                   aus_division_elect_map_simple_2007,
                   aus_division_elect_map_simple_2004, overwrite = TRUE)
