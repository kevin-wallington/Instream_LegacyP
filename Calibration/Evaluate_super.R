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
  map_dbl(., ~NSE(.x, obs_phos_cal$Wyckles))
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
  map_dbl(., ~mNSE(.x, obs_phos_cal$Wyckles, j=1)) 
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

#Best NSE/mNSE among simulations
A <- max(nse_flow_6)
B <-max(nse_flow_14)
C <-max(nse_flow_25)
D <- max(mnse_flow_6)
E <-max(mnse_flow_14)
F <-max(mnse_flow_25)
H <-max(mnse_sed_14)
I <- max(mnse_sed_23)
J <- max(mnse_sed_25)
K <-max(mnse_sed_26)
L <-max(mnse_sed_res)
M <- max(mnse_sedsrc)
O <- max(nse_phos_14)
P <-max(mnse_phos_14)
Q <- max(nse_phos_23)
R <-max(mnse_phos_23)
S <- max(nse_phos_25)
T <-max(mnse_phos_25)
U <- max(nse_phos_26)
V <-max(mnse_phos_26)
W <- max(nse_phos_resconc)
X <- max(nse_phossrc)
Y <- max(mnse_phossrc)
