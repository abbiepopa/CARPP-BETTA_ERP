setwd("~/Documents/ERP Analyses/data")

###for happy replace angry with happy, ang with hap, and bini==5 with bini==6

#angry
ang_N2PC_22q<-read.table("eDT_angry_measures_22q_N2PC_corr.txt", header=T, sep="\t")
ang_PD_22q<-read.table("eDT_angry_measures_22q_PD_corr.txt", header=T, sep="\t")

ang_N2PC_TD<-read.table("eDT_angry_measures_TD_N2PC_corr.txt", header=T, sep="\t")
ang_PD_TD<-read.table("eDT_angry_measures_TD_PD_corr.txt", header=T, sep="\t")

###for now just focus on cases where angry is the target###
ang_N2PC_22qa<-ang_N2PC_22q[which(ang_N2PC_22q$bini==5),]
ang_PD_22qa<-ang_PD_22q[which(ang_PD_22q$bini==5),]
ang_N2PC_TDa<-ang_N2PC_TD[which(ang_N2PC_TD$bini==5),]
ang_PD_TDa<-ang_PD_TD[which(ang_PD_TD$bini==5),]

ang_N2PC_22qa$Dx<-"22q"
ang_PD_22qa$Dx<-"22q"
ang_N2PC_TDa$Dx<-"1td"
ang_PD_TDa$Dx<-"1td"

ang_N2PC_22qa$Comp<-"N2PC"
ang_PD_22qa$Comp<-"PD"
ang_N2PC_TDa$Comp<-"N2PC"
ang_PD_TDa$Comp<-"PD"

angry_DT<-rbind(ang_N2PC_22qa, ang_PD_22qa, ang_N2PC_TDa, ang_PD_TDa)

cabilid<-function(rawr){
	return(substr(rawr, start = (nchar(rawr)-2), stop = nchar(rawr)))
}


angry_DT$cabil<-unlist(lapply(as.character(angry_DT$ERPset), cabilid))
angry_DT[which(angry_DT$cabil == "yDT"), "cabil"]<-"842"

angry_DT$cabil<-as.factor(angry_DT$cabil)

library(nlme)

fit<-lme(value~as.factor(Dx)*as.factor(Comp), random = ~1|cabil, data=angry_DT)


angry_DT_22q_N2PC_mean<-mean(angry_DT[which(angry_DT$Dx == "22q" & angry_DT$Comp == "N2PC"),"value"])
angry_DT_22q_N2PC_sem<-sd(angry_DT[which(angry_DT$Dx == "22q" & angry_DT$Comp == "N2PC"),"value"])/sqrt(dim(angry_DT[which(angry_DT$Dx == "22q" & angry_DT$Comp == "N2PC"),])[1])
angry_DT_22q_N2PC_n<-dim(angry_DT[which(angry_DT$Dx == "22q" & angry_DT$Comp == "N2PC"),])[1]

angry_DT_22q_PD_mean<-mean(angry_DT[which(angry_DT$Dx == "22q" & angry_DT$Comp == "PD"),"value"])
angry_DT_22q_PD_sem<-sd(angry_DT[which(angry_DT$Dx == "22q" & angry_DT$Comp == "PD"),"value"])/sqrt(dim(angry_DT[which(angry_DT$Dx == "22q" & angry_DT$Comp == "PD"),])[1])
angry_DT_22q_PD_n<-dim(angry_DT[which(angry_DT$Dx == "22q" & angry_DT$Comp == "PD"),])[1]


angry_DT_1td_N2PC_mean<-mean(angry_DT[which(angry_DT$Dx == "1td" & angry_DT$Comp == "N2PC"),"value"])
angry_DT_1td_N2PC_sem<-sd(angry_DT[which(angry_DT$Dx == "1td" & angry_DT$Comp == "N2PC"),"value"])/sqrt(dim(angry_DT[which(angry_DT$Dx == "1td" & angry_DT$Comp == "N2PC"),])[1])
angry_DT_1td_N2PC_n<-dim(angry_DT[which(angry_DT$Dx == "1td" & angry_DT$Comp == "N2PC"),])[1]

angry_DT_1td_PD_mean<-mean(angry_DT[which(angry_DT$Dx == "1td" & angry_DT$Comp == "PD"),"value"])
angry_DT_1td_PD_sem<-sd(angry_DT[which(angry_DT$Dx == "1td" & angry_DT$Comp == "PD"),"value"])/sqrt(dim(angry_DT[which(angry_DT$Dx == "1td" & angry_DT$Comp == "PD"),])[1])
angry_DT_1td_PD_n<-dim(angry_DT[which(angry_DT$Dx == "1td" & angry_DT$Comp == "PD"),])[1]

####weeee!!!!

angry_DT_wide<-merge(angry_DT[which(angry_DT$Comp == "N2PC"),], angry_DT[which(angry_DT$Comp == "PD"),], by.x="cabil", by.y="cabil")

angry_DT_wide_trim<-angry_DT_wide[,c("cabil","value.x","Dx.x","value.y")]
colnames(angry_DT_wide_trim)<-c("cabil","N2PC","Dx","PD")
angry_DT_wide_trim$ratio<-angry_DT_wide_trim$PD/angry_DT_wide_trim$N2PC

angry_DT_wide_trim[which(angry_DT_wide_trim$ratio>200), "ratio"]<-NA

angry_DT_wide_trim1<-angry_DT_wide_trim
angry_DT_wide_trim<-na.omit(angry_DT_wide_trim)

angry_DT_22q_ratio_mean<-mean(angry_DT_wide_trim[which(angry_DT_wide_trim$Dx == "22q"), "ratio"], na.action=na.omit)
angry_DT_TD_ratio_mean<-mean(angry_DT_wide_trim[which(angry_DT_wide_trim$Dx == "1td"), "ratio"], na.action=na.omit)

angry_DT_22q_ratio_n<-length(angry_DT_wide_trim[which(angry_DT_wide_trim$Dx == "22q"), "ratio"])
angry_DT_TD_ratio_n<-length(angry_DT_wide_trim[which(angry_DT_wide_trim$Dx == "1td"), "ratio"])

angry_DT_22q_ratio_sem<-sd(angry_DT_wide_trim[which(angry_DT_wide_trim$Dx == "22q"), "ratio"])/sqrt(angry_DT_22q_ratio_n)
angry_DT_TD_ratio_sem<-sd(angry_DT_wide_trim[which(angry_DT_wide_trim$Dx == "1td"), "ratio"])/sqrt(angry_DT_TD_ratio_n)

Dx_out<-c("22q","22q","TD","TD", "22q", "TD")
Comp_out<-c("N2PC","PD","N2PC","PD", "ratio","ratio")
mean_out<-c(angry_DT_22q_N2PC_mean, angry_DT_22q_PD_mean, angry_DT_1td_N2PC_mean, angry_DT_1td_PD_mean, angry_DT_22q_ratio_mean, angry_DT_TD_ratio_mean)
sem_out<-c(angry_DT_22q_N2PC_sem, angry_DT_22q_PD_sem, angry_DT_1td_N2PC_sem, angry_DT_1td_PD_sem, angry_DT_22q_ratio_sem, angry_DT_TD_ratio_sem)
n_out<-c(angry_DT_22q_N2PC_n, angry_DT_22q_PD_n, angry_DT_1td_N2PC_n, angry_DT_1td_PD_n, angry_DT_22q_ratio_n, angry_DT_TD_ratio_n)

out<-data.frame(Dx_out, Comp_out, mean_out, sem_out, n_out)

t.test(angry_DT[which(angry_DT$Dx == "22q" & angry_DT$Comp == "N2PC"),"value"], angry_DT[which(angry_DT$Dx == "1td" & angry_DT$Comp == "N2PC"),"value"])
t.test(angry_DT[which(angry_DT$Dx == "22q" & angry_DT$Comp == "PD"),"value"], angry_DT[which(angry_DT$Dx == "1td" & angry_DT$Comp == "PD"),"value"])
t.test(angry_DT[which(angry_DT$Dx == "22q" & angry_DT$Comp == "N2PC"),"value"], angry_DT[which(angry_DT$Dx == "22q" & angry_DT$Comp == "PD"),"value"])
t.test(angry_DT[which(angry_DT$Dx == "1td" & angry_DT$Comp == "N2PC"),"value"], angry_DT[which(angry_DT$Dx == "1td" & angry_DT$Comp == "PD"),"value"])

write.csv(out, "eDT_angry_out.csv",row.names=F)
write.csv(angry_DT, "angry_DT_long.csv",row.names=F)
write.csv(angry_DT_wide_trim,"angry_DT_wide.csv", row.names=F)