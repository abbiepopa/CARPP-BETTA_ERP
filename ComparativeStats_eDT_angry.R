setwd("~/Documents/ERP Analyses/data")

#cold DT
DT_N2_22q<-read.table("DT_cold_measures_22q_N2PC.txt", header=T)
DT_N2_TD<-read.table("DT_cold_measures_TD_N2PC.txt", header=T)

DT_PD_22q<-read.table("DT_cold_measures_22q_PD.txt", header=T)
DT_PD_TD<-read.table("DT_cold_measures_TD_PD.txt", header=T)

DT_N2_22q$Dx<-"22q"
DT_PD_22q$Dx<-"22q"
DT_N2_TD$Dx<-"1td"
DT_PD_TD$Dx<-"1td"

DT_N2_22q$comp<-"N2PC"
DT_PD_22q$comp<-"PD"
DT_N2_TD$comp<-"N2PC"
DT_PD_TD$comp<-"PD"

DT<-rbind(DT_N2_22q, DT_N2_TD, DT_PD_22q, DT_PD_TD)

cabilid<-function(rawr){
	return(substr(rawr, start = (nchar(rawr)-2), stop = nchar(rawr)))
}

DT$cabil<-unlist(lapply(as.character(DT$ERPset), cabilid))
DT[which(DT$cabil == "_DT"), "cabil"]<-"308"
DT[which(DT$cabil == "CI1"), "cabil"]<-"180"

DT$cabil<-as.factor(DT$cabil)

library(nlme)

colnames(DT)[1]<-"erp"

fit<-lme(erp~as.factor(Dx)*as.factor(comp), random = ~1|cabil, data=DT)
#N2PC differs between 22q and TD (bigger in 22q)
#difference between N2PC and PD differs, N2PC equivalent to PD in TD, not 22q

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

write.csv(out, "DT_out.csv", row.names=F)