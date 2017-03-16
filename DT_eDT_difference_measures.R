setwd('Documents/ERP Analyses/data/measures_170314')

DT<-read.csv('happy_DT_wide.csv')

DT$difference <- DT$PD - DT$N2PC

DT$outliers <- 0

my_max<-function(i){
	j <- mean(i)+(2.5*sd(i))
	return(j)
}

my_min<-function(i){
	j <- mean(i)-(2.5*sd(i))
	return(j)
}

DT_out_finder <- function(d){
	d[which(d$N2PC > my_max(d$N2PC)), "outliers"]<-1
	d[which(d$N2PC < my_min(d$N2PC)), "outliers"]<-1

	d[which(d$PD > my_max(d$PD)), "outliers"]<-1
	d[which(d$PD < my_min(d$PD)), "outliers"]<-1

#	d[which(d$ratio > my_max(d$difference)), "outliers"]<-1
#	d[which(d$ratio < my_min(d$difference)), "outliers"]<-1
	return(d)
}

DT<-DT_out_finder(DT)

DT_outliers <- DT[which(DT$outliers == 1),]
DT_noout<- DT[which(DT$outliers == 0),]
DT_22q <- DT_noout[which(DT_noout$Dx == "22q"),]
DT_td <- DT_noout[which(DT_noout$Dx == "1td"),]

t.test(DT_22q$N2PC, DT_22q$PD, paired = T)
t.test(DT_td$N2PC, DT_td$PD, paired = T)

t.test(DT_22q$N2PC, DT_td$N2PC)
t.test(DT_22q$PD, DT_td$PD)
t.test(DT_22q$difference, DT_td$difference)

DT_22q_N2PC_mean <- mean(DT_22q$N2PC)
DT_22q_PD_mean <- mean(DT_22q$PD)
DT_1td_N2PC_mean <- mean(DT_td$N2PC)
DT_1td_PD_mean <- mean(DT_td$PD)
DT_22q_diff_mean <- mean(DT_22q$difference)
DT_TD_diff_mean <- mean(DT_td$difference)

DT_22q_N2PC_n <- length(DT_22q$N2PC)
DT_22q_PD_n <- length(DT_22q$PD)
DT_1td_N2PC_n <- length(DT_td$N2PC)
DT_1td_PD_n <- length(DT_td$PD)
DT_22q_diff_n <- length(DT_22q$difference)
DT_TD_diff_n <- length(DT_td$difference)

DT_22q_N2PC_sem <- sd(DT_22q$N2PC)/sqrt(DT_22q_N2PC_n)
DT_22q_PD_sem <- sd(DT_22q$PD)/sqrt(DT_22q_PD_n)
DT_1td_N2PC_sem <- sd(DT_td$N2PC)/sqrt(DT_1td_N2PC_n)
DT_1td_PD_sem <- sd(DT_td$PD)/sqrt(DT_1td_PD_n)
DT_22q_diff_sem <- sd(DT_22q$difference)/sqrt(DT_22q_diff_n)
DT_TD_diff_sem <- sd(DT_td$difference)/sqrt(DT_TD_diff_n)

Dx_out<-c("22q","22q","TD","TD", "22q", "TD")
comp_out<-c("N2PC","PD","N2PC","PD", "difference","difference")
mean_out<-c(
	DT_22q_N2PC_mean, 
	DT_22q_PD_mean, 
	DT_1td_N2PC_mean, 
	DT_1td_PD_mean, 
	DT_22q_diff_mean, 
	DT_TD_diff_mean)
sem_out<-c(
	DT_22q_N2PC_sem, 
	DT_22q_PD_sem, 
	DT_1td_N2PC_sem, 
	DT_1td_PD_sem, 
	DT_22q_diff_sem, 
	DT_TD_diff_sem)
n_out<-c(
	DT_22q_N2PC_n, 
	DT_22q_PD_n, 
	DT_1td_N2PC_n, 
	DT_1td_PD_n, 
	DT_22q_diff_n, 
	DT_TD_diff_n)
out<-data.frame(Dx_out, comp_out, mean_out, sem_out, n_out)

write.csv(out, "happy_DT_out_diff_nooutliers.csv", row.names = F)
write.csv(DT_noout, "happy_DT_wide_diff_nooutliers.csv", row.names = F)
write.csv(DT_outliers, "happy_DT_diff_outliers.csv", row.names = F)