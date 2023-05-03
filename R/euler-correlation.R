#' Diagrama de Euler
#'
#'
#'
#' @export
euler_correlation <- function(y, x1, x2, labels = NULL) {
  # From https://www.andrewheiss.com/blog/2021/08/21/r2-euler/
  ss <- function(x) {
    sum((x - mean(x))^2)
  }

  extract_sumsq <- function(model){
    summary(model)[[1]][, 'Sum Sq'][1]   # Qué carajo?
  }

  if (is.null(labels)) {
    labels <- c(deparse(substitute(y)),
                deparse(substitute(x1)),
                deparse(substitute(x2)))
  }

  y <- scale(y)
  x1 <- scale(x1)
  x2 <- scale(x2)

  n <- length(y) - 1

  # A
  y_alone <- ss(aov(y ~ x2 + x1)$residuals)


  # B
  x1_alone <-  ss(aov(x1 ~ y + x2)$residuals)


  # C
  x2_alone <- ss(aov(x2 ~ y + x1)$residuals)

  # D + G
  y_plus_x1 <- extract_sumsq(aov(y ~ x1))

  # E + G
  y_plus_x2 <- extract_sumsq(aov(y ~ x2))

  # F + G
  x1_plus_x2 <- extract_sumsq(aov(x1 ~ x2))

  # D = (A + D + E + G) − A − (E + G)
  y_x1_alone <- n - y_alone - y_plus_x2

  # E = (A + D + E + G) − A − (D + G)
  y_x2_alone <- n - y_alone - y_plus_x1

  # G = (D + G) − D
  y_x1_x2_alone <- y_plus_x1 - y_x1_alone

  # F = (F + G) - G
  x1_x2_alone <- x1_plus_x2 - y_x1_x2_alone

  pasteand <- function(..., sep = "&") paste(..., sep = sep)
  all_pieces <- c(y_alone,
                  x1_alone,
                  x2_alone,
                  y_x1_alone,
                  y_x2_alone,
                  x1_x2_alone,
                  y_x1_x2_alone)/n

  all_pieces <- pmax(all_pieces, 0)
  labels <- c(labels,
              pasteand(labels[1], labels[2]),
              pasteand(labels[1], labels[3]),
              pasteand(labels[2], labels[3]),
              pasteand(labels[1], labels[2], labels[3]))


  all_pieces <- setNames(all_pieces, labels)

  plot(eulerr::euler(all_pieces),
       quantities = scales::percent(all_pieces))
}
