#' Separa números complejos entre su parte real e imaginaria
#'
#' @param complex vector de valores compeljos
#' @param data un dataframe
#' @param column nombre puro de la columna que hay que dividir. Si es `NULL`,
#' la función busca si hay una única columna compleja.
#' @param format formato de salida. `"longer"` usa [tidyr::pivot_longer] para devolver una
#' columna única con el valor con una fila para cada parte. `"wider"` deja una columna
#' llamara `Real` y otra llamada `Imaginario`
#'
#' @export
ReIm <- function(complex) {
  list(Real = Re(complex), Imaginario = Im(complex))
}

#' @export
#' @rdname ReIm
sep_ReIm <- function(data, column = NULL, format = c("longer", "wider")) {
  R <- part <- I <- NULL
  names <- c("Real", "Imaginario")


  if (is.null(column)) {
    complex <- vapply(data, function(x) inherits(x, "complex"), TRUE)
    if (sum(complex) > 1) {
      stop("`column` es NULL and more than one complex column found")
    }
    if (sum(complex) == 0) {
      stop("`column` missing and no complex column found. Returning unchanged data")

    }

    col <- colnames(data)[complex]
  } else {
    col <- deparse(substitute(column))
  }

  data <- data.table::copy(data)[, (names) := ReIm(get(col))]


  if (format[1] == "longer") {
    data[, c(col) := NULL]
    data <- data.table::setDT(tidyr::pivot_longer(data, Real:Imaginario, names_to = "part", values_to = col))
    data[, part := factor(part, levels = names, ordered = TRUE)]
  }

  return(data[])
}

#' @param part vector de caracteres con elementos llamados "Real" e "Imaginario"
#' @export
#' @rdname ReIm
factor_ReIm <- function(part) {
  factor(part, levels = c("Real", "Imaginario"), ordered = TRUE)
}
