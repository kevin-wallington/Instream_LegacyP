###NSE###
nse_sed_14 <- sed_val_14 %>%
  select(-date) %>%
  map_dbl(., ~NSE(.x, obs_sed_val$Monticello_30)) 
nse_tss_26 <- tss_val_26 %>%
  select(-date) %>%
  map_dbl(., ~NSE(.x, obs_sed_val$Wyckles_30)) 
nse_tss_res <- sed_val_resconc %>%
  select(-date) %>%
  map_dbl(., ~NSE(.x, obs_sed_val$Decatur_conc))
nse_tss_23 <- tss_val_23 %>%
  select(-date) %>%
  map_dbl(., ~NSE(.x, obs_sed_val$Stevens_Creek_30))
nse_sedsrc <- sed_source_val %>%
  select(-date) %>%
  map_dbl(., ~NSE(.x, obs_sed_source_val$Sed.source.10))
nse_tss_25 <- tss_val_25 %>%
  select(-date) %>%
  map_dbl(., ~NSE(.x, obs_sed_val$Decatur_SDD_30))
###mNSE###
mnse_sed_14 <- sed_val_14 %>%
  select(-date) %>%
  map_dbl(., ~mNSE(.x, Mont_1down, j=1)) 
mnse_tss_26 <- tss_val_26 %>%
  select(-date) %>%
  map_dbl(., ~mNSE(.x, obs_sed_val$Wyckles_30, j=1)) 
mnse_tss_res <- sed_val_resconc %>%
  select(-date) %>%
  map_dbl(., ~mNSE(.x, obs_sed_val$Decatur_conc, j=1)) 
mnse_tss_23 <- tss_val_23 %>%
  select(-date) %>%
  map_dbl(., ~mNSE(.x, obs_sed_val$Stevens_Creek_30, j=1)) 
mnse_sedsrc <- sed_source_val %>%
  select(-date) %>%
  map_dbl(., ~mNSE(.x, obs_sed_source_val$Sed.source.10, j=1))
mnse_tss_25 <- tss_val_25 %>%
  select(-date) %>%
  map_dbl(., ~mNSE(.x, obs_sed_val$Decatur_SDD_30, j=1)) 
###PBIAS###
pbias_sed_14 <- sed_val_14 %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, obs_sed_val$Monticello))
pbias_tss_26 <- tss_val_26 %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, obs_sed_val$Wyckles))
pbias_tss_res <- sed_val_resconc %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, obs_sed_val$Decatur_conc))
pbias_tss_23 <- tss_val_23 %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, obs_sed_val$Stevens_Creek))
pbias_sedsrc <- sed_source_val %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, obs_sed_source_val$Sed.source))
pbias_tss_25 <- tss_val_25 %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, obs_sed_val$Decatur_SDD))
###PBIAS-1 down###
pbias_sed_14_1d <- sed_val_14 %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, Mont_1down))
# pbias_tss_26_1d <- tss_cal_26 %>%
#   select(-date) %>%
#   map_dbl(., ~pbias(.x, Wyck_1down))
# pbias_tss_res_1d <- tss_cal_res %>%
#   select(-date) %>%
#   map_dbl(., ~pbias(.x, Dec_1down))
# pbias_tss_23_1d <- tss_cal_23 %>%
#   select(-date) %>%
#   map_dbl(., ~pbias(.x, StvCrk_1down))
# pbias_tss_25_1d <- tss_cal_25 %>%
#   select(-date) %>%
#   map_dbl(., ~pbias(.x, Dec48_1down))

### Cramer-von Mises test ###
CramerVM <- as.vector(matrix(0,nrow=(n_sample-3))) # n_sample minus number of NaNs
for(run in 1:(n_sample-0))  # n_sample minus number of NaNs
{
  sim <- as.numeric(unlist(sed_source_val[,run+1]))
  obs <- obs_sed_source_val$Sed.source[!is.na(obs_sed_source_val$Sed.source)]
  N <- length(unlist(sed_source_val[,run+1]))
  M <- length(obs)
  full_set <- c(sim, obs)
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
  CramerVM[run] <- T
}

A <- max(nse_sed_14)
B <-max(nse_tss_26)
C <-max(nse_tss_res)
D <-max(mnse_sed_14)
E <-max(mnse_tss_26)
F <-max(mnse_tss_res)
G <-max(nse_tss_23)
H <- max(nse_sedsrc)
I <- max(mnse_tss_23)
J <- max(mnse_sedsrc)
K <- var(obs_sed_source$Sed.source[!is.na(obs_sed_source$Sed.source)])
L <- max(mnse_tss_25)
M <- min(CramerVM)

Dec48_sorted_obs <- obs_sed_cal$Decatur_SDD
Dec48_sorted_sim <- tss_cal_25
Dec48_sorted_obs <- sort(Dec48_sorted_obs,decreasing=TRUE)
Sed_99p9_obs <- Dec48_sorted_obs[1]
Sed_99_obs <- Dec48_sorted_obs[3]
Sed_90_obs <- Dec48_sorted_obs[24]
Sed_40_obs <- Dec48_sorted_obs[235-94] #235 observations at Dec48 total observations in cal period
Sed_20_obs <- Dec48_sorted_obs[235-47] #235 observations at Dec48 total observations in cal period
Sed_5_obs <- Dec48_sorted_obs[235-12]
Sed_99p9 <- as.vector(matrix(0,nrow=n_sample))
Sed_99 <- as.vector(matrix(0,nrow=n_sample))
Sed_90 <- as.vector(matrix(0,nrow=n_sample))
Sed_40 <- as.vector(matrix(0,nrow=n_sample))
Sed_20 <- as.vector(matrix(0,nrow=n_sample))
Sed_5 <- as.vector(matrix(0,nrow=n_sample))
for(run in 1:n_sample)
{
  Dec48_sorted_sim[,run+1] <- sort(unlist(Dec48_sorted_sim[,run+1]),decreasing=TRUE)
  Sed_99p9[run] <- as.numeric(Dec48_sorted_sim[1,run+1])
  Sed_99[run] <- as.numeric(Dec48_sorted_sim[44,run+1])
  Sed_90[run] <- as.numeric(Dec48_sorted_sim[438,run+1])
  Sed_40[run] <- as.numeric(Dec48_sorted_sim[4383-1752,run+1])
  Sed_20[run] <- as.numeric(Dec48_sorted_sim[4383-876,run+1])
  Sed_5[run] <- as.numeric(Dec48_sorted_sim[4383-219,run+1])
}

Mont_sorted_obs <- obs_sed_cal$Monticello
Mont_sorted_sim <- sed_cal_14
Mont_sorted_obs <- sort(Mont_sorted_obs,decreasing=TRUE)
SedMont_99p9_obs <- Mont_sorted_obs[1]
SedMont_99_obs <- Mont_sorted_obs[5]
SedMont_90_obs <- Mont_sorted_obs[50]
SedMont_20_obs <- Mont_sorted_obs[497-100] #497 observations at Mont total observations in cal period
SedMont_10_obs <- Mont_sorted_obs[497-50]
SedMont_5_obs <- Mont_sorted_obs[497-25]
SedMont_99p9 <- as.vector(matrix(0,nrow=n_sample))
SedMont_99 <- as.vector(matrix(0,nrow=n_sample))
SedMont_90 <- as.vector(matrix(0,nrow=n_sample))
SedMont_20 <- as.vector(matrix(0,nrow=n_sample))
SedMont_10 <- as.vector(matrix(0,nrow=n_sample))
SedMont_5 <- as.vector(matrix(0,nrow=n_sample))
for(run in 1:n_sample)
{
  Mont_sorted_sim[,run+1] <- sort(unlist(Mont_sorted_sim[,run+1]),decreasing=TRUE)
  SedMont_99p9[run] <- as.numeric(Mont_sorted_sim[1,run+1])
  SedMont_99[run] <- as.numeric(Mont_sorted_sim[44,run+1])
  SedMont_90[run] <- as.numeric(Mont_sorted_sim[438,run+1])
  SedMont_20[run] <- as.numeric(Mont_sorted_sim[4383-876,run+1])
  SedMont_10[run] <- as.numeric(Mont_sorted_sim[4383-438,run+1])
  SedMont_5[run] <- as.numeric(Mont_sorted_sim[4383-219,run+1])
}

StvCrk_sorted_obs <- obs_sed_cal$Stevens_Creek
StvCrk_sorted_sim <- tss_cal_23
StvCrk_sorted_obs <- sort(StvCrk_sorted_obs,decreasing=TRUE)
SedStvCrk_99p9_obs <- StvCrk_sorted_obs[1]
SedStvCrk_99_obs <- StvCrk_sorted_obs[3]
SedStvCrk_90_obs <- StvCrk_sorted_obs[23]
SedStvCrk_20_obs <- StvCrk_sorted_obs[226-46] #226 observations at StvCrk total observations in cal period
SedStvCrk_5_obs <- StvCrk_sorted_obs[226-11]
SedStvCrk_99p9 <- as.vector(matrix(0,nrow=n_sample))
SedStvCrk_99 <- as.vector(matrix(0,nrow=n_sample))
SedStvCrk_90 <- as.vector(matrix(0,nrow=n_sample))
SedStvCrk_20 <- as.vector(matrix(0,nrow=n_sample))
SedStvCrk_5 <- as.vector(matrix(0,nrow=n_sample))
for(run in 1:n_sample)
{
  StvCrk_sorted_sim[,run+1] <- sort(unlist(StvCrk_sorted_sim[,run+1]),decreasing=TRUE)
  SedStvCrk_99p9[run] <- as.numeric(StvCrk_sorted_sim[1,run+1])
  SedStvCrk_99[run] <- as.numeric(StvCrk_sorted_sim[44,run+1])
  SedStvCrk_90[run] <- as.numeric(StvCrk_sorted_sim[438,run+1])
  SedStvCrk_20[run] <- as.numeric(StvCrk_sorted_sim[4383-876,run+1])
  SedStvCrk_5[run] <- as.numeric(StvCrk_sorted_sim[4383-219,run+1])
}

DecRes_sorted_obs <- obs_sed_cal$Decatur_IEPA
DecRes_sorted_sim <- sed_cal_res
DecRes_sorted_obs <- sort(DecRes_sorted_obs,decreasing=TRUE)
SedRes_99_obs <- DecRes_sorted_obs[1]
SedRes_90_obs <- DecRes_sorted_obs[9]
SedRes_40_obs <- DecRes_sorted_obs[92-36] #92 observations at Dec IEPA total observations in cal period
SedRes_20_obs <- DecRes_sorted_obs[92-18] #92 observations at Dec IEPA total observations in cal period
SedRes_5_obs <- DecRes_sorted_obs[92-5]
SedRes_99p9 <- as.vector(matrix(0,nrow=n_sample))
SedRes_99 <- as.vector(matrix(0,nrow=n_sample))
SedRes_90 <- as.vector(matrix(0,nrow=n_sample))
SedRes_40 <- as.vector(matrix(0,nrow=n_sample))
SedRes_20 <- as.vector(matrix(0,nrow=n_sample))
SedRes_5 <- as.vector(matrix(0,nrow=n_sample))
for(run in 1:n_sample)
{
  DecRes_sorted_sim[,run+1] <- sort(unlist(DecRes_sorted_sim[,run+1]),decreasing=TRUE)
  SedRes_99p9[run] <- as.numeric(DecRes_sorted_sim[1,run+1])
  SedRes_99[run] <- as.numeric(DecRes_sorted_sim[44,run+1])
  SedRes_90[run] <- as.numeric(DecRes_sorted_sim[438,run+1])
  SedRes_40[run] <- as.numeric(DecRes_sorted_sim[4383-1752,run+1])
  SedRes_20[run] <- as.numeric(DecRes_sorted_sim[4383-876,run+1])
  SedRes_5[run] <- as.numeric(DecRes_sorted_sim[4383-219,run+1])
}

Wyck_sorted_obs <- obs_sed_cal$Wyckles
Wyck_sorted_sim <- tss_cal_26
Wyck_sorted_obs <- sort(Wyck_sorted_obs,decreasing=TRUE)
SedWyck_99p9_obs <- Wyck_sorted_obs[1]
SedWyck_99_obs <- Wyck_sorted_obs[3]
SedWyck_90_obs <- Wyck_sorted_obs[23]
SedWyck_20_obs <- Wyck_sorted_obs[226-46] #226 observations at StvCrk total observations in cal period
SedWyck_5_obs <- Wyck_sorted_obs[226-11]
SedWyck_99p9 <- as.vector(matrix(0,nrow=n_sample))
SedWyck_99 <- as.vector(matrix(0,nrow=n_sample))
SedWyck_90 <- as.vector(matrix(0,nrow=n_sample))
SedWyck_20 <- as.vector(matrix(0,nrow=n_sample))
SedWyck_5 <- as.vector(matrix(0,nrow=n_sample))
for(run in 1:n_sample)
{
  Wyck_sorted_sim[,run+1] <- sort(unlist(Wyck_sorted_sim[,run+1]),decreasing=TRUE)
  SedWyck_99p9[run] <- as.numeric(Wyck_sorted_sim[1,run+1])
  SedWyck_99[run] <- as.numeric(Wyck_sorted_sim[44,run+1])
  SedWyck_90[run] <- as.numeric(Wyck_sorted_sim[438,run+1])
  SedWyck_20[run] <- as.numeric(Wyck_sorted_sim[4383-876,run+1])
  SedWyck_5[run] <- as.numeric(Wyck_sorted_sim[4383-219,run+1])
}


# optimal_runs <- c()
# for(run in 1:n_sample)
# {
#   if((CramerVM[run] < .46136) & # .74346 is alpha = 0.01, .46136 is alpha = 0.05, .34730 is alpha = 0.10
#     # (nse_sedsrc[run]  > -1.0*H) &
#      (mnse_sedsrc[run]  > 0.4 *J) &# &
#      (abs(pbias_sedsrc[run])  < 40))
#   {
#     optimal_runs  <- c(optimal_runs,run)
#   }
# }


optimal_runs <- c()
for(run in 1:n_sample)
{
  if((CramerVM[run] < 0.8) & # .74346 is alpha = 0.01, .46136 is alpha = 0.05, .34730 is alpha = 0.10
  #   #(nse_sed_14[run] > 0.0*A) & (nse_tss_26[run]  > 0.0*B) &
  #    #(nse_tss_res[run]  > 0.0*C) & 
      (mnse_tss_26[run]  > 0.7*E) &
  #    #(mnse_tss_res_1d[run]  > 0.0*F) &
      (abs(pbias_sed_14[run]) < 40) & 
      (abs(pbias_tss_26[run])  < 40) &
  #    #(abs(pbias_tss_res[run])  < 50) & 
  #    #(abs(pbias_sed_14_1d[run])  < 50) &
  #    # (abs(pbias_tss_26_1d[run])  < 35) &
  #    #(abs(pbias_tss_res_1d[run])  < 50) &
  #    #(nse_tss_23[run]  > 0.0*G) & (abs(pbias_tss_23[run])  < 50) &
      (mnse_tss_23[run]  > 0.7*I) &
      (mnse_tss_25[run]  > 0.7*L) &
      (abs(pbias_tss_23[run])  < 40) &
      (abs(pbias_tss_25[run])  < 40) &
      (mnse_sed_14[run] > 0.7*D) & 
  #    (nse_sedsrc[run]  > -1.0*H) &
      (mnse_sedsrc[run]  > 0.7 *J) &
  #    (var(unlist(sim_sed_source[,(run+1)])) < 3 * K) &
  #    (median(unlist(sim_sed_source[,(run+1)])) > 0.5) &
      (abs(pbias_sedsrc[run])  < 40))# &
  #    # (abs(pbias_sedsrc[run])  < 300))
  #   # (abs((SedMont_90[run]-SedMont_90_obs)/SedMont_90_obs)  <  1.2) &
  #   # (abs((SedMont_20[run]-SedMont_20_obs)/SedMont_20_obs)  < 0.85) &
  #   # (abs((SedMont_99[run]-SedMont_99_obs)/SedMont_99_obs)  < 1.2) &
  #   # (SedMont_99p9[run] > (0.25 * SedMont_99p9_obs)))
  #   # (abs((SedMont_10[run]-SedMont_10_obs)/SedMont_10_obs)  < .9) &
  #   (abs((SedStvCrk_90[run]-SedStvCrk_90_obs)/SedStvCrk_90_obs)  < 0.95) &
  #   (abs((SedStvCrk_99[run]-SedStvCrk_99_obs)/SedStvCrk_99_obs)  < 0.45) &
  #   (SedStvCrk_99[run] > 0.75 * SedStvCrk_99_obs) &
  #   # (abs((SedStvCrk_99p9[run]-SedStvCrk_99p9_obs)/SedStvCrk_99p9_obs)  < 2.5) &
  #   #(SedStvCrk_99p9[run] > SedStvCrk_99p9_obs) &
  #   (abs((SedStvCrk_20[run]-SedStvCrk_20_obs)/SedStvCrk_20_obs)  < 5) &
  # (abs((Sed_90[run]-Sed_90_obs)/Sed_90_obs)  < 0.55) &
  # (abs((Sed_99[run]-Sed_99_obs)/Sed_99_obs)  < 0.65) &
  # (Sed_99p9[run] > (0.45 * Sed_99p9_obs)) &
  # #(Sed_90[run] > (2 * Sed_90_obs)) &
  # (abs((Sed_40[run]-Sed_40_obs)/Sed_40_obs)  < 2) &
  # (abs((Sed_20[run]-Sed_20_obs)/Sed_20_obs)  < 5) &
  #   # (abs((SedRes_90[run]-SedRes_90_obs)/SedRes_90_obs)  < 0.3) &
  #   # (abs((SedRes_99[run]-SedRes_99_obs)/SedRes_99_obs)  < 0.3) &
  #   # (abs((SedRes_40[run]-SedRes_40_obs)/SedRes_40_obs)  < 0.41) &
  #   # (abs((SedRes_20[run]-SedRes_20_obs)/SedRes_20_obs)  < 1.01))
  #   (abs((SedWyck_90[run]-SedWyck_90_obs)/SedWyck_90_obs)  <  0.75) &
  #   (abs((SedWyck_20[run]-SedWyck_20_obs)/SedWyck_20_obs)  < 1) &
  #   (abs((SedWyck_99[run]-SedWyck_99_obs)/SedWyck_99_obs)  < 0.8) &
  #   (SedWyck_99p9[run] > (0.4 * SedWyck_99p9_obs)))
  {
    optimal_runs  <- c(optimal_runs,run)
  }
}


dotty_40th <- values %>%
  mutate(fourty = Sed_40) %>%
  #filter(pbias > -300) %>%
  #filter(bed_kd1 > 0.0003, bnk_kd1 > 0.0001, bed_kd2 > 0.0001, bnk_kd2 > 0.0001, tc_bed1 < 20) %>%
  #filter(kod_a2 > 1000, bed_kd1 > 0.095, bed_kd1 < 0.105)%>%
  gather(key = "par", value = "parameter_range", -fourty) 

ggplot(data = dotty_40th) +
  geom_point(aes(x = parameter_range, y = fourty)) +
  facet_wrap(.~par, ncol = 3, scales = "free_x") +
  theme_bw() +
  ggtitle("Decatur Rt 48 40th percentile flow")



#num_analyze <- length(optimal_runs)
#optimal_runs  <- c(804,1183)
values_opt <- sed_iter$parameter$values[optimal_runs,]
sed_val_14_opt <- sed_val_14[,c(1,optimal_runs+1)]
sed_val_14_opt <- filter(sed_val_14_opt, date >= ymd("2013-01-01"), date <= ymd("2020-12-31"))
tss_val_26_opt <- tss_val_26[,c(1,optimal_runs+1)]
tss_val_26_opt <- filter(tss_val_26_opt, date >= ymd("2013-01-01"), date <= ymd("2020-12-31"))
tss_val_25_opt <- tss_val_25[,c(1,optimal_runs+1)]
tss_val_25_opt <- filter(tss_val_25_opt, date >= ymd("2013-01-01"), date <= ymd("2020-12-31"))
res_cla_out_opt <- sed_iter$simulation$res_cla_out[,c(1,optimal_runs+1)]
res_sil_out_opt <- sed_iter$simulation$res_sil_out[,c(1,optimal_runs+1)]
tss_val_res_opt <- res_cla_out_opt
tss_val_res_opt[,-(1)] <- tss_val_res_opt[,-(1)] + res_sil_out_opt[,-(1)] 
tss_val_res_opt <- filter(tss_val_res_opt, date >= ymd("2013-01-01"), date <= ymd("2020-12-31"))
tss_val_23_opt <- tss_val_23[,c(1,optimal_runs+1)]
sim_sed_source_opt <- sim_sed_source[,c(1,optimal_runs+1)]
sed_source_opt <- filter(sim_sed_source_opt, date >= ymd("2013-01-01"), date <= ymd("2020-12-31"))
sed_val_resconc_opt <- sed_val_resconc[,c(1,optimal_runs+1)]


###NSE###
nse_sed_14_opt <- sed_cal_14_opt %>%
  select(-date) %>%
  map_dbl(., ~NSE(.x, obs_sed_cal$Monticello_30)) 
nse_tss_26_opt <- tss_cal_26_opt %>%
  select(-date) %>%
  map_dbl(., ~NSE(.x, obs_sed_cal$Wyckles_30)) 
nse_tss_res_opt <- tss_cal_res_opt %>%
  select(-date) %>%
  map_dbl(., ~NSE(.x, obs_sed_cal$Decatur_IEPA_30))
nse_sedsrc_opt <- sim_sed_source_opt %>%
  select(-date) %>%
  map_dbl(., ~NSE(.x, obs_sed_source$Sed.source.10))
nse_tss_25_opt <- tss_cal_25_opt %>%
  select(-date) %>%
  map_dbl(., ~NSE(.x, obs_sed_cal$Decatur_SDD_30)) 
dotty_nse_sed_14_opt <- values_opt %>%
  mutate(nse = nse_sed_14_opt) %>%
  gather(key = "par", value = "parameter_range", -nse)
dotty_nse_tss_26_opt <- values_opt %>%
  mutate(nse = nse_tss_26_opt) %>%
  gather(key = "par", value = "parameter_range", -nse)
dotty_nse_tss_res_opt <- values_opt %>%
  mutate(nse = nse_tss_res_opt) %>%
  gather(key = "par", value = "parameter_range", -nse)
dotty_nse_sedsrc_opt <- values_opt %>%
  mutate(nse = nse_sedsrc_opt) %>%
  gather(key = "par", value = "parameter_range", -nse) 
dotty_nse_tss_25_opt <- values_opt %>%
  mutate(nse = nse_tss_25_opt) %>%
  gather(key = "par", value = "parameter_range", -nse)
ggplot(data = dotty_nse_sed_14_opt) +
  geom_point(aes(x = parameter_range, y = nse)) +
  facet_wrap(.~par, ncol = 3, scales = "free_x") +
  theme_bw() +
  ggtitle("Sediment NSE at Monticello")
ggplot(data = dotty_nse_tss_26_opt) +
  geom_point(aes(x = parameter_range, y = nse)) +
  facet_wrap(.~par, ncol = 3, scales = "free_x") +
  theme_bw() +
  ggtitle("TSS NSE at Wyckles")
ggplot(data = dotty_nse_tss_res_opt) +
  geom_point(aes(x = parameter_range, y = nse)) +
  facet_wrap(.~par, ncol = 3, scales = "free_x") +
  theme_bw() +
  ggtitle("TSS NSE at Lake Decatur")
ggplot(data = dotty_nse_sedsrc_opt) +
  geom_point(aes(x = parameter_range, y = nse)) +
  facet_wrap(.~par, ncol = 3, scales = "free_x") +
  theme_bw() +
  ggtitle("Sediment Source NSE")
ggplot(data = dotty_nse_tss_25_opt) +
  geom_point(aes(x = parameter_range, y = nse)) +
  facet_wrap(.~par, ncol = 3, scales = "free_x") +
  theme_bw() +
  ggtitle("TSS NSE at Decatur Rt 48")

###mNSE-1 down###
mnse_sed_14_1d_opt <- sed_cal_14_opt %>%
  select(-date) %>%
  map_dbl(., ~mNSE(.x, Mont_1down, j=1)) 
mnse_tss_26_1d_opt <- tss_cal_26_opt %>%
  select(-date) %>%
  map_dbl(., ~mNSE(.x, Wyck_1down, j=1)) 
mnse_tss_res_1d_opt <- tss_cal_res_opt %>%
  select(-date) %>%
  map_dbl(., ~mNSE(.x, Dec_1down, j=1)) 
mnse_sedsrc_opt <- sim_sed_source_opt %>%
  select(-date) %>%
  map_dbl(., ~mNSE(.x, obs_sed_source$Sed.source.10, j=1))
mnse_tss_23_1d_opt <- tss_cal_23_opt %>%
  select(-date) %>%
  map_dbl(., ~mNSE(.x, StvCrk_1down, j=1)) 
mnse_tss_25_1d_opt <- tss_cal_25_opt %>%
  select(-date) %>%
  map_dbl(., ~mNSE(.x, Dec48_1down, j=1)) 
dotty_mnse_sed_14_1d_opt <- values_opt %>%
  mutate(mnse = mnse_sed_14_1d_opt) %>%
  gather(key = "par", value = "parameter_range", -mnse)
dotty_mnse_tss_26_1d_opt <- values_opt %>%
  mutate(mnse = mnse_tss_26_1d_opt) %>%
  gather(key = "par", value = "parameter_range", -mnse)
dotty_mnse_tss_res_1d_opt <- values_opt %>%
  mutate(mnse = mnse_tss_res_1d_opt) %>%
  gather(key = "par", value = "parameter_range", -mnse)
dotty_mnse_sedsrc_opt <- values_opt %>%
  mutate(mnse = mnse_sedsrc_opt) %>%
  #filter(tc_bed1 < 25)%>%
  gather(key = "par", value = "parameter_range", -mnse)
dotty_mnse_tss_23_1d_opt <- values_opt %>%
  mutate(mnse = mnse_tss_23_1d_opt) %>%
  gather(key = "par", value = "parameter_range", -mnse)
dotty_mnse_tss_25_1d_opt <- values_opt %>%
  mutate(mnse = mnse_tss_25_1d_opt) %>%
  #filter(tc_bed1 < 25)%>%
  gather(key = "par", value = "parameter_range", -mnse)
ggplot(data = dotty_mnse_sed_14_1d_opt) +
  geom_point(aes(x = parameter_range, y = mnse)) +
  facet_wrap(.~par, ncol = 3, scales = "free_x") +
  theme_bw() +
  ggtitle("Sediment mNSE at Monticello - 1Down")
ggplot(data = dotty_mnse_tss_26_1d_opt) +
  geom_point(aes(x = parameter_range, y = mnse)) +
  facet_wrap(.~par, ncol = 3, scales = "free_x") +
  theme_bw() +
  ggtitle("TSS mNSE at Wyckles - 1Down")
ggplot(data = dotty_mnse_tss_res_1d_opt) +
  geom_point(aes(x = parameter_range, y = mnse)) +
  facet_wrap(.~par, ncol = 3, scales = "free_x") +
  theme_bw() +
  ggtitle("TSS mNSE at Lake Decatur - 1Down")
ggplot(data = dotty_mnse_tss_23_1d_opt) +
  geom_point(aes(x = parameter_range, y = mnse)) +
  facet_wrap(.~par, ncol = 3, scales = "free_x") +
  theme_bw() +
  ggtitle("Sediment mNSE at Stevens Creek - 1Down")
ggplot(data = dotty_mnse_sedsrc_opt) +
  geom_point(aes(x = parameter_range, y = mnse)) +
  facet_wrap(.~par, ncol = 3, scales = "free_x") +
  theme_bw() +
  ggtitle("Sediment Source mNSE")
ggplot(data = dotty_mnse_tss_25_1d_opt) +
  geom_point(aes(x = parameter_range, y = mnse)) +
  facet_wrap(.~par, ncol = 3, scales = "free_x") +
  theme_bw() +
  ggtitle("TSS mNSE at Decatur Rt 48 - 1Down")


###PBIAS###
pbias_sed_14_opt <- sed_val_14_opt %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, obs_sed_val$Monticello))
pbias_tss_26_opt <- tss_val_26_opt %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, obs_sed_val$Wyckles))
pbias_tss_res_opt <- sed_val_resconc_opt %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, obs_sed_val$Decatur_conc))
pbias_tss_23_opt <- tss_val_23_opt %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, obs_sed_val$Stevens_Creek))
pbias_sedsrc_opt <- sed_source_opt %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, obs_sed_source_val$Sed.source))
pbias_tss_25_opt <- tss_val_25_opt %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, obs_sed_val$Decatur_SDD))
dotty_pbias_sed_14_opt <- values_opt %>%
  mutate(pbias = pbias_sed_14_opt) %>%
  gather(key = "par", value = "parameter_range", -pbias)
dotty_pbias_tss_26_opt <- values_opt %>%
  mutate(pbias = pbias_tss_26_opt) %>%
  gather(key = "par", value = "parameter_range", -pbias)
dotty_pbias_tss_res_opt <- values_opt %>%
  mutate(pbias = pbias_tss_res_opt) %>%
  gather(key = "par", value = "parameter_range", -pbias)
dotty_pbias_tss_23_opt <- values_opt %>%
  mutate(pbias = pbias_tss_23_opt) %>%
  #filter(pbias < 200)%>%
  gather(key = "par", value = "parameter_range", -pbias)
dotty_pbias_sedsrc_opt <- values_opt %>%
  mutate(pbias = pbias_sedsrc_opt) %>%
  #filter(tc_bed1 < 25)%>%
  gather(key = "par", value = "parameter_range", -pbias) 
dotty_pbias_tss_25_opt <- values_opt %>%
  mutate(pbias = pbias_tss_25_opt) %>%
  #filter(pbias < 200)%>%
  gather(key = "par", value = "parameter_range", -pbias)
ggplot(data = dotty_pbias_sed_14_opt) +
  geom_point(aes(x = parameter_range, y = pbias)) +
  facet_wrap(.~par, ncol = 3, scales = "free_x") +
  theme_bw() +
  ggtitle("Pbias at Monticello")
ggplot(data = dotty_pbias_tss_26_opt) +
  geom_point(aes(x = parameter_range, y = pbias)) +
  facet_wrap(.~par, ncol = 3, scales = "free_x") +
  theme_bw() +
  ggtitle("Pbias at Wyckles")
ggplot(data = dotty_pbias_tss_res_opt) +
  geom_point(aes(x = parameter_range, y = pbias)) +
  facet_wrap(.~par, ncol = 3, scales = "free_x") +
  theme_bw() +
  ggtitle("Pbias at Lake Decatur")
ggplot(data = dotty_pbias_tss_23_opt) +
  geom_point(aes(x = parameter_range, y = pbias)) +
  facet_wrap(.~par, ncol = 3, scales = "free_x") +
  theme_bw() +
  ggtitle("Pbias at Stevens Creek")
ggplot(data = dotty_pbias_sedsrc_opt) +
  geom_point(aes(x = parameter_range, y = pbias)) +
  facet_wrap(.~par, ncol = 3, scales = "free_x") +
  theme_bw() +
  ggtitle("Sediment Source PBias")
ggplot(data = dotty_pbias_tss_25_opt) +
  geom_point(aes(x = parameter_range, y = pbias)) +
  facet_wrap(.~par, ncol = 3, scales = "free_x") +
  theme_bw() +
  ggtitle("Pbias at Decatur Rt 48")


###PBIAS-1 down###
pbias_sed_14_1d_opt <- sed_cal_14_opt %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, Mont_1down))
pbias_tss_26_1d_opt <- tss_cal_26_opt %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, Wyck_1down))
pbias_tss_res_1d_opt <- tss_cal_res_opt %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, Dec_1down))
pbias_tss_23_1d_opt <- tss_cal_23_opt %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, StvCrk_1down))
dotty_pbias_sed_14_1d_opt <- values_opt %>%
  mutate(pbias = pbias_sed_14_1d_opt) %>%
  gather(key = "par", value = "parameter_range", -pbias)
dotty_pbias_tss_26_1d_opt <- values_opt %>%
  mutate(pbias = pbias_tss_26_1d_opt) %>%
  gather(key = "par", value = "parameter_range", -pbias)
dotty_pbias_tss_res_1d_opt <- values_opt %>%
  mutate(pbias = pbias_tss_res_1d_opt) %>%
  gather(key = "par", value = "parameter_range", -pbias)
dotty_pbias_tss_23_1d_opt <- values_opt %>%
  mutate(pbias = pbias_tss_23_1d_opt) %>%
  gather(key = "par", value = "parameter_range", -pbias)
ggplot(data = dotty_pbias_sed_14_1d_opt) +
  geom_point(aes(x = parameter_range, y = pbias)) +
  facet_wrap(.~par, ncol = 3, scales = "free_x") +
  theme_bw() +
  ggtitle("Pbias at Monticello - 1Down")
ggplot(data = dotty_pbias_tss_26_1d_opt) +
  geom_point(aes(x = parameter_range, y = pbias)) +
  facet_wrap(.~par, ncol = 3, scales = "free_x") +
  theme_bw() +
  ggtitle("Pbias at Wyckles - 1Down")
ggplot(data = dotty_pbias_tss_res_1d_opt) +
  geom_point(aes(x = parameter_range, y = pbias)) +
  facet_wrap(.~par, ncol = 3, scales = "free_x") +
  theme_bw() +
  ggtitle("Pbias at Lake Decatur - 1Down")
ggplot(data = dotty_pbias_tss_23_1d_opt) +
  geom_point(aes(x = parameter_range, y = pbias)) +
  facet_wrap(.~par, ncol = 3, scales = "free_x") +
  theme_bw() +
  ggtitle("Pbias at Stevens Creek - 1Down")

###PBIAS SedSource###
pbias_sedsrc_opt <- sed_source_opt %>%
  select(-date) %>%
  map_dbl(., ~pbias(.x, obs_sed_source_val$Sed.source))

dotty_pbias_sedsrc_opt <- values_opt %>%
  mutate(pbias = pbias_sedsrc_opt) %>%
  #filter(pbias > -300) %>%
  #filter(bed_kd1 > 0.0003, bnk_kd1 > 0.0001, bed_kd2 > 0.0001, bnk_kd2 > 0.0001, tc_bed1 < 20) %>%
  #filter(kod_a2 > 1000, bed_kd1 > 0.095, bed_kd1 < 0.105)%>%
  gather(key = "par", value = "parameter_range", -pbias) 

ggplot(data = dotty_pbias_sedsrc_opt) +
  geom_point(aes(x = parameter_range, y = pbias)) +
  facet_wrap(.~par, ncol = 3, scales = "free_x") +
  theme_bw() +
  ggtitle("Sediment Source PBias")