#' Computa el cEOF de modelos de CMIP6
#'
#' @param files vector de archivos NetCDF con las corridas del modelo
#' @param members nombres de los miembros de la simulación
#' @param time vector que define el rango de fechas a usar
#' @param ref cEOF de referencia
#'
#' @returns un objeto de clase EOF
#'
#' @export
compute_ceof_cmip <- function(files, members, time = c("1979-10-01", "2014-12-31"), ref = NULL) {
  message("procesando ", files[1])

  array <- lapply(files, function(file) {
    metR::ReadNetCDF(file, vars = c(hgt = "zg"),
                     subset = list(lat = c(-85, -20),
                                   time = time),
                     out = "array")[[1]]
  })

  time_lookup <- data.table::data.table(time = dimnames(array[[1]])$time,
                                        time_date = as.integer(year(attr(array[[1]], "dimvalues")$time)))

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

  # Calcular anomalias zonales
  array <- apply(array, whichdimnot(array, "lon"), metR::Anomaly) %>%
    aperm(names(dimnames(array)))


  # Estandarizar
  sd <- apply(array, "plev", sd)
  array <- sweep(array, whichdim(array, "plev"), sd, FUN = "/")

  # Transfomar de hilbert
  hilbert <- apply(array, whichdimnot(array, "lon"), spectral::analyticFunction) %>%
    aperm(names(dimnames(array)))

  hilbert <- aperm(hilbert, setNames(seq_along(dimnames(hilbert)),
                                     names(dimnames(hilbert)))[c("time", "ensemble", "lon", "lat", "plev")])

  # Calcular EOF y hacer tidy
  dim(hilbert) <- c(prod(lengths(dimnames(hilbert))[1:2]),
                    prod(lengths(dimnames(hilbert))[3:5]))

  eof <- irlba::irlba(hilbert, 2, 2)

  dim(eof$u) <-  c(dimnames(array)[c("time", "ensemble")] %>% lengths(),
                   eof = 2)
  dimnames(eof$u) <- with(dimnames(array),
                          list(time = time, ensemble = ensemble, cEOF = 1:2))
  eof$u <- reshape2::melt(eof$u, value.name = "hgt") %>% data.table::setDT()
  eof$u[, time := as.character(time)]

  eof$u <- time_lookup[eof$u, on = .NATURAL] %>%
    .[, time := NULL] %>%
    data.table::setnames("time_date", "time")
  eof$u[, cEOF := factor(paste0("cEOF", cEOF))]

  dim(eof$v) <- c(dimnames(array)[c("lon", "lat", "plev")] %>% lengths(),
                  eof = 2)
  dimnames(eof$v) <- with(dimnames(array),
                          list(lon = lon, lat = lat, lev = plev, cEOF = 1:2))

  eof$v <- reshape2::melt(eof$v, value.name = "hgt") %>%  data.table::setDT()
  eof$v[, cEOF := factor(paste0("cEOF", cEOF))]
  eof$v[, lat := as.numeric(lat)]
  eof$v[, lon := as.numeric(lon)]
  eof$v[, lev := as.integer(lev/100)]

  variance <- norm(abs(hilbert), type = "F")

  eof$d <- data.table::data.table(cEOF = factor(paste0("cEOF", 1:2), levels = paste0("cEOF", 1:2),
                                                ordered = TRUE),
                                  sd = eof$d,
                                  r2 = eof$d^2/variance^2)
  ceof <- structure(
    list(left = eof$u,
         right = eof$v,
         sdev = eof$d),
    call = match.call(),
    class = c("eof", "list"),
    suffix = "cEOF",
    value.var = "hgt")

  if (!is.null(ref)) {
    ceof <- optimise_rotation(ceof, ref)
  }

  message("  terminado.")
  return(ceof)
}


#' Rota un cEOF para maximizar la correlación con una referencia
#'
#' @param ceof cEOF a rotar
#' @param ref cEOF de referencia
#'
#' @returns un cEOF
#'
#' @export
optimise_rotation <- function(ceof, ref) {
  message("Optimizando la rotación...")
  angles <- seq(-pi, pi, by = 0.5*pi/180)

  joined <- ceof$right %>%
    pad_longitudes() %>%
    .[, Interpolate(hgt ~ lon + lat, x.out = unique(ref$lon), y.out = unique(ref$lat)),
      by = .(cEOF, lev)] %>%
    .[ref, on = .NATURAL] %>%
    na.omit()

  cors <- lapply(angles, function(a) {
    joined %>%
      .[, eof2 := rotate(hgt, a)] %>%
      .[, .(correlation = weighted_correlation(Re(eof2), Re(eof_ref), cos(lat*pi/180))),
        by = .(cEOF)] %>%
      .[, angle := a]
  }) %>%
    rbindlist()

  best_cor <- cors[, .SD[which.max(correlation)], by = cEOF]
  ceof <- rotate_ceof(ceof, hgt, best_cor[, .(cEOF, angle)])

  ceof$sdev <- ceof$sdev[best_cor[, .(cEOF, correlation, angle)], on = "cEOF"]
  ceof
}

#' Agrega longitudes en los extremos
#'
#' (Para poder interpolar despúes)
#'
#' @param data los datos
#'
#' @export
pad_longitudes <- function(data) {
  left <- right <- NULL
  rlon <- ggplot2::resolution(data$lon, zero = FALSE)
  mlon <- min(data$lon)
  Mlon <- max(data$lon)

  if (mlon > 0) {
    left <- data[lon == Mlon] %>%
      .[, lon := mlon - rlon]
  }

  if (Mlon < 357.5) {
    right <- data[lon == mlon] %>%
      .[, lon := Mlon + rlon]
  }

  rbind(left,
        data,
        right)
}
