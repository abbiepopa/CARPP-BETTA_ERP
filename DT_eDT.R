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

DTw<-read.csv("DT_wide.csv")
aDTw<-read.csv("angry_DT_wide.csv")
hDTw<-read.csv("happy_DT_wide.csv")

DTw$task<-"cold"
aDTw$task<-"angry"
hDTw$task<-"happy"

allw<-rbind(DTw, aDTw, hDTw)

fit_ratio_22q<-lme(ratio~task, random= ~1|cabil, data = allw[which(all$Dx == "22q"),], na.action = na.omit)

fit_ratio_td<-lme(ratio~task, random= ~1|cabil, data = allw[which(all$Dx == "1td"),], na.action = na.omit)

t.test(all[which(all$Dx == "1td" & all$task == "angry"),"value"], all[which(all$Dx == "1td" & all$task == "happy"),"value"])

t.test(allw[which(allw$Dx == "22q" & allw$task == "angry"),"ratio"], allw[which(allw$Dx == "22q" & allw$task == "happy"),"ratio"])


t.test(allw[which(allw$Dx == "22q" & allw$task == "cold"),"ratio"], allw[which(allw$Dx == "22q" & allw$task == "happy"),"ratio"])