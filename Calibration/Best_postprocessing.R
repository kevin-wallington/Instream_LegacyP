# Eliminate runs with NaNs
last_entry <- unlist(best_perf$simulation$solp_out_26[5844,-(1)], recursive = TRUE, use.names = FALSE)
last_entry <- as.numeric(last_entry)
nan_location <- which(is.na(last_entry))+1
num_nans <- length(nan_location)
if (num_nans>0){
  best_perf$parameter$values <- best_perf$parameter$values[-(nan_location-1),]
  best_perf$simulation <-lapply(best_perf$simulation, "[", -(nan_location)) 
}
# best_perf$parameter$values <- best_perf$parameter$values[-(nan_location-1),]
# best_perf$simulation <-lapply(best_perf$simulation, "[", -(nan_location)) 
# best_perf$simulation <-lapply(best_perf$simulation, "[", -c(141, 1842)) #change numbers to nan_location
# If there are still NaNs (evident when running code below, e.g. lines 57-78; just iterate that
# section of code with trimmed range of simulations until identify the run with a NaN)

#All runs
n_sample <- length(best_perf$parameter$values$bd)
num_analyze <- n_sample - num_nans
last <- 1 + n_sample - num_nans # minus however many entries removed due to nans
values <- best_perf$parameter$values[1:num_analyze,]

#Flow
flow_cal_6 <- filter(best_perf$simulation$q_out_6, date >= ymd("2003-01-01"), date <= ymd("2014-12-31"))
flow_cal_14 <- filter(best_perf$simulation$q_out_14, date >= ymd("2003-01-01"), date <= ymd("2014-12-31"))
flow_cal_25 <- filter(best_perf$simulation$q_out_25, date >= ymd("2003-01-01"), date <= ymd("2014-12-31"))
flow_cvm_6 <- filter(best_perf$simulation$q_out_6, date >= ymd("2009-01-01"), date <= ymd("2010-12-31"))
flow_cvm_14 <- filter(best_perf$simulation$q_out_14, date >= ymd("2009-01-01"), date <= ymd("2010-12-31"))
flow_cvm_25 <- filter(best_perf$simulation$q_out_25, date >= ymd("2009-01-01"), date <= ymd("2010-12-31"))

#Sediment
best_perf$simulation$sed_resconc <- best_perf$simulation$res_sed_stor
best_perf$simulation$sed_resconc[,2:last] <- 1000000 * best_perf$simulation$res_sed_stor[,2:last]/ best_perf$simulation$res_flo_stor[,2:last]
sed_cal_14 <- filter(best_perf$simulation$sed_out_14, date >= ymd("2003-01-01"), date <= ymd("2014-12-31"))
sed_cal_26 <- filter(best_perf$simulation$sed_out_26, date >= ymd("2003-01-01"), date <= ymd("2014-12-31"))
tss_cal_23 <- filter(best_perf$simulation$tss_out_23, date >= ymd("2003-01-01"), date <= ymd("2014-12-31"))
tss_cal_26 <- filter(best_perf$simulation$tss_out_26, date >= ymd("2003-01-01"), date <= ymd("2014-12-31"))
tss_cal_25 <- filter(best_perf$simulation$tss_out_25, date >= ymd("2003-01-01"), date <= ymd("2014-12-31"))
sed_val_14 <- filter(best_perf$simulation$sed_out_14, date >= ymd("2015-01-01"), date <= ymd("2020-12-31"))
sed_val_26 <- filter(best_perf$simulation$sed_out_26, date >= ymd("2015-01-01"), date <= ymd("2020-12-31"))
tss_val_23 <- filter(best_perf$simulation$tss_out_23, date >= ymd("2015-01-01"), date <= ymd("2020-12-31"))
tss_val_26 <- filter(best_perf$simulation$tss_out_26, date >= ymd("2015-01-01"), date <= ymd("2020-12-31"))
tss_val_25 <- filter(best_perf$simulation$tss_out_25, date >= ymd("2015-01-01"), date <= ymd("2020-12-31"))
tss_val_24 <- filter(best_perf$simulation$tss_out_24, date >= ymd("2015-01-01"), date <= ymd("2020-12-31"))
sed_cvm_14 <- filter(best_perf$simulation$sed_out_14, date >= ymd("2008-01-01"), date <= ymd("2014-12-31"))
sed_cvm_26 <- filter(best_perf$simulation$sed_out_26, date >= ymd("2008-01-01"), date <= ymd("2014-12-31"))
tss_cvm_23 <- filter(best_perf$simulation$tss_out_23, date >= ymd("2008-01-01"), date <= ymd("2014-12-31"))
tss_cvm_26 <- filter(best_perf$simulation$tss_out_26, date >= ymd("2008-01-01"), date <= ymd("2014-12-31"))
tss_cvm_25 <- filter(best_perf$simulation$tss_out_25, date >= ymd("2008-01-01"), date <= ymd("2014-12-31"))
sed_cal_resconc <- filter(best_perf$simulation$sed_resconc, date >= ymd("2003-01-01"), date <= ymd("2014-12-31"))
sed_val_resconc <- filter(best_perf$simulation$sed_resconc, date >= ymd("2015-01-01"), date <= ymd("2020-12-31"))
sed_cvm_resconc <- filter(best_perf$simulation$sed_resconc, date >= ymd("2008-01-01"), date <= ymd("2014-12-31"))

sim_sed_source <- best_perf$simulation$tss_out_26[,1:(num_analyze+1)]
sim_sed_source[,2:(num_analyze+1)] <- sim_sed_source[,2:(num_analyze+1)] - best_perf$simulation$tss_out_25[,2:(num_analyze+1)] -
  best_perf$simulation$tss_out_23[,2:(num_analyze+1)]
for(run in 1:num_analyze)
{
  sim_sed_source[,(run+1)] = sim_sed_source[,(run+1)] - obs_source$Sed.load.SDD..tons.
}
sed_source_cal <- filter(sim_sed_source[,1:(num_analyze+1)], date >= ymd("2003-01-01"), date <= ymd("2014-12-31"))
sed_source_val <- filter(sim_sed_source[,1:(num_analyze+1)], date >= ymd("2015-01-01"), date <= ymd("2020-12-31"))
sed_source_cvm <- filter(sim_sed_source[,1:(num_analyze+1)], date >= ymd("2007-01-01"), date <= ymd("2014-12-31"))

#Phosphorus
best_perf$simulation$totalP_14 <- best_perf$simulation$orgp_out_14
best_perf$simulation$totalP_14[,2:last] <- best_perf$simulation$orgp_out_14[,2:last] +
  best_perf$simulation$minpa_out_14[,2:last] + best_perf$simulation$minps_out_14[,2:last] +
  best_perf$simulation$solp_out_14[,2:last]
best_perf$simulation$totalP_26 <- best_perf$simulation$orgp_out_26
best_perf$simulation$totalP_26[,2:last] <- best_perf$simulation$orgp_out_26[,2:last] +
  best_perf$simulation$minpa_out_26[,2:last] + best_perf$simulation$minps_out_26[,2:last] +
  best_perf$simulation$solp_out_26[,2:last]
best_perf$simulation$totalP_23 <- best_perf$simulation$orgp_out_23
best_perf$simulation$totalP_23[,2:last] <- best_perf$simulation$orgp_out_23[,2:last] +
  best_perf$simulation$minpa_out_23[,2:last] + best_perf$simulation$minps_out_23[,2:last] +
  best_perf$simulation$solp_out_23[,2:last]
best_perf$simulation$totalP_24 <- best_perf$simulation$orgp_out_24
best_perf$simulation$totalP_24[,2:last] <- best_perf$simulation$orgp_out_24[,2:last] +
  best_perf$simulation$minpa_out_24[,2:last] + best_perf$simulation$minps_out_24[,2:last] +
  best_perf$simulation$solp_out_24[,2:last]
best_perf$simulation$totalP_25 <- best_perf$simulation$orgp_out_25
best_perf$simulation$totalP_25[,2:last] <- best_perf$simulation$orgp_out_25[,2:last] +
  best_perf$simulation$minpa_out_25[,2:last] + best_perf$simulation$minps_out_25[,2:last] +
  best_perf$simulation$solp_out_25[,2:last]
best_perf$simulation$totalP_resconc <- best_perf$simulation$res_orgp_stor
best_perf$simulation$totalP_resconc[,2:last] <- 1000 * (best_perf$simulation$res_orgp_stor[,2:last] +
                                                           best_perf$simulation$res_minpa_stor[,2:last] + best_perf$simulation$res_minps_stor[,2:last] +
                                                           best_perf$simulation$res_solp_stor[,2:last]) / best_perf$simulation$res_flo_stor[,2:last]
best_perf$simulation$solP_resconc <- best_perf$simulation$res_solp_stor
best_perf$simulation$solP_resconc[,2:last] <- 1000 * best_perf$simulation$res_solp_stor[,2:last] / best_perf$simulation$res_flo_stor[,2:last]

sim_phos_source <- best_perf$simulation$totalP_26[,1:(num_analyze+1)]
sim_phos_source[,2:(num_analyze+1)] <- sim_phos_source[,2:(num_analyze+1)] - best_perf$simulation$totalP_25[,2:(num_analyze+1)] -
  best_perf$simulation$totalP_23[,2:(num_analyze+1)]
for(run in 1:num_analyze)
{
  sim_phos_source[,(run+1)] = sim_phos_source[,(run+1)] - obs_source$P.load.SDD..kg.
}

#total P
phos_cal_14 <- filter(best_perf$simulation$totalP_14[,1:(num_analyze+1)], date >= ymd("2013-01-01"), date <= ymd("2018-12-31"))
phos_cal_26 <- filter(best_perf$simulation$totalP_26[,1:(num_analyze+1)], date >= ymd("2013-01-01"), date <= ymd("2018-12-31"))
phos_cal_23 <- filter(best_perf$simulation$totalP_23[,1:(num_analyze+1)], date >= ymd("2013-01-01"), date <= ymd("2018-12-31"))
phos_cal_24 <- filter(best_perf$simulation$totalP_24[,1:(num_analyze+1)], date >= ymd("2013-01-01"), date <= ymd("2018-12-31"))
phos_cal_25 <- filter(best_perf$simulation$totalP_25[,1:(num_analyze+1)], date >= ymd("2013-01-01"), date <= ymd("2018-12-31"))
phos_cal_resconc <- filter(best_perf$simulation$totalP_resconc[,1:(num_analyze+1)], date >= ymd("2013-01-01"), date <= ymd("2018-12-31"))
phos_val_14 <- filter(best_perf$simulation$totalP_14[,1:(num_analyze+1)], date >= ymd("2019-01-01"), date <= ymd("2020-12-31")) 
phos_val_26 <- filter(best_perf$simulation$totalP_26[,1:(num_analyze+1)], date >= ymd("2019-01-01"), date <= ymd("2020-12-31")) 
phos_val_23 <- filter(best_perf$simulation$totalP_23[,1:(num_analyze+1)], date >= ymd("2019-01-01"), date <= ymd("2020-12-31"))
phos_val_24 <- filter(best_perf$simulation$totalP_24[,1:(num_analyze+1)], date >= ymd("2019-01-01"), date <= ymd("2020-12-31")) 
phos_val_25 <- filter(best_perf$simulation$totalP_25[,1:(num_analyze+1)], date >= ymd("2019-01-01"), date <= ymd("2020-12-31")) 
phos_val_resconc <-filter(best_perf$simulation$totalP_resconc[,1:(num_analyze+1)], date >= ymd("2019-01-01"), date <= ymd("2020-12-31")) 

#dissolved P
solphos_cal_14 <- filter(best_perf$simulation$solp_out_14[,1:(num_analyze+1)], date >= ymd("2013-01-01"), date <= ymd("2018-12-31"))
solphos_cal_resconc <- filter(best_perf$simulation$solP_resconc[,1:(num_analyze+1)], date >= ymd("2013-01-01"), date <= ymd("2018-12-31"))
solphos_val_14 <- filter(best_perf$simulation$solp_out_14[,1:(num_analyze+1)], date >= ymd("2019-01-01"), date <= ymd("2020-12-31")) 
solphos_val_resconc <- filter(best_perf$simulation$solP_resconc[,1:(num_analyze+1)], date >= ymd("2019-01-01"), date <= ymd("2020-12-31")) 

#Source/sink
phos_source_13to20 <- filter(sim_phos_source[,1:(num_analyze+1)], date >= ymd("2013-01-01"), date <= ymd("2020-12-31"))
phos_source_cal <- filter(sim_phos_source[,1:(num_analyze+1)], date >= ymd("2013-01-01"), date <= ymd("2018-12-31")) 
phos_source_val <- filter(sim_phos_source[,1:(num_analyze+1)], date >= ymd("2019-01-01"), date <= ymd("2020-12-31")) 
