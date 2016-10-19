setwd("~/Documents/ERP Analyses/data")
DTl<-read.csv("DT_long.csv")
aDTl<-read.csv("angry_DT_long.csv")
hDTl<-read.csv("happy_DT_long.csv")

aDTl<-aDTl[,c("value", "ERPset","Dx","Comp","cabil")]
hDTl<-hDTl[,c("value", "ERPset","Dx","Comp","cabil")]

colnames(DTl)<-colnames(aDTl)

DTl$cabil<-as.character(DTl$cabil)
aDTl$cabil<-as.character(aDTl$cabil)
hDTl$cabil<-as.character(hDTl$cabil)

DTl$ERPset<-as.character(DTl$ERPset)
aDTl$ERPset<-as.character(aDTl$ERPset)
hDTl$ERPset<-as.character(hDTl$ERPset)

DTl$task<-"cold"
aDTl$task<-"angry"
hDTl$task<-"happy"

all<-rbind(DTl, aDTl)
all<-rbind(all, hDTl)

library(nlme)

fit_N2PC_22q<-lme(value~as.factor(task), random= ~1|cabil, data=all[which(all$Dx=="22q" & all$Comp=="N2PC"),])
fit_PD_22q<-lme(value~as.factor(task), random= ~1|cabil, data=all[which(all$Dx=="22q" & all$Comp=="PD"),])

fit_N2PC_TD<-lme(value~as.factor(task), random= ~1|cabil, data=all[which(all$Dx=="1td" & all$Comp=="N2PC"),])
fit_PD_TD<-lme(value~as.factor(task), random= ~1|cabil, data=all[which(all$Dx=="1td" & all$Comp=="PD"),])