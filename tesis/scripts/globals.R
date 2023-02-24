
theme_set(theme_tesis(base_size = 10) +
            theme(legend.box.spacing = grid::unit(-.5, "lines")))


lab_lev <- AddSuffix(" hPa")
lab_cplx <- c("Real" = "0º",
              "Imaginario" = "90º")

lab_sam <-  c(full = "SAM",
              asym = "A-SAM",
              sym  = "S-SAM")

axis_labs_smol <- function() theme(axis.text = element_text(size = 6))


r2 <- expression(`$r^2$` = paste("", "r", phantom()^{
  paste("2")
}, "", ""))

width_column <- 3.3


main_period <- c("1979-01-01", "2022-12-01")
