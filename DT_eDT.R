setwd('~/Documents/carpp/erp/data/')
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

oldDTl<-DTl

DTl$value <- oldDTl$cabil
DTl$ERPset <- 0
DTl$Dx <- oldDTl$ERPset
DTl$cabil <- as.character(oldDTl$value)

# DTl$cabil <- as.numeric(DTl$cabil)
# aDTl$cabil <- as.numeric(aDTl$cabil)
# hDTl$cabil <- as.numeric(hDTl$cabil)

all<-rbind(DTl, aDTl)
all<-rbind(all, hDTl)

all$cabil <- as.factor(all$cabil)
all$value <- as.numeric(all$value)
all[which(all$task == "cold"),"task"]<-"1cold"

library(nlme)

fit_N2PC_22q<-lme(value~as.factor(task), random= ~1|cabil, data=all[which(all$Dx=="22q" & all$Comp=="N2PC"),])
fit_PD_22q<-lme(value~as.factor(task), random= ~1|cabil, data=all[which(all$Dx=="22q" & all$Comp=="PD"),])

fit_N2PC_TD<-lme(value~as.factor(task), random= ~1|cabil, data=all[which(all$Dx=="1td" & all$Comp=="N2PC"),])
fit_PD_TD<-lme(value~as.factor(task), random= ~1|cabil, data=all[which(all$Dx=="1td" & all$Comp=="PD"),])

DTw<-read.csv("DT_wide_nooutliers.csv")
aDTw<-read.csv("angry_DT_wide_nooutliers.csv")
hDTw<-read.csv("happy_DT_wide_nooutliers.csv")

DTw$task<-"cold"
aDTw$task<-"angry"
hDTw$task<-"happy"

DTw$cabil<-as.numeric(DTw$cabil)
DTw$cabil<-as.integer(DTw$cabil)

allw<-rbind(DTw, aDTw, hDTw)

allw[which(allw$task == "cold"),"task"]<-"1cold"

fit_ratio_22q<-lme(ratio~task, random= ~1|cabil, data = allw[which(all$Dx == "22q"),], na.action = na.omit)

fit_ratio_td<-lme(ratio~task, random= ~1|cabil, data = allw[which(all$Dx == "1td"),], na.action = na.omit)


#t.test(allw[which(allw$Dx == "22q" & allw$task == "cold"),"ratio"], allw[which(allw$Dx == "22q" & allw$task == "happy"),"ratio"])

summary(fit_N2PC_22q)
summary(fit_N2PC_TD)

summary(fit_PD_22q)
summary(fit_PD_TD)

summary(fit_ratio_22q)
summary(fit_ratio_td)

t.test(allw[which(allw$Dx == "22q" & allw$task == "angry"),"N2PC"], allw[which(allw$Dx == "22q" & allw$task == "happy"),"N2PC"])

t.test(allw[which(allw$Dx == "1td" & allw$task == "angry"),"N2PC"], allw[which(allw$Dx == "1td" & allw$task == "happy"),"N2PC"])

t.test(allw[which(allw$Dx == "22q" & allw$task == "angry"),"PD"], allw[which(allw$Dx == "22q" & allw$task == "happy"),"PD"])

t.test(allw[which(allw$Dx == "1td" & allw$task == "angry"),"PD"], allw[which(allw$Dx == "1td" & allw$task == "happy"),"PD"])

t.test(allw[which(allw$Dx == "22q" & allw$task == "angry"),"ratio"], allw[which(allw$Dx == "22q" & allw$task == "happy"),"ratio"])

t.test(allw[which(allw$Dx == "1td" & allw$task == "angry"),"ratio"], allw[which(allw$Dx == "1td" & allw$task == "happy"),"ratio"])