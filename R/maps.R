#' Geom que dibuja un mapa usando geom_sf()
#'
#' Usa un mapa global simplificado centrado en el Pacífico.
#'
#'
#' @param transform una función arbitraria que se aplicar a los datos.
#' @param crop caja de límites opcionales para recortar el mapa.
#' @param color,size,fill parámetros pasados a [ggplot2::geom_polygon()].
#' @param ... otros ajustes pasados a [ggplot2::geom_polygon()].
#'
#' @export
geom_qmap <- function(transform = identity,
                      crop = NULL,
                      color = "gray50", size = 0.3,
                      fill = NA, ...) {
  lon <- lat <- group <- NULL
  data <- simplemap

  if (!is.null(crop)) {
    bbox <- sf::st_bbox(data)

    for (n in names(crop)) {
      bbox[[n]] <- crop[[n]]
    }

    data <- sf::st_crop(data, bbox)
  }

  data <- transform(data)

  ggplot2::geom_sf(data = data,
                   inherit.aes = FALSE,
                   color = color,
                   size = size,
                   fill = fill,
                   ...)

}


