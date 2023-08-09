
#' Selecciona el HS
#'
#'
#' @export
cmip_select_SH <- function(file_in, folder) {

  unique_items <- file_in %>%
    basename() %>%
    unglue::unglue_data("{variable}_{mean}_{model}_{experiment}_r{member}i{init}p{physics}f{forcing}_{grid}_{start_date}-{end_date}.nc") %>%
    data.table::as.data.table() %>%
    .[, ":="(start_date = NULL, end_date = NULL)] %>%
    unique()

  stopifnot(nrow(unique_items) == 1)


  file_out <- file.path(folder, basename(file_in[1]))

  dir.create(folder, recursive = TRUE, showWarnings = FALSE)


  if (file.exists(file_out)) {
    cli::cli_alert_success("Omitiendo archivo {basename(file_out)} (archivo exitente).")
    return(file_out)
  }
  # Hay algunos archivos mal bajados.
  nulos <- file.size(file_in) == 0
  if (any(nulos)) {
    cli::cli_alert_warning(paste0("Archivo(s) nulos: \n", paste0(file_in[nulos], collapse = "\n")))

    return(NA_character_)
  }

  cli::cli_alert_info(paste0("Procesando ", basename(file_in[1])))
  cli::cli_alert_info("Procesando archivos")

  # Algunos modelos (IPSL) vienen con una grilla "genérica" en vez de lonlat
  to_regrid <- FALSE

  # Selecciondo para cada archivito
  # TODO: hacer un hard stop si falla algún archivo.
  # https://twitter.com/UbuntR314/status/1523761710548406272
  # temp_files <- furrr::future_map_chr(file_in, function(file) {
  #   file_out <- tempfile(fileext = ".nc")
  #
  #   error <- TRUE
  #
  #   on.exit(unlink(c(file_out)))
  #
  #   command <- paste0("ncks -d lat,-90.,0. ", shQuote(file), " ", shQuote(file_out))
  #
  #   # select <- "-sellonlatbox,0,360,-90,0"
  #   #
  #   # command <- paste0("cdo ", select, " ",
  #   #                   shQuote(file), " ",
  #   #                   shQuote(file_out))
  #   # cli::cli_progress_message("{basename(file)}")
  #
  #   s <- capture.output(system(command,
  #                              intern = TRUE,
  #                              ignore.stdout = TRUE,
  #                              ignore.stderr = TRUE))
  #
  #   if (!file.exists(file_out)) {
  #     file_out <- NA_character_
  #   }
  #   error <- FALSE
  #   return(file_out)
  # })

  cli::cli_alert_info("... uniendo tiempos")


  command <- paste("cdo -mergetime -apply,-remapbil,r144x72 [",
        paste0(shQuote(file_in), collapse = " "), "]",
        shQuote(file_out))


  # on.exit(unlink(c(temp_files)))
  # y luego uno
  s <- system(command)


  if (s == 1) {
    cli::cli_alert_danger("CDO falló al generar archivo {basename(file_out)}.")
    return(NA_character_)
  }

  cli::cli_alert_success("Archivo {basename(file_out)} generado.")
  return(file_out)
}

#' Promedia y selecciona la estación
#'
#' @export
cmip_select_season <- function(file_in, season, folder) {

  unique_items <- file_in %>%
    basename() %>%
    unglue::unglue_data("{variable}_{mean}_{model}_{experiment}_r{member}i{init}p{physics}f{forcing}_{grid}_{start_date}-{end_date}.nc") %>%
    data.table::as.data.table() %>%
    .[, ":="(start_date = NULL, end_date = NULL)] %>%
    unique()

  stopifnot(nrow(unique_items) == 1)


  file_out <- file.path(folder, basename(file_in[1]))
  dir.create(folder, recursive = TRUE, showWarnings = FALSE)

  if (file.exists(file_out)) {
    return(file_out)
  }
  # Hay algunos archivos mal bajados.
  nulos <- file.size(file_in) == 0
  if (any(nulos)) {
    warning("Archivo(s) nulos: \n", paste0(file_in[nulos], collapse = "\n"))
    return(NA_character_)
  }
  message("Procesando archivos ", basename(file_in[1]))
  var <- substr(basename(file_in[1]), 1, 1)

  # Algunos modelos (IPSL) vienen con una grilla "genérica" en vez de lonlat
  to_regrid <- FALSE
  if (var == "t") {
    grid <- tempfile()
    invisible(capture.output(t <- system(paste0("cdo griddes ", file_in[1], " > ", grid), intern = TRUE)))
    if (length(grep("generic", readLines(grid))) != 0) {
      to_regrid <- TRUE
      invisible(capture.output(t <- system(paste0('sed -i "s/generic/lonlat/g" ', grid), intern = TRUE)))
    }
  }


  # Selecciondo para cada archivito
  # TODO: hacer un hard stop si falla algún archivo.
  # https://twitter.com/UbuntR314/status/1523761710548406272
  temp_files <- furrr::future_map_chr(file_in, function(file) {
    file_out <- tempfile(fileext = ".nc")

    if (to_regrid) {
      outfile <- tempfile(fileext = ".nc")
      invisible(capture.output(t <- system(paste0("cdo setgrid,", grid, " ", file, " ", outfile))))
      file <- outfile
    }
    if (var == "z") {
      select <- "-sellevel,20000,5000"
      remap <- NULL
    } else {
      select <- NULL
      # Paso sst a una grilla regular porque sino distintos modelos tienen distintas
      # grillas y es un quilombo procesarlos programáticamente.
      remap <- "-remapdis,r240x60"
    }
    command <- paste0("cdo ", select, " -timselmean,3 -select,season=", toupper(season), " ",
                      remap, " ",
                      shQuote(file), " ",
                      shQuote(file_out))
    message("... corriendo: \n      ", command)

    s <- capture.output(system(command,
                               intern = TRUE, ignore.stdout = TRUE))
    if (!file.exists(file_out)) {
      file_out <- NA_character_
    }

    return(file_out)
  })

  message(" ... uniendo tiempos")
  # y luego uno
  s <- system(paste0("cdo mergetime ", paste0(shQuote(temp_files), collapse = " "), " ",
                     shQuote(file_out)))

  if (s == 1) {
    return(NA_character_)
  }
  unlink(temp_files)
  return(file_out)
}

#' Lista modelos disponibles
#'
#' Versión optimizada de la función de rcmip6
#'
#' @export
cmip_available <- function(..., root = cmip_root) {

  template <- rcmip6:::cmip6_folder_template %>%
    gsub("\\%\\(", "{", .) %>%
    gsub("\\)s", "}", .)

  vars <- template %>%
    gsub("\\{", "", .) %>%
    gsub("\\}", "", .) %>%
    strsplit("/") %>%
    .[[1]]

  search_null <- rep("*", length(vars)) %>%
    setNames(vars) %>%
    as.list()

  globulate <- function(x) {
    if (length(x) > 1) {
      paste0("@(", paste0(unique(x), collapse = "|"), ")")
    } else {
      x
    }
  }

  search <- list(...)
  for (name in names(search)) {
    search_null[[name]] <- search[[name]]
  }
  search <- search_null

  search <- lapply(search, globulate)
  search$root <- root

  # Hay que asegurarse de correr en bash
  command <- paste0("shopt -s extglob\n ls -f ",
                    paste0(glue::glue_data(search, template), "/model.info"))
  script_file <- tempfile()
  writeLines(command, script_file)

  info <- system(paste0("/bin/bash  ", script_file), intern = TRUE)

  info <- normalizePath(info)

  data <- unglue::unglue_data(gsub(root, "", dirname(info)),
                              gsub("\\{root\\}/", "", template))


  files <- lapply(info, function(info) {
    Sys.glob(paste0(dirname(info), "/*nc"))
  })
  data$files <- files

  return(data)
}
