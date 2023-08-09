library(eliotesis)
library(data.table)
library(magrittr)

main <- function() {
  mensaje <- "SAM falló!"
  on.exit(httr::POST("ntfy.sh/elio-critical", body = mensaje))

  cli::cli_alert_info("Listando archivos...")

  files <- data_path("derived", "cmip", "SH") %>%
    list.files(full.names = TRUE)

  get_levels <- function(file) {
    metR::GlanceNetCDF(file)$dims$plev$vals/100
  }

  modelos_malos <- "BCC-CSM2-MR"
  simulaciones_sam <- files %>%
    basename() %>%
    unglue::unglue_data("{variable}_{mean}_{model}_{experiment}_r{member}i{init}p{physics}f{forcing}_{grid}_{start_date}-{end_date}.nc",
                        convert = TRUE) %>%
    data.table::as.data.table() %>%
    .[, file := files] %>%
    .[order(variable, model, member)] %>%
    .[, member := interaction(member, init, physics, forcing)] %>%
    .[!(model %in% modelos_malos)] %>%
    .[, `:=`(levels = list(get_levels(file[1]))), by = .(model, experiment)]

  cmip_sam <- simulaciones_sam %>%
    .[variable == "zg"] %>%
    .[, compute_sam_cmip(file, member, levs = levels[[1]]), by = .(model, experiment)]


  saveRDS(cmip_sam, data_path("derived", "cmip_sam.Rds"))
  mensaje <- "SAM terminó bien!"
  cmip_sam
}

main()


