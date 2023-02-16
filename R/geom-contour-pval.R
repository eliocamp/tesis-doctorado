

#' Contorno al rededor de p-valores 'significativos'
#'
#'
#'
#' @export
geom_contour_pval <- function(mapping, p.value = 0.01, size = 0.1, ...) {
  mapping2 <- mapping
  mapping2$fill <- aes(fill = NA)$fill
  list(
    stat_contour_filled(mapping2, breaks = c(0, p.value), fill = NA, geom = pattern_dots, ...),
    geom_contour2(mapping, breaks = p.value, size = size, ...)
  )
}



pattern_dots <- ggplot2::ggproto("GeomDots", ggpattern::GeomPolygonPattern)
ggplot2::update_geom_defaults(pattern_dots,
                              list(pattern = "circle",
                                   colour = NA,
                                   pattern_colour = NA,
                                   pattern_fill = "black",
                                   pattern_density = 0.3,
                                   pattern_alpha = 1,
                                   pattern_spacing = 0.02,
                                   fill = NA
                              ))
