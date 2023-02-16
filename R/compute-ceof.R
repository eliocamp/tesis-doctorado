#' Computa Funciones Empíricas Ortogonales Complejas
#'
#' @param hgt vector de observaciones de altura geopotencial
#' @param lon,lat,lev vectores de ubicación de las observaciones de altura geopotencial
#' @param temporal valor lógico indicando si hay que computar anomalías temporales
#' @param lats_eof rango de latitudes a usar
#' @param n numérico indicando qué EOFs computar.
#'
#' @export
compute_ceof <- function(hgt, lon, lat, lev, time, temporal = FALSE, lats_eof = c(-90, -20), n = 1:2) {
  dt <- data.table::data.table(hgt, lon, lat, lev, time)

  dt <- dt[lev %in% c(50, 200) & lat %between% lats_eof] %>%
    .[, hgt := metR::Anomaly(hgt),
      by  = .(lat, time, lev)]

  if (temporal) {
    dt <- dt[, hgt := metR::Anomaly(hgt), by = .(lon, lat, lev)]
  }

  dt %>%
    .[, hgt := hgt/stats::sd(hgt), by = .(lev)] %>%
    .[, hgt := hgt*sqrt(cos(lat*pi/180))] %>%
    .[, hgt.cpx := spectral::analyticFunction(hgt),
      by = .(lat, time, lev)] %>%
    .[, hgt := hgt.cpx] %>%
    metR::EOF(hgt ~ time | lon + lat + lev, n = n, suffix = "cEOF", data = .)
}

