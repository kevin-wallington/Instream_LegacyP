library(SWATplusR)
library(lhs)
library(hydroGOF)
library(dplyr)
library(lubridate)
library(tidyr)
library(purrr)
library(ggplot2)
library(hydroTSM)
library(stringr)
library(car)
library(twosamples)

project_path <- "C:/Users/kevin/Documents/INFEWS/SWAT+R/TxtInOut_FinalEval"

#Main
par_bound_super <- tibble("bed_kd5.rte | change = absval" = c(0.001, 0.7),
                          "tc_bed5.rte | change = absval" = c(3.0, 6.0))
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
save.image(file = "FullEval_5.Rdata")

#Flow
obs_flow <- read.csv('../Observations/DailyFlow_KDW.csv')
obs_flow_cal <- filter(obs_flow, Date >= ymd("2003-01-01"), Date <= ymd("2014-12-31"))
obs_flow_val <- filter(obs_flow, Date >= ymd("2015-01-01"), Date <= ymd("2020-12-31")) 
obs_flow_cvm <- filter(obs_flow, Date >= ymd("2009-01-01"), Date <= ymd("2010-12-31"))

#Phosphorus
obs_phos <- read.csv('../Observations/DailyTP_withremovals_KDW.csv') 
obs_phos_cal <- filter(obs_phos, Date >= ymd("2013-01-01"), Date <= ymd("2018-12-31"))
obs_phos_val <- filter(obs_phos, Date >= ymd("2019-01-01"), Date <= ymd("2020-12-31")) 
obs_solphos <- read.csv('../Observations/DailySRP_withremovals_KDW.csv')
obs_solphos_cal <- filter(obs_solphos, Date >= ymd("2013-01-01"), Date <= ymd("2018-12-31"))
obs_solphos_val <- filter(obs_solphos, Date >= ymd("2019-01-01"), Date <= ymd("2020-12-31")) 

#Sediment
obs_sed <- read.csv('../Observations/DailySed_KDW.csv') 
obs_sed_cal <- filter(obs_sed, Date >= ymd("2003-01-01"), Date <= ymd("2014-12-31"))
obs_sed_val <- filter(obs_sed, Date >= ymd("2015-01-01"), Date <= ymd("2020-12-31"))
obs_sed_cvm <- filter(obs_sed, Date >= ymd("2008-01-01"), Date <= ymd("2014-12-31"))

#Sink/Source
obs_source <- read.csv('../Observations/SinkSource_withFlowFilters.csv') 
obs_source_oldcal <- filter(obs_source, Date >= ymd("2003-01-01"), Date <= ymd("2014-12-31"))
obs_source_cvm <- filter(obs_source, Date >= ymd("2007-01-01"), Date <= ymd("2014-12-31"))
obs_source_13to20 <- filter(obs_source, Date >= ymd("2013-01-01"), Date <= ymd("2020-12-31"))
obs_source_cal <- filter(obs_source, Date >= ymd("2013-01-01"), Date <= ymd("2018-12-31"))
obs_source_val <- filter(obs_source, Date >= ymd("2019-01-01"), Date <= ymd("2020-12-31"))

#Data on 10/03/2013 at Wyckle's can't be right...
obs_phos_cal$Wyckles[276] <- NA
obs_phos_cal$Wyckles_10[276] <- NA
obs_phos_cal$Wyckles_30[276] <- NA
obs_source_cal$P.source[276] <- NA
obs_source_cal$P.source.10[276] <- NA
obs_source_cal$P.source.30[276] <- NA
obs_source_13to20$P.source[276] <- NA
obs_source_13to20$P.source.10[276] <- NA
obs_source_13to20$P.source.30[276] <- NA

#All runs
num_analyze <- n_sample
last <- 1 + n_sample
values <- super_iter$parameter$values[1:num_analyze,]

#Flow
flow_cal_6 <- filter(super_iter$simulation$q_out_6, date >= ymd("2003-01-01"), date <= ymd("2014-12-31"))
flow_cal_14 <- filter(super_iter$simulation$q_out_14, date >= ymd("2003-01-01"), date <= ymd("2014-12-31"))
flow_cal_25 <- filter(super_iter$simulation$q_out_25, date >= ymd("2003-01-01"), date <= ymd("2014-12-31"))
flow_val_6 <- filter(super_iter$simulation$q_out_6, date >= ymd("2015-01-01"), date <= ymd("2020-12-31"))
flow_val_14 <- filter(super_iter$simulation$q_out_14, date >= ymd("2015-01-01"), date <= ymd("2020-12-31"))
flow_val_25 <- filter(super_iter$simulation$q_out_25, date >= ymd("2015-01-01"), date <= ymd("2020-12-31"))
flow_cvm_6 <- filter(super_iter$simulation$q_out_6, date >= ymd("2009-01-01"), date <= ymd("2010-12-31"))
flow_cvm_14 <- filter(super_iter$simulation$q_out_14, date >= ymd("2009-01-01"), date <= ymd("2010-12-31"))
flow_cvm_25 <- filter(super_iter$simulation$q_out_25, date >= ymd("2009-01-01"), date <= ymd("2010-12-31"))

#Sediment
super_iter$simulation$sed_resconc <- super_iter$simulation$res_sed_stor
super_iter$simulation$sed_resconc[,2:last] <- 1000000 * super_iter$simulation$res_sed_stor[,2:last]/ super_iter$simulation$res_flo_stor[,2:last]
sed_cal_14 <- filter(super_iter$simulation$sed_out_14, date >= ymd("2003-01-01"), date <= ymd("2014-12-31"))
sed_cal_26 <- filter(super_iter$simulation$sed_out_26, date >= ymd("2003-01-01"), date <= ymd("2014-12-31"))
tss_cal_23 <- filter(super_iter$simulation$tss_out_23, date >= ymd("2003-01-01"), date <= ymd("2014-12-31"))
tss_cal_26 <- filter(super_iter$simulation$tss_out_26, date >= ymd("2003-01-01"), date <= ymd("2014-12-31"))
tss_cal_25 <- filter(super_iter$simulation$tss_out_25, date >= ymd("2003-01-01"), date <= ymd("2014-12-31"))
sed_val_14 <- filter(super_iter$simulation$sed_out_14, date >= ymd("2015-01-01"), date <= ymd("2020-12-31"))
sed_val_26 <- filter(super_iter$simulation$sed_out_26, date >= ymd("2015-01-01"), date <= ymd("2020-12-31"))
tss_val_23 <- filter(super_iter$simulation$tss_out_23, date >= ymd("2015-01-01"), date <= ymd("2020-12-31"))
tss_val_26 <- filter(super_iter$simulation$tss_out_26, date >= ymd("2015-01-01"), date <= ymd("2020-12-31"))
tss_val_25 <- filter(super_iter$simulation$tss_out_25, date >= ymd("2015-01-01"), date <= ymd("2020-12-31"))
tss_val_24 <- filter(super_iter$simulation$tss_out_24, date >= ymd("2015-01-01"), date <= ymd("2020-12-31"))
sed_cvm_14 <- filter(super_iter$simulation$sed_out_14, date >= ymd("2008-01-01"), date <= ymd("2014-12-31"))
sed_cvm_26 <- filter(super_iter$simulation$sed_out_26, date >= ymd("2008-01-01"), date <= ymd("2014-12-31"))
tss_cvm_23 <- filter(super_iter$simulation$tss_out_23, date >= ymd("2008-01-01"), date <= ymd("2014-12-31"))
tss_cvm_26 <- filter(super_iter$simulation$tss_out_26, date >= ymd("2008-01-01"), date <= ymd("2014-12-31"))
tss_cvm_25 <- filter(super_iter$simulation$tss_out_25, date >= ymd("2008-01-01"), date <= ymd("2014-12-31"))
sed_cal_resconc <- filter(super_iter$simulation$sed_resconc, date >= ymd("2003-01-01"), date <= ymd("2014-12-31"))
sed_val_resconc <- filter(super_iter$simulation$sed_resconc, date >= ymd("2015-01-01"), date <= ymd("2020-12-31"))
sed_cvm_resconc <- filter(super_iter$simulation$sed_resconc, date >= ymd("2008-01-01"), date <= ymd("2014-12-31"))

sim_sed_source <- super_iter$simulation$tss_out_26[,1:(num_analyze+1)]
sim_sed_source[,2:(num_analyze+1)] <- sim_sed_source[,2:(num_analyze+1)] - super_iter$simulation$tss_out_25[,2:(num_analyze+1)] -
  super_iter$simulation$tss_out_23[,2:(num_analyze+1)]
for(run in 1:num_analyze)
{
  sim_sed_source[,(run+1)] = sim_sed_source[,(run+1)] - obs_source$Sed.load.SDD..tons.
}
sed_source_cal <- filter(sim_sed_source[,1:(num_analyze+1)], date >= ymd("2003-01-01"), date <= ymd("2014-12-31"))
sed_source_val <- filter(sim_sed_source[,1:(num_analyze+1)], date >= ymd("2015-01-01"), date <= ymd("2020-12-31"))
sed_source_cvm <- filter(sim_sed_source[,1:(num_analyze+1)], date >= ymd("2007-01-01"), date <= ymd("2014-12-31"))

#Phosphorus
super_iter$simulation$totalP_14 <- super_iter$simulation$orgp_out_14
super_iter$simulation$totalP_14[,2:last] <- super_iter$simulation$orgp_out_14[,2:last] +
  super_iter$simulation$minpa_out_14[,2:last] + super_iter$simulation$minps_out_14[,2:last] +
  super_iter$simulation$solp_out_14[,2:last]
super_iter$simulation$totalP_26 <- super_iter$simulation$orgp_out_26
super_iter$simulation$totalP_26[,2:last] <- super_iter$simulation$orgp_out_26[,2:last] +
  super_iter$simulation$minpa_out_26[,2:last] + super_iter$simulation$minps_out_26[,2:last] +
  super_iter$simulation$solp_out_26[,2:last]
super_iter$simulation$totalP_23 <- super_iter$simulation$orgp_out_23
super_iter$simulation$totalP_23[,2:last] <- super_iter$simulation$orgp_out_23[,2:last] +
  super_iter$simulation$minpa_out_23[,2:last] + super_iter$simulation$minps_out_23[,2:last] +
  super_iter$simulation$solp_out_23[,2:last]
super_iter$simulation$totalP_24 <- super_iter$simulation$orgp_out_24
super_iter$simulation$totalP_24[,2:last] <- super_iter$simulation$orgp_out_24[,2:last] +
  super_iter$simulation$minpa_out_24[,2:last] + super_iter$simulation$minps_out_24[,2:last] +
  super_iter$simulation$solp_out_24[,2:last]
super_iter$simulation$totalP_25 <- super_iter$simulation$orgp_out_25
super_iter$simulation$totalP_25[,2:last] <- super_iter$simulation$orgp_out_25[,2:last] +
  super_iter$simulation$minpa_out_25[,2:last] + super_iter$simulation$minps_out_25[,2:last] +
  super_iter$simulation$solp_out_25[,2:last]
super_iter$simulation$totalP_resconc <- super_iter$simulation$res_orgp_stor
super_iter$simulation$totalP_resconc[,2:last] <- 1000 * (super_iter$simulation$res_orgp_stor[,2:last] +
                                                           super_iter$simulation$res_minpa_stor[,2:last] + super_iter$simulation$res_minps_stor[,2:last] +
                                                           super_iter$simulation$res_solp_stor[,2:last]) / super_iter$simulation$res_flo_stor[,2:last]
super_iter$simulation$solP_resconc <- super_iter$simulation$res_solp_stor
super_iter$simulation$solP_resconc[,2:last] <- 1000 * super_iter$simulation$res_solp_stor[,2:last] / super_iter$simulation$res_flo_stor[,2:last]

sim_phos_source <- super_iter$simulation$totalP_26[,1:(num_analyze+1)]
sim_phos_source[,2:(num_analyze+1)] <- sim_phos_source[,2:(num_analyze+1)] - super_iter$simulation$totalP_25[,2:(num_analyze+1)] -
  super_iter$simulation$totalP_23[,2:(num_analyze+1)]
for(run in 1:num_analyze)
{
  sim_phos_source[,(run+1)] = sim_phos_source[,(run+1)] - obs_source$P.load.SDD..kg.
}

#total P
phos_cal_14 <- filter(super_iter$simulation$totalP_14[,1:(num_analyze+1)], date >= ymd("2013-01-01"), date <= ymd("2018-12-31"))
phos_cal_26 <- filter(super_iter$simulation$totalP_26[,1:(num_analyze+1)], date >= ymd("2013-01-01"), date <= ymd("2018-12-31"))
phos_cal_23 <- filter(super_iter$simulation$totalP_23[,1:(num_analyze+1)], date >= ymd("2013-01-01"), date <= ymd("2018-12-31"))
phos_cal_24 <- filter(super_iter$simulation$totalP_24[,1:(num_analyze+1)], date >= ymd("2013-01-01"), date <= ymd("2018-12-31"))
phos_cal_25 <- filter(super_iter$simulation$totalP_25[,1:(num_analyze+1)], date >= ymd("2013-01-01"), date <= ymd("2018-12-31"))
phos_cal_resconc <- filter(super_iter$simulation$totalP_resconc[,1:(num_analyze+1)], date >= ymd("2013-01-01"), date <= ymd("2018-12-31"))
phos_val_14 <- filter(super_iter$simulation$totalP_14[,1:(num_analyze+1)], date >= ymd("2019-01-01"), date <= ymd("2020-12-31")) 
phos_val_26 <- filter(super_iter$simulation$totalP_26[,1:(num_analyze+1)], date >= ymd("2019-01-01"), date <= ymd("2020-12-31")) 
phos_val_23 <- filter(super_iter$simulation$totalP_23[,1:(num_analyze+1)], date >= ymd("2019-01-01"), date <= ymd("2020-12-31"))
phos_val_24 <- filter(super_iter$simulation$totalP_24[,1:(num_analyze+1)], date >= ymd("2019-01-01"), date <= ymd("2020-12-31")) 
phos_val_25 <- filter(super_iter$simulation$totalP_25[,1:(num_analyze+1)], date >= ymd("2019-01-01"), date <= ymd("2020-12-31")) 
phos_val_resconc <-filter(super_iter$simulation$totalP_resconc[,1:(num_analyze+1)], date >= ymd("2019-01-01"), date <= ymd("2020-12-31")) 

#dissolved P
solphos_cal_14 <- filter(super_iter$simulation$solp_out_14[,1:(num_analyze+1)], date >= ymd("2013-01-01"), date <= ymd("2018-12-31"))
solphos_cal_resconc <- filter(super_iter$simulation$solP_resconc[,1:(num_analyze+1)], date >= ymd("2013-01-01"), date <= ymd("2018-12-31"))
solphos_val_14 <- filter(super_iter$simulation$solp_out_14[,1:(num_analyze+1)], date >= ymd("2019-01-01"), date <= ymd("2020-12-31")) 
solphos_val_resconc <- filter(super_iter$simulation$solP_resconc[,1:(num_analyze+1)], date >= ymd("2019-01-01"), date <= ymd("2020-12-31")) 

#Source/sink
phos_source_13to20 <- filter(sim_phos_source[,1:(num_analyze+1)], date >= ymd("2013-01-01"), date <= ymd("2020-12-31"))
phos_source_cal <- filter(sim_phos_source[,1:(num_analyze+1)], date >= ymd("2013-01-01"), date <= ymd("2018-12-31")) 
phos_source_val <- filter(sim_phos_source[,1:(num_analyze+1)], date >= ymd("2019-01-01"), date <= ymd("2020-12-31")) 


###Flow###
###NSE###
nse_flow_6 <- flow_cal_6 %>%
  select(-date) %>%
  map_dbl(., ~NSE(.x, obs_flow_cal$Fisher))
nse_flow_14 <- flow_cal_14 %>%
  select(-date) %>%
  map_dbl(., ~NSE(.x, obs_flow_cal$Monticello))
nse_flow_25 <- flow_cal_25 %>%
  select(-date) %>%
  map_dbl(., ~NSE(.x, obs_flow_cal$Decatur))
###mNSE###
mnse_flow_6 <- flow_cal_6 %>%
  select(-date) %>%
  map_dbl(., ~mNSE(.x, obs_flow_cal$Fisher, j=1))
mnse_flow_14 <- flow_cal_14 %>%
  select(-date) %>%
  map_dbl(., ~mNSE(.x, obs_flow_cal$Monticello, j=1))
mnse_flow_25 <- flow_cal_25 %>%
  select(-date) %>%
  map_dbl(., ~mNSE(.x, obs_flow_cal$Decatur, j=1))
###PBIAS###
pbias_flow_6 <- flow_cal_6 %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, obs_flow_cal$Fisher))
pbias_flow_14 <- flow_cal_14 %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, obs_flow_cal$Monticello))
pbias_flow_25 <- flow_cal_25 %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, obs_flow_cal$Decatur))
###Tile flow###
tile_flow <- super_iter$simulation$tile_flow[ , -c(1)]
lat_flow <- super_iter$simulation$lat_flow[ , -c(1)]
surf_flow <- super_iter$simulation$surf_flow[ , -c(1)]
total_flow <- super_iter$simulation$total_flow[ , -c(1)]
pct_tile <- colSums(tile_flow[1:5844,]) / colSums(total_flow[1:5844,])
pct_lat <- colSums(lat_flow[1:5844,]) / colSums(total_flow[1:5844,])
pct_surf <- colSums(surf_flow[1:5844,]) / colSums(total_flow[1:5844,])

###Sediment###
obs_sed_val_Wyckles <- obs_sed_val$Wyckles
obs_sed_val_Wyckles[1877]<-NA
obs_sed_val_Wyckles[1583]<-NA
obs_sed_val_Wyckles[1569]<-NA
obs_sed_val_Wyckles[1499]<-NA
obs_sed_val_Wyckles[1156]<-NA
###NSE###
nse_sed_14 <- sed_cal_14 %>%
  select(-date) %>%
  map_dbl(., ~NSE(.x, obs_sed_cal$Monticello)) 
nse_sed_23 <- tss_cal_23 %>%
  select(-date) %>%
  map_dbl(., ~NSE(.x, obs_sed_cal$Stevens_Creek))
nse_sed_25 <- tss_cal_25 %>%
  select(-date) %>%
  map_dbl(., ~NSE(.x, obs_sed_cal$Decatur_SDD))
nse_sed_26 <- tss_cal_26 %>%
  select(-date) %>%
  map_dbl(., ~NSE(.x, obs_sed_cal$Wyckles))
nse_sed_res <- sed_cal_resconc %>%
  select(-date) %>%
  map_dbl(., ~NSE(.x, obs_sed_cal$Decatur_conc))
nse_sedsrc <- sed_source_cal %>%
  select(-date) %>%
  map_dbl(., ~NSE(.x, obs_source_oldcal$Sed.source))
###mNSE###
mnse_sed_14 <- sed_cal_14 %>%
  select(-date) %>%
  map_dbl(., ~mNSE(.x, obs_sed_cal$Monticello, j=1)) 
mnse_sed_23 <- tss_cal_23 %>%
  select(-date) %>%
  map_dbl(., ~mNSE(.x, obs_sed_cal$Stevens_Creek, j=1)) 
mnse_sed_25 <- tss_cal_25 %>%
  select(-date) %>%
  map_dbl(., ~mNSE(.x, obs_sed_cal$Decatur_SDD, j=1)) 
mnse_sed_26 <- tss_cal_26 %>%
  select(-date) %>%
  map_dbl(., ~mNSE(.x, obs_sed_cal$Wyckles, j=1)) 
mnse_sed_res <- sed_cal_resconc %>%
  select(-date) %>%
  map_dbl(., ~mNSE(.x, obs_sed_cal$Decatur_conc, j=1)) 
mnse_sedsrc <- sed_source_cal %>%
  select(-date) %>%
  map_dbl(., ~mNSE(.x, obs_source_oldcal$Sed.source, j=1))
###PBIAS###
pbias_sed_14 <- sed_cal_14 %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, obs_sed_cal$Monticello))
pbias_sed_23 <- tss_cal_23 %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, obs_sed_cal$Stevens_Creek))
pbias_sed_25 <- tss_cal_25 %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, obs_sed_cal$Decatur_SDD))
pbias_sed_26 <- tss_cal_26 %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, obs_sed_cal$Wyckles))
pbias_sed_res <- sed_cal_resconc %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, obs_sed_cal$Decatur_conc))
pbias_sedsrc <- sed_source_cal %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, obs_source_oldcal$Sed.source))

###Phosphorus###
###NSE###
nse_phos_14 <- phos_cal_14 %>%
  select(-date) %>%
  map_dbl(., ~NSE(.x, obs_phos_cal$Monticello)) 
nse_phos_23 <- phos_cal_23 %>%
  select(-date) %>%
  map_dbl(., ~NSE(.x, obs_phos_cal$StvCrk)) 
nse_phos_25 <- phos_cal_25 %>%
  select(-date) %>%
  map_dbl(., ~NSE(.x, obs_phos_cal$Dec_SDD)) 
nse_phos_26 <- phos_cal_26 %>%
  select(-date) %>%
  map_dbl(., ~NSE(.x, obs_phos_cal$Wyckles_30))
nse_phos_resconc <- phos_cal_resconc %>%
  select(-date) %>%
  map_dbl(., ~NSE(.x, obs_phos_cal$Dec_IEPA_conc))
nse_phossrc <- phos_source_13to20 %>%
  select(-date) %>%
  map_dbl(., ~NSE(.x, obs_source_13to20$P.source.30))
###mNSE###
mnse_phos_14 <- phos_cal_14 %>%
  select(-date) %>%
  map_dbl(., ~mNSE(.x, obs_phos_cal$Monticello, j=1)) 
mnse_phos_23 <- phos_cal_23 %>%
  select(-date) %>%
  map_dbl(., ~mNSE(.x, obs_phos_cal$StvCrk, j=1)) 
mnse_phos_25 <- phos_cal_25 %>%
  select(-date) %>%
  map_dbl(., ~mNSE(.x, obs_phos_cal$Dec_SDD, j=1)) 
mnse_phos_26 <- phos_cal_26 %>%
  select(-date) %>%
  map_dbl(., ~mNSE(.x, obs_phos_cal$Wyckles_30, j=1)) 
mnse_phos_resconc <- phos_cal_resconc %>%
  select(-date) %>%
  map_dbl(., ~mNSE(.x, obs_phos_cal$Dec_IEPA_conc, j=1)) 
mnse_phossrc <- phos_source_13to20 %>%
  select(-date) %>%
  map_dbl(., ~mNSE(.x, obs_source_13to20$P.source.30))
### PBIAS ###
pbias_phos_14 <- phos_cal_14 %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, obs_phos_cal$Monticello))#
pbias_phos_23 <- phos_cal_23 %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, obs_phos_cal$StvCrk)) #
pbias_phos_25 <- phos_cal_25 %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, obs_phos_cal$Dec_SDD)) #
pbias_phos_26 <- phos_cal_26 %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, obs_phos_cal$Wyckles))#
pbias_phos_resconc <- phos_cal_resconc %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, obs_phos_cal$Dec_IEPA_conc))
pbias_phossrc <- phos_source_13to20 %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, obs_source_13to20$P.source))

Cramer_flow_6 <- as.vector(matrix(0,nrow=num_analyze)) # flow_cvm_6, obs_flow_cvm$Fisher
Cramer_flow_14 <- as.vector(matrix(0,nrow=num_analyze)) # flow_cvm_14, obs_flow_cvm$Monticello
Cramer_flow_25 <- as.vector(matrix(0,nrow=num_analyze)) # flow_cvm_25, obs_flow_cvm$Decatur
Cramer_sed_14 <- as.vector(matrix(0,nrow=num_analyze)) # sed_cvm_14, obs_sed_cvm$Monticello
Cramer_sed_23 <- as.vector(matrix(0,nrow=num_analyze)) # tss_cvm_23, obs_sed_cvm$Stevens_Creek
Cramer_sed_25 <- as.vector(matrix(0,nrow=num_analyze)) # tss_cvm_25, obs_sed_cvm$Decatur_SDD
Cramer_sed_26 <- as.vector(matrix(0,nrow=num_analyze)) # tss_cvm_26, obs_sed_cvm$Wyckles
Cramer_phos_23 <- as.vector(matrix(0,nrow=num_analyze)) # phos_cal_23, obs_phos_cal$StvCrk
Cramer_phos_25 <- as.vector(matrix(0,nrow=num_analyze)) # phos_cal_25, obs_phos_cal$Dec_SDD
Cramer_phos_26 <- as.vector(matrix(0,nrow=num_analyze)) # phos_cal_26, obs_phos_cal$Wyckles
Cramer_sedsrc <- as.vector(matrix(0,nrow=num_analyze)) # sed_source_cvm, obs_source_cvm$Sed.source
Cramer_phossrc <- as.vector(matrix(0,nrow=num_analyze)) # phos_source_13to20, obs_source_13to20$P.source
###Edit lines according to each variable###
for(run in 1:(num_analyze))  
{
  sim <- as.numeric(unlist(flow_cvm_6[,run+1])) ###Edit###
  obs <- obs_flow_cvm$Fisher[!is.na(obs_flow_cvm$Fisher)] ###Edit###
  N <- length (sim)
  M <- length(obs)
  full_set <- c(sim, obs)
  ### Cramer-von Mises test ###
  sorted_set <- sort(full_set, decreasing = FALSE, index.return = TRUE)
  sim_ranks <- c()
  obs_ranks <- c()
  for (ii in 1:(N+M))
  {
    if(sorted_set$ix[ii] < (N+1)) {
      sim_ranks <- c(sim_ranks, ii)
    } else {
      obs_ranks <- c(obs_ranks, ii)
    }
  }
  U1 <- 0
  for(ii in 1:N)
  {
    U1 <- U1 + (sim_ranks[ii]-ii)^2
  }
  U1 <- U1 * N
  U2 <- 0
  for(ii in 1:M)
  {
    U2 <- U2 + (obs_ranks[ii]-ii)^2
  }
  U2 <- U2 * M
  U <- U1 + U2
  T <- U/(N*M*(N+M)) - (4*M*N-1)/(6*(M+N))
  Cramer_flow_6[run] <- T ###Edit###
}

for(run in 1:(num_analyze))  
{
  sim <- as.numeric(unlist(flow_cvm_14[,run+1])) 
  obs <- obs_flow_cvm$Monticello[!is.na(obs_flow_cvm$Monticello)] 
  N <- length (sim)
  M <- length(obs)
  full_set <- c(sim, obs)
  ### Cramer-von Mises test ###
  sorted_set <- sort(full_set, decreasing = FALSE, index.return = TRUE)
  sim_ranks <- c()
  obs_ranks <- c()
  for (ii in 1:(N+M))
  {
    if(sorted_set$ix[ii] < (N+1)) {
      sim_ranks <- c(sim_ranks, ii)
    } else {
      obs_ranks <- c(obs_ranks, ii)
    }
  }
  U1 <- 0
  for(ii in 1:N)
  {
    U1 <- U1 + (sim_ranks[ii]-ii)^2
  }
  U1 <- U1 * N
  U2 <- 0
  for(ii in 1:M)
  {
    U2 <- U2 + (obs_ranks[ii]-ii)^2
  }
  U2 <- U2 * M
  U <- U1 + U2
  T <- U/(N*M*(N+M)) - (4*M*N-1)/(6*(M+N))
  Cramer_flow_14[run] <- T 
}

for(run in 1:(num_analyze))  
{
  sim <- as.numeric(unlist(flow_cvm_25[,run+1])) 
  obs <-  obs_flow_cvm$Decatur[!is.na( obs_flow_cvm$Decatur)] 
  N <- length (sim)
  M <- length(obs)
  full_set <- c(sim, obs)
  ### Cramer-von Mises test ###
  sorted_set <- sort(full_set, decreasing = FALSE, index.return = TRUE)
  sim_ranks <- c()
  obs_ranks <- c()
  for (ii in 1:(N+M))
  {
    if(sorted_set$ix[ii] < (N+1)) {
      sim_ranks <- c(sim_ranks, ii)
    } else {
      obs_ranks <- c(obs_ranks, ii)
    }
  }
  U1 <- 0
  for(ii in 1:N)
  {
    U1 <- U1 + (sim_ranks[ii]-ii)^2
  }
  U1 <- U1 * N
  U2 <- 0
  for(ii in 1:M)
  {
    U2 <- U2 + (obs_ranks[ii]-ii)^2
  }
  U2 <- U2 * M
  U <- U1 + U2
  T <- U/(N*M*(N+M)) - (4*M*N-1)/(6*(M+N))
  Cramer_flow_25[run] <- T 
}

for(run in 1:(num_analyze))  
{
  sim <- as.numeric(unlist(sed_cvm_14[,run+1])) 
  obs <- obs_sed_cvm$Monticello[!is.na(obs_sed_cvm$Monticello)] 
  N <- length (sim)
  M <- length(obs)
  full_set <- c(sim, obs)
  ### Cramer-von Mises test ###
  sorted_set <- sort(full_set, decreasing = FALSE, index.return = TRUE)
  sim_ranks <- c()
  obs_ranks <- c()
  for (ii in 1:(N+M))
  {
    if(sorted_set$ix[ii] < (N+1)) {
      sim_ranks <- c(sim_ranks, ii)
    } else {
      obs_ranks <- c(obs_ranks, ii)
    }
  }
  U1 <- 0
  for(ii in 1:N)
  {
    U1 <- U1 + (sim_ranks[ii]-ii)^2
  }
  U1 <- U1 * N
  U2 <- 0
  for(ii in 1:M)
  {
    U2 <- U2 + (obs_ranks[ii]-ii)^2
  }
  U2 <- U2 * M
  U <- U1 + U2
  T <- U/(N*M*(N+M)) - (4*M*N-1)/(6*(M+N))
  Cramer_sed_14[run] <- T 
}

for(run in 1:(num_analyze))  
{
  sim <- as.numeric(unlist(tss_cvm_23[,run+1])) 
  obs <- obs_sed_cvm$Stevens_Creek[!is.na(obs_sed_cvm$Stevens_Creek)] 
  N <- length (sim)
  M <- length(obs)
  full_set <- c(sim, obs)
  ### Cramer-von Mises test ###
  sorted_set <- sort(full_set, decreasing = FALSE, index.return = TRUE)
  sim_ranks <- c()
  obs_ranks <- c()
  for (ii in 1:(N+M))
  {
    if(sorted_set$ix[ii] < (N+1)) {
      sim_ranks <- c(sim_ranks, ii)
    } else {
      obs_ranks <- c(obs_ranks, ii)
    }
  }
  U1 <- 0
  for(ii in 1:N)
  {
    U1 <- U1 + (sim_ranks[ii]-ii)^2
  }
  U1 <- U1 * N
  U2 <- 0
  for(ii in 1:M)
  {
    U2 <- U2 + (obs_ranks[ii]-ii)^2
  }
  U2 <- U2 * M
  U <- U1 + U2
  T <- U/(N*M*(N+M)) - (4*M*N-1)/(6*(M+N))
  Cramer_sed_23[run] <- T 
}

for(run in 1:(num_analyze))  
{
  sim <- as.numeric(unlist(tss_cvm_25[,run+1])) 
  obs <- obs_sed_cvm$Decatur_SDD[!is.na(obs_sed_cvm$Decatur_SDD)] 
  N <- length (sim)
  M <- length(obs)
  full_set <- c(sim, obs)
  ### Cramer-von Mises test ###
  sorted_set <- sort(full_set, decreasing = FALSE, index.return = TRUE)
  sim_ranks <- c()
  obs_ranks <- c()
  for (ii in 1:(N+M))
  {
    if(sorted_set$ix[ii] < (N+1)) {
      sim_ranks <- c(sim_ranks, ii)
    } else {
      obs_ranks <- c(obs_ranks, ii)
    }
  }
  U1 <- 0
  for(ii in 1:N)
  {
    U1 <- U1 + (sim_ranks[ii]-ii)^2
  }
  U1 <- U1 * N
  U2 <- 0
  for(ii in 1:M)
  {
    U2 <- U2 + (obs_ranks[ii]-ii)^2
  }
  U2 <- U2 * M
  U <- U1 + U2
  T <- U/(N*M*(N+M)) - (4*M*N-1)/(6*(M+N))
  Cramer_sed_25[run] <- T 
}

for(run in 1:(num_analyze))  
{
  sim <- as.numeric(unlist(tss_cvm_26[,run+1])) 
  obs <- obs_sed_cvm$Wyckles[!is.na(obs_sed_cvm$Wyckles)] 
  N <- length (sim)
  M <- length(obs)
  full_set <- c(sim, obs)
  ### Cramer-von Mises test ###
  sorted_set <- sort(full_set, decreasing = FALSE, index.return = TRUE)
  sim_ranks <- c()
  obs_ranks <- c()
  for (ii in 1:(N+M))
  {
    if(sorted_set$ix[ii] < (N+1)) {
      sim_ranks <- c(sim_ranks, ii)
    } else {
      obs_ranks <- c(obs_ranks, ii)
    }
  }
  U1 <- 0
  for(ii in 1:N)
  {
    U1 <- U1 + (sim_ranks[ii]-ii)^2
  }
  U1 <- U1 * N
  U2 <- 0
  for(ii in 1:M)
  {
    U2 <- U2 + (obs_ranks[ii]-ii)^2
  }
  U2 <- U2 * M
  U <- U1 + U2
  T <- U/(N*M*(N+M)) - (4*M*N-1)/(6*(M+N))
  Cramer_sed_26[run] <- T 
}

for(run in 1:(num_analyze))  
{
  sim <- as.numeric(unlist(phos_cal_23[,run+1])) 
  obs <- obs_phos_cal$StvCrk[!is.na(obs_phos_cal$StvCrk)] 
  N <- length (sim)
  M <- length(obs)
  full_set <- c(sim, obs)
  ### Cramer-von Mises test ###
  sorted_set <- sort(full_set, decreasing = FALSE, index.return = TRUE)
  sim_ranks <- c()
  obs_ranks <- c()
  for (ii in 1:(N+M))
  {
    if(sorted_set$ix[ii] < (N+1)) {
      sim_ranks <- c(sim_ranks, ii)
    } else {
      obs_ranks <- c(obs_ranks, ii)
    }
  }
  U1 <- 0
  for(ii in 1:N)
  {
    U1 <- U1 + (sim_ranks[ii]-ii)^2
  }
  U1 <- U1 * N
  U2 <- 0
  for(ii in 1:M)
  {
    U2 <- U2 + (obs_ranks[ii]-ii)^2
  }
  U2 <- U2 * M
  U <- U1 + U2
  T <- U/(N*M*(N+M)) - (4*M*N-1)/(6*(M+N))
  Cramer_phos_23[run] <- T 
}

for(run in 1:(num_analyze))  
{
  sim <- as.numeric(unlist(phos_cal_25[,run+1])) 
  obs <- obs_phos_cal$Dec_SDD[!is.na(obs_phos_cal$Dec_SDD)] 
  N <- length (sim)
  M <- length(obs)
  full_set <- c(sim, obs)
  ### Cramer-von Mises test ###
  sorted_set <- sort(full_set, decreasing = FALSE, index.return = TRUE)
  sim_ranks <- c()
  obs_ranks <- c()
  for (ii in 1:(N+M))
  {
    if(sorted_set$ix[ii] < (N+1)) {
      sim_ranks <- c(sim_ranks, ii)
    } else {
      obs_ranks <- c(obs_ranks, ii)
    }
  }
  U1 <- 0
  for(ii in 1:N)
  {
    U1 <- U1 + (sim_ranks[ii]-ii)^2
  }
  U1 <- U1 * N
  U2 <- 0
  for(ii in 1:M)
  {
    U2 <- U2 + (obs_ranks[ii]-ii)^2
  }
  U2 <- U2 * M
  U <- U1 + U2
  T <- U/(N*M*(N+M)) - (4*M*N-1)/(6*(M+N))
  Cramer_phos_25[run] <- T 
}

for(run in 1:(num_analyze))  
{
  sim <- as.numeric(unlist(phos_cal_26[,run+1])) 
  obs <- obs_phos_cal$Wyckles[!is.na(obs_phos_cal$Wyckles)] 
  N <- length (sim)
  M <- length(obs)
  full_set <- c(sim, obs)
  ### Cramer-von Mises test ###
  sorted_set <- sort(full_set, decreasing = FALSE, index.return = TRUE)
  sim_ranks <- c()
  obs_ranks <- c()
  for (ii in 1:(N+M))
  {
    if(sorted_set$ix[ii] < (N+1)) {
      sim_ranks <- c(sim_ranks, ii)
    } else {
      obs_ranks <- c(obs_ranks, ii)
    }
  }
  U1 <- 0
  for(ii in 1:N)
  {
    U1 <- U1 + (sim_ranks[ii]-ii)^2
  }
  U1 <- U1 * N
  U2 <- 0
  for(ii in 1:M)
  {
    U2 <- U2 + (obs_ranks[ii]-ii)^2
  }
  U2 <- U2 * M
  U <- U1 + U2
  T <- U/(N*M*(N+M)) - (4*M*N-1)/(6*(M+N))
  Cramer_phos_26[run] <- T 
}

for(run in 1:(num_analyze))  
{
  sim <- as.numeric(unlist(sed_source_cvm[,run+1])) 
  obs <- obs_source_cvm$Sed.source[!is.na(obs_source_cvm$Sed.source)] 
  N <- length (sim)
  M <- length(obs)
  full_set <- c(sim, obs)
  ### Cramer-von Mises test ###
  sorted_set <- sort(full_set, decreasing = FALSE, index.return = TRUE)
  sim_ranks <- c()
  obs_ranks <- c()
  for (ii in 1:(N+M))
  {
    if(sorted_set$ix[ii] < (N+1)) {
      sim_ranks <- c(sim_ranks, ii)
    } else {
      obs_ranks <- c(obs_ranks, ii)
    }
  }
  U1 <- 0
  for(ii in 1:N)
  {
    U1 <- U1 + (sim_ranks[ii]-ii)^2
  }
  U1 <- U1 * N
  U2 <- 0
  for(ii in 1:M)
  {
    U2 <- U2 + (obs_ranks[ii]-ii)^2
  }
  U2 <- U2 * M
  U <- U1 + U2
  T <- U/(N*M*(N+M)) - (4*M*N-1)/(6*(M+N))
  Cramer_sedsrc[run] <- T 
}

for(run in 1:(num_analyze))  
{
  sim <- as.numeric(unlist(phos_source_13to20[,run+1])) 
  obs <- obs_source_13to20$P.source[!is.na(obs_source_13to20$P.source)] 
  N <- length (sim)
  M <- length(obs)
  full_set <- c(sim, obs)
  ### Cramer-von Mises test ###
  sorted_set <- sort(full_set, decreasing = FALSE, index.return = TRUE)
  sim_ranks <- c()
  obs_ranks <- c()
  for (ii in 1:(N+M))
  {
    if(sorted_set$ix[ii] < (N+1)) {
      sim_ranks <- c(sim_ranks, ii)
    } else {
      obs_ranks <- c(obs_ranks, ii)
    }
  }
  U1 <- 0
  for(ii in 1:N)
  {
    U1 <- U1 + (sim_ranks[ii]-ii)^2
  }
  U1 <- U1 * N
  U2 <- 0
  for(ii in 1:M)
  {
    U2 <- U2 + (obs_ranks[ii]-ii)^2
  }
  U2 <- U2 * M
  U <- U1 + U2
  T <- U/(N*M*(N+M)) - (4*M*N-1)/(6*(M+N))
  Cramer_phossrc[run] <- T 
}

Cramer_result <- as.vector(matrix(0,nrow=(n_sample-0))) # n_sample minus number of NaNs
# Cramer_test <- as.vector(matrix(0,nrow=(n_sample-0))) # n_sample minus number of NaNs
KS_result <- as.vector(matrix(0,nrow=(n_sample-0))) # n_sample minus number of NaNs
Levene_result <- as.vector(matrix(0,nrow=(n_sample-0))) # n_sample minus number of NaNs
Wilcox_result <- as.vector(matrix(0,nrow=(n_sample-0))) # n_sample minus number of NaNs
Relative_var <- as.vector(matrix(0,nrow=(n_sample-0))) # n_sample minus number of NaNs
for(run in 1:(n_sample-0))  # n_sample minus number of NaNs
{
  sim <- as.numeric(unlist(phos_source_cal[,run+1]))
  obs <- obs_source_cal$P.source[!is.na(obs_source_cal$P.source)]
  N <- length(unlist(phos_source_cal[,run+1]))
  M <- length(obs)
  full_set <- c(sim, obs)
  ### Cramer-von Mises test ###
  sorted_set <- sort(full_set, decreasing = FALSE, index.return = TRUE)
  sim_ranks <- c()
  obs_ranks <- c()
  for (ii in 1:(N+M))
  {
    if(sorted_set$ix[ii] < (N+1)) {
      sim_ranks <- c(sim_ranks, ii)
    } else {
      obs_ranks <- c(obs_ranks, ii)
    }
  }
  # sim_ranks <- sorted_set$ix[1:N]
  # obs_ranks <- sorted_set$ix[(N+1):(N+M)]
  U1 <- 0
  for(ii in 1:N)
  {
    U1 <- U1 + (sim_ranks[ii]-ii)^2
  }
  U1 <- U1 * N
  U2 <- 0
  for(ii in 1:M)
  {
    U2 <- U2 + (obs_ranks[ii]-ii)^2
  }
  U2 <- U2 * M
  U <- U1 + U2
  T <- U/(N*M*(N+M)) - (4*M*N-1)/(6*(M+N))
  Cramer_result[run] <- T
  # result <- cvm_test(sim,obs,p=2)
  # Cramer_result[run] <- as.numeric(result[1])
  # Cramer_test[run] <- as.numeric(result[2])
  ### Kolmorogorov-Smirnov test ###
  #result <- ks.test(phos_source_val[,run+1], obs_phos_source_val$P.source, alternative="two.sided")
  result <- ks.test(sim, obs, alternative="two.sided")
  KS_result[run] <- result$statistic
  ### Levene test for difference in Variance ###
  type_sim <- as.vector(matrix(1,nrow=N))
  type_obs <- as.vector(matrix(2,nrow=M))
  type_full <- c(type_sim,type_obs)
  type_full <- factor(type_full)
  result <- leveneTest(full_set,type_full)
  Levene_result[run] <- result$`Pr(>F)`[1]
  ### Wilcox rank-sum test for difference in mean ###
  result <- wilcox.test(sim,obs,alternative="two.sided",mu=0)
  Wilcox_result[run] <- result$p.value
  Relative_var[run] <- var(sim)/var(obs)
}


A <- max(nse_phos_26)
B <-max(mnse_phos_26)
C <- max(nse_phos_23)
D <-max(mnse_phos_23)
E <- max(nse_phos_25)
F <-max(mnse_phos_25)
G <- max(nse_phos_14)
H <-max(mnse_phos_14)
I <- max(nse_phos_resconc)
J <-max(mnse_phos_resconc)
K <- var(obs_source_cal$P.source[!is.na(obs_source_cal$P.source)])
L <- max(nse_phossrc)
M <- max(mnse_phossrc)
N <- min(Cramer_result)
O <- min(KS_result)
P <- max(Levene_result)
Q <- max(Wilcox_result)
R <- min(abs(Relative_var-1))
# S <- min(Cramer_test)

# optimal_runs <- c()
# for(run in 1:(n_sample-0)) #n_sample - NaN removals
# {
#   if(#(nse_phossrc[run] > 0.3) &
#     #(nse_phos_26[run] > 0.3) & #0.6*A) & # (mnse_phos_26[run]  > 0.0*B) &
#      #(nse_phos_26_val[run] > 0.3) &
#     (var(unlist(sim_phos_source[,(run+1)])) > 4.5*K)) 
#   {
#     optimal_runs  <- c(optimal_runs,run)
#   }
# }

optimal_runs <- c()
for(run in 1:(n_sample-0)) #n_sample - NaN removals
{
  if((nse_phossrc[run] > -0.16) &
     #(abs(pbias_phos_14[run]) < 50) & 
     (abs(pbias_phos_23[run])  < 35) &
     (abs(pbias_phos_25[run])  < 35) & (abs(pbias_phos_26[run])  < 35) &
     #(abs(pbias_phos_resconc[run])  < 75) & #(abs(pbias_solphos_14[run])  < 50) &
     #    #(abs(pbias_solphos_resconc[run])  < 50) & 
     (abs(pbias_sed_26[run])  < 30) &
     (abs(pbias_phossrc[run])  < 20) &
     (nse_phos_26[run] > 0.25) & #0.6*A) & # (mnse_phos_26[run]  > 0.0*B) &
     #(nse_phos_26_val[run] > 0.15) &
     #(nse_phos_23[run] > 0.2)&#0.6*C) & 
     #(mnse_phos_23[run]  > 0.4*D) &
     #(mnse_phos_25[run]  > 0.4*F) &
     #(nse_phos_25[run] > 0.2)&#0.6*E) & 
     #(nse_phos_14[run] > 0.2)& #&#0.6*G))# & 
     #(mnse_phos_14[run]  > 0.4*H) &
     #(nse_phos_resconc[run] > 0.5*I) & (mnse_phos_resconc[run]  > 0*J) &
     (Cramer_result[run] < 0.34)& # .74346 is alpha = 0.01, .46136 is alpha = 0.05, .34730 is alpha = 0.10
     (KS_result[run] < 0.08))# & # 0.08176979989 is D threshold before factoring in c(alpha), c(alpha) = 1.224, 1.628, 1.949 for alpha = 0.1,0.01,0.001
  #(max(phos_source_val[run+1]) < 50000) &
  #(values$srpm2_swq[run] < 0.02) &
  #(Levene_result[run] > 0.05))# &
  #(Wilcox_result[run]> 0.05))
  
  #(var(unlist(sim_phos_source[,(run+1)])) > 4.0*K))# & (nse_phossrc[run] > 0*L))
  
  {
    optimal_runs  <- c(optimal_runs,run)
  }
}


values_opt <- super_iter$parameter$values[optimal_runs,]

dotty_pbias_tss_26 <- values %>%
  mutate(pbias = pbias_sed_26) %>%
  gather(key = "par", value = "parameter_range", -pbias)
ggplot(data = dotty_pbias_tss_26) +
  geom_point(aes(x = parameter_range, y = pbias)) +
  facet_wrap(.~par, ncol = 3, scales = "free_x") +
  theme_bw() +
  ggtitle("Pbias Sed at Wyckles")

dotty_nse_phos_26 <- values %>%
  mutate(nse = nse_phos_26) %>%
  gather(key = "par", value = "parameter_range", -nse)
ggplot(data = dotty_nse_phos_26) +
  geom_point(aes(x = parameter_range, y = nse)) +
  facet_wrap(.~par, ncol = 3, scales = "free_x") +
  theme_bw() +
  ggtitle("NSE Phos at Wyckles")

dotty_pbias_phos_26 <- values %>%
  mutate(pbias = pbias_phos_26) %>%
  gather(key = "par", value = "parameter_range", -pbias)
ggplot(data = dotty_pbias_phos_26) +
  geom_point(aes(x = parameter_range, y = pbias)) +
  facet_wrap(.~par, ncol = 3, scales = "free_x") +
  theme_bw() +
  ggtitle("Pbias Phos at Wyckles")

dotty_pbias_phossrc <- values %>%
  mutate(pbias = pbias_phossrc) %>%
  gather(key = "par", value = "parameter_range", -pbias)
ggplot(data = dotty_pbias_phossrc) +
  geom_point(aes(x = parameter_range, y = pbias)) +
  facet_wrap(.~par, ncol = 3, scales = "free_x") +
  theme_bw() +
  ggtitle("Pbias P src at Wyckles")

dotty_nse_phossrc <- values %>%
  mutate(nse = nse_phossrc) %>%
  gather(key = "par", value = "parameter_range", -nse)
ggplot(data = dotty_nse_phossrc) +
  geom_point(aes(x = parameter_range, y = nse)) +
  facet_wrap(.~par, ncol = 3, scales = "free_x") +
  theme_bw() +
  ggtitle("NSE P src at Wyckles")

dotty_cramer <- values %>%
  mutate(cram = Cramer_result) %>%
  gather(key = "par", value = "parameter_range", -cram)
ggplot(data = dotty_cramer) +
  geom_point(aes(x = parameter_range, y = cram)) +
  facet_wrap(.~par, ncol = 3, scales = "free_x") +
  theme_bw() +
  ggtitle("Cramer")

dotty_ks <- values %>%
  mutate(ks = KS_result) %>%
  gather(key = "par", value = "parameter_range", -ks)
ggplot(data = dotty_ks) +
  geom_point(aes(x = parameter_range, y = ks)) +
  facet_wrap(.~par, ncol = 3, scales = "free_x") +
  theme_bw() +
  ggtitle("KS")

