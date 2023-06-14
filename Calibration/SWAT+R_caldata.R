#Flow
obs_flow <- read.csv('../Observations/DailyFlow_KDW.csv')
obs_flow_cal <- filter(obs_flow, Date >= ymd("2003-01-01"), Date <= ymd("2014-12-31"))
obs_flow_val <- filter(obs_flow, Date >= ymd("2013-01-01"), Date <= ymd("2020-12-31")) 
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
obs_sed_val <- filter(obs_sed, Date >= ymd("2013-01-01"), Date <= ymd("2020-12-31"))
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
