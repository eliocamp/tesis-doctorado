ggplot2::theme_set(eliotesis::theme_tesis(base_size = 14) +
                     ggplot2::theme(legend.box.spacing = grid::unit(-.5, "lines")))


path <- "presentacion"
which_time <- unique(hgt$time)[6]



hgt %>%
  .[time == which_time] %>%
  ggperiodic::periodic(lon = c(0, 360)) %>%
  ggplot(aes(lon, lat)) +
  geom_contour_fill(aes(z = hgt, fill = after_stat(level)),
                    breaks = AnchorBreaks(0, exclude = 0)) +
  geom_contour_tanaka(aes(z = hgt), range = c(0.01, 0.2),
                      breaks = AnchorBreaks(0, exclude = 0)) +
  geom_qmap() +
  scale_y_latitude(limits = c(-90, 0)) +
  scale_x_longitude() +
  scale_linetype(guide = "none") +
  as.discretised_scale(scale_fill_viridis_c)(NULL, guide = "none") +
  # scale_fill_divergent_discretised(NULL, guide = guide_colorsteps_bottom(10)) +
  annotate_grid() +
  coord_polar2()


ggsave(filename = "hgt.png",
       width = 7.76,
       height = 8.14,
       units = "cm",
       path = "presentacion")




hgt %>%
  .[time == which_time] %>%
  .[, hgt := mean(hgt), by = lat] %>%
  .[, hgt := hgt + rnorm(.N)*0.01] %>%
  ggperiodic::periodic(lon = c(0, 360)) %>%
  ggplot(aes(lon, lat)) +
  geom_contour_fill(aes(z = hgt, fill = after_stat(level)),
                    breaks = AnchorBreaks(0, exclude = 0)) +
  geom_contour_tanaka(aes(z = hgt), range = c(0.01, 0.2),
                      breaks = AnchorBreaks(0, exclude = 0)) +
  geom_qmap() +
  scale_y_latitude(limits = c(-90, 0)) +
  scale_x_longitude() +
  scale_linetype(guide = "none") +
  as.discretised_scale(scale_fill_viridis_c)(NULL, guide = "none") +
  # scale_fill_divergent_discretised(NULL, guide = guide_colorsteps_bottom(10)) +
  annotate_grid() +
  coord_polar2()


ggsave(filename = "hgt_sym.png",
       width = 7.76,
       height = 8.14,
       units = "cm",
       path = "presentacion")



hgt %>%
  .[time == which_time] %>%
  .[, hgt := hgt - mean(hgt), by = lat] %>%
  # .[, hgt := hgt + rnorm(.N)*0.01] %>%
  ggperiodic::periodic(lon = c(0, 360)) %>%
  ggplot(aes(lon, lat)) +
  geom_contour_fill(aes(z = hgt, fill = after_stat(level)),
                    breaks = AnchorBreaks(0, exclude = 0)) +
  geom_contour_tanaka(aes(z = hgt), range = c(0.01, 0.2),
                      breaks = AnchorBreaks(0, exclude = 0)) +
  geom_qmap() +
  scale_y_latitude(limits = c(-90, 0)) +
  scale_x_longitude() +
  scale_linetype(guide = "none") +
  # as.discretised_scale(scale_fill_viridis_c)(NULL, guide = "none") +
  scale_fill_divergent_discretised(NULL, guide = "none") +
  annotate_grid() +
  coord_polar2()


ggsave(filename = "hgt_asym.png",
       width = 7.76,
       height = 8.14,
       units = "cm",
       path = "presentacion")


hgt %>%
  .[time == which_time] %>%
  .[, as.character(c(1:3)) := lapply(1:3, \(x) FilterWave(hgt, x)), by = .(lat, time)] %>%
  .[, hgt := NULL] %>%
  setnames("hgt_z", "0") %>%
  .[] %>%
  tidyfast::dt_pivot_longer(cols = `0`:`3`, names_to = "onda") %>%
  ggperiodic::periodic(lon = c(0, 360)) %>%
  ggplot(aes(lon, lat)) +
  geom_contour_fill(aes(z = value, fill = after_stat(level)),
                    breaks = AnchorBreaks(0, exclude = 0)) +
  geom_contour_tanaka(aes(z = value),range = c(0.01, 0.2),
                      breaks = AnchorBreaks(0, exclude = 0)) +
  geom_qmap() +
  scale_y_latitude(limits = c(-90, 0)) +
  scale_x_longitude() +
  scale_linetype(guide = "none") +
  scale_fill_divergent_discretised(NULL, guide = guide_colorsteps_bottom(25)) +
  annotate_grid() +
  coord_polar2() +
  facet_wrap(~onda, ncol = 4, labeller = labeller(onda = c(`0` = "Anomalía zonal",
                                                           `1` = "Onda 1",
                                                           `2` = "Onda 2",
                                                           `3` = "Onda 3")))

ggsave(filename = "division.png",
       width = 24.55,
       height = 9.18,
       units = "cm",
       path = "presentacion")


hgt %>%
  .[, .(mean = mean(hgt_z)), by = .(lon, lat, season(time))] %>%
  .[, mean := FilterWave(mean, 3), by = .(lat, season)] %>%
  ggperiodic::periodic(lon = c(0, 360)) %>%
  ggplot(aes(lon, lat)) +
  geom_contour_fill(aes(z = mean, fill = after_stat(level)),
                    breaks = AnchorBreaks(0, exclude = 0)) +
  geom_contour_tanaka(aes(z = mean), range = c(0.01, 0.2),
                      breaks = AnchorBreaks(0, exclude = 0)) +
  geom_qmap() +
  scale_y_latitude(limits = c(-90, 0)) +
  scale_x_longitude() +
  scale_linetype(guide = "none") +
  scale_fill_divergent_discretised(NULL, guide = guide_colorsteps_bottom(25)) +
  annotate_grid() +
  coord_polar2() +
  facet_wrap(~season, ncol = 4)

ggsave(filename = "fourier1.png",
       width = 24.55,
       height = 9.91,
       units = "cm",
       path = path)


zw <- hgt %>%
  .[lat == -50] %>%
  .[, hgt_za := Anomaly(hgt_z), by = .(lon, lat, month(time))] %>%
  .[, FitWave(hgt_z, 3), by = time]

hgt %>%
  zw[., on = "time"] %>%
  .[, hgt_za := Anomaly(hgt_z), by = .(lon, lat, month(time))] %>%
  .[, FitLm(hgt_za, amplitude), by = .(lon, lat, season(time))] %>%
  rm_intercept() %>%
  ggperiodic::periodic(lon = c(0, 360)) %>%
  ggplot(aes(lon, lat)) +
  geom_contour_fill(aes(z = estimate, fill = after_stat(level)),
                    breaks = AnchorBreaks(0, exclude = 0)) +
  geom_contour_tanaka(aes(z = estimate), breaks = AnchorBreaks(0, exclude = 0)) +
  geom_qmap() +
  scale_y_latitude(limits = c(-90, 0)) +
  scale_x_longitude() +
  scale_linetype(guide = "none") +
  scale_fill_divergent_discretised(NULL, guide = guide_colorsteps_bottom(25)) +
  annotate_grid() +
  coord_polar2() +
  facet_wrap(~season, ncol = 4)


ggsave(filename = "fourier2.png",
       width = 24.55,
       height = 9.91,
       units = "cm",
       path = path)


hgt %>%
  copy() %>%
  .[lat > -90] %>%
  .[, hgt_za := Anomaly(hgt_z), by = .(lon, lat, month(time))] %>%
  .[, envelope := WaveEnvelope(hgt_za), by = .(lat, time)] %>%
  .[zw, on = c("time")] %>%
  .[, FitLm(envelope, amplitude), by = .(lat, lon, season(time))] %>%
  rm_intercept() %>%
  periodic(lon = c(0, 360)) %>%
  ggplot(aes(lon, lat)) +
  geom_contour_fill(aes(z = estimate, fill = after_stat(level)),
                    breaks = AnchorBreaks(0, exclude = 0)) +
  geom_contour_tanaka(aes(z = estimate),
                      breaks = AnchorBreaks(0, exclude = 0)) +
  # geom_contour2(aes(z = hgt_za, linetype = after_stat(factor(-sign(level)))),
  #               breaks = breaks) +
  geom_qmap() +
  scale_y_latitude(limits = c(-90, 0)) +
  scale_x_longitude() +
  scale_linetype(guide = "none") +
  scale_fill_divergent_discretised(NULL, guide = guide_colorsteps_bottom(20),
                                   labels = label_one_less) +
  annotate_grid() +
  coord_polar2() +
  facet_wrap(~season, ncol = 4)

ggsave(filename = "envelope.png",
       width = 24.55,
       height = 8.25,
       units = "cm",
       path = path)



hgt %>%
  .[raphael, on = "time"] %>%
  .[, FitLm(hgt_z, r04), by = .(lon, lat)] %>%
  rm_intercept() %>%
  # .[, envelope := WaveEnvelope(estimate), by = .(lat)] %>%
  ggperiodic::periodic(lon = c(0, 360)) %>%
  ggplot(aes(lon, lat)) +
  geom_contour_fill(aes(z = estimate, fill = after_stat(level)),
                    breaks = AnchorBreaks(0, exclude = 0)) +
  geom_contour_tanaka(aes(z = estimate), breaks = AnchorBreaks(0, exclude = 0)) +
  inject(geom_point(data = points_raphael, !!!raphael_aes_used)) +
  geom_qmap() +
  scale_y_latitude(limits = c(-90, 0)) +
  scale_x_longitude() +
  scale_linetype(guide = "none") +
  scale_fill_divergent_discretised(NULL, guide = guide_colorsteps_bottom(10)) +
  annotate_grid() +
  coord_polar2()

ggsave(filename = "raphael.png",
       width = 9.55,
       height = 9.55,
       units = "cm",
       path = path)



gdata <- rbind(cor_singles,
               cor_dobles) %>%
  .[, index := forcats::fct_inorder(index)]

levels <- levels(gdata$index)

gdata %>%
  periodic(lon = c(0, 360)) %>%
  ggplot(aes(lon, lat)) +
  geom_contour_fill(aes(z = estimate, fill = after_stat(level)),
                    breaks = AnchorBreaks(0, exclude = 0, binwidth = 5)) +
  geom_contour_tanaka(aes(z = estimate),
                      breaks = AnchorBreaks(0, exclude = 0, binwidth = 5)) +
  inject(geom_point(data = unique(puntos[, .(lat, lon)]),
                    !!!raphael_aes_unused)) +

  inject(geom_point(data = unique(puntos[, .(lat, lon)] %>%
                                    .[, index := factor(LonLabel(lon),
                                                        levels = levels)]),
                    !!!raphael_aes_used)) +

  inject(geom_point(data = unique(pares[, .(lon ,lat, index = factor(index, levels = levels))]),
                    !!!raphael_aes_used)) +

  geom_qmap() +
  scale_y_latitude(limits = c(-90, 0)) +
  scale_x_longitude() +
  scale_fill_divergent_discretised(NULL, guide = guide_colorsteps_bottom(20)) +
  annotate_grid() +
  coord_polar2() +
  facet_wrap(index~., ncol = 3)

ggsave(filename = "pseudoraphael.png",
       width = 15.26,
       height = 12.72,
       units = "cm",
       path = path)



gdata <- era5[lev == 50] %>%
  # .[lat %~% -50] %>%
  .[year(time) == 1982] %>%
  .[, hgt := hgt - mean(hgt)] %>%
  .[, hgt := hgt - mean(hgt), by = .(lat)]



gdata %>%
  periodic(lon = c(0, 360)) %>%
  ggplot(aes(lon, lat)) +
  geom_contour_fill(aes(z = hgt, fill = after_stat(level)),
                    breaks = AnchorBreaks(0, exclude = 0)) +
  geom_qmap() +
  scale_y_latitude(limits = c(-90, 0)) +
  scale_x_longitude() +
  scale_linetype(guide = "none") +
  scale_fill_divergent_discretised(NULL, guide =  NULL) +
  annotate_grid() +
  coord_polar2()



gdata %>%
  periodic(lon = c(0, 360)) %>%
  ggplot(aes(lon, lat)) +
  geom_contour_fill(aes(z = hgt, fill = after_stat(level)),
                    breaks = AnchorBreaks(0, exclude = 0)) +
  annotate("segment", y = -50, yend = -50, x = 0, xend = 360,
           linewidth = 2) +
  geom_qmap() +
  scale_y_latitude(limits = c(-90, 0)) +
  scale_x_longitude() +
  scale_linetype(guide = "none") +
  scale_fill_divergent_discretised(NULL, guide =  NULL) +
  annotate_grid() +
  coord_polar2()


gdata %>%
  .[lat == -50] %>%
  ggplot(aes(lon, hgt)) +
  geom_line() +
  scale_y_continuous(NULL) +
  scale_x_longitude()

N <- 360/2
angles <- rev(rev(seq(0, 360, length.out = N))[-1])*pi/180
path_anim <- "presentacion/hilber_anim"

animdata <- lapply(seq_along(angles), function(a) {
  gdata %>%
    copy() %>%
    .[, hgt := spectral::analyticFunction(hgt) %>%
        rotate(angles[a]) %>%
        Re(), by = lat] %>%
    .[, angle := angles[a]] %>%
    .[, n := a]

}) %>%
  rbindlist()


hilbert <- animdata[n == 1] %>%
  # .[lat == -50] %>%
  .[, .(lon, hgt_c = spectral::analyticFunction(hgt)), by = lat]

animdata <- hilbert[animdata, on = c("lon", "lat")]

lims2d <- range(pretty(animdata$hgt))

breaks <- AnchorBreaks(0, exclude = 0)(lims2d)

lims <- range(pretty(animdata[lat == -50]$hgt))


plot_anim <- function(data) {
  data %>%
    periodic(lon = c(0, 360)) %>%
    ggplot(aes(lon, lat)) +
    geom_contour_fill(aes(z = hgt, fill = after_stat(level)),
                      breaks = breaks) +
    annotate("segment", y = -50, yend = -50, x = 0, xend = 360,
             linewidth = 0.5) +
    geom_qmap() +
    scale_y_latitude(limits = c(-90, 0)) +
    scale_x_longitude() +
    scale_linetype(guide = "none") +
    scale_fill_divergent_discretised(NULL, guide  = NULL) +
    annotate_grid() +
    coord_polar2() +

    data %>%
    .[lat == -50] %>%
    ggplot(aes(lon, hgt)) +
    geom_line(linewidth = 1) +
    scale_y_continuous(name = NULL, limits = lims) +
    scale_x_longitude()
}



ggsave("hilber_obs_.png",
       plot = plot_anim(animdata[n == 1]),
       width = 23, height = 9,
       units = "cm",
       path = "presentacion")

scales <- seq(1, -1, length.out = 20)
for (s in seq_along(scales)) {
  animdata[n == 1] %>%
    periodic(lon = c(0, 360)) %>%
    ggplot(aes(lon, lat)) +
    geom_contour_fill(aes(z = hgt*scales[s], fill = after_stat(level)),
                      breaks = breaks) +
    annotate("segment", y = -50, yend = -50, x = 0, xend = 360,
             linewidth = 0.5) +
    geom_qmap() +
    scale_y_latitude(limits = c(-90, 0)) +
    scale_x_longitude() +
    scale_linetype(guide = "none") +
    scale_fill_divergent_discretised(NULL, guide  = NULL) +
    annotate_grid() +
    coord_polar2() +

    animdata[n == 1] %>%
    .[lat == -50] %>%
    ggplot(aes(lon, hgt*scales[s])) +
    geom_line(linewidth = 1) +
    scale_y_continuous(name = NULL, limits = lims) +
    scale_x_longitude()

  ggsave(paste0(formatC(s, width = 3, flag = "0"), ".png"),
         width = 23, height = 9,
         units = "cm", bg = "white",
         path = "presentacion/hiblert_flip")
}



ggsave("hilber_obs_180.png",
       plot = plot_anim(animdata[n == floor(N/2)]),
       width = 23, height = 9,
       units = "cm",
       path = "presentacion")

ggsave("hilber_obs_90.png",
       plot = plot_anim(animdata[n == floor(N/4)]),
       width = 23, height = 9,
       units = "cm",
       path = "presentacion")







plot_anim2 <- function(data) {
  data %>%
    periodic(lon = c(0, 360)) %>%
    ggplot(aes(lon, lat)) +
    geom_contour_fill(aes(z = hgt, fill = after_stat(level)),
                      breaks = breaks) +
    annotate("segment", y = -50, yend = -50, x = 0, xend = 360,
             linewidth = 0.5) +
    geom_qmap() +
    scale_y_latitude(limits = c(-90, 0)) +
    scale_x_longitude() +
    scale_linetype(guide = "none") +
    scale_fill_divergent_discretised(NULL, guide  = NULL) +
    annotate_grid() +
    coord_polar2() +

    data %>%
    .[lat == -50] %>%
    .[] %>%
    ggplot(aes(lon, hgt)) +
    geom_line(aes(y = Re(hgt_c)*cos(angle), color = "Real"), linewidth = 1) +
    geom_line(aes(y = -Im(hgt_c)*sin(angle), color = "Imaginario"), linewidth = 1) +
    geom_line() +
    scale_y_continuous(name = NULL, limits = lims) +
    scale_x_longitude() +
    scale_color_fase(guide = "none")
}


ggsave("hilber_sep_0.png",
       plot = plot_anim2(animdata[n == 1]),
       width = 23, height = 9,
       units = "cm",
       path = "presentacion")


ggsave("hilber_sep_180.png",
       plot = plot_anim2(animdata[n == floor(N/2)]),
       width = 23, height = 9,
       units = "cm",
       path = "presentacion")


ggsave("hilber_sep_90.png",
       plot = plot_anim2(animdata[n == floor(N/4)]),
       width = 23, height = 9,
       units = "cm",
       path = "presentacion")


ggsave("hilber_sep_mid.png",
       plot = plot_anim2(animdata[n == floor(N/3)]),
       width = 23, height = 9,
       units = "cm",
       path = "presentacion")


for (a in seq_along(angles)) {
  ggsave(paste0(formatC(a, width = 3, flag = "0"), ".png"),
         plot = plot_anim2(animdata[n == a]),
         width = 23, height = 9,
         units = "cm",
         path = "presentacion/hilber_anim2")
}


gdata <- era5[lev == 50] %>%
  .[lat %~% -50] %>%
  .[year(time) == 1982] %>%
  .[, hgt := hgt - mean(hgt)] %>%
  .[, hgt := FilterWave(hgt, 1:4)]



gdata %>%
  copy() %>%
  .[, as.character(c(1:4)) := lapply(1:4, \(x) FilterWave(hgt, x))] %>%
  .[, hgt := NULL] %>%
  dt_pivot_longer(cols = `1`:`4`, names_to = "onda") %>%
  .[, value_c := spectral::analyticFunction(value), by = onda] %>%
  ggplot(aes(lon, value_c)) +
  geom_line(aes(y = Re(value_c), color = factor_ReIm("Real")), linewidth = 1) +
  geom_line(aes(y = Im(value_c), color = factor_ReIm("Imaginario")), linewidth = 1, alpha = 0) +
  facet_wrap(~onda, labeller = labeller(onda = AddPreffix("Onda "))) +
  scale_y_continuous(NULL) +
  scale_x_longitude(ticks = 60) +
  scale_color_fase(guide = "none")


ggsave("hilbert_ondas_1.png",
       width = 18.3, height = 9.3,
       units = "cm",
       path = "presentacion")

gdata %>%
  copy() %>%
  .[, as.character(c(1:4)) := lapply(1:4, \(x) FilterWave(hgt, x))] %>%
  .[, hgt := NULL] %>%
  dt_pivot_longer(cols = `1`:`4`, names_to = "onda") %>%
  .[, value_c := spectral::analyticFunction(value), by = onda] %>%
  ggplot(aes(lon, value_c)) +
  geom_line(aes(y = Re(value_c), color = factor_ReIm("Real")), linewidth = 1) +
  geom_line(aes(y = Im(value_c), color = factor_ReIm("Imaginario")), linewidth = 1, alpha = 1) +
  facet_wrap(~onda, labeller = labeller(onda = AddPreffix("Onda "))) +
  scale_y_continuous(NULL) +
  scale_x_longitude(ticks = 60) +
  scale_color_fase(guide = "none")



ggsave("hilbert_ondas_2.png",
       width = 18.3, height = 9.3,
       units = "cm",
       path = "presentacion")



gdata %>%
  copy() %>%
  .[, hgt := spectral::analyticFunction(hgt)] %>%
  sep_ReIm() %>%
  ggplot(aes(lon, hgt)) +
  geom_line(aes(color = part), linewidth = 1)  +
  scale_y_continuous(NULL) +
  scale_x_longitude(ticks = 60) +
  scale_color_fase(guide = "none")



ggsave("hilbert_ondas_3.png",
       width = 18.3, height = 9.3,
       units = "cm",
       path = "presentacion")




gdata <- ceof$right %>%
  copy() %>%
  .[, hgt := hgt/sd(abs(hgt))]

var <- ceof$sdev %>%
  .[, setNames(paste0(cEOF, " (", scales::percent(r2, accuracy = 0.1), ")"),
               cEOF)]



gdata %>%
  sep_ReIm() %>%
  .[cEOF == "cEOF1"] %>%
  periodic(lon = c(0, 360)) %>%
  .[, lev := as.numeric(lev)] %>%
  ggplot(aes(lon, lat)) +
  geom_contour_fill(aes(z = hgt, fill = ..level..),
                    breaks = AnchorBreaksSym(0, 1, exclude = 0)) +
  geom_contour_tanaka(aes(z = hgt), range = c(0.01, 0.2),
                      breaks = AnchorBreaksSym(0, 1, exclude = 0)) +
  # geom_contour2(aes(z = Im(hgt),  linetype = factor(sign(..level..))),
  # breaks = AnchorBreaksSym(0, 1, exclude = 0)) +

  scale_fill_divergent_discretised(guide = guide_colorsteps_bottom(10)) +
  geom_qmap() +
  scale_x_longitude(labels = NULL) +
  scale_y_latitude(labels = NULL,
                   minor_breaks = NULL) +
  scale_linetype_manual(values = c("1" = 1, "-1" = 2),
                        labels = c("1" = "+", "-1" = "-"),
                        guide = "none") +
  ggh4x::facet_grid2(lev ~  cEOF + part,
                     strip = ggh4x::strip_nested(),
                     labeller = labeller(lev = lab_lev,
                                         cEOF = var,
                                         part = lab_cplx)) +
  theme(legend.title = element_blank()) +
  annotate_grid() +
  coord_polar2()



ggsave("ceofs_1.png",
       width = 8.89, height = 10.49,
       units = "cm",
       path = "presentacion")



gdata %>%
  sep_ReIm() %>%
  .[cEOF == "cEOF2"] %>%
  periodic(lon = c(0, 360)) %>%
  .[, lev := as.numeric(lev)] %>%
  ggplot(aes(lon, lat)) +
  geom_contour_fill(aes(z = hgt, fill = ..level..),
                    breaks = AnchorBreaksSym(0, 1, exclude = 0)) +
  geom_contour_tanaka(aes(z = hgt), range = c(0.01, 0.2),
                      breaks = AnchorBreaksSym(0, 1, exclude = 0)) +
  # geom_contour2(aes(z = Im(hgt),  linetype = factor(sign(..level..))),
  # breaks = AnchorBreaksSym(0, 1, exclude = 0)) +

  scale_fill_divergent_discretised(guide = guide_colorsteps_bottom(10)) +
  geom_qmap() +
  scale_x_longitude(labels = NULL) +
  scale_y_latitude(labels = NULL,
                   minor_breaks = NULL) +
  scale_linetype_manual(values = c("1" = 1, "-1" = 2),
                        labels = c("1" = "+", "-1" = "-"),
                        guide = "none") +
  ggh4x::facet_grid2(lev ~  cEOF + part,
                     strip = ggh4x::strip_nested(),
                     labeller = labeller(lev = lab_lev,
                                         cEOF = var,
                                         part = lab_cplx)) +
  theme(legend.title = element_blank()) +
  annotate_grid() +
  coord_polar2()


ggsave("ceofs_2.png",
       width = 8.89, height = 10.49,
       units = "cm",
       path = "presentacion")

N <- 362/2
angles <- rev(rev(seq(0, 360, length.out = N))[-1])*pi/180

animdata <- lapply(seq_along(angles), function(a) {
  gdata %>%
    copy() %>%
    .[, hgt := Re(rotate(hgt, angles[a]))] %>%
    .[, angle := angles[a]] %>%
    .[, n := a]
}) %>%
  rbindlist()

breaks <- AnchorBreaks(0, binwidth = 1, exclude = 0)(range(animdata$hgt))

for (a in seq_along(angles)) {
  animdata %>%
    .[n == a] %>%
    .[, lev := as.numeric(lev)] %>%
    periodic(lon = c(0, 360)) %>%
    ggplot(aes(lon, lat)) +
    geom_contour_fill(aes(z = hgt, fill = ..level..),
                      breaks = breaks) +
    geom_contour_tanaka(aes(z = hgt), range = c(0.01, 0.2),
                        breaks = breaks) +
    # geom_contour2(aes(z = Im(hgt),  linetype = factor(sign(..level..))),
    # breaks = AnchorBreaksSym(0, 1, exclude = 0)) +

    scale_fill_divergent_discretised(guide = guide_colorsteps_bottom(10)) +
    geom_qmap() +
    scale_x_longitude(labels = NULL) +
    scale_y_latitude(labels = NULL,
                     minor_breaks = NULL) +
    scale_linetype_manual(values = c("1" = 1, "-1" = 2),
                          labels = c("1" = "+", "-1" = "-"),
                          guide = "none") +
    ggh4x::facet_grid2(lev ~  cEOF,
                       strip = ggh4x::strip_nested(),
                       labeller = labeller(lev = lab_lev,
                                           cEOF = var,
                                           part = lab_cplx)) +
    theme(legend.title = element_blank()) +
    annotate_grid() +
    coord_polar2()

  ggsave(paste0(formatC(a, width = 3, flag = "0"), ".png"),
         width = 8.89, height = 10.49,
         units = "cm",
         path = "presentacion/ceof_anim")
}






era_more %>%
  copy() %>%
  .[, ref := year(time) > 1979] %>%
  # .[, hgt := scale(hgt, center = FALSE, scale = sd(hgt[ref])), by = .(part, cEOF)] %>%
  ggplot(aes(time, hgt*1e3)) +
  # Zero line + rangeframe
  geom_hline(data = ~.x[, mean(hgt)*1e3, by  = .(cEOF, part)],
             aes(yintercept = V1), linewidth = 0.2, color = "gray30") +
  geom_segment(data = ~.x[, .(min = min(hgt)*1e3,
                              max = max(hgt)*1e3), by  = .(cEOF, part)],
               aes(x = structure(Inf, class = "Date"),
                   xend = structure(Inf, class = "Date"),
                   y = min,
                   yend = max), linewidth = 0.2, color = "gray30") +
  geom_line() +
  # geom_line(data = ceof[, eof[[1]]$left] %>%
  #             sep_ReIm()) +
  geom_point(size = 0.25) +
  # geom_line(data = era_less) +
  scale_alpha_manual(values = c(1, 0.2)) +
  geom_smooth(
    show.legend = FALSE, linewidth = 0.8) +
  scale_x_date(NULL,
               breaks = seq(as.Date("1930-01-01"),
                            as.Date("2024-01-01"), by = "10 years"),
               labels = function(x) JumpBy(format(x, "%Y"), 2, fill = " "),
               minor_breaks = seq(as.Date("1930-01-01"),
                                  as.Date("2024-01-01"), by = "2 years")) +
  scale_y_continuous(NULL, minor_breaks = NULL, sec.axis = dup_axis()) +
  scale_color_fase(name = NULL, guide = "none") +
  facet_grid(cEOF ~ part, labeller = labeller(part = lab_cplx, cEOF = var)) +
  theme(panel.spacing = grid::unit(1.5, "lines"),
        strip.placement = "outside",
        panel.grid.minor.x = element_line(linetype = 2))  +
  panel_background()

ggsave("ceofs_timeseries.png",
       width = 20.41, height = 10.21,
       units = "cm",
       path = "presentacion")





# hgt regression ----------------------------------------------------------


plot_hgt_regr <- function(data, angle = 0) {

  data[lat <= -20] %>%
    # .[term == "I" & lev == 50] %>%
    .[, p.value := Pvaluate(estimate, std.error, df, "fdr"), by = .(lev, cEOF, term)] %>%
    .[, lev := as.numeric(lev)] %>%
    periodic(lon = c(0, 360)) %>%
    ggplot(aes(lon, lat)) +
    geom_contour_fill(aes(z = estimate), breaks = AnchorBreaksSym(exclude = 0),
                      global.breaks = FALSE) +
    geom_contour_tanaka(aes(z = estimate), range = c(0.01, 0.2),
                        breaks = AnchorBreaksSym(exclude = 0), global.breaks = FALSE) +
    scale_fill_divergent(name = NULL,
                         breaks = AnchorBreaksSym(0, exclude = 0),
                         guide = guide_colorsteps_bottom(17, even.steps = TRUE)) +
    geom_contour_pval(aes(z = p.value)) +

    geom_qmap() +

    scale_x_longitude(labels = NULL) +
    scale_y_latitude(labels = NULL,
                     minor_breaks = NULL) +
    theme(panel.grid.major.y = element_line(color = "gray60", size = 0.1)) +
    ggh4x::facet_grid2(lev ~ cEOF + term, strip = ggh4x::strip_nested(),
                       labeller = labeller(lev = lab_lev, term = lab_cplx)) +
    annotate_grid() +
    coord_polar2()
}



ggsave("ceof_hgt_1.png",
       plot = plot_hgt_regr(regr[cEOF == "cEOF1" & variable == "hgt"]),
       width = 12, height = 11,
       units = "cm",
       path = "presentacion")


ggsave("ceof_hgt_2.png",
       plot = plot_hgt_regr(regr[cEOF == "cEOF2" & variable == "hgt"]),
       width = 12, height = 11,
       units = "cm",
       path = "presentacion")


regr[cEOF == "cEOF2" & variable == "hgt"] %>%
  .[lev == 200] %>%
  .[lat <= -20] %>%
  # .[term == "I" & lev == 50] %>%
  .[, p.value := Pvaluate(estimate, std.error, df, "fdr"), by = .(lev, cEOF, term)] %>%
  .[, lev := as.numeric(lev)] %>%
  .[, term := factor(term, rev(levels(term)))] %>%
  periodic(lon = c(0, 360)) %>%
  ggplot(aes(lon, lat)) +
  geom_contour_fill(aes(z = estimate), breaks = AnchorBreaksSym(exclude = 0),
                    global.breaks = FALSE) +
  geom_contour_tanaka(aes(z = estimate), range = c(0.01, 0.2),
                      breaks = AnchorBreaksSym(exclude = 0), global.breaks = FALSE) +
  scale_fill_divergent(name = NULL,
                       breaks = AnchorBreaksSym(0, exclude = 0),
                       guide = guide_colorsteps_bottom(15, even.steps = TRUE)) +
  geom_contour_pval(aes(z = p.value)) +

  geom_qmap() +

  scale_x_longitude(labels = NULL) +
  scale_y_latitude(labels = \(x) return(rep("", length(x))),
                   minor_breaks = NULL) +
  theme(panel.grid.major.y = element_line(color = "gray60", size = 0.1)) +
  facet_wrap(~term, ncol = 1,
             labeller = labeller(lev = lab_lev, term = lab_cplx)) +
  annotate_grid() +
  coord_sf(ylim = c(NA, 0)) +
  theme(plot.title = element_text(hjust = 0.5, size = theme_get()$strip.text$size))


ggsave("ceof_psa.png",
       width = 11.75, height = 11,
       units = "cm",
       path = "presentacion")


# sst ---------------------------------------------------------------------

# Find maximum absolute value of x*cos(a) - y*sin(a)
find_max_rotation <- function(x, y) {
  a_max <- atan(-y/x)
  abs(x*cos(a_max) - y*sin(a_max))
}

# LM que permite "rotar" los coeficientes y obtener el error estandard.

mylm <- function(y, ...) {
  X <-  cbind(1, ...)
  df <- nrow(X) - ncol(X)

  fit <- stats::.lm.fit(X, y)

  fit$df <- df
  fit$terms <- colnames(X)

  fit$res_sum <- sum(fit$residuals^2)
  fit$ss <- sum((y - mean(y))^2)


  p <- seq_len(fit$rank)
  fit$R <- chol2inv(fit$qr[p, p, drop = FALSE])
  fit$vcov <- fit$R * fit$res_sum/fit$df

  return(fit)
}

coef <- function(fit, angle = 0) {
  rotation_weights <- c(0, cos(angle*pi/180), -sin(angle*pi/180))

  coef <- sum(fit$coefficients * rotation_weights)


  v <- c(t(rotation_weights) %*% fit$vcov %*% rotation_weights)   ## variance of contrast

  list(term = angle,
       estimate = coef,
       std.error = sqrt(v),
       df = fit$df
  )
}



sst_regr2 <- ceof$left %>%
  # .[cEOF == "cEOF2"] %>%
  copy() %>%
  sep_ReIm(format = "wide") %>%
  .[, hgt := NULL] %>%
  .[sst, on = "time", allow.cartesian = TRUE] %>%
  na.omit() %>%
  .[, .(model = list(mylm(t, Real, Imaginario))), by = .(lon, lat, cEOF)]


max_sst <- sst_regr2 %>%
  .[, as.list(model[[1]]$coefficients[2:3]), by = .(lon, lat, cEOF)] %>%
  .[, find_max_rotation(V1, V2), by = .(lon, lat, cEOF)] %>%
  .[, .(max = max(V1)), by = .(cEOF)]


psi_regr2 <- ceof$left %>%
  # .[cEOF == "cEOF2"] %>%
  copy() %>%
  sep_ReIm(format = "wide") %>%
  .[, hgt := NULL] %>%
  .[psi[lev == 200 & lat %between% c(-90, 10)], on = "time", allow.cartesian = TRUE] %>%
  .[, .(model = list(mylm(psi.z, Real, Imaginario))), by = .(lon, lat, lev, cEOF)]


max_psi <- psi_regr2 %>%
  .[lat != -90] %>%
  .[, as.list(model[[1]]$coefficients[2:3]), by = .(lon, lat, cEOF)] %>%
  .[, find_max_rotation(V1, V2), by = .(lon, lat, cEOF)] %>%
  .[, .(max = max(V1)), by = .(cEOF)]


data_sst <- sst_regr2[cEOF == "cEOF2"]
data_psi <- psi_regr2[cEOF == "cEOF2"]


plot_sst_psi_angle <- function(data_sst, data_psi, max_sst, max_psi, which_angle = 0, min.mag = 0.0001) {
  angles_labs <- which_angle %>%
    unique() %>%
    setNames(paste0(abs(.), "º"), .)
  breaks_sst <- AnchorBreaks(0, bins = 20, exclude = 0)(c(-max_sst, max_sst))

  gdata_sst <- data_sst %>%
    .[lat %between% c(-90, 10)] %>%
    .[, coef(model[[1]], angle = which_angle), by = .(lon, lat)] %>%
    .[, p_val := Pvaluate(estimate, std.error, df, "fdr")] %>%
    .[, var := factor("TSM", levels = c("TSM", "Función Corriente"))]

  pattern_spacing <- 0.06

  gdata_psi <- data_psi %>%
    .[lat %between% c(-90, 10)] %>%
    .[, coef(model[[1]], angle = which_angle), by = .(lon, lat)] %>%
    .[, p_val := Pvaluate(estimate, std.error, df, "fdr")] %>%
    .[, psi.z := Anomaly(estimate), by = .(lat)] %>%
    .[, c("fx", "fy") := WaveFlux2(psi.z, lon, lat, p = 200)] %>%
    periodic(lon = c(0, 360)) %>%
    .[, var := factor("Función Corriente", levels = c("TSM", "Función Corriente"))]

  breaks_stream <- AnchorBreaksSym(0, bins = 20, exclude = 0)(c(-max_psi*1e-7, max_psi*1e-7))

  gdata_psi %>%
    ggplot(mapping = aes(lon, lat)) +

    geom_contour_fill(data = gdata_sst,
                      aes(z = estimate, fill = ..level..),
                      breaks = breaks_sst) +
    geom_contour_pval(data = gdata_sst, aes(z = p_val), pattern_spacing = pattern_spacing) +

    scale_fill_divergent_discretised("TSM",
                                     labels = label_one_less,
                                     guide = guide_colorsteps_bottom(width = 20,
                                                                     show.limits = FALSE, ticks = TRUE,
                                                                     order = 1)) +
    new_scale_fill() +
    geom_contour_fill(data = gdata_psi, aes(z = estimate*1e-7, fill = ..level..),
                      breaks = breaks_stream) +
    geom_contour_pval(data = gdata_psi, aes(z = p_val), pattern_spacing = pattern_spacing) +
    # geom_streamline(data = data_psi, aes(dx = fx, dy = fy), min.L = 3, L = 10,
    #                 size = 0.1, res = 2, nx = 22, ny = 12,
    #                 arrow.angle = 14, arrow.length = 0.2) +
    geom_vector(data = gdata_psi, aes(dx = fx, dy = fy), skip = 3,
                min.mag = min.mag,
                size = 0.1) +
    scale_mag(max_size = .5, guide = "none") +

    scale_fill_divergent_discretised("Función corriente",
                                     labels = label_one_less,
                                     low = scales::muted("red"),
                                     high = scales::muted("blue"),
                                     guide = guide_colorsteps_bottom(20, show.limits = FALSE,
                                                                     order = 99)) +
    geom_qmap() +
    grid_panel(grob_spoke, aes(angle = which_angle,
                               var = factor("TSM", levels = c("TSM", "Función Corriente"))),
               inherit.aes = FALSE) +

    scale_x_continuous(NULL, expand = c(0, 0),
                       breaks = seq(0, 360, by = 60),
                       labels = LonLabel) +

    scale_y_continuous(NULL, breaks  = seq(-90, 0, by = 30), expand = c(0, 0)) +

    facet_grid(. ~ var) +
    # coord_quickmap(ylim = c(NA, 10)) +
    coord_sf(ylim = c(-89, 10), expand = FALSE,
             # crs = "+proj=longlat +pm=180 +over",
             default_crs = "+proj=longlat +lon_wrap=180 +over") +
    theme(legend.box = "horizontal",
          legend.text = element_text(size = rel(0.7)),
          legend.spacing = grid::unit(0, "lines"),
          legend.box.spacing = grid::unit(0, "lines"))
}


angles <- rev(rev(seq(0, 360, length.out = 20*4+1))[-1])

for (a in seq_along(angles)) {
  plot <- plot_sst_psi_angle(sst_regr2[cEOF == "cEOF2"],
                             psi_regr2[cEOF == "cEOF2"],
                             max_sst = max_sst[cEOF == "cEOF2"]$max,
                             max_psi = max_psi[cEOF == "cEOF2"]$max,
                             which_angle = angles[a])


  ggsave(paste0(formatC(a, width = 3, flag = "0"), "_", angles[a] ,".png"),
         plot = plot,
         bg = "white",
         width = 24.34, height = 9.37,
         units = "cm",
         path = "presentacion/sst_psi_anim")
}




# sinusoide ---------------------------------------------------------------

gdata <- ceof$left %>%
  .[cEOF == "cEOF2"] %>%
  # .[, hgt := Anomaly(hgt)] %>%
  .[, arg := Arg(hgt)] %>%
  .[, mag := Mod(hgt)] %>%
  .[enso, on = "time"] %>%
  na.omit() %>%
  .[, q := ifelse(mag >= quantile(mag, 0.5), "|cEOF2| > 50%", "|cEOF2| < 50%")]

cor_enso_mag <- gdata[, correlate(mag, abs(oni))]

cor_enso_spearman <- gdata[, cor.test(mag, abs(oni), method = "spearman")[c("estimate", "p.value")]]

cor_enso_mag_outlier <- gdata[oni < 1.5][, correlate(mag, abs(oni))]

cor_enso_mag_quantile <- gdata[mag >= quantile(mag, 0.5)] %>%
  .[oni < 1.5] %>%
  .[, correlate(mag, abs(oni))]

cos_model <- gdata %>%
  .[, .(model = list(lm(oni ~ I(sin(arg)) - 1, weights = mag)))]

gdata %>%
  ggplot(aes(arg, oni)) +
  geom_hline(yintercept = c(-0.5, 0, 0.5), size = 0.2, color = "gray50") +
  geom_vline(xintercept = 0, size = 0.2, color = "gray50") +
  geom_smooth(data = ~qwrap(.x, arg = c(-pi, pi) ~ c(-2*pi, 2*pi)),
              method = "lm", aes(weight = mag),
              formula = y ~ I(sin(x)) -1,
              se = FALSE, color = "black", size = 0.5) +
  geom_point(aes(color = q,
                 shape  = q),
             size = 3) +
  ggrepel::geom_text_repel(data = ~.x[order(-oni)][1:3],
                           aes(label = year(time)), size = 2) +

  scale_color_brewer("", palette = "Dark2") +
  scale_shape_manual("", values = c(20, 18)) +
  scale_y_continuous("ONI") +
  scale_x_continuous("Fase de cEOF2",
                     breaks = seq(-pi, pi, by = 45*pi/180),
                     labels = function(x) paste0(round(x*180/pi, 5), "º")) +
  coord_cartesian(xlim = c(-pi, pi)) +
  panel_background()

ggsave("enso_sinusoide.png", width = 11.85, height = 8.65, units = "cm", path = "presentacion/")


ceof$left %>%
  .[cEOF == "cEOF2"] %>%
  # .[, hgt := Anomaly(hgt)] %>%
  .[enso, on = "time"] %>%
  .[, arg := Arg(hgt)] %>%
  .[, mag := Mod(hgt)] %>%
  na.omit() %>%
  .[, ninio := cut(oni, c(-Inf, -0.5, 0.5, Inf), label = c("ONI < -0.5", "-0.5 < ONI < 0.5", "ONI > 0.5"))] %>%
  qwrap(arg = c(-pi, pi) ~ c(-2*pi, 2*pi)) %>%

  ggplot(aes(arg)) +
  # geom_density(aes(group = model)) +
  geom_density(aes(color = ninio),
               adjust = 0.5) +
  stat_density(aes(fill = ninio),
               adjust = 0.5, geom = "area",
               alpha = 0.4, position = "identity") +
  scale_color_brewer(NULL, palette = "Dark2", aesthetics = c("color", "fill")) +
  scale_y_continuous(NULL) +
  scale_x_continuous("Fase de cEOF2",
                     breaks =  seq(-pi, pi, by = 90*pi/180)[-1],
                     labels = function(x) paste0(round(x*180/pi, 5), "º")) +
  coord_cartesian(xlim = c(-pi, pi))

ggsave("enso_density.png", width = 11.85, height = 8.65, units = "cm", path = "presentacion/")

# espectro ----------------------------------------------------------------

fft %>%
  .[cEOF == "cEOF2"] %>%
  ggplot(aes(1/freq, spec)) +
  # geom_ribbon(aes(ymin = 0, ymax = `95%`), position = "dodge", alpha = 0.1) +
  # geom_line(aes(y = ar_spectrum), alpha = 0.15) +
  geom_line(data = enso_fft, aes(y = spec*3, color = "ONI"), linewidth = 1) +
  geom_line(aes(color = part), linewidth = 1) +
  # annotation_logticks(sides = "b") +
  scale_x_log10("Período (años)") +
  scale_y_continuous("Espectro")  +
  scale_color_manual(name= NULL,
                     values = c(Real = color_real,
                                Imaginario = color_imaginario,
                                ONI = "gray50"),
                     labels = setNames(paste0("cEOF2 - ", lab_cplx), names(lab_cplx))) +
  # facet_grid(cEOF ~ part, labeller = labeller(part = lab_cplx, cEOF = var)) +
  theme(panel.spacing = grid::unit(1.5, "lines"),
        strip.placement = "outside",
        panel.grid.minor.x = element_line(linetype = 2))  +
  panel_background()



ceof$left %>%
  sep_ReIm() %>%
  enso[., on = "time"] %>%
  dmi[., on = "time"] %>%
  .[, `:=`(hgt = as.numeric(scale(hgt)),
           dmi = as.numeric(scale(dmi)),
           oni = as.numeric(scale(oni))), by = .(cEOF, part)] %>%
  na.omit() %>%
  .[cEOF == "cEOF2" & part == "Imaginario"] %>%
  with(euler_correlation(hgt, oni, dmi, c("90º cEOF2", "ONI", "DMI")))


# pp ----------------------------------------------------------------------



pp_regr <- ceof$left %>%
  # .[cEOF == "cEOF2"] %>%
  copy() %>%
  sep_ReIm(format = "wide") %>%
  .[, hgt := NULL] %>%
  .[cmap, on = "time", allow.cartesian = TRUE] %>%
  .[, pp := pp/sd(pp), by = .(lon, lat)] %>%
  .[, .(model = list(mylm(pp, Real, Imaginario))), by = .(lon, lat, cEOF)]

max_pp <- pp_regr %>%
  .[, as.list(model[[1]]$coefficients[2:3]), by = .(lon, lat, cEOF)] %>%
  .[, find_max_rotation(V1, V2), by = .(lon, lat, cEOF)] %>%
  .[, .(max = max(V1)), by = .(cEOF)]

t2m_regr <- ceof$left %>%
  # .[cEOF == "cEOF2"] %>%
  copy() %>%
  sep_ReIm(format = "wide") %>%
  .[, hgt := NULL] %>%
  .[t2m, on = "time", allow.cartesian = TRUE] %>%
  na.omit() %>%
  .[, .(model = list(mylm(t2m, Real, Imaginario))), by = .(lon, lat, cEOF)]

max_t2m <- t2m_regr %>%
  .[, as.list(model[[1]]$coefficients[2:3]), by = .(lon, lat, cEOF)] %>%
  .[, find_max_rotation(V1, V2), by = .(lon, lat, cEOF)] %>%
  .[, .(max = max(V1)), by = .(cEOF)]


plot_pp_angle <- function(data_pp, data_t2m, max_pp, max_t2m, which_angle = 0) {

  angles_labs <- which_angle %>%
    unique() %>%
    setNames(paste0(abs(.), "º"), .)
  variables <- rev(c("Precipitación", "Temperatura a 2 metros"))



  gdata_pp <- data_pp %>%
    .[lat %between% c(-90, 10)] %>%
    .[, coef(model[[1]], angle = which_angle), by = .(lon, lat)] %>%
    .[, p_val := Pvaluate(estimate, std.error, df, "fdr")] %>%
    .[, var := factor(variables[2], levels = variables)]

  breaks_pp <- AnchorBreaks(0, bins = 10, exclude = 0)(c(-max_pp, max_pp))


  gdata_t2m <- data_t2m %>%
    .[lat %between% c(-90, 10)] %>%
    .[, coef(model[[1]], angle = which_angle), by = .(lon, lat)] %>%
    .[, p_val := Pvaluate(estimate, std.error, df, "fdr")] %>%
    .[, var := factor(variables[1], levels = variables)]

  breaks_t2m <- AnchorBreaks(0, bins = 10, exclude = 0)(c(-max_t2m, max_t2m))

  pattern_spacing <- 0.06


  gdata_pp %>%
    ggplot(aes(lon, lat)) +

    geom_contour_fill(aes(z = estimate, fill = ..level..),
                      breaks = breaks_pp) +
    geom_contour_tanaka(aes(z = estimate),
                        range = c(0.01, 0.2),
                        breaks = breaks_pp) +


    scale_fill_divergent_discretised("Precipitación estandarizada",
                                     # limits = c(-1, 1),
                                     low = "#8E521C",
                                     high = "#00665E",
                                     guide = guide_colorsteps_bottom(15, order = 99)) +
    geom_contour_pval(aes(z = p_val), pattern_spacing = pattern_spacing) +

    new_scale_fill() +


    geom_contour_fill(data = gdata_t2m,
                      aes(z = estimate, fill = ..level..),
                      breaks = breaks_t2m) +
    geom_contour_tanaka(data = gdata_t2m,
                        aes(z = estimate),
                        range = c(0.01, 0.2),
                        breaks = breaks_t2m) +

    scale_fill_divergent_discretised("Temperatura",
                                     # limits = c(-1, 1),
                                     guide = guide_colorsteps_bottom(15, order = 1)) +
    geom_contour_pval(data = gdata_t2m, aes(z = p_val), pattern_spacing = pattern_spacing) +



    geom_qmap() +

    grid_panel(grob_spoke, aes(angle = which_angle, var = factor(variables[2], levels = variables)), inherit.aes = FALSE) +

    scale_x_continuous("", expand = c(0, 0), breaks = seq(0, 360, by = 30),
                       labels = LonLabel) +
    scale_y_continuous("", expand = c(0, 0), breaks = seq(-90, 0, by = 15),
                       labels = LatLabel) +
    # scale_y_latitude(ticks = 15, labels = LatLabel) +
    scale_linetype_discrete(guide = "none") +
    facet_grid(. ~ var, labeller = labeller(angle = angles_labs)) +
    theme(axis.text = element_text(size = 6)) +

    coord_sf(ylim = c(NA, 10),
             default_crs = "+proj=longlat +over") +
    theme(panel.spacing = grid::unit(1, "lines")) +
    theme(legend.box = "horizontal",
          legend.spacing = grid::unit(0, "lines"),
          legend.text = element_text(size = rel(0.7)),
          legend.box.spacing = grid::unit(0, "lines") )

}


angles <- rev(rev(seq(0, 360, length.out = 20*4+1))[-1])

for (a in seq_along(angles)) {
  plot <- plot_pp_angle(pp_regr[cEOF == "cEOF2"],
                        t2m_regr[cEOF == "cEOF2"],
                        max_pp = max_pp[cEOF == "cEOF2", max],
                        max_t2m = max_t2m[cEOF == "cEOF2", max],
                        which_angle = angles[a])


  ggsave(paste0(formatC(a, width = 3, flag = "0"), "_", angles[a] ,".png"),
         plot = plot,
         width = 24.34, height = 7.3,
         units = "cm",
         path = "presentacion/pp_t2m_anim")
}


ylim_sa <- c(-90, 0)
xlim_sa <- c(250, 340)


max_pp <- pp_regr %>%
  .[lat %between% ylim_sa & lon %between% xlim_sa] %>%
  .[, as.list(model[[1]]$coefficients[2:3]), by = .(lon, lat, cEOF)] %>%
  .[, find_max_rotation(V1, V2), by = .(lon, lat, cEOF)] %>%
  .[, .(max = max(V1)), by = .(cEOF)]

max_t2m <- t2m_regr %>%
  .[lat %between% ylim_sa & lon %between% xlim_sa] %>%
  .[, as.list(model[[1]]$coefficients[2:3]), by = .(lon, lat, cEOF)] %>%
  .[, find_max_rotation(V1, V2), by = .(lon, lat, cEOF)] %>%
  .[, .(max = max(V1)), by = .(cEOF)]

angles <- rev(rev(seq(0, 360, length.out = 20*4+1))[-1])

for (a in seq_along(angles)) {
  plot <- plot_pp_angle(pp_regr[cEOF == "cEOF2"],
                        t2m_regr[cEOF == "cEOF2"],
                        max_pp = max_pp[cEOF == "cEOF2", max],
                        max_t2m = max_t2m[cEOF == "cEOF2", max],
                        which_angle = angles[a]) +

    coord_sf(ylim = ylim_sa,
             xlim = xlim_sa,
             # crs = "+proj=moll +lon_0=290",
             default_crs = "+proj=longlat +over")


  ggsave(paste0(formatC(a, width = 3, flag = "0"), "_", angles[a] ,".png"),
         plot = plot,
         width = 20, height = 10.7,
         units = "cm",
         path = "presentacion/pp_t2m_sa_anim")
}



cEOF() %>%
  readRDS() %>%
  .$right %>%
  # .[, hgt := hgt/sd(abs(hgt))] %>%
  .[cEOF == "cEOF2"] %>%
  .[lev == 200] %>%
  periodic(lon = c(0, 360)) %>%
  ggplot(aes(lon, lat)) +
  geom_contour_fill(aes(z = Mod(hgt),
                        fill = after_stat(level))) +
  geom_contour2(aes(z = Re(hgt), linetype = after_stat(factor(sign(-level)))),
                linewidth = 0.5, breaks = AnchorBreaks(exclude = 0)) +
  scale_linetype(guide = "none") +
  geom_qmap(~.x[lat <= 0]) +
  annotate_grid() +
  scale_x_longitude(labels = NULL) +
  scale_y_latitude(labels = NULL, limits = c(NA, 0)) +
  scale_fill_divergent_discretised(NULL,
                                   guide = "none") +
  coord_polar2(ymax = 0)


ggsave("ceof_ceof2_amplitude.png",
       width = 9.83, height = 9.86,
       units = "cm",
       path = "presentacion"
       )


PSA() %>%
  readRDS() %>%
  .$right %>%
  .[PC != "SAM"] %>%
  dcast(lon + lat ~ PC, value.var = "value") %>%
  periodic(lon = c(0, 360)) %>%
  ggplot(aes(lon, lat)) +
  geom_contour_fill(aes(z = sqrt(PSA1^2 + PSA2^2),
                        fill = after_stat(level))) +
  geom_contour2(aes(z = PSA2, linetype = after_stat(factor(-sign(level)))),
                linewidth = 0.5, breaks = AnchorBreaks(exclude = 0)) +
  geom_qmap(~.x[lat <= 0]) +
  annotate_grid() +
  scale_linetype(guide = "none") +
  scale_x_longitude(labels = NULL) +
  scale_y_latitude(labels = NULL, limits = c(NA, 0)) +
  scale_fill_divergent_discretised(NULL,
                                   guide = "none") +
  coord_polar2(ymax = 0)

ggsave("ceof_psa_amplitude.png",
       width = 9.83, height = 9.86,
       units = "cm",
       path = "presentacion"
)



# SAM ---------------------------------------------------------------------

sam_sep %>%
  .[lev %in% c(700)] %>%
  rm_singleton() %>%
  melt(id.vars = c("lon", "lat")) %>%
  .[, value := value + rnorm(.N, sd = 1e-6)] %>%
  .[, variable := factor_sam(variable)] %>%
  .[variable == "full"] %>%
  .[lat > -90] %>%
  .[, value := value/sqrt(cos(lat*pi/180))] %>%
  # .[, hgt := ifelse(lat == -90, mean(value[lat == -87.5]), hgt)] %>%
  periodic(lon = c(0, 360)) %>%
  ggplot(aes(lon, lat)) +
  # geom_contour(aes(z = value, linetype = factor(-sign(..level..))), global.breaks = FALSE) +
  geom_contour_fill(aes(z = value), global.breaks = FALSE, breaks = ZeroBreaks) +
  geom_contour_tanaka(aes(z = value), global.breaks = FALSE, breaks = ZeroBreaks) +
  geom_qmap() +
  annotate_grid() +
  scale_x_longitude(labels = NULL) +
  scale_y_latitude(limits = c(NA, -20), labels = NULL) +
  scale_fill_divergent(guide = "none") +
  coord_polar2() +
  axis_labs_smol()


ggsave("sam_full_map.png",
       width = 6.8, height = 6.8,
       units = "cm",
       path = "presentacion")

indices %>%
  .[lev == 700 & term == "full"] %>%
  .[, .(estimate = mean(estimate_norm)), by = .(lev, term, time = seasonally(time))] %>%
  .[time, on = .NATURAL, allow.cartesian = TRUE] %>%
  ggplot(aes(hgt, estimate)) +
  geom_point() +
  geom_smooth(method = "lm", colour = "#FE9AB8") +
  scale_y_continuous("SAM") +
  scale_x_continuous("cEOF") +
  panel_background() +
  facet_grid(cEOF ~ part, labeller = labeller(part = lab_cplx))

ggsave("ceof_sam_scatter.png",
       width = 20.8, height = 10.4,
       units = "cm",
       path = "presentacion")


indices %>%
  .[lev == 700 & term == "full"] %>%
  .[, .(estimate = mean(estimate_norm)), by = .(lev, term, time = seasonally(time))] %>%
  .[time, on = .NATURAL, allow.cartesian = TRUE] %>%
  .[part == "Imaginario" & cEOF == "cEOF2"] %>%
  ggplot(aes(hgt, estimate)) +
  geom_point() +
  geom_smooth(method = "lm", colour = "#FE9AB8") +
  scale_y_continuous("SAM") +
  scale_x_continuous("cEOF") +
  panel_background() +
  facet_grid(cEOF ~ part, labeller = labeller(part = lab_cplx))

ggsave("ceof_sam_scatter_ceof2.png",
       width = 11.54, height = 10.39,
       units = "cm",
       path = "presentacion")


sam_plot %>%
  copy() %>%
  .[, variable := factor(variable, levels(variable)[c(1, 3, 2)])] %>%
  copy() %>%
  .[lat > -90] %>%
  .[, value := value/sqrt(cos(lat*pi/180))] %>%
  # .[, hgt := ifelse(lat == -90, mean(value[lat == -87.5]), hgt)] %>%
  periodic(lon = c(0, 360)) %>%
  ggplot(aes(lon, lat)) +
  # geom_contour(aes(z = value, linetype = factor(-sign(..level..))), global.breaks = FALSE) +
  geom_contour_fill(aes(z = value), global.breaks = FALSE, breaks = ZeroBreaks) +
  geom_contour_tanaka(aes(z = value), global.breaks = FALSE, breaks = ZeroBreaks) +
  geom_qmap() +
  annotate_grid() +
  scale_x_longitude(labels = NULL) +
  scale_y_latitude(limits = c(NA, -20), labels = NULL) +
  scale_fill_divergent(guide = "none") +
  coord_polar2() +
  facet_grid(.~variable, labeller = labeller(variable = label_parsed, lev = lab_lev)) +
  axis_labs_smol() +
  theme(panel.grid = element_blank())  +
  theme(panel.spacing = grid::unit(1, "lines"))


ggsave("sam_fields.png",
       width = 24.66, height = 9.36,
       units = "cm",
       path = "presentacion")



gdata <- indices_2d_yearly %>%
  .[lat <= -20] %>%
  .[lev %in% c(50, 700)] %>%
  .[, lev := as.numeric(lev)] %>%
  .[, term := factor_sam(term)]

plot_sam_regr <- function(which_lev) {
  ggplot(gdata[lev == which_lev], aes(lon, lat)) +
    scale_fill_divergent_discretised(name = NULL,
                                     guide = guide_colorsteps_bottom()) +
    geom_contour_fill(aes(z = estimate, fill = after_stat(level)),
                      breaks = AnchorBreaks(0, exclude =  0)) +
    geom_contour_tanaka(aes(z = estimate), range = c(0.01, 0.2),
                        breaks = AnchorBreaks(0, exclude =  0),
                        size = 0.3) +



    geom_qmap(~.x[lat <= -20]) +
    annotate_grid() +
    scale_x_longitude(labels = NULL) +
    scale_y_latitude(limits = c(NA, -20), labels = NULL) +
    scale_linetype(guide = "none") +
    coord_polar2() +
    facet_grid(lev ~ term, labeller = labeller(lev = lab_lev, term = lab_sam))

}


plot_sam_regr(700)

ggsave("sam_regr_700.png",
       width = 25.18, height = 10.4,
       units = "cm",
       path = "presentacion")



time <- ceof$left %>%
  sep_ReIm() %>%
  .[, hgt := scale(hgt), by = .(cEOF, part)]

sam_r2 <- indices %>%
  .[, .(estimate = mean(estimate)), by = .(lev, term, time = seasonally(time))] %>%
  .[time, on = .NATURAL, allow.cartesian = TRUE] %>%
  na.omit() %>%
  .[, correlate(hgt, estimate), by = .(lev, term, part, cEOF, season(time, "es"))]

max_r2 <- sam_r2[part == "Imaginario"] %>%
  .[, .SD[which.max(estimate^2)], by = .(cEOF, term, season)]

sam_r2 %>%
  .[cEOF == "cEOF2"] %>%
  .[, p.value_a := p.adjust(p.value, "fdr")] %>%
  ggplot(aes(lev, estimate^2)) +
  geom_vline(xintercept = c(50, 200),  size = 0.2, color = "gray50") +
  # geom_point(data = ~.x[p.adjust(p.value, "fdr") < 0.01], aes(color = term)) +
  geom_line(data = ~copy(.x)[p.value_a > 0.01, estimate := NA],
            aes(colour = stage(term, after_scale = scales::alpha(colour, 0.5))),
            size = 2) +
  geom_line(aes(color = term, group = term)) +

  scale_x_level("Nivel (hPa)", minor_breaks = NULL) +
  scale_y_continuous(r2, limits = c(0, 1), labels = scales::percent_format(),
                     guide = guide_axis(check.overlap = TRUE)) +
  scale_size_manual("p-value", values = c("TRUE" = 1,
                                          "FALSE" = 0.5),
                    guide = "none") +
  scale_color_brewer(NULL, palette = "Dark2", labels = c(full = "SAM",
                                                         asym = "A-SAM",
                                                         sym = "S-SAM")) +
  facet_grid(cEOF ~ part, labeller = labeller(part = lab_cplx)) +
  coord_flip() +
  panel_background()

ggsave("sam_ceof_r2.png",
       width = 12.32, height = 11.62,
       units = "cm",
       path = "presentacion")



air_regr %>%
  .[season == "DEF"] %>%
  copy() %>%
  .[, p.value := Pvaluate(estimate, std.error, df, "fdr"), by = .(term, season)] %>%
  periodic(lon = c(0, 360)) %>%
  ggplot(aes(lon, lat)) +
  geom_contour_fill(aes(z = estimate, fill = ..level..),
                    breaks = anchor_limits(0, 0.1, 0, range = c(-.6, 0.6))) +
  geom_contour_pval(aes(z = p.value)) +
  geom_qmap(~.x[lat <= 0]) +
  annotate_grid() +
  scale_x_longitude(labels = NULL) +
  scale_y_latitude(labels = NULL, limits = c(NA, 0)) +
  scale_fill_divergent_discretised(NULL,
                                   guide = guide_colorsteps_bottom(width = 20, even.steps = FALSE)) +
  coord_polar2(ymax = 0) +
  facet_grid(season ~ term, labeller = labeller(term = lab_sam, lev = lab_lev)) +
  theme(panel.grid = element_blank())

ggsave("sam_t2m.png",
       width = 24.96, height = 11.04,
       units = "cm",
       path = "presentacion")




gh <- indices_2d %>%
  copy() %>%
  .[season == "Anual"] %>%
  .[, c("u", "v") := GeostrophicWind(estimate, lon, lat, cyclical = TRUE), by = .(term, season)] %>%
  add_continent() %>%
  .[continent == "america"]

gdata <- pp_regr %>%
  .[season == "Anual"] %>%
  .[term != "mei"] %>%
  add_continent() %>%
  # .[lat <= -10] %>%
  .[continent == "america"] %>%
  .[, p.value := Pvaluate(estimate, std.error, df, "fdr"), by = .(season, continent, term)]


gdata %>%
  ggplot(aes(lon, lat)) +
  geom_contour_fill(aes(z = estimate, fill = ..level..), na.fill = 0,
                    breaks = anchor_limits(0, 0.1, 0, range = c(-.8, 0.8))) +
  stat_subset(aes(subset = is.na(estimate)), geom = "tile", color = "gray50") +
  # geom_raster(aes(fill = estimate/30)) +
  geom_contour_pval(aes(z = p.value), pattern_spacing = 0.05) +
  # geom_contour_fill(aes(z = as.numeric(is.na(estimate))), breaks = 1) +
  # stat_subset(aes(subset = p.value <= 0.05 & is.cross(lon, lat, 2)), size = 0.4, alpha = 0.8) +
  geom_contour2(data = gh, breaks = MakeBreaks(bins = 15, exclude = 0),
                color = "gray50", size = 0.2, global.breaks = FALSE,
                aes(z = estimate, linetype = factor(-sign(..level..)))) +
  geom_text_contour(data = gh, breaks = MakeBreaks(bins = 15, exclude = 0),
                    global.breaks = FALSE,
                    size = 2.5,
                    stroke = 0.15, stroke.color = "white",
                    aes(z = estimate), rotate = FALSE, skip = 1) +
  geom_qmap(~.x[lat <= 10]) +
  scale_x_longitude(ticks = 15, minor_breaks = NULL) +
  scale_y_latitude(ticks = 10,  minor_breaks = NULL) +
  # discrete_scale("fill", "name", name = "Precipitación",
  #             palette = discrete_div_pp,
  #             guide = guide_colorsteps_bottom(show.limits = TRUE, even.steps = FALSE)) +
  scale_fill_divergent_discretised(NULL,
                                   # limits = c(-.8, .8),
                                   # oob = scales::squish,
                                   low = "#8E521C",
                                   high = "#00665E",
                                   # label = scales::percent_format(),
                                   guide = guide_colorsteps_bottom(width = 25, even.steps = FALSE)) +

  scale_linetype(guide = "none") +
  coord_sf(xlim = continents[["america"]]$lon,
           ylim = continents[["america"]]$lat) +
  facet_grid(season ~ term, labeller = labeller(term = lab_sam, lev = lab_lev)) +
  axis_labs_smol()


ggsave("sam_pp_sa.png",
       width = 21.82, height = 9.9,
       units = "cm",
       path = "presentacion")


indices %>%
  .[, lapply(.SD, mean), by = .(lev, PC, term, time = seasonally(time))] %>%
  .[, season := season(time, "es")] %>%
  rbind(., copy(indices)[, season := "Anual"]) %>%
  .[year(time) >= c(1979)] %>%
  .[, estimate_norm := estimate_norm/sd(estimate_norm), by = .(lev, term)] %>%
  .[, FitLm(estimate_norm, time = time, se = TRUE), by = .(type = term, lev, season)] %>%
  rm_intercept() %>%
  .[, term := NULL] %>%
  .[, estimate := estimate*365*10] %>%
  .[, std.error := std.error*365*10] %>%
  .[, pval := Pvaluate(estimate, std.error, df, "fdr")] %>%
  setnames("type", "term") %>%
  .[, season := forcats::fct_relevel(season, "Anual")] %>%
  .[, t := qt(.975, df)] %>%
  .[, term := factor_sam(term)] %>%
  ggplot(aes(lev, estimate)) +
  geom_hline(yintercept = 0) +
  geom_ribbon(aes(ymax = estimate + std.error*t, ymin = estimate - std.error*t),
              fill = "#95a3ab", color = "black",
              alpha = .6, size = 0.1) +
  geom_line() +
  # stat_subset(aes(subset = pval <= 0.05), shape = 4, size = 2) +
  scale_fill_brewer(palette = "Dark2", aesthetics = c("color", "fill")) +
  scale_x_level() +
  scale_y_continuous("Desvío estándard por década") +
  coord_flip() +
  facet_grid(season ~ term,labeller = labeller(term = lab_sam)) +
  panel_background()


ggsave("sam_trends.png",
       width = 15.5, height = 12.48,
       units = "cm",
       path = "presentacion")



indices %>%
  .[term != "full"] %>%
  .[year(time) >= 1979] %>%
  .[year(time) <= 2020] %>%
  .[, FitLm(r.squared, time, se = TRUE), by = .(lev, type = term, season(time, "es"))] %>%
  rm_intercept() %>%
  .[, estimate := estimate*365*10] %>%
  .[, std.error := std.error*365*10] %>%
  ggplot(aes(lev, estimate)) +
  geom_hline(yintercept = 0) +
  geom_ribbon(aes(fill = type, color = type,
                  ymin = estimate - 1.96*std.error, ymax = estimate + 1.96*std.error),
              size = 0.2, alpha = 0.2) +
  geom_line(aes(color = type)) +
  scale_x_level() +
  scale_y_continuous("Vambio en varianza explicada por década",
                     label = scales::percent_format(1)) +
  scale_fill_brewer(NULL, guide = "none", palette = "Dark2", aesthetics = c("color", "fill"), labels = lab_sam) +
  coord_flip() +
  facet_grid(type~season, labeller = labeller(type = lab_sam)) +
  panel_background()


ggsave("sam_asym.png",
       width = 20.2, height = 9.6,
       units = "cm",
       path = "presentacion")


data <- ERA5_geopotential() %>%
  ReadNetCDF(subset = list(latitude = c(-90, -20),
                           level = 700),
             vars = c(hgt = "z")) %>%
  .[, hgt := hgt/9.8] %>%
  normalise_coords() %>%
  na.omit() %>%
  .[, hgt := hgt/9.8] %>%
  .[, hgt_a := hgt - mean(hgt), by = .(lon, lat, lev, month(time))] %>%
  .[, time := as.Date(time)] %>%
  .[, year := year(time)] %>%
  .[, hgt := hgt_a*sqrt(cos(lat*pi/180))]


years <- unique(data$year)

start_years <- head(years, -11)
end_years   <- tail(years, -11)

running_sam <- lapply(seq_along(start_years), function(i) {
  EOF(hgt ~ time | lon + lat, n = 1, data = data[year %between% c(start_years[i], end_years[i])])$right %>%
    .[, year := start_years[i]]
}) %>%
  rbindlist()

running_sam %>%
  .[, hgt_z := hgt - mean(hgt), by = .(year, lat)] %>%
  .[, mean(hgt_z), by = .(lon, year)] %>%
  ggplot(aes(year, lon)) +
  geom_contour_fill(aes(z = -V1), breaks = AnchorBreaks(exclude = 0)) +
  geom_contour_tanaka(aes(z = -V1), range = c(0.01, 0.2),
                      breaks = AnchorBreaks(exclude = 0)) +
  scale_fill_divergent(guide = "none") +
  scale_y_longitude() +
  scale_x_continuous("Año inicial", expand = c(0, 0))


ggsave("sam_running.png",
       width = 23, height = 9.6,
       units = "cm",
       path = "presentacion")


running_sam %>%
  .[year %in% range(start_years)] %>%
  ggplot(aes(lon, lat)) +
  geom_contour_fill(aes(z = -hgt)) +
  scale_fill_divergent() +
  facet_wrap(~year)




running_sam %>%
  .[, hgt_z := hgt - mean(hgt), by = .(year, lat)] %>%
  .[, cor(hgt_z, hgt)^2, by = year] %>%
  ggplot(aes(year, V1)) +
  geom_line()


# CMIP --------------------------------------------------------------------



simulaciones %>%
  .[, .(miembros = .N), by = .(model, experiment)] %>%
  tidyr::pivot_wider(names_from = experiment, values_from = miembros, values_fill = 0) %>%
  as.data.table() %>%
  .[order(-historical, -(`hist-GHG` + `hist-nat` + `hist-stratO3` + `hist-aer`))] %>%
  .[sims, on = "model"] %>%
  # .[, model := paste(model, ref, sep = "\n")] %>%
  .[, ref := NULL] %>%
  setnames("model", "Modelo") %>%


  knitr::kable(caption = "Modelos analizados y la cantidad de miembros para cada experimento.",
               format = "markdown", format.args = list(zero.print = "-"))



interpolated %>%
  .[experiment == "historical"] %>%
  .[, mean(hgt_norm), by = .(cEOF, model, experiment, lon, lat, lev)] %>%
  .[, mean(V1), by = .(cEOF, experiment, lon, lat, lev)] %>%
  # .[(cEOF == "cEOF1" & lev == 50) | (cEOF == "cEOF2" & lev == 200)] %>%

  sep_ReIm() %>%
  periodic(lon = c(0, 360)) %>%
  ggplot(aes(lon, lat)) +
  geom_contour_fill(aes(z = V1), breaks = AnchorBreaks(exclude = 0)) +
  geom_contour2(aes(z = base, linetype = factor(-sign(..level..))),
                data = sep_ReIm(base) %>%
                  periodic(lon = c(0, 360)),
                breaks = AnchorBreaks(exclude = 0)) +
  scale_linetype(guide = "none") +
  scale_fill_divergent(guide = "none") +
  geom_qmap(crop = c(ymax = -20)) +
  scale_x_longitude() +
  scale_y_latitude(limits = c(-90, NA)) +
  coord_polar2() +
  ggh4x::facet_nested(lev ~ cEOF + part,
                      labeller = labeller(lev = AddSuffix(" hPa"),
                                          cEOF = ceof_labs,
                                          part = lab_cplx))

ggsave("cmip_mmm.png",
       width = 17.93,
       height = 10.27,
       units = "cm",
       path = "presentacion")


cors %>%
  .[experiment == "historical"] %>%
  .[, model := reorder(model, r2, fun = mean)] %>%
  # .[, cEOF := forcats::fct_rev(cEOF)] %>%
  ggplot(aes(r2, model)) +
  geom_col(aes(fill = cEOF),
           position = position_dodge2(reverse = TRUE, padding = 0)) +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous(name = NULL, limits = c(0, 1), labels = scales::percent_format()) +
  scale_y_discrete(NULL)


ggsave("cmip_cors.png",
       width = 11.24,
       height = 13.49,
       units = "cm",
       path = "presentacion")


sst_regression %>%
  .[, pval := Pvaluate(estimate, std.error, df)] %>%
  .[, .(estimate = mean(estimate),
        prop = mean(pval < 0.01)), by = .(lon, lat, experiment, cEOF, term)] %>%
  .[, term := factor_ReIm(term)] %>%
  ggplot(aes(lon, lat)) +
  geom_contour_fill(aes(z = estimate, fill = after_stat(level)),
                    breaks = AnchorBreaks(exclude = 0)) +
  geom_contour_pval(aes(z = prop), p.value = 0.5, hatch = 9, pattern_spacing = 0.05) +

  # geom_contour2(aes(z = era5, linetype = factor(-sign(..level..))),
  #               data = sst_regression_ERA5,
  #               breaks = AnchorBreaks(exclude = 0)) +
  geom_qmap() +
  scale_y_latitude() +
  scale_x_continuous(name = NULL, breaks  = seq(0, 360, by = 60), expand = c(0, 0)) +
  scale_fill_divergent_discretised(NULL,
                                   labels = label_one_less,
                                   guide = guide_colorsteps_bottom(width = 25,
                                                                   show.limits = FALSE,
                                                                   ticks = TRUE,
                                                                   order = 1)) +
  scale_linetype(guide = "none") +
  coord_sf(ylim = c(10, -90), xlim = c(0, 360), crs = "+proj=lonlat +over") +
  facet_grid(cEOF ~ term, labeller = labeller(term = lab_cplx))



ggsave("cmip_sst.png",
       width = 21.88,
       height = 9.66,
       units = "cm",
       path = "presentacion")


sst_cors %>%
  .[, r2_ceof2 := r2[cEOF == "cEOF2" & term == "Imaginario"],
    by = .(model, experiment)] %>%
  .[, model := reorder(model, r2_ceof2, fun = mean)] %>%
  {
    models_sst_cor <<- levels(.$model)
    .
  } %>%

  .[, picos := model %in% con_picos$model & cEOF == "cEOF2" & term == "Imaginario"] %>%
  ggplot(aes(r2, model)) +
  # geom_col(aes(x = 1 ,
  #               y = ifelse(picos, model, NA)), alpha = 0.2, fill = "gray50") +
  geom_col(aes(fill = term),
           position = position_dodge2(reverse = TRUE, padding = 0)) +
  scale_fill_fase() +
  scale_x_continuous(r2, limits = c(0, 1), labels = scales::percent_format()) +
  scale_y_discrete(NULL) +
  facet_wrap(~cEOF)




ggsave("cmip_sst_cor.png",
       width = 14.76,
       height = 13.19,
       units = "cm",
       path = "presentacion")


ceofs[, eof[[1]]$left, by = .(model, experiment)] %>%
  .[cEOF == "cEOF2"] %>%
  # .[, hgt := Anomaly(hgt)] %>%
  .[, arg := Arg(hgt)] %>%
  .[, mag := Mod(hgt)] %>%
  .[enso_cmip, on = c("time", "model", "experiment", "ensemble" = "member")] %>%
  .[cors_enso[part == "Imaginario"], on = .NATURAL] %>%
  .[, model := reorder(model, -(correlation^2)*(part == "Imaginario"))] %>%
  na.omit() %>%
  .[, ninio := cut(oni, c(-Inf, -0.5, 0.5, Inf), label = c("ONI < -0.5", "-0.5 < ONI < 0.5", "ONI > 0.5"))] %>%
  qwrap(arg = c(-pi, pi) ~ c(-2*pi, 2*pi)) %>%

  ggplot(aes(arg)) +
  # geom_density(aes(group = model)) +
  geom_density(aes(color = ninio),
               adjust = 0.5) +
  stat_density(aes(fill = ninio),
               adjust = 0.5, geom = "area",
               alpha = 0.4, position = "identity") +
  scale_color_brewer(NULL, palette = "Dark2", aesthetics = c("color", "fill")) +
  scale_y_continuous(NULL) +
  scale_x_continuous("Fase de cEOF2",
                     breaks =  seq(-pi, pi, by = 90*pi/180)[-1],
                     labels = function(x) paste0(round(x*180/pi, 5), "º")) +
  facet_wrap(~model) +
  coord_cartesian(xlim = c(-pi, pi))



ggsave("cmip_enso_density.png",
       width = 17.88,
       height = 13.89,
       units = "cm",
       path = "presentacion")


fft %>%
  .[cEOF == "cEOF2"] %>%
  .[experiment %in% c("historical", "reanalysis")] %>%
  # .[, .(spec = mean(spec)), by = .(freq, part, model, cEOF)] %>%
  .[cors_enso, on = .NATURAL] %>%
  .[, model := reorder(model, -(correlation^2)*(part == "Imaginario"))] %>%
  .[, ensembleN := uniqueN(ensemble), by = model] %>%
  ggplot(aes(1/freq, spec)) +
  # geom_ribbon(aes(ymin = 0, ymax = `95%`), position = "dodge", alpha = 0.1) +
  # geom_line(aes(y = ar_spectrum), alpha = 0.15) +
  geom_line(data = enso_gdata, aes(y = spec*3, color = "ONI")) +
  geom_line(aes(color = part, group = interaction(part, ensemble),
                alpha = alpha_from_n(ensembleN, 0.9))) +
  geom_line(data = ~.x[, .(spec = mean(spec)), by = .(freq, part, model, cEOF)],
            aes(color = part)) +
  # annotation_logticks(sides = "b") +
  scale_color_manual(name= NULL,
                     values = c(Real = color_real,
                                Imaginario = color_imaginario,
                                ONI = "gray20"),
                     labels = setNames(paste0("cEOF2 - ", lab_cplx), names(lab_cplx))) +
  scale_x_log10("Período (años)") +
  scale_y_continuous("Espectro")  +
  scale_alpha_identity() +
  facet_wrap(model ~ ., labeller = labeller(model = labs_cor_enso))



ggsave("cmip_enso_fourier.png",
       width = 17.16,
       height = 12.86,
       units = "cm",
       path = "presentacion")

gdata <- sam_cors %>%
  .[, .(correlation = mean(correlation)), by = .(cEOF, term, model, experiment, part, lev)] %>%
  .[, approx(lev, correlation, xout = levs), by = .(cEOF, term, model, experiment, part)] %>%
  setnames(c("x", "y"), c("lev", "correlation")) %>%
  .[, term := factor_sam(term)]

# facet_grid2 shenanigans
panels <- paste(rep(letters[1:4], 3), rep(1:3, each = 4), sep = ".")
order <- order(c(1, 5, 9, 2, 6, 10, 3, 7, 11, 4, 8, 12))
panels <- panels[order]

# gdata <- gdata %>%
#   .[, ggplot2::mean_se(correlation^2), by = .(lev, experiment, cEOF, part, term)]

ggplot(mapping = aes(lev, correlation^2)) +
  geom_line(data = gdata[experiment == "reanalysis"] %>%
              .[, experiment := NULL],
            aes(color = term),
            linewidth = 2) +
  stat_summary(data = gdata[experiment != "reanalysis"] %>%
                 .[experiment == "historical"],
               fun.data = \(x) mean_se(x,
                                       mult = qt(.025, length(x),
                                                 lower.tail = FALSE)),

               geom = "ribbon", alpha = 0.4, aes(fill = term)) +


  stat_summary(data = gdata[experiment != "reanalysis"] %>%
                 .[experiment == "historical"],
               fun = mean,
               geom = "line", alpha = 1, aes(color = term)) +

  geom_line(data = gdata[experiment != "reanalysis"][experiment == "historical"],
            aes(group = interaction(term, model), color = term), alpha = 0.1) +

  # geom_line(data = gdata[experiment != "reanalysis"][experiment == "historical"] %>%
  #             .[model == "NorCPM1"],
  #           aes(group = interaction(term, model))) +


  ggh4x::facet_grid2(term ~ cEOF + part,
                     labeller = labeller(part = lab_cplx,
                                         term = c(full = "SAM",
                                                  asym = "A-SAM",
                                                  sym = "S-SAM")),
                     strip = ggh4x::strip_nested()) +
  coord_flip() +
  scale_x_level() +
  scale_y_continuous(name = r2,  limits = c(0, 1),
                     labels = scales::percent_format()) +
  scale_color_brewer(NULL, palette = "Dark2", labels = c(full = "SAM",
                                                         asym = "A-SAM",
                                                         sym = "S-SAM"),
                     aesthetics = c("colour", "fill")) +
  panel_background()


ggsave("cmip_sam.png",
       width = 13.47,
       height = 11.43,
       units = "cm",
       path = "presentacion")


ceof_largo_p %>%
  sep_ReIm() %>%
  .[experiment == "historical"] %>%
  .[, hgt := Anomaly(hgt, time >= 1900), by = .(model, experiment, part, ensemble, cEOF)] %>%
  .[, hgt := hgt/sd(hgt[time >= 1900]), by = .(model, experiment, part, ensemble, cEOF)] %>%
  .[, .(hgt = mean(hgt)), by = .(model, experiment, time, part, cEOF)] %>%
  ggplot(aes(time, hgt)) +
  geom_line(aes(group = model),
            alpha = 0.1) +
  geom_line(data = ~.x[, .(hgt = mean(hgt)), by = .(time, experiment, cEOF, part)]) +
  scale_x_continuous(NULL) +
  scale_y_continuous(NULL) +
  scale_color_fase(name = NULL, guide = "none") +
  coord_cartesian(ylim = c(-1, 1)) +
  panel_background() +
  facet_grid(cEOF ~ part, labeller = labeller(part = lab_cplx))



ggsave("cmip_trends.png",
       width = 19.29,
       height = 9.77,
       units = "cm",
       path = "presentacion")


ceof_largo_p %>%
  sep_ReIm() %>%
  .[, hgt := Anomaly(hgt, time <= 1900), by = .(model, experiment, part, ensemble, cEOF)] %>%
  .[, hgt := hgt/sd(hgt[time <= 1900]), by = .(model, experiment, part, ensemble, cEOF)] %>%
  # .[, eof := scale_eof(eof, time <= 1900), by = .(model, experiment, part, ensemble, cEOF)] %>%
  # .[, eof := scale(eof, center = mean(eof[time <= 1900]),
  #                  scale = sd(eof[time <= 1900])),
  #   by = .(model, part, cEOF)] %>%
  .[, .(hgt = mean(hgt)), by = .(model, experiment, time, part, cEOF)] %>%
  # .[experiment != "historical"] %>%

  ggplot(aes(time, hgt, color = experiment)) +
  # geom_line(aes(group = model), alpha = 0.1) +
  geom_line(data = ~.x[, .(hgt = mean(hgt)), by = .(time, experiment, cEOF, part)],
            alpha = 0.3) +
  geom_smooth(data = ~.x[, .(hgt = mean(hgt)), by = .(time, experiment, part, cEOF)],
              show.legend = FALSE) +

  # geom_line(data = ceof_era5[, eof[[1]]$left] %>% sep_ReIm() %>% .[, eof := scale_eof(eof), by = .(cEOF, part)]) +
  scale_x_continuous(NULL) +
  scale_y_continuous(NULL) +
  scale_color_experiments(guide = guide_legend(override.aes = list(linewidth = 2, alpha = 1))) +
  # coord_cartesian(ylim = c(-1.5, 1.5)) +
  panel_background() +
  facet_grid(cEOF ~ part, labeller = labeller(part = lab_cplx))


ggsave("cmip_trends_damip.png",
       width = 19.29,
       height = 9.77,
       units = "cm",
       path = "presentacion")


ceof_largo_p %>%

  sep_ReIm() %>%
  # .[experiment == "historical"] %>%
  .[, hgt := Anomaly(hgt, time <= 1900), by = .(model, experiment, part, ensemble, cEOF)] %>%
  .[, hgt := hgt/sd(hgt[time <= 1900]), by = .(model, experiment, part, ensemble, cEOF)] %>%
  .[, .(hgt = mean(hgt)), by = .(model, experiment, time, part, cEOF)] %>%
  .[, .(hgt = mean(hgt)), by = .(experiment, time, part, cEOF)] %>%
  .[, .(historical = hgt[experiment == "historical"],
        # suma_forzantes = sum(hgt[experiment != "historical"]),
        antropogénicos = sum(hgt[!(experiment %in% c("historical", "hist-nat"))])),
    by = .(time, part, cEOF)] %>%
  .[cEOF == "cEOF1"] %>%
  dt_pivot_longer(cols = historical:antropogénicos) %>%
  ggplot(aes(time, value)) +
  geom_line(aes(color = name), alpha = 0.4) +
  geom_smooth(aes(color = name)) +
  scale_color_brewer(name = "Forzantes", palette = "Set1") +
  scale_y_continuous(name = NULL) +
  scale_x_continuous(name = NULL) +
  panel_background() +
  facet_grid(cEOF ~ part, labeller = labeller(part = lab_cplx))


ggsave("cmip_trends_suma.png",
       width = 19.29,
       height = 9.77,
       units = "cm",
       path = "presentacion")

