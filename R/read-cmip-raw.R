#' Leer un archivo de CMIP como un array
#'
#'
#'
#' @export
read_cmip_raw <- function(files, member, vars = NULL, subset = NULL, stop_if_na = FALSE) {

  # files is a list of lenth length(member). Each element has
  # a vector with the files corresponding to that member.

  array <- lapply(files, function(member_files) {
    read_cmip_raw_member(member_files,
                         vars = vars,
                         subset = subset,
                         stop_if_na = stop_if_na)

    if (stop_if_na && is.na(array)) {
      return(NA)
    }
  })



  time_lookup <- attr(array[[1]], "time_lookup")

  array <- abind::abind(array, rev.along = 0,
                        use.dnns = TRUE)

  dimnames(array)[[5]] <- member
  names(dimnames(array))[[5]] <- "ensemble"


  attr(array, "time_lookup") <- time_lookup

  return(array)

}


read_cmip_raw_member <- function(files, vars = NULL, subset = NULL, stop_if_na = FALSE) {

  if (!is.null(subset$time)) {
    years_select <- rep(TRUE, length(files))
    # Tengo que filtrar los años que no necesito
    # Asumo que todos los cortes empiezan en enero y temrinan en diciembre.
    # O sea, el formato es YYYY01-YYYY12
    years <- basename(files) %>%
      substr(nchar(.) - 15, nchar(.)) %>%
      gsub(pattern = ".nc", replacement = "", .) %>%
      unglue::unglue_data("{start_year}01-{end_year}12")

    if (!is.na(subset$time[1])) {
      years_select <- years_select & years$start_year >= year(as.Date(subset$time[1]))
    }
    if (!is.na(subset$time[2])) {
      years_select <- years_select & years$end_year <= year(as.Date(subset$time[2]))
    }

    files <- files[years_select]
  }

  if (!is.null(subset$plev)) {
    select <- paste0("-apply,-sellevel,", paste(unlist(subset$plev), collapse = ","))
    open_braket <- "["
    close_braket <- "]"
  } else {
    close_braket <- open_braket <- select <- NULL
  }
  file_out <- tempfile()
  s <- system(paste0("cdo mergetime ", select, " ",
                     open_braket, paste0(shQuote(files), collapse = " "), " ", close_braket, " ",
                     shQuote(file_out)))


  array <- metR::ReadNetCDF(file_out, vars = vars,
                            subset = subset,
                            out = "array")[[1]]

  time_lookup <- data.table::data.table(time = dimnames(array)$time,
                                        time_date = attr(array, "dimvalues")$time)

  attr(array, "time_lookup") <- time_lookup

  return(array)
}
