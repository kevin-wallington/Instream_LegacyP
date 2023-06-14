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