#' Computa EOF asimétrico
#'
#' @export
eof_asym <- function(value, lon, lat, time, period = data.table::year(time) >= 1979 & data.table::year(time) <= 2000, n = 1) {
  sym <- asym <- full <- PC <- estimate_norm <- term <- estimate <- r.squared <-  partial.r.squared <- adj.r.squared <- NULL
  data <- data.table::data.table(value, lon, lat, time)

  lab_sam <-  c(full = "Full",
                asym = "Asymmetric",
                sym  = "Symmetric")

  eof <- data %>%
    .[period == TRUE] %>%
    .[, full := value*sqrt(cos(lat*pi/180))] %>%
    metR::EOF(full ~ time | lon + lat, n = n, data = .)
  eof$right[, c("sym", "asym") := list(mean(full), metR::Anomaly(full)), by = .(lat, PC)]

  indexes <- eof$right %>%
    data[., on = .NATURAL, allow.cartesian = TRUE]

  indexes[, rbind(data.table::as.data.table(metR::FitLm(value, full, weights = cos(lat*pi/180), r2 = TRUE)),
                  data.table::as.data.table(metR::FitLm(value,  sym, weights = cos(lat*pi/180), r2 = TRUE)),
                  data.table::as.data.table(metR::FitLm(value, asym, weights = cos(lat*pi/180), r2 = TRUE))),
          keyby = .(time, PC)] %>%
    .[term != "(Intercept)"] %>%
    .[, estimate_norm := estimate/stats::sd(estimate[term == "full"]), by = PC] %>%
    .[, term := factor(term, levels = names(lab_sam), ordered = TRUE)] %>%
    .[]
}
