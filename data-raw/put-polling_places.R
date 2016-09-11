
polling_places <- function(year = "2016"){
  if (year == "2016"){
    fread("http://vtr.aec.gov.au/Downloads/GeneralPollingPlacesDownload-20499.txt")
  }
}

polling_places_2016 <- polling_places()

devtools::use_data(polling_places_2016)

