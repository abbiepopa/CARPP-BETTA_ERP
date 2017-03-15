setwd('~/Documents/ERP Analyses/data/measures_170314')

DT_wide<-read.csv('DT_wide.csv')

DT_wide$outliers<-0

my_max<-function(i){
	j <- mean(i)+(2.5*sd(i))
	return(j)
}

my_min<-function(i){
	j <- mean(i)-(2.5*sd(i))
	return(j)
}

DT_wide[which(DT_wide$N2PC > my_max(DT_wide$N2PC)), "outliers"]<-1
DT_wide[which(DT_wide$N2PC < my_min(DT_wide$N2PC)), "outliers"]<-1

DT_wide[which(DT_wide$PD > my_max(DT_wide$PD)), "outliers"]<-1
DT_wide[which(DT_wide$PD < my_min(DT_wide$PD)), "outliers"]<-1

DT_wide[which(DT_wide$ratio > my_max(DT_wide$ratio)), "outliers"]<-1
DT_wide[which(DT_wide$ratio < my_min(DT_wide$ratio)), "outliers"]<-1

DT_wide_trim <- DT_wide[which(DT_wide$outliers == 0),]

library(reshape)

DT<-melt(DT_wide_trim, id = c("cabil", "Dx", "outliers"))

colnames(DT)<-c("cabil", "Dx", "outliers", "comp", "erp")

library(nlme)
fit<-lme(erp~as.factor(Dx)*as.factor(comp), random = ~1|cabil, data=DT)

DT_22q_N2PC_mean<-mean(DT[which(DT$Dx == "22q" & DT$comp == "N2PC"),"erp"])
DT_22q_N2PC_sem<-sd(DT[which(DT$Dx == "22q" & DT$comp == "N2PC"),"erp"])/sqrt(dim(DT[which(DT$Dx == "22q" & DT$comp == "N2PC"),])[1])
DT_22q_N2PC_n<-dim(DT[which(DT$Dx == "22q" & DT$comp == "N2PC"),])[1]

DT_22q_PD_mean<-mean(DT[which(DT$Dx == "22q" & DT$comp == "PD"),"erp"])
DT_22q_PD_sem<-sd(DT[which(DT$Dx == "22q" & DT$comp == "PD"),"erp"])/sqrt(dim(DT[which(DT$Dx == "22q" & DT$comp == "PD"),])[1])
DT_22q_PD_n<-dim(DT[which(DT$Dx == "22q" & DT$comp == "PD"),])[1]


DT_1td_N2PC_mean<-mean(DT[which(DT$Dx == "1td" & DT$comp == "N2PC"),"erp"])
DT_1td_N2PC_sem<-sd(DT[which(DT$Dx == "1td" & DT$comp == "N2PC"),"erp"])/sqrt(dim(DT[which(DT$Dx == "1td" & DT$comp == "N2PC"),])[1])
DT_1td_N2PC_n<-dim(DT[which(DT$Dx == "1td" & DT$comp == "N2PC"),])[1]

DT_1td_PD_mean<-mean(DT[which(DT$Dx == "1td" & DT$comp == "PD"),"erp"])
DT_1td_PD_sem<-sd(DT[which(DT$Dx == "1td" & DT$comp == "PD"),"erp"])/sqrt(dim(DT[which(DT$Dx == "1td" & DT$comp == "PD"),])[1])
DT_1td_PD_n<-dim(DT[which(DT$Dx == "1td" & DT$comp == "PD"),])[1]

DT_wide<-merge(DT[which(DT$comp == "N2PC"),], DT[which(DT$comp == "PD"),], by.x="cabil", by.y="cabil")

DT_wide_trim<-DT_wide[,c("cabil","erp.x","Dx.x","erp.y")]
colnames(DT_wide_trim)<-c("cabil","N2PC","Dx","PD")
DT_wide_trim$ratio<-DT_wide_trim$PD/DT_wide_trim$N2PC

DT_wide_trim[which(DT_wide_trim$ratio>200), "ratio"]<-NA

DT_wide_trim1<-DT_wide_trim
DT_wide_trim<-na.omit(DT_wide_trim)

DT_22q_ratio_mean<-mean(DT_wide_trim[which(DT_wide_trim$Dx == "22q"), "ratio"], na.action=na.omit)
DT_TD_ratio_mean<-mean(DT_wide_trim[which(DT_wide_trim$Dx == "1td"), "ratio"], na.action=na.omit)

DT_22q_ratio_n<-length(DT_wide_trim[which(DT_wide_trim$Dx == "22q"), "ratio"])
DT_TD_ratio_n<-length(DT_wide_trim[which(DT_wide_trim$Dx == "1td"), "ratio"])

DT_22q_ratio_sem<-sd(DT_wide_trim[which(DT_wide_trim$Dx == "22q"), "ratio"])/sqrt(DT_22q_ratio_n)
DT_TD_ratio_sem<-sd(DT_wide_trim[which(DT_wide_trim$Dx == "1td"), "ratio"])/sqrt(DT_TD_ratio_n)

Dx_out<-c("22q","22q","TD","TD", "22q", "TD")
comp_out<-c("N2PC","PD","N2PC","PD", "ratio","ratio")
mean_out<-c(DT_22q_N2PC_mean, DT_22q_PD_mean, DT_1td_N2PC_mean, DT_1td_PD_mean, DT_22q_ratio_mean, DT_TD_ratio_mean)
sem_out<-c(DT_22q_N2PC_sem, DT_22q_PD_sem, DT_1td_N2PC_sem, DT_1td_PD_sem, DT_22q_ratio_sem, DT_TD_ratio_sem)
n_out<-c(DT_22q_N2PC_n, DT_22q_PD_n, DT_1td_N2PC_n, DT_1td_PD_n, DT_22q_ratio_n, DT_TD_ratio_n)

out<-data.frame(Dx_out, comp_out, mean_out, sem_out, n_out)

t.test(DT[which(DT$Dx == "22q" & DT$comp == "N2PC"),"erp"], DT[which(DT$Dx == "1td" & DT$comp == "N2PC"),"erp"])
t.test(DT[which(DT$Dx == "22q" & DT$comp == "PD"),"erp"], DT[which(DT$Dx == "1td" & DT$comp == "PD"),"erp"])
t.test(DT[which(DT$Dx == "22q" & DT$comp == "N2PC"),"erp"], DT[which(DT$Dx == "22q" & DT$comp == "PD"),"erp"])
t.test(DT[which(DT$Dx == "1td" & DT$comp == "N2PC"),"erp"], DT[which(DT$Dx == "1td" & DT$comp == "PD"),"erp"])

write.csv(out, "DT_out_nooutliers.csv", row.names=F)
write.csv(DT,"DT_long_nooutliers.csv",row.names=F)
write.csv(DT_wide_trim,"DT_wide_nooutliers.csv",row.names=F)