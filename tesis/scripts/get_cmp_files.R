library(data.table)
library(magrittr)
library(eliotesis)

cmip_root <- "/shera/datos/CMIP/"
# Tuve que optimizar algunas cosas para poder parsear miles de archivos

cli::cli_alert_info("Buscando archivos disponibles...")
sims <- cmip_available(mip_era = "CMIP6",
                       activity_drs = "CMIP",
                       experiment_id = "historical",
                       # source_id = unique(simulaciones$model),
                       table_id = c("Amon", "Omon"),
                       variable_id = c("zg", "tos")) %>%
  as.data.table() %>%
  .[, version := as.numeric(version)] %>%
  .[, c("ensemble", "init", "physics", "forcing") := as.list(unglue::unglue_data(member_id, "r{ensemble}i{init}p{physics}f{forcing}", convert = TRUE))] %>%
  .[order(ensemble)]

# Algunos modelos tienen distintas parametrizaciones, inicializaciones y demás.
# Me quedo sólo con una combinación para no volverme loque.
sims <- sims[, .SD[physics == physics[1] & init == init[1] & forcing == forcing[1]],
             by =  .(source_id, variable_id)] %>%
  .[, .SD[uniqueN(ensemble) >= 5], by = source_id]

# EC-Earth3 da muchos problemas. Los miembros no tienen todos el mismo
# rango de fechas y eso ya me da errores más abajo... se va.
sims <- sims[!(source_id == "EC-Earth3")]

# ICON-ESM-LR no tiene una grilla lon lat. Tiene una coordenada
# i que identifica el punto de grilla.
sims <- sims[source_id != "ICON-ESM-LR"]

# Me quedo con la "mejor grilla". Esto afecta únicamente
# a tos (sst).
# El orden de preferencia de las grillas es
# medio aleatorio; gn es el más común.
grid_order <- c("gn", "gr", "gr1")

sims <- sims %>%
  copy() %>%
  .[, grid_label := factor(grid_label, levels = grid_order, ordered = TRUE)] %>%
  .[order(grid_label)] %>%
  .[, .SD[grid_label == grid_label[1]], by = .(source_id, ensemble, variable_id)]



damip_experiments <- c("hist-GHG", "hist-stratO3", "hist-nat", "hist-aer")
sims_damip <- cmip_available(mip_era = "CMIP6",
                             activity_drs = "DAMIP",
                             experiment_id = damip_experiments,
                             # source_id = unique(simulaciones$model),
                             table_id = c("Amon"),
                             variable_id = c("zg")) %>%
  as.data.table() %>%
  .[, version := as.numeric(version)] %>%
  .[, c("ensemble", "init", "physics", "forcing") := as.list(unglue::unglue_data(member_id, "r{ensemble}i{init}p{physics}f{forcing}", convert = TRUE))] %>%
  .[, ensemble := interaction(ensemble, init, physics, forcing)]


sims <- rbind(sims, sims_damip)
saveRDS(sims, data_path("derived", "sims.Rds"))
