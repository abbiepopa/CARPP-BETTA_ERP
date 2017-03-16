setwd("~/Documents/ERP Analyses/data/measures_170314")

###for happy replace angry with happy, ang with hap, and bini==5 with bini==6

#happy
hap_N2PC_22q<-read.table("eDT_Happy_22q_N2PC_170315 copy.txt", header=T, sep="\t")
hap_PD_22q<-read.table("eDT_Happy_22q_Pd_170315 copy.txt", header=T, sep="\t")

hap_N2PC_TD<-read.table("eDT_Happy_TD_N2PC_170315.txt", header=T, sep="\t")
hap_PD_TD<-read.table("eDT_Happy_TD_Pd_170315.txt", header=T, sep="\t")

###for now just focus on cases where happy is the target###
hap_N2PC_22qa<-hap_N2PC_22q[which(hap_N2PC_22q$bini==6),]
hap_PD_22qa<-hap_PD_22q[which(hap_PD_22q$bini==6),]
hap_N2PC_TDa<-hap_N2PC_TD[which(hap_N2PC_TD$bini==6),]
hap_PD_TDa<-hap_PD_TD[which(hap_PD_TD$bini==6),]

hap_N2PC_22qa$Dx<-"22q"
hap_PD_22qa$Dx<-"22q"
hap_N2PC_TDa$Dx<-"1td"
hap_PD_TDa$Dx<-"1td"

hap_N2PC_22qa$Comp<-"N2PC"
hap_PD_22qa$Comp<-"PD"
hap_N2PC_TDa$Comp<-"N2PC"
hap_PD_TDa$Comp<-"PD"

happy_DT<-rbind(hap_N2PC_22qa, hap_PD_22qa, hap_N2PC_TDa, hap_PD_TDa)

cabilid<-function(rawr){
	return(substr(rawr, start = (nchar(rawr)-2), stop = nchar(rawr)))
}


happy_DT$cabil<-unlist(lapply(as.character(happy_DT$ERPset), cabilid))
happy_DT[which(happy_DT$cabil == "yDT"), "cabil"]<-"842"
happy_DT[which(happy_DT$cabil == "_CI"), "cabil"]<-"300"

happy_DT$cabil<-as.factor(happy_DT$cabil)

library(nlme)

fit<-lme(value~as.factor(Dx)*as.factor(Comp), random = ~1|cabil, data=happy_DT)


happy_DT_22q_N2PC_mean<-mean(happy_DT[which(happy_DT$Dx == "22q" & happy_DT$Comp == "N2PC"),"value"])
happy_DT_22q_N2PC_sem<-sd(happy_DT[which(happy_DT$Dx == "22q" & happy_DT$Comp == "N2PC"),"value"])/sqrt(dim(happy_DT[which(happy_DT$Dx == "22q" & happy_DT$Comp == "N2PC"),])[1])
happy_DT_22q_N2PC_n<-dim(happy_DT[which(happy_DT$Dx == "22q" & happy_DT$Comp == "N2PC"),])[1]

happy_DT_22q_PD_mean<-mean(happy_DT[which(happy_DT$Dx == "22q" & happy_DT$Comp == "PD"),"value"])
happy_DT_22q_PD_sem<-sd(happy_DT[which(happy_DT$Dx == "22q" & happy_DT$Comp == "PD"),"value"])/sqrt(dim(happy_DT[which(happy_DT$Dx == "22q" & happy_DT$Comp == "PD"),])[1])
happy_DT_22q_PD_n<-dim(happy_DT[which(happy_DT$Dx == "22q" & happy_DT$Comp == "PD"),])[1]


happy_DT_1td_N2PC_mean<-mean(happy_DT[which(happy_DT$Dx == "1td" & happy_DT$Comp == "N2PC"),"value"])
happy_DT_1td_N2PC_sem<-sd(happy_DT[which(happy_DT$Dx == "1td" & happy_DT$Comp == "N2PC"),"value"])/sqrt(dim(happy_DT[which(happy_DT$Dx == "1td" & happy_DT$Comp == "N2PC"),])[1])
happy_DT_1td_N2PC_n<-dim(happy_DT[which(happy_DT$Dx == "1td" & happy_DT$Comp == "N2PC"),])[1]

happy_DT_1td_PD_mean<-mean(happy_DT[which(happy_DT$Dx == "1td" & happy_DT$Comp == "PD"),"value"])
happy_DT_1td_PD_sem<-sd(happy_DT[which(happy_DT$Dx == "1td" & happy_DT$Comp == "PD"),"value"])/sqrt(dim(happy_DT[which(happy_DT$Dx == "1td" & happy_DT$Comp == "PD"),])[1])
happy_DT_1td_PD_n<-dim(happy_DT[which(happy_DT$Dx == "1td" & happy_DT$Comp == "PD"),])[1]

####weeee!!!!

happy_DT_wide<-merge(happy_DT[which(happy_DT$Comp == "N2PC"),], happy_DT[which(happy_DT$Comp == "PD"),], by.x="cabil", by.y="cabil")

happy_DT_wide_trim<-happy_DT_wide[,c("cabil","value.x","Dx.x","value.y")]
colnames(happy_DT_wide_trim)<-c("cabil","N2PC","Dx","PD")
happy_DT_wide_trim$ratio<-happy_DT_wide_trim$PD/happy_DT_wide_trim$N2PC

happy_DT_wide_trim[which(happy_DT_wide_trim$ratio>10), "ratio"]<-NA

happy_DT_wide_trim1<-happy_DT_wide_trim
happy_DT_wide_trim<-na.omit(happy_DT_wide_trim)

happy_DT_22q_ratio_mean<-mean(happy_DT_wide_trim[which(happy_DT_wide_trim$Dx == "22q"), "ratio"], na.action=na.omit)
happy_DT_TD_ratio_mean<-mean(happy_DT_wide_trim[which(happy_DT_wide_trim$Dx == "1td"), "ratio"], na.action=na.omit)

happy_DT_22q_ratio_n<-length(happy_DT_wide_trim[which(happy_DT_wide_trim$Dx == "22q"), "ratio"])
happy_DT_TD_ratio_n<-length(happy_DT_wide_trim[which(happy_DT_wide_trim$Dx == "1td"), "ratio"])

happy_DT_22q_ratio_sem<-sd(happy_DT_wide_trim[which(happy_DT_wide_trim$Dx == "22q"), "ratio"])/sqrt(happy_DT_22q_ratio_n)
happy_DT_TD_ratio_sem<-sd(happy_DT_wide_trim[which(happy_DT_wide_trim$Dx == "1td"), "ratio"])/sqrt(happy_DT_TD_ratio_n)

Dx_out<-c("22q","22q","TD","TD", "22q", "TD")
Comp_out<-c("N2PC","PD","N2PC","PD", "ratio","ratio")
mean_out<-c(happy_DT_22q_N2PC_mean, happy_DT_22q_PD_mean, happy_DT_1td_N2PC_mean, happy_DT_1td_PD_mean, happy_DT_22q_ratio_mean, happy_DT_TD_ratio_mean)
sem_out<-c(happy_DT_22q_N2PC_sem, happy_DT_22q_PD_sem, happy_DT_1td_N2PC_sem, happy_DT_1td_PD_sem, happy_DT_22q_ratio_sem, happy_DT_TD_ratio_sem)
n_out<-c(happy_DT_22q_N2PC_n, happy_DT_22q_PD_n, happy_DT_1td_N2PC_n, happy_DT_1td_PD_n, happy_DT_22q_ratio_n, happy_DT_TD_ratio_n)

out<-data.frame(Dx_out, Comp_out, mean_out, sem_out, n_out)


t.test(happy_DT[which(happy_DT$Dx == "22q" & happy_DT$Comp == "N2PC"),"value"], happy_DT[which(happy_DT$Dx == "1td" & happy_DT$Comp == "N2PC"),"value"])
t.test(happy_DT[which(happy_DT$Dx == "22q" & happy_DT$Comp == "PD"),"value"], happy_DT[which(happy_DT$Dx == "1td" & happy_DT$Comp == "PD"),"value"])
t.test(happy_DT[which(happy_DT$Dx == "22q" & happy_DT$Comp == "N2PC"),"value"], happy_DT[which(happy_DT$Dx == "22q" & happy_DT$Comp == "PD"),"value"])
t.test(happy_DT[which(happy_DT$Dx == "1td" & happy_DT$Comp == "N2PC"),"value"], happy_DT[which(happy_DT$Dx == "1td" & happy_DT$Comp == "PD"),"value"])

write.csv(out, "eDT_happy_out_nooutliers.csv",row.names=F)
write.csv(happy_DT, "happy_DT_long_nooutliers.csv",row.names=F)
write.csv(happy_DT_wide_trim, "happy_DT_wide_nooutliers.csv", row.names=F)