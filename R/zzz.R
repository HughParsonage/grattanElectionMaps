.onLoad <- function(libname = find.package("grattan"), pkgname = "grattan"){
  # CRAN note avoidance:
  if (getRversion() >= "2.15.1"){
    utils::globalVariables(c("."))
  }
}
