#' Tema de ggplot2 usado en la tesis
#'
#' Basado en [ggplot2::theme_minimal()] pero con modificaciones... mínimas (badumtssss)
#'
#' @param base_size base font size, given in pts
#'
#' @export
theme_tesis <- function(base_size = 16) {
  ggplot2::theme_minimal(base_size = base_size) +
    ggplot2::theme(
      # strip.background = ggplot2::element_rect(fill = NA, color = "gray30"),
      # text = element_text(family = font_rc),
      legend.position = "bottom", legend.box = "vertical",
      tagger.panel.tag.background = ggplot2::element_rect(color = NA),
      strip.text = ggplot2::element_text(size =  ggplot2::rel(11/16)),
      # panel.spacing.y = grid::unit(5, "mm"),
      # panel.spacing.x = grid::unit(5, "mm"),
      # legend.spacing = grid::unit(2, "mm"),
      # panel.border = ggplot2::element_rect(colour = "black", fill = NA),
      # plot.margin = grid::unit(rep(3, 4), "mm"),
      # # legend.title = element_blank(),
      # legend.box.spacing = grid::unit(3, "mm"),
      # legend.margin = ggplot2::margin(t = -5),
      panel.grid = ggplot2::element_line(color = scales::alpha("gray60", 0.5), size = 0.1),
      panel.ontop = TRUE)
}


#' Agrega un fondo gris a los paneles
#'
#' @export
panel_background <- function() {
  theme(panel.background = element_rect(fill = "#fbfbfb", color = NA),
                          panel.ontop = FALSE,
                          tagger.panel.tag.background = ggplot2::element_rect(color = NA,
                                                                              fill = "#fbfbfb"))
}


#' Grilla para los mapas
#'
#' @export
annotate_grid <- function() {

  list(
    theme(panel.grid = element_blank()),
    annotate("segment",
             y = seq(-90, 0, by = 15),
             yend = seq(-90, 0, by = 15),
             x = 0,
             xend = 360,
             size = 0.1, alpha = 0.5),

    annotate("segment",
             x = seq(0, 360 - 30, by = 30),
             xend =  seq(0, 360 - 30, by = 30),
             y = -90 + 15,
             yend = Inf,
             size = 0.1, alpha = 0.5),
    shadowtext::geom_shadowtext(data = data.frame(x = 0, y = seq(-90 + 15, 0,
                                                                 by = 15)),
                                aes(x, y, label = LatLabel(y)), size = 1.5,
                                alpha = 0.7,
                                colour = "black",
                                bg.colour = "white")
  )
}

#' Coordenadas polares con un sf blanco que tapa lo que sobra
#'
#' @export
coord_polar2 <- function(ymax = -20, ...) {
  x <- c(seq(0, 360, length.out = 40),
         seq(360, 0, length.out = 40),
         0)
  y <- c(rep(ymax, length.out = 40),
         rep(60, length.out = 40),
         ymax)

  cbind(x, y) %>%
    list() %>%
    sf::st_polygon() %>%
    sf::st_sfc(crs = "+proj=latlong") -> white

  list(
    geom_sf(data = white, inherit.aes = FALSE,
            fill = "white",
            colour = "white", size = 2),
    coord_sf(ylim = c(-90, ymax),
             lims_method = "box",
             crs = "+proj=laea +lat_0=-90",
             default_crs = "+proj=longlat",
             label_axes =  "----", ...)
  )
}



#' guide_colorsteps personalizada
#'
#' @export
guide_colorsteps <- function(even.steps = TRUE, show.limits = NULL, ticks = FALSE,
                              ...) {
  guide <- guide_colourbar(raster = FALSE, ticks = ticks,
                           nbin = 300, ...)
  guide$even.steps <- even.steps
  guide$show.limits <- show.limits
  class(guide) <- c("colorsteps", class(guide))
  guide
}

#' @export
#' @rdname guide_colorsteps
guide_colorsteps_bottom <- function(width = 15, height = 0.5, even.steps = FALSE,
                                    title.position = "top", show.limits = TRUE, ticks = TRUE,
                                    ...) {
  guide_colorsteps(show.limits = show.limits, even.steps = even.steps,
                   title.position = title.position, title.hjust = 0.5,
                   barheight = height, ticks = ticks,
                   ticks.colour = "black",
                   barwidth = width, frame.colour = "black", ...)
}


#' AnchorBreaks que opcionalmente extiende los límites para ser simétrico al rededor del ancla
#'
#' @export
AnchorBreaksSym <- function (anchor = 0, binwidth = NULL, exclude = NULL, bins = 10, symmetrical = FALSE) {
  force(anchor)
  force(binwidth)
  force(exclude)
  force(bins)
  force(symmetrical)
  function(x, binwidth2 = NULL) {
    if (symmetrical) {
      length <- max(abs(x - anchor))
      x <- c(anchor - length, anchor + length)
    }
    if (!is.null(binwidth))
      binwidth2 <- binwidth
    if (is.null(binwidth2)) {
      binwidth2 <- diff(pretty(x, bins))[1]
    }
    mult <- ceiling((x[1] - anchor)/binwidth2) - 1L
    start <- anchor + mult * binwidth2
    b <- seq(start, x[2] + binwidth2, binwidth2)
    b[!(b %in% exclude)]
  }
}
