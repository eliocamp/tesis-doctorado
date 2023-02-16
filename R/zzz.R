#' Funciones para agregar pre/sufijos
#'
#' @param suffix,preffix caracter que luego va a agregarse.
#'
#' @export
AddSuffix <- function(suffix = "") {
  force(suffix)
  function(string) {
    paste0(string, suffix)
  }
}

#' @export
#' @rdname AddSuffix
AddPreffix <- function(preffix = "") {
  force(preffix)
  function(string) {
    paste0(preffix, string)
  }
}



#' Remueve el intercepto
#'
#' Remueve las filas donde la columna `term` es igual a `"(Intercept)"`.
#'
#' @param data un dataframe
#'
#' @export
rm_intercept <- function(data) {
  data[data$term != "(Intercept)"]
}

`%||%` <- function (x, y) {
  if (is.null(x))
    y
  else x
}


globalVariables(c(":=", ".", ".NATURAL"))

.datatable.aware <- TRUE
