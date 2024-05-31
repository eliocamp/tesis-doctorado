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


#' Remove singleton dimensions
#'
#' Removes any column from a dataframe that holds only
#' 1 unique value.
#'
#' @param data a dataframe
#'
#' @export
rm_singleton <- function(data) {
  data[, vapply(data, data.table::uniqueN, 1) != 1, with = FALSE]
}


#' Testea si puntos están en la región ENSO 34
#'
#' @param lon,lat vectores de longitud y latitud
#'
#' @returns Un vector lógico para cada punto indicando si está dentro de la región de ENSO 34 o no
#'
#' @export
is.enso34 <- function(lon, lat) {
  (abs(lat) < 5) & (ConvertLongitude(lon) %between% c(-170, -120))
}

`%||%` <- function (x, y) {
  if (is.null(x))
    y
  else x
}


globalVariables(c(":=", ".", ".NATURAL"))

.datatable.aware <- TRUE


# zzz.R
.onLoad <- function(libname, pkgname) {
  cache_root <- here::here("cache", "memoise")
  # compute_sam_cmip_one <<- memoise::memoise(compute_sam_cmip_one,
  #                                           cache = cachem::cache_disk(file.path(cache_root, "compute_sam_cmip_one"),
  #                                                                      max_size = Inf))
  # ceof_proyectado <<- memoise::memoise(ceof_proyectado,
  #                                      cache = cachem::cache_disk(file.path(cache_root, "ceof_proyectado"),
  #                                                                 max_size = Inf))

  # compute_ceof_cmip <<- memoise::memoise(compute_ceof_cmip,
  #                                        cache = cachem::cache_disk(file.path(cache_root, "compute_ceof_cmip"),
  #                                                                   max_size = Inf))

}
