
knitr::opts_hooks$set(label = function(options) {
  # Tira un error si el chunk no tiene label
  default_label <- knitr::opts_knit$get("unnamed.chunk.label")
  if (grepl(default_label, options$label)) {
    stop("Name your chunks!")
  }

  # Setea el default del caption a label-cap
  if (is.null(options[["fig.cap"]])) {
    options[["fig.cap"]] <- paste0("(ref:", options[["label"]], "-cap)")
  }


  options
})

"%||%" <- function (x, y) {
  if (is.null(x))
    y
  else x
}

format <- knitr::opts_knit$get("rmarkdown.pandoc.to") %||% "r"
chapter <- tools::file_path_sans_ext(knitr::current_input())

knitr::opts_chunk$set(
  fig.path = file.path("figures", chapter, ""),
  cache.path = file.path("cache", chapter, format, "")
)

is_word <- function() {
  format <- knitr::opts_knit$get("rmarkdown.pandoc.to") %||% "r"
  format == "docx"
}

get_caption <- function() {
  knitr::opts_current$get("fig.cap")
}

theme_set(theme_tesis(base_size = 10) +
            theme(legend.box.spacing = grid::unit(-.5, "lines")))


lab_lev <- AddSuffix(" hPa")
lab_cplx <- c("Real" = "0º",
              "Imaginario" = "90º")

lab_sam <-  c(full = "SAM",
              asym = "A-SAM",
              sym  = "S-SAM")

factor_sam <- function(term) {
  factor(term, levels = names(lab_sam), ordered = TRUE)
}



axis_labs_smol <- function() theme(axis.text = element_text(size = 6))


r2 <- expression(`$r^2$` = paste("", "r", phantom()^{
  paste("2")
}, "", ""))

width_column <- 3.3


main_period <- c("1979-01-01", "2019-12-01")

combine_words <- purrr::partial(knitr::combine_words, and = " y ")


texto_pval <- function(pval = 0.01, ajustado = TRUE) {
  ajuste <- if (ajustado) " ajustado por FDR"
  paste0("Áreas con puntos tienen p-valor menor que ", pval, ajuste, ".")

}


todo <- function(text) {
  if (knitr::is_html_output()) {
    text <- paste0("<span style='background-color:#FF8000;'>", text, "</p>")
  } else if (knitr::is_latex_output()) {
    text <- paste0(" \\todo[inline]{", text, "}")
  } else {
    text <- paste0("**TODO: ", text, "**")
  }

  return(text)
}


pval_contours <- function(pval = 0.01, adjust = TRUE) {
  if (adjust) {
    adjust <- " ajustado por FDR"
  } else {
    adjust <- NULL
  }

  paste0("Áreas con puntos marcan regiones donde el p-valor de la diferencia entre el signo positivo y el negativo es menor que ", pval, adjust)
}
