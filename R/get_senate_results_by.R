#' Obtain senate results
#' @param year The year of the election for which results are desired.
#' @param by Which table of results should be fetched? \code{division} for results aggregated up to division; \code{polling_place} to obtain the results at each polling place.
#' @param state Which seats are results requested? Setting \code{by = 'division'} while selecting a state will ignore the state argument, with a warning.
#' @return A \code{data.table} of the results.
#' @note Connects to AEC website.
#' @export

get_senate_results_by <- function(year = c("2016", "2013", "2010", "2007", "2004"),
                                  by = c("division", "polling_place"),
                                  state = c("NSW", "VIC", "QLD", "SA", "WA", "TAS", "ACT", "NT")){
  if (by == "division" && !missing(state)){
    warning("by = 'division' but for a specific state. The state will be ignored.")
  }

  # Warnings occur because the file does not start in the expected place
  # However, we expect these to be stable.
  my_fread <- function(...) suppressWarnings({data.table::fread(...)})

  if (by == "division"){
    year <- match.arg(year)

    aec_code <- yearcd[year == year][["code"]]


    switch(year,
           "2016" = {
             my_fread("http://vtr.aec.gov.au/Downloads/SenateFirstPrefsByDivisionByVoteTypeDownload-20499.csv")
           },
           "2013" = {
             my_fread("http://results.aec.gov.au/17496/website/Downloads/SenateFirstPrefsByDivisionByVoteTypeDownload-17496.csv")
           },
           "2010" = {
             my_fread("http://results.aec.gov.au/15508/Website/Downloads/SenateFirstPrefsByDivisionByVoteTypeDownload-15508.csv")
           },
           "2007" = {
             my_fread("http://results.aec.gov.au/13745/Website/Downloads/SenateFirstPrefsByDivisionByVoteTypeDownload-13745.csv")
           },
           "2004" = {
             my_fread("http://results.aec.gov.au/12246/results/Downloads/SenateFirstPrefsByDivisionByVoteTypeDownload-12246.csv")
           })
  } else {
    if (year == "2016"){
      url <- paste0("http://vtr.aec.gov.au/External/SenateStateFirstPrefsByPollingPlaceDownload-20499-", state, ".zip")
    } else {
      url <- paste0("http://results.aec.gov.au/", aec_code, "/website/External/SenateStateFirstPrefsByPollingPlaceDownload-", aec_code, "-", state, ".zip")
    }

    temp.file <- tempfile(fileext = ".zip")
    temp.dir <- tempdir()

    if(httr::http_error(url))
      stop("Bad URL. This is a bug.")

    message("Fetching zip file from aec.gov.au ...", appendLF = FALSE)
    httr::GET(url = url, httr::write_disk(temp.file))
    message("unzipping ...")
    utils::unzip(zipfile = temp.file, exdir = temp.dir)
    csv.file <- list.files(path = temp.dir, pattern = "\\.csv$", full.names = TRUE)
    if (length(csv.file) != 1){
      stop("There does not exist a unique csv file in the target directory.")
    } else {
      my_fread(csv.file)
    }


  }
}
