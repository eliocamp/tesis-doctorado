#' Calcula serie temporal de un campo
#'
#'
#'
#' @export
ceof_proyectado <- function(files, member, ..model, ..experiment, fields, time = c(lubridate::NA_Date_, "2014-12-31")) {
  message("procesando ", files[1])

  array <- lapply(files, function(file) {
    ReadNetCDF(file, vars = c(hgt = "zg"),
               subset = list(lat = c(-85, -20),
                             time = time),
               out = "array")[[1]]
  })

  time_lookup <- data.table::data.table(time = dimnames(array[[1]])$time,
                                        time_date = as.integer(year(attr(array[[1]], "dimvalues")$time)))

  array <- abind::abind(array, rev.along = 0,
                        use.dnns = TRUE)

  dimnames(array)[[5]] <- member
  names(dimnames(array))[[5]] <- "ensemble"


  whichdim <- function(array, dims) {
    which((names(dimnames(array)) %in% dims))
  }
  whichdimnot <- function(array, dims) {
    which(!(names(dimnames(array)) %in% dims))
  }

  # Calcular anomalias zonales
  array <- apply(array, whichdimnot(array, "lon"), Anomaly) %>%
    aperm(names(dimnames(array)))

  # Estandarizar
  sd <- apply(array, "plev", sd)
  array <- sweep(array, whichdim(array, "plev"), sd, FUN = "/")

  f <- fields[model == ..model & experiment == ..experiment]
  fa <- array(f$hgt, dim = c(lon = uniqueN(f$lon),
                             lat = uniqueN(f$lat),
                             lev = uniqueN(f$lev),
                             cEOF = uniqueN(f$cEOF),
                             part = uniqueN(f$part)),
              dimnames = list(lon = unique(f$lon),
                              lat = unique(f$lat),
                              lev = unique(f$lev)*100,
                              cEOF = unique(f$cEOF),
                              part = unique(f$part))
  )

  v <- apply(array, c("time", "ensemble") , function(a) {
    # ESTO NO DEBERÍA SER TAN COMPLICADO!!!
    v <- apply(fa, c("cEOF"), function(f) {
      r <- .lm.fit(cbind(c(f[, , , 1]), c(f[, , , 2])), c(a))
      exp <- 1 - var(r$residuals)/var(c(a))
      setNames(c(r$coefficients, exp), c(dimnames(f)[["part"]], "r2"))
    })

    names(dimnames(v))[1] <- "variable"

    v <- reshape2::melt(v)
    names <- paste(v$variable, v$cEOF, sep = ".")
    setNames(v$value, names)
  })

  names(dimnames(v))[1] <- "variable.cEOF"


  reshape2::melt(v, value.name = "eof") %>%
    setDT() %>%
    .[, c("variable", "cEOF") := tstrsplit(variable.cEOF,
                                           split = ".", fixed = TRUE)] %>%
    .[, variable.cEOF := NULL] %>%
    dcast(time + ensemble + cEOF ~ variable, value.var = "eof") %>%
    .[, hgt := complex(real = Real, imaginary = Imaginario)] %>%
    .[, `:=`(Imaginario = NULL, Real = NULL)] %>%
    .[, time := as.character(time)] %>%
    time_lookup[., on = "time"] %>%
    .[, time := NULL] %>%
    setnames("time_date", "time") %>%
    .[]

}
