optimal_runs <- c()
for(run in 1:num_analyze)
{
  if((nse_flow_6[run] > 0.7) & (nse_flow_14[run]  > 0.7) & (nse_flow_25[run]  > 0.7) &
     (mnse_flow_6[run] > 0.5) & (mnse_flow_14[run]  > 0.5) & (mnse_flow_25[run] > 0.5) &
     (abs(pbias_flow_6[run]) < 8) & (abs(pbias_flow_14[run]) < 8) & (abs(pbias_flow_25[run]) < 8) &
     #(pct_tile[run]> 0.30) & (pct_tile[run]< 0.50) &
     (Cramer_flow_6[run] < 0.75) & (Cramer_flow_14[run] < 0.75) & (Cramer_flow_25[run] < 1.0) &  # .74346 is alpha = 0.01, .46136 is alpha = 0.05, .34730 is alpha = 0.10
     
     (mnse_sed_14[run] > 0.2) & (mnse_sed_23[run]  > 0.2) & (mnse_sed_25[run] > 0.2) &
     (mnse_sed_26[run] > 0.2) & #(mnse_sedsrc[run] > -2) & #& (mnse_sed_res[run]  > -0.5) &
     (nse_sed_14[run] > 0.4) & (nse_sed_23[run]  > 0.4) & (nse_sed_25[run] > 0.4) &
     (nse_sed_26[run] > 0.4) & #(nse_sedsrc[run] > -2) & #& (mnse_sed_res[run]  > -0.5) &
     (abs(pbias_sed_14[run]) < 30) & (abs(pbias_sed_23[run]) < 40) & (abs(pbias_sed_25[run]) < 40) &
     (abs(pbias_sed_26[run]) < 40) & (abs(pbias_sedsrc[run]) < 40) &#(abs(pbias_sed_res[run]) < 80) &
     #(Cramer_sed_14[run] < 3) & (Cramer_sed_23[run] < 3) & (Cramer_sed_25[run] < 3) &
     #(Cramer_sed_26[run] < 3) & (Cramer_sedsrc[run] < 3) &
     
     (mnse_phos_23[run]  > 0.2) & (mnse_phos_25[run] > 0.2) &
     (mnse_phos_26[run] > 0.15) & #(mnse_phos_resconc[run]  > 0) &
     (nse_phos_23[run]  > 0.2) & (nse_phos_25[run] > 0.2) &
     (nse_phos_26[run] > 0.35) & #(mnse_phos_resconc[run]  > 0) &
     (mnse_phossrc[run] > 0.2) & (nse_phossrc[run] > 0.4) &
     (abs(pbias_phos_23[run]) < 30) & (abs(pbias_phos_25[run]) < 30) &
     (abs(pbias_phos_26[run]) < 30) & (abs(pbias_phossrc[run]) < 40) &
     (Cramer_phos_23[run] < 1.0) & (Cramer_phos_25[run] < 1.0) &
     (Cramer_phos_26[run] < 0.75) & (Cramer_phossrc[run] < 0.75)
     
  )
  {
    optimal_runs  <- c(optimal_runs,run)
  }
}