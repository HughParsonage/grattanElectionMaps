library(data.table)

polling_places <- function(year){
  if(year == "2016") {
    fread("http://vtr.aec.gov.au/Downloads/GeneralPollingPlacesDownload-20499.txt")
  } else {
    the_year <- year
    code <- yearcd[year == the_year]$code
    if (year != "2004")
      suppressWarnings(fread(paste0("http://results.aec.gov.au/", code, "/Website/Downloads/GeneralPollingPlacesDownload-", code, ".csv")))
    else
      suppressWarnings(fread(paste0("http://results.aec.gov.au/", code, "/results/Downloads/GeneralPollingPlacesDownload-", code, ".csv")))
  }
}

polling_places_2016 <- polling_places()
polling_places_2013 <- polling_places("2013")
polling_places_2010 <- polling_places("2010")
polling_places_2007 <- polling_places("2007")
polling_places_2004 <- polling_places("2004")

devtools::use_data(#polling_places_2016,
                   polling_places_2013,# <- polling_places("2013")
                   polling_places_2010,# <- polling_places("2010")
                   polling_places_2007,# <- polling_places("2007")
                   polling_places_2004#, <- polling_places("2004"))
)

