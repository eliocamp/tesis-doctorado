#' Remueve la mitad de los labels de forma simétrica
#'
#'
#'
#' @export
label_one_less <- function(x) {
  n <- length(x)
  if (n < 4) return(x)
  x <- round(x, 5)

  c(rev(JumpBy(rev(x[x < 0]), 2, fill = "")),
     JumpBy(x[x > 0], 2, fill = ""))
}
