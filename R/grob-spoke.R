#' Grob de un círculo con una flecha
#'
#' @export
grob_spoke <- function(data, coords) {
  radius <-  grid::unit(.15, "snpc")

  outer_circle <-  grid::circleGrob(x = 0,
                                    y = 0,
                                    r = radius*1.2)

  xcentre <- grid::unit(0, "npc") + grid:::grobHeight(outer_circle)/2
  ycentre <-  grid::unit(0, "npc") + grid:::grobWidth(outer_circle)/2


  circle <- grid::circleGrob(x = xcentre,
                             y = ycentre,
                             r = radius,
                             gp = grid::gpar(fill = "white",
                                             alpha = 0.7))
  # browser()
  dx <- cos(coords$angle[1]*pi/180)*grid::grobHeight(circle)/2
  dy <- sin(coords$angle[1]*pi/180)*grid::grobWidth(circle)/2


  line <- grid::segmentsGrob(x0 = xcentre, y0 = ycentre,
                             x1 = xcentre + dx,
                             y1 = ycentre + dy,
                             gp = grid::gpar(fill = "black"),
                             arrow = grid::arrow(angle = 13,
                                                 length =  grid::unit(.15/2, "snpc"),
                                                 type = "closed")
  )

  grid::gTree(children = grid::gList(circle, line))


}
