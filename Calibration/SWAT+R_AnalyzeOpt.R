library(vioplot)

num_analyze_opt <- length(optimal_runs)
values_opt <- super_iter$parameter$values[optimal_runs,]

# Violin plots for all parameters
N <- length(values_opt[1,])
for(param in 1:N)
{
  #boxplot(values_opt[,param])
  vioplot(values_opt[,param])
}
# # Estimate new uppper and lower bounds
# param_new_bounds <- values_opt[1:2,]
# param_new_bounds[1:2,] <- NA
# UB <- floor(num_analyze_opt * 0.9) #num_analyze_opt #
# LB <- ceiling(num_analyze_opt * 0.1) # 1 #
# for(param in 1:N)
# {
#   temp <- sort(unlist(values_opt[,param]))
#   param_new_bounds[1,param] <- temp[LB]
#   param_new_bounds[2,param]  <- temp[UB]
# }
# 
# # Percent exceedance check, add 1 to an optimal run number in Exceedance_sim
# Exceedance_obs <- fdc(obs_sed_cal$Stevens_Creek) #obs_flow_cal$Monticello
# Exceedance_sim <- fdc(tss_val_23$run_0008, col="blue", main = "Simulated and Observed Exceedances",
#                    xlab = "% Exceedance", ylab = "Flow or Load") # flow_cal_14$run_0023
# points(Exceedance_obs, obs_sed_cal$Stevens_Creek, col="red") #obs_flow_cal$Monticello
# legend(x = "topright",          # Position
#        legend = c("Simulated", "Observed"),  # Legend texts
#        lty = c(1, 2),           # Line types
#        col = c("blue", "red"),           # Line colors
#        lwd = 2) 
