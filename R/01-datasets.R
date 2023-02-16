southern_hemisphere <- c(20, 0, -90, 360)

# Generic functions to handle downloading from some common sources

simple_download <- function(url) {
  force(url)
  function(file){
    utils::download.file(url, destfile = file)
    file
  }
}

download_cds <- function(request) {
  force(request)
  function(file) {
    user <- Sys.getenv("CDSUSER", NA)
    key <- Sys.getenv("CDSKEY", NA)
    filename <- basename(file)

    if (is.na(user) | is.na(key)) {
      stop("Please set the environmental variables CDSUSER and CDSKEY")
    }

    request$target <- filename

    ecmwfr::wf_set_key(user = user,
                       key = key,
                       service = "cds")

    files <- ecmwfr::wf_request(request = request,
                                user = user,
                                time_out = 5*3600,
                                path = dirname(file))
    file
  }
}

download_webapi <- function(request) {
  force(request)
  function(file) {
    user <- Sys.getenv("WEBAPIUSER", NA)
    key <- Sys.getenv("WEBAPIKEY", NA)
    filename <- basename(file)

    if (is.na(user) | is.na(key)) {
      stop("Please set the environmental variables CDSUSER and CDSKEY")
    }

    request$target <- filename

    ecmwfr::wf_set_key(user = user,
                       key = key,
                       service = "webapi")

    files <- ecmwfr::wf_request(request = request,
                                user = user,
                                time_out = 5*3600,
                                path = dirname(file))
    file
  }
}



#' Data locations
#'
#' Functions that return the location of different datasets. They check that
#' relevant file exist and then return it with a class that has a neat print method.
#'
#'
#' @param type character indicating the type of data. The resulting base will be type_data
#' @param ... characters to be concatenated with [file.path()]
#'
#' @export
data_path <- function(type = c("raw", "derived"), ...) {
  here::here("tesis", "data", paste0(type[1], "_data"), ...)
}




zenodo_record <- "https://zenodo.org/record/6612429/"
zenodo_from_file <- function(file) {
  paste0(zenodo_record, "/files/", basename(file), "?download=1")
}


#' Crea una nueva base de datos
#'
#' Devuelve una función que hace todo lo necesario para descargar los datos y
#' devuelve el archivo para leer.
#'
#' @param name el nombre de la base de datos (usada para mensajes)
#' @param file el archivo donde se va a guardar
#' @param source una función que toma un nombre de archivo y descarga los datos
#' @param md5 checksum para verificar que los datos están bien
#'
#' @returns
#' Una función que devuelve el nombre de archivo.
#' Chequea que los datos existan y si no existen los descarga de Zenodo, a menos que
#' `zenodo_url` sea `NULL` o se llame a la función con el argumento `from_source` `TRUE`.
#' En cuyo caso, descarga los datos de la fuente original con la función `source`.
#' La función advierte si el checksum no es igual al registrado.
#'
new_dataset <- function(name,
                        file,
                        source,
                        md5) {
  if (is.character(source)) {
    source <- simple_download(source)
  }

  data <- list(
    name = name,
    file = file,
    source = source,
    zenodo_url = zenodo_from_file(file),
    md5 = md5
  )

  function(from_source = FALSE) {
    will_download <- from_source == TRUE || !file.exists(data$file)

    if (will_download) {
      dir.create(dirname(data$file), showWarnings = FALSE, recursive = TRUE)
      if (from_source || is.null(data$zenodo_url)) {
        message("Downloading dataset ", data$name, " from remote source.")
        data$source(data$file)
      } else {
        message("Downloading dataset ", data$name, " from zenodo repository.")
        utils::download.file(data$zenodo_url, data$file)
      }
    }

    if (!is.null(data$md5)) {
      md5 <- digest::digest(data$file, "md5", file = TRUE)
      if (data$md5 != md5) {
        warning("File for dataset ", data$name, " has incorrect checksum compared to the Zenodo reference.")
      }
    }

    data$file
  }

}


#' Datasets
#'
#' Chequea que los datos existan y si no existen los descarga de Zenodo, a menos que
#' `zenodo_url` sea `NULL` o se llame a la función con el argumento `from_source` `TRUE`.
#' En cuyo caso, descarga los datos de la fuente original con la función `source`.
#' La función advierte si el checksum no es igual al registrado.
#' @param from_source Lógico indicando si hay que descargar los datos desde la fuente
#' primaria en vez del repositorio de Zenodo
#'
#'
#' @export
#' @rdname datasets
#' @name datasets
ERA5_TOC <- new_dataset(
  name = "era5-total_column_ozone",
  file = data_path("raw", "era5.toc.mon.mean.nc"),
  source = download_cds(
    list(
      format = "netcdf",
      variable = "total_column_ozone",
      product_type = "monthly_averaged_reanalysis",
      year = as.character(1979:2020),
      month = formatC(9:11, width = 2, flag = 0),
      time = "00:00",
      area = southern_hemisphere,
      grid = c("2.5", "2.5"),
      dataset_short_name = "reanalysis-era5-single-levels-monthly-means",
      target = "ozone.era5.nc"
    )
  ),
  md5 = "71c56bc40022026da943c35fb4983941"
)




#' @export
#' @rdname datasets
ERA5_geopotential <- new_dataset(
  name = "era5-geopotential",
  file = data_path("raw", "era5.z.mon.mean.nc"),
  source = download_cds(
    list(
      format = "netcdf",
      product_type = "monthly_averaged_reanalysis",
      variable = c("geopotential"),
      pressure_level = c("50", "200", "500", "850"),
      year = as.character(1979:2020),
      month = formatC(1:12, width = 2, flag = 0),   # Need all months to compute PSA
      time = "00:00",
      grid = c("2.5", "2.5"),
      area = southern_hemisphere,
      dataset_short_name = "reanalysis-era5-pressure-levels-monthly-means"
    )
  ),
  md5 = "78cb847b37f05536da0a8fa7422a7c6f"
)




#' @export
#' @rdname datasets
ERA5_geopotential_all <- new_dataset(
  name = "era5-geopotential-all",
  file = data_path("raw", "era5-all.z.mon.mean.nc"),
  source = download_cds(
    list(
      format = "netcdf",
      product_type = "monthly_averaged_reanalysis",
      variable = c("geopotential"),
      pressure_level = c('1', '2', '3',
                         '5', '7', '10',
                         '20', '30', '50',
                         '70', '100', '125',
                         '150', '175', '200',
                         '225', '250', '300',
                         '350', '400', '450',
                         '500', '550', '600',
                         '650', '700', '750',
                         '775', '800', '825',
                         '850', '875', '900',
                         '925', '950', '975',
                         '1000'),
      year = as.character(1979:2020),
      month = formatC(1:12, width = 2, flag = 0),   # Need all months to compute PSA
      time = "00:00",
      grid = c("2.5", "2.5"),
      area = southern_hemisphere,
      dataset_short_name = "reanalysis-era5-pressure-levels-monthly-means"
    )
  ),
  md5 = "d58ae65b9e68e92274a051251d267b45"
)





#' @export
#' @rdname datasets
ERA5_temperature <- new_dataset(
  name = "era5-air_temperature",
  file = data_path("raw", "era5.air.mon.mean.nc"),
  source = download_cds(
    list(
      format = "netcdf",
      product_type = "monthly_averaged_reanalysis",
      variable = c("temperature"),
      pressure_level = c("1", "2", "3", "5", "7", "10", "20", "30", "50",
                         "70", "100", "125", "150", "175", "200", "225",
                         "250", "300", "350", "400", "450", "500", "550",
                         "600", "650", "700", "750", "775", "800", "825",
                         "850", "875", "900", "925", "950", "975", "1000"),
      year = as.character(1979:2020),
      month = formatC(9:11, width = 2, flag = 0),
      time = "00:00",
      grid = c("2.5", "2.5"),
      area = southern_hemisphere,
      dataset_short_name = "reanalysis-era5-pressure-levels-monthly-means"
    )
  ),
  md5 = "ebabdb3760c5999f4e7360f1d9c93b9e"
)



#' @export
#' @rdname datasets
ERA5_vorticity <- new_dataset(
  name = "era5-vorticity",
  file = data_path("raw", "era5.vor.mon.mean.nc"),
  source = download_cds(
    list(
      format = "netcdf",
      product_type = "monthly_averaged_reanalysis",
      variable = c("vorticity"),
      pressure_level = c("200"),
      year = as.character(1979:2020),
      month = formatC(9:11, width = 2, flag = 0),
      time = "00:00",
      grid = c("2.5", "2.5"),
      dataset_short_name = "reanalysis-era5-pressure-levels-monthly-means"
    )
  ),
  md5 = "ba65b25c763ed6541db9d8e89bf68a05"
)



#' @export
#' @rdname datasets
ERA5_ozone <- new_dataset(
  name = "era5-ozone",
  file = data_path("raw", "era5.o3.mon.mean.nc"),
  source = download_cds(
    list(
      format = "netcdf",
      product_type = "monthly_averaged_reanalysis",
      variable = c("ozone_mass_mixing_ratio"),
      pressure_level = c("1", "2", "3", "5", "7", "10", "20", "30", "50",
                         "70", "100", "125", "150", "175", "200", "225",
                         "250", "300", "350", "400", "450", "500", "550",
                         "600", "650", "700", "750", "775", "800", "825",
                         "850", "875", "900", "925", "950", "975", "1000"),
      year = as.character(1979:2020),
      month = formatC(9:11, width = 2, flag = 0),
      time = "00:00",
      grid = c("2.5", "2.5"),
      area = southern_hemisphere,
      dataset_short_name = "reanalysis-era5-pressure-levels-monthly-means"
    )
  ),
  md5 = "0055f304426c700d91be68be38df0b83"
)

#' @export
#' @rdname datasets
ERA5_BE <- new_dataset(
  name = "era5-back_extended-geopotential",
  file = data_path("raw", "era5be.mon.mean.nc"),
  source = download_cds(
    list(
      format = "netcdf",
      product_type = "reanalysis-monthly-means-of-daily-means",
      variable = c("geopotential"),
      pressure_level = c("50", "200"),
      year = as.character(1950:1978),
      month = c("09", "10", "11"),
      time = "00:00",
      grid = c("2.5", "2.5"),
      area = southern_hemisphere,
      dataset_short_name = "reanalysis-era5-pressure-levels-monthly-means-preliminary-back-extension"
    )
  ),
  md5 = "7bebebf781bcdb045fc2a7735ef90629"
)

#' @export
#' @rdname datasets
ERA5_T2M <- new_dataset(
  name = "era5-2_metre_temperature",
  file = data_path("raw", "era5.2mt.mon.mean.nc"),
  source = download_cds(
    list(
      format = "netcdf",
      variable = c("2m_temperature"),
      product_type = "monthly_averaged_reanalysis",
      year = as.character(1979:2020),
      month =  c("09", "10", "11"),
      time = "00:00",
      grid = c("2.5", "2.5"),
      area = southern_hemisphere,
      dataset_short_name = "reanalysis-era5-single-levels-monthly-means"
    )
  ),
  md5 = "bc6cb57caee814847374e47ca2f22fe2"
)


#' @export
#' @rdname datasets
NCEP_PSI <- new_dataset(
  name = "ncep-streamfunction",
  file = data_path("raw", "psi.mon.mean.nc"),
  md5 = NULL,
  source = "ftp://ftp2.psl.noaa.gov/Datasets/ncep.reanalysis.derived/sigma/psi.mon.mean.nc"
)

# #' @export
# #' @rdname datasets
# NCEP_VOR <- data_nc_fun(file =  data_path("raw", "vor.mon.mean.nc"),
#                         download = "ftp://ftp2.psl.noaa.gov/Datasets/ncep.reanalysis.derived/sigma/vor.mon.mean.nc")

#' @export
#' @rdname datasets
CMAP <- new_dataset(
  name = "cmap-precipitation",
  file = data_path("raw", "cmap.mon.mean.nc"),
  source = "ftp://ftp.cdc.noaa.gov/Datasets/cmap/std/precip.mon.mean.nc",
  md5 = "c003b8bb4d277418a5e7fa235828949b"
)



#' @export
#' @rdname datasets
ERSST <- new_dataset(
  name = "ERSST",
  file = data_path("raw", "ersst.csv"),
  source = function(file) {
    base_url <- "https://www.ncei.noaa.gov/pub/data/cmb/ersst/v5/netcdf/ersst.v5."

    years <- 1979:2020
    months <- formatC(9:11, width = 2, flag = "0")
    dates <- data.table::CJ(years, months)[, paste0(years, months)]

    urls <- paste0(base_url, dates, ".nc")

    files <- vapply(urls, function(url) {
      file <- tempfile(fileext = ".nc")
      utils::download.file(url, file)
      file
    }, character(1))

    data <- lapply(files, function(file) metR::ReadNetCDF(file, vars = c(t = "sst")))
    data <- data.table::rbindlist(data)

    data.table::fwrite(data, file)
    file
  },

  md5 = "fae3de4b4a0128b2a4b738d5cebd7094"
)

#' @export
#' @rdname datasets
ENSO <- new_dataset(
  name  = "ENSO-oceanic_enso_index",
  file = data_path("raw", "oni.csv"),
  source = function(file) {
    data <- rsoi::download_oni(use_cache = FALSE)
    data.table::fwrite(
      data.frame(
        time = lubridate::as_datetime(data$Date),
        oni = data$ONI
      ),
      file = file
    )
    file
  },

  md5 = "98d31a4984f1bac522717e4d303c890c"
)

#' @export
#' @rdname datasets
DMI <- new_dataset(
  name  = "DMI",
  file = data_path("raw", "dmi.csv"),
  source = function(file) {
    data <- rsoi::download_dmi(use_cache = FALSE)

    data.table::fwrite(
      data.frame(
        time = lubridate::as_datetime(data$Date),
        dmi = data$DMI
      ),
      file = file
    )

    file
  },

  md5 = "9e09ae2d9b6a260c78d76c80d3b4b9bf"
)

#' @export
#' @rdname datasets
SAM <- new_dataset(
  name = "sam",
  file = data_path("derived", "sam.csv"),
  source = function(file) {
    check_asymsam <- requireNamespace("asymsam", quietly = TRUE)
    if (!check_asymsam) {
      stop("Computing the Asymmetric and Symmetric SAM requires package asymsam.\n",
           "Install it with remotes::install_github(\"eliocamp/asymsam\").")
    }

    sams <- ERA5_geopotential_all() %>%
      metR::ReadNetCDF(vars = c("hgt" = "z"),
                       subset = list(latitude = c(-90, -20))) %>%
      normalise_coords() %>%
      .[, hgt := hgt - mean(hgt), by = .(lon, lat, lev, month(time))] %>%
      .[, asymsam::eof_asym(hgt, lon, lat, time), by = lev] %>%
      rm_singleton()

    data.table::fwrite(sams, file)
    file
  },

  md5 = "c46a278527ba97686172ca2f1a7e4469"
)
