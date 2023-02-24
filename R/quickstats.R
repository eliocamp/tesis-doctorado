#' Computa p-valores
#'
#' Computa p-valores uando la distribución t-student a partir de estimación,
#' error estándar  y grados de libertad. Opcionalmente los ajusta usando FDR u
#' otro ajuste.
#'
#' @param estimate estimador
#' @param std.error error estándar
#' @param df grados de libertad
#' @param adjustment método para ajustar el p-valor ([stats::p.adjust()])
#'
#' @export
Pvaluate <- function(estimate, std.error, df, adjustment = "none") {
  stats::p.adjust(2*stats::pt(abs(estimate)/std.error, df, lower.tail = FALSE), method = adjustment)
}


#' Report p-values
#'
#' Creates a "pretty" string from p-values. Reports p-values (adding an equal sign)
#' rounded to two  significant if they are greater than 0.001, in which case,
#' it reports " < 0.001".
#'
#' @param p numeric vector of p-values
#'
#'
#' @return
#' A character vector of the same length as `p` with `" < 0.001"` for values
#' lower than 0.001 and `" = signif(p, 2)"` otherwise.
#'
#' @export
report_p <- function(p) {
  ifelse(p < 0.001, "<\ 0.001", paste0("=\ ", signif(p, 2)))
}


#' Computar correlación
#'
#' Capa alrededor de  [cor.test] que devuelve la correlación estimada, el
#' p-valor, el mínimo y máximo del intervalo de confianza y un texto listo
#' para reportar.
#'
#' @param x,y variables numéricas a correlacionar
#' @param signif cifras significativas para el texto
#' @param sep separador para usar entre el estimador y el intervalo de confianza.
#' Por defecto usa un espacio protejido.
#'
#' @export
correlate <- function(x, y, signif = 2, sep = "\ ", ...) {
  correlation <- stats::cor.test(x, y, ...)
  out <- with(correlation,
              list(estimate = estimate,
                   p.value = p.value,
                   low = conf.int[1],
                   hig = conf.int[2]))

  out$text <- with(out,
                   paste0(round(estimate, signif), sep, "(CI:\ ",
                          round(low, signif), "\ --\ ", round(hig, signif), ")"))

  out
}


#' Computa p-valor y demás en correlación
#'
#' Similar a [correlate()] pero toma una correlación calculada y el número de observaciones.
#'
#' @param correlation vector con correlaciones
#' @param n vector con número de observaciones usadas para calcular la correlación
#' @param signif cifras significativas para el texto
#'
#'
#' @export
correlation_statistics <- function(correlation, n, signif = 2) {
  z <- atanh(correlation)
  se <- 1/sqrt(n - 3)

  low <- qnorm(.025, mean = z, sd = se)
  low <- tanh(low)
  hig <- qnorm(.975, mean = z, sd = se)
  hig <- tanh(hig)

  p.value <- pnorm(abs(correlation)/se, lower.tail = FALSE)

  text <- paste0(signif(correlation, signif), " (CI:\ ",
                 signif(low, signif), "\ --\ ", signif(hig, signif), ")")

  list(estimate = correlation,
       p.value = p.value,
       low = low,
       hig = hig,
       text = text
  )
}


#' Partial correlation between x1 and y and x2 and y.
#'
#' @param y variable to which partial correlation will be computed
#' @param x1,x2 variables that will be correlated with y
# #' @param weights vector of weights
#'
#' @export
partial_cor <- function(y, x1, x2) {
  estimate1 <- ppcor::pcor.test(y, x1, x2)
  estimate2 <- ppcor::pcor.test(y, x2, x1)

  list(term = c(deparse(substitute(x1)),
                deparse(substitute(x2))),
       partial_correlation = c(estimate1$estimate, estimate2$estimate),
       p.value = c(estimate1$p.value, estimate2$p.value)
  )
}



#' Computes weights for seasonal weighted means
#'
#' [weighted.mean()] is not GForce-optimised in data.table and
#' therefore, using it to compute weighted means is much slower
#' than computing the weights first and the computing `mean(x*w)`
#'
#'
#' @param time, a vector of times
#' @param groups vector of the same length as `time` that
#' defines the grouping.
#'
#' @returns
#' a vector of the same length as `time` that when used as
#' weights in `mean(x*w)` returns the same as
#' `weighted.mean(x, w)` computed for each group in `groups`.
#'
#'
#' @export
season_weights <- function(time, groups = metR::seasonally(time)) {
  w <- as.numeric(lubridate::days_in_month(time))

  data.table::setDT(list(w = w, groups = groups))[, w := w/mean(w), by = groups]$w
}


