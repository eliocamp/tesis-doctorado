#' @export
compute_sam_cmip <- function(files, members, levs,  baseline_years = c(1979, 2014)) {
  cli::cli_alert_info("Procesando {files[1]}")

  # Ordeno de menor a mayor. Si un nivel falla por tener NAs,
  # todos los niveles más bajos (mayores) van a fallar, y entonces directamente
  # ni trato.
  bad <- FALSE
  levs <- sort(levs)
  data <- lapply(levs, function(lev) {

    if (bad) {
      cli::cli_alert_warning("Nivel previo con NA, salteando siguientes...")
      return(NULL)
    } else {
      cli::cli_alert_info("Procesando nivel {lev}")
    }
    data <- compute_sam_cmip_one(files, members, lev, baseline_years)

    if (!is.null(data)) {
      data$lev <- lev
    } else {
      bad <<- TRUE
    }

    data

  })

  data.table::rbindlist(data)
}



compute_sam_cmip_one <- function(files, members, lev, baseline_years = c(1979, 2014)) {
  eofs <- 1
  cli::cli_alert_info("Leyendo datos")
  bad <- FALSE
  array <- lapply(files, function(file) {
    if (bad) {
      return(NA)
    }
    data <- metR::ReadNetCDF(file, vars = c(hgt = "zg"),
                             subset = list(lat = c(-90, -20),
                                           time = c(NA, "2014-12-31"),
                                           plev = lev*100),
                             out = "array")[[1]]

    if (anyNA(data)) {
      bad <<- TRUE
      return(NA)
    }
    data

  })

  if (bad) {
    cli::cli_alert_warning("nivel con NA..salteando")
    return(NULL)
  }


  cli::cli_alert_info("Calculando patrones espaciales")
  time_lookup <- data.table::data.table(time = dimnames(array[[1]])$time,
                                        time_date = attr(array[[1]], "dimvalues")$time)



  array <- abind::abind(array, rev.along = 0,
                        use.dnns = TRUE)

  dimnames(array)[[5]] <- members
  names(dimnames(array))[[5]] <- "ensemble"

  whichdim <- function(array, dims) {
    which((names(dimnames(array)) %in% dims))
  }
  whichdimnot <- function(array, dims) {
    which(!(names(dimnames(array)) %in% dims))
  }

  # Tengo que calcular la media porcada mes!

  new_dims <- dim(array)

  cut <- which(names(dimnames(array)) == "time")

  months <- 12
  years <- new_dims[cut]/months

  new_dims <- c(new_dims[seq_len(cut-1)], c(month = months, year = years), new_dims[-seq_len(cut)])

  new_dimnames <- dimnames(array)

  new_dimnames <- c(new_dimnames[seq_len(cut-1)],
                    list(month = 1:12,
                         year = unique(year(time_lookup$time_date))),
                    new_dimnames[-seq_len(cut)])


  dim(array) <- new_dims

  dimnames(array) <- new_dimnames

  mean <- apply(array[, , , , as.numeric(dimnames(array)$year) %between% baseline_years, , drop = FALSE], c("lon", "lat", "month", "ensemble"), mean)
  array <- sweep(array, whichdim(array, c("lon", "lat", "month", "ensemble")), mean, FUN = "-")

  matrix <- array[, , , , as.numeric(dimnames(array)$year) %between% baseline_years, , drop = FALSE]

  baseline_dimnames <- dimnames(matrix)

  # Calcular EOF
  # Las dimensiones hardcodeadas es medio mal, pero creo que funciona.
  dim(matrix) <- c(prod(lengths(baseline_dimnames)[1:3]),
                   prod(lengths(baseline_dimnames)[4:6]))

  scale <- sqrt(cos(as.numeric(baseline_dimnames$lat)*pi/180))
  scale <- rep(scale, each =  length(baseline_dimnames$lon))

  sam_pattern <- t(irlba::irlba(t(matrix), max(eofs), max(eofs), scale = 1/scale)$v)



  dim(sam_pattern) <- c(baseline_dimnames[c("lon", "lat")] %>% lengths())
  dimnames(sam_pattern) <- baseline_dimnames[c("lon", "lat")]

  # Quiero que en altas latitudes el signo sea negativo.
  signo_sam <- sign(mean(sam_pattern[, 1]))
  sam_pattern <- sam_pattern*(-signo_sam)

  sam_spatial <- reshape2::melt(sam_pattern) %>%
    data.table::setDT()

  ssam_pattern <- colMeans(sam_pattern, dims = 1)

  asam_pattern <- sweep(sam_pattern, "lat", ssam_pattern)

  sam_pattern <- cbind(c(sam_pattern))
  asam_pattern <- cbind(c(asam_pattern))

  long_ssam <- cbind(rep(c(ssam_pattern), each = length(baseline_dimnames$lon)))

  cli::cli_alert_info("Proyectando..")
  ssam <- apply(array, c("month", "year", "ensemble"), function(a) {
    r <- lm.fit(long_ssam, c(a))

    mms <- sum(r$fitted.values^2)
    rss <- sum(r$residuals^2)

    r2 <- mms/(mms + rss)

    c(estimate = unname(r$coef),
      r.squared = r2
    )
  }) %>%
    reshape2::melt(as.is = TRUE) %>%
    data.table::setDT() %>%
    tidyfast::dt_pivot_wider(names_from = Var1, values_from = value)

  asam <- apply(array, c("month", "year", "ensemble"), function(a) {
    r <- lm.fit(asam_pattern, c(a))

    mms <- sum(r$fitted.values^2)
    rss <- sum(r$residuals^2)

    r2 <- mms/(mms + rss)

    c(estimate = unname(r$coef),
      r.squared = r2
    )
  }) %>%
    reshape2::melt(as.is = TRUE) %>%
    data.table::setDT() %>%
    tidyfast::dt_pivot_wider(names_from = Var1, values_from = value)

  sam <- apply(array, c("month", "year", "ensemble"), function(a) {
    r <- lm.fit(sam_pattern, c(a))

    mms <- sum(r$fitted.values^2)
    rss <- sum(r$residuals^2)

    r2 <- mms/(mms + rss)

    c(estimate = unname(r$coef),
      r.squared = r2
    )
  }) %>%
    reshape2::melt(as.is = TRUE) %>%
    data.table::setDT() %>%
    tidyfast::dt_pivot_wider(names_from = Var1, values_from = value)

  time_series <- rbind(sam = sam,
                       asam = asam,
                       ssam = ssam,
                       idcol = "type") %>%
    .[, time := as.Date(paste(year, month, "01", sep = "-"))] %>%
    .[, `:=`(year = NULL, month = NULL)] %>%
    .[]

  data.table(time_series = list(time_series),
             sam = list(sam_spatial))

}
