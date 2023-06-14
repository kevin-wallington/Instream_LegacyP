# library(SWATplusR)
# library(lhs)
# library(hydroGOF)
# library(dplyr)
# library(lubridate)
# library(tidyr)
# library(purrr)
# library(ggplot2)
# library(hydroTSM)
# library(stringr)
# library(car)
# library(twosamples)

project_path <- "C:/Users/kevin/Documents/INFEWS/SWAT+R/TxtInOut_SuperCal"

#Main
#For new water quality and soil P routines
par_bound_super <- tibble(#"cn2.hru | change = pctchg" = c(-20, 20),
  #"latq_co.hru | change = absval" = c(0.2, 5),
  #"k_res.res | change = absval" = c(0.1, 5),
  #"k.sol | change = pctchg" = c(-25,25),
  #"awc.sol | change = pctchg" = c(-10,10),
  "bd.sol | change = pctchg" = c(0, 6), # had 5,15
  "surlag.bsn | change = absval" = c(1.05, 1.6), # had 1.0,4.0
  #"epco.hru | change = absval" = c(0.75, 0.95), #approx. = 0.85 for yield
  #"esco.hru | change = absval" = c(0.8, 0.99),
  #"canmx.hru | change = absval" = c(0.1, 3),
  #"cn3_swf.hru | change = absval" = c(0.3,0.7),
  #"lat_ttime.hru | change = absval" = c(1.0,48.0), #let model calculate
  #"lat_len.hru | change = absval" = c(60,120),
  #"perco.hru | change = absval" = c(0.1,0.6),
  #"ovn.hru | change = pctchg" = c(-5,8),
  #"tile_latk.hru | change = absval" = c(1.0, 4.0),
  #"tile_lag.hru | change = absval" = c(4, 48),
  "n.rte | change = absval" = c(0.07,0.085), # had 0.02,0.1
  "tile_sed.hru | change = absval" = c(0.2,0.55),
  #"usle_p.hru | change = pctchg" = c(-50,0),
  "lat_sed.hru | change = absval" = c(0.2,0.5),
  "usle_k.sol | change = pctchg" = c(-30, 10),
  "prf.bsn | change = absval" = c(1.0, 1.14),
  "bed_kd1.rte | change = absval" = c(0.2, 1.7),
  "bed_kd2.rte | change = absval" = c(0.3, 1.7),
  "bed_kd3.rte | change = absval" = c(0.45, 1.8),
  "bed_kd4.rte | change = absval" = c(0.7, 1.8),
  "bed_kd5.rte | change = absval" = c(0.01, 1.7),
  "tc_bed1.rte | change = absval" = c(4,17),
  "tc_bed2.rte | change = absval" = c(15,17.5),
  "tc_bed3.rte | change = absval" = c(10,16),
  "tc_bed4.rte | change = absval" = c(4,15),
  "tc_bed5.rte | change = absval" = c(5,14),
  "kod_a1.rte | change = absval" = c(60, 160),
  "kod_b1.rte | change = absval" = c(3.4, 4.0),
  "kod_a2.rte | change = absval" = c(540, 850),
  "kod_b2.rte | change = absval" = c(2.9, 3.45),
  "kod_a3.rte | change = absval" = c(140, 400),
  "kod_b3.rte | change = absval" = c(2.5, 3.05),
  "kod_a4.rte | change = absval" = c(330, 500),
  "kod_b4.rte | change = absval" = c(2.85, 3.1),
  "kod_a5.rte | change = absval" = c(320, 550),
  "kod_b5.rte | change = absval" = c(2.85, 3.2),
  #"pdep_alt.rte | change = absval" = c(1.5 , 2.0),
  "nsed.res | change = absval" = c(2, 16),
  "sed_stl.res | change = absval" = c(0.43, 0.7),
  "trapeff.res | change = absval" = c(0.64, 0.75),
  "stl_vel.res | change = absval" = c(12, 28),
  "erorgp.hru | change = absval" = c(0.7, 1.05),
  "pperco.bsn | change = absval" = c(0.55, 0.95),
  "phoskd.bsn | change = absval" = c(3, 24),
  "p_updis.bsn | change = absval" = c(8, 20),
  "srpm2.bsn | change = absval" = c(0.022, 0.06), # for new soil only
  "adskeq.bsn | change = absval" = c(0.014, 0.058), # for new soil only
  "rs2.swq | change = absval" = c(0.5, 0.75), # different for new WQ
  "bc4.swq | change = absval" = c(0.2, 0.42),
  "srpm2_swq.swq | change = absval" = c(0.032, 0.055), # for new WQ only
  "adkeq_swq.swq | change = absval" = c(0.4, 0.75),  # for new WQ only
  "dox_half.swq | change = absval" = c(3.5, 6.5),  # for new WQ only
  "mumax.swq | change = absval" = c(1.7, 2.2),
  "rhoq.swq | change = absval" = c(0.3, 0.5))


n_sample <- 2000
n_par <- ncol(par_bound_super)

par_super <- randomLHS(n = n_sample, k = n_par) %>%
  as_tibble(.) %>%
  map2_df(., par_bound_super, ~ (.x * (.y[2] - .y[1]) + .y[1])) %>%
  set_names(names(par_bound_super))

super_iter <- run_swatplus(project_path,
                          output = list(q_out = define_output(file = "channel",
                                                              variable = "flo_out",
                                                              unit = c(6,14,23,24,25,26)),
                                        tile_flow = define_output(file = "basin_wb",
                                                                  variable = "qtile",
                                                                  unit = 1),
                                        lat_flow = define_output(file = "basin_wb",
                                                                 variable = "latq",
                                                                 unit = 1),
                                        surf_flow = define_output(file = "basin_wb",
                                                                  variable = "surq_gen",
                                                                  unit = 1),
                                        total_flow = define_output(file = "basin_wb",
                                                                   variable = "wateryld",
                                                                   unit = 1),
                                        sed_out = define_output(file = "channel",
                                                                variable = "sed_out",
                                                                unit = c(14,23,24,25,26)),
                                        tss_out = define_output(file = "channel",
                                                                variable = "tot_ssed",
                                                                unit = c(14,23,24,25,26)),
                                        res_sed_stor = define_output(file = "reservoir",
                                                                     variable = "sed_stor",
                                                                     unit = 1),
                                        res_flo_stor = define_output(file = "reservoir",
                                                                     variable = "flo_stor",
                                                                     unit = 1),
                                        orgp_out = define_output(file = "channel",
                                                                 variable = "orgp_out",
                                                                 unit = c(14,23,24,25,26)),
                                        minpa_out = define_output(file = "channel",
                                                                  variable = "minpa_out",
                                                                  unit = c(14,23,24,25,26)),
                                        minps_out = define_output(file = "channel",
                                                                  variable = "minps_out",
                                                                  unit = c(14,23,24,25,26)),
                                        solp_out = define_output(file = "channel",
                                                                 variable = "solp_out",
                                                                 unit = c(14,23,24,25,26)),
                                        res_orgp_stor = define_output(file = "reservoir",
                                                                      variable = "orgp_stor",
                                                                      unit = 1),
                                        res_minpa_stor = define_output(file = "reservoir",
                                                                       variable = "minpa_stor",
                                                                       unit = 1),
                                        res_minps_stor = define_output(file = "reservoir",
                                                                       variable = "minps_stor",
                                                                       unit = 1),
                                        res_solp_stor = define_output(file = "reservoir",
                                                                      variable = "solp_stor",
                                                                      unit = 1)),
                          parameter = par_super,
                          start_date = "2001-01-01",
                          end_date = "2020-12-31",
                          years_skip = 2,
                          n_thread = 9)
save.image(file = "SuperCal_test.Rdata")
