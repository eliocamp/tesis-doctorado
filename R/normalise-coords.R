#' Cambiar nombres de columnas
#'
#' Cambia los nombres de las columnas de un dataframe según un conjunto de reglas
#'
#' @param data un dataframe.
#' @param rules una lista de reglas para renombrar. Cada elemento es un vector
#' de caracteres con el posible nombre de las columnas. El nombre que se le dará
#' es el nombre de elemento en la lista.
#'
#' @export
normalise_coords <- function(data,
                             rules =  list(lev = c("level"),
                                           lat = c("latitude"),
                                           lon = c("longitude", "long"),
                                           time = c("date"))) {

  for (f in seq_along(rules)) {
    old <- colnames(data)[colnames(data) %in% rules[[f]]]

    if (length(old) != 0) {
      data.table::setnames(data,
                           old,
                           names(rules)[[f]], skip_absent = TRUE)
    }
  }
  return(invisible(data))
}
