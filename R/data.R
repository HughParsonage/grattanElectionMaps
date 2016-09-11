#' @title Electoral map shapefiles
#' @description Simplified and swept shapefiles.
#'
#' @format A \code{data.table} of vertices of the polygons definining the division boundaries (approximately).
#' \describe{
#'  \item{id}{The id of the original shapefiles.}
#'  \item{long}{The longitude of the vertex.}
#'  \item{lat}{The latitude of the vertex.}
#'  \item{order}{The order in which the vertices are to be plotted for each polygon.}
#'  \item{hole}{Does the polygon contain a hole?}
#'  \item{piece}{Which piece?}
#'  \item{group}{Defines each polygon.}
#'  \item{ELECT_DIV}{A standardized name of the electoral division. Contains only capital letters; all other characters are stripped out: so McEwen is MCEWEN; O'Connor is OCONNOR; Kingsford-Smith is KINGSFORDSMITH.}
#' }
#'
#' @source \url{https://github.com/ropenscilabs/eechidna} for the 2013 shapefiles. \url{http://www.aec.gov.au/Electorates/gis/gis_datadownload.htm} for 2016, 2013, 2010. \url{http://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/2923.0.30.0012006?OpenDocument} for the 2007 and 2004 shapefiles.
#' @name aus_division_elect_map_simple_YEAR
NULL

#> NULL

#' @rdname aus_division_elect_map_simple_YEAR
'aus_division_elect_map_simple_2004'

#' @rdname aus_division_elect_map_simple_YEAR
'aus_division_elect_map_simple_2007'

#' @rdname aus_division_elect_map_simple_YEAR
'aus_division_elect_map_simple_2010'

#' @rdname aus_division_elect_map_simple_YEAR
'aus_division_elect_map_simple_2013'

#' @rdname aus_division_elect_map_simple_YEAR
'aus_division_elect_map_simple_2016'

