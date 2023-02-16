#' Computa actividad de onda
#'
#' @param psi_z vector con anomalía zonal de función corriente
#' @param lon,lat vectores con ubicaciones
#' @param p nivel de presión en hPa
#' @param a radio de la Tierra en metros
#'
#' @export
WaveFlux2 <- function(psi_z, lon, lat, p = 250, a = 6371000) {
  psi <- data.table::data.table(psi_z = psi_z,
                                lon = lon,
                                lat = lat)


  k <- p*100/(a^2*2000)

  psi[, c("psi.dlon", "psi.dlat") := metR::Derivate(psi_z ~ lon + lat,
                                                    cyclical = c(TRUE, FALSE))] %>%
    .[, psi.ddlon := metR::Derivate(psi_z ~ lon, cyclical = TRUE, order = 2),
      by = lat] %>%
    .[, psi.dlondlat := metR::Derivate(psi.dlon ~ lat),
      by = lon] %>%
    .[, `:=`(f.lon = k/cos(lat*pi/180)*(psi.dlon^2 - psi_z*psi.ddlon),
             f.lat = k*(psi.dlon*psi.dlat - psi_z*psi.dlondlat))]
  list(f.lon = psi$f.lon, f.lat = psi$f.lat)
}
