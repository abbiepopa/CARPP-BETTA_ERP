setwd("~/Documents/carpp/erp/data/GNG_eGNG/raw")

#cold GNG

GNG_22q<-read.table("GNG_22q_N2_180111.txt", header=T, sep = '\t')
GNG_TD<-read.table("GNG_TD_N2_180111.txt", header=T, sep = '\t')

t.test(GNG_22q$value, GNG_TD$value)

out<-data.frame(
	task<-c("GNG","GNG"), 
	Dx<-c("22q","TD"), 
	means<-c(mean(GNG_22q$value),mean(GNG_TD$value)), 
	ses<-c((sd(GNG_22q$value)/sqrt(dim(GNG_22q)[1])), (sd(GNG_TD$value)/sqrt(dim(GNG_TD)[1]))), 
	ns<-c(dim(GNG_22q)[1], dim(GNG_TD)[1])
	)		

colnames(out)<-c("task", "Dx", "mean", "se", "n")
setwd("~/Documents/carpp/erp/data/GNG_eGNG/out")
write.csv(out, "GNG_out_180111.csv", row.names=F)

#eGNG angry
setwd("~/Documents/carpp/erp/data/GNG_eGNG/raw")
eGNG_angry_22q<-read.table("eGNG_Angry_22q_N2_180111.txt", header=T, sep = '\t')
eGNG_angry_TD<-read.table("eGNG_Angry_TD_N2_180111.txt", header=T, sep = '\t')


t.test(eGNG_angry_22q$value, eGNG_angry_TD$value)

out<-data.frame(
	task<-c("eGNG_angry","eGNG_angry"), 
	Dx<-c("22q","TD"), 
	means<-c(mean(eGNG_angry_22q$value),mean(eGNG_angry_TD$value)), 
	ses<-c((sd(eGNG_angry_22q$value)/sqrt(dim(eGNG_angry_22q)[1])), (sd(eGNG_angry_TD$value)/sqrt(dim(eGNG_angry_TD)[1]))), 
	ns<-c(dim(eGNG_angry_22q)[1], dim(eGNG_angry_TD)[1])
	)		

colnames(out)<-c("task", "Dx", "mean", "se", "n")
setwd("~/Documents/carpp/erp/data/GNG_eGNG/out")
write.csv(out, "eGNG_Angry_out_180111.csv", row.names=F)

#eGNG happy
setwd("~/Documents/carpp/erp/data/GNG_eGNG/raw")
eGNG_happy_22q<-read.table("eGNG_Happy_22q_N2_180111.txt", header=T, sep = '\t')
eGNG_happy_TD<-read.table("eGNG_Happy_TD_N2_180111.txt", header=T, sep = '\t')


t.test(eGNG_happy_22q$value, eGNG_happy_TD$value)

out<-data.frame(
	task<-c("eGNG_happy","eGNG_happy"), 
	Dx<-c("22q","TD"), 
	means<-c(mean(eGNG_happy_22q$value),mean(eGNG_happy_TD$value)), 
	ses<-c((sd(eGNG_happy_22q$value)/sqrt(dim(eGNG_happy_22q)[1])), (sd(eGNG_happy_TD$value)/sqrt(dim(eGNG_happy_TD)[1]))), 
	ns<-c(dim(eGNG_happy_22q)[1], dim(eGNG_happy_TD)[1])
	)		

colnames(out)<-c("task", "Dx", "mean", "se", "n")

setwd("~/Documents/carpp/erp/data/GNG_eGNG/out")

write.csv(out, "eGNG_Happy_out_180111.csv", row.names=F)

###lme with participant as a random effect, also with Dx together (and effect of Dx) and separate

rm(list = c("Dx","means","ns","out","ses","task"))

eGNG_angry_22q$task<-"eGNG_angry"
eGNG_angry_TD$task<-"eGNG_angry"

eGNG_happy_22q$task<-"eGNG_happy"
eGNG_happy_TD$task<-"eGNG_happy"

GNG_22q$task<-"GNG"
GNG_TD$task<-"GNG"

eGNG_angry_22q$Dx<-"22q"
eGNG_happy_22q$Dx<-"22q"
GNG_22q$Dx<-"22q"

eGNG_angry_TD$Dx<-"TD"
eGNG_happy_TD$Dx<-"TD"
GNG_TD$Dx<-"TD"

all<-rbind(eGNG_angry_22q,eGNG_angry_TD,eGNG_happy_22q,eGNG_happy_TD,GNG_22q,GNG_TD)

all[which(all$Dx == "TD"), "Dx"]<-"1td"
all[which(all$task == "GNG"), "task"]<-"1GNG"

all$Dx<-as.factor(all$Dx)
all$task<-as.factor(all$task)
all$ERPset<-as.character(all$ERPset)

cabilid<-function(rawr){
	outs <- gsub("eGNG_Angry_", "", rawr)
	outs <- gsub("eGNG_angry_", "", outs)
	outs <- gsub("_cb", "", outs)
	outs <- gsub("_cp", "", outs)
	outs <- gsub("eGNG_Happy_", "", outs)
	outs <- gsub("eGNG_happy_", "", outs)
	outs <- gsub("GNG_", "", outs)
	outs <- gsub("_new_elist", "", outs)
	return(outs)
#	return(substr(rawr, start = (nchar(rawr)-2), stop = nchar(rawr)))
}

all$cabil<-unlist(lapply(all$ERPset, cabilid))
all$cabil<-as.factor(all$cabil)

library(nlme)

fit<-lme(value~task*Dx, random = ~1|cabil, data=all)
summary(fit)

t.test(all[which(all$Dx=="22q" & all$task == "1GNG"),"value"], all[which(all$Dx=="22q" & all$task == "eGNG_angry"),"value"])

t.test(all[which(all$Dx=="22q" & all$task == "1GNG"),"value"], all[which(all$Dx=="22q" & all$task == "eGNG_happy"),"value"])

t.test(all[which(all$Dx=="22q" & all$task == "eGNG_angry"),"value"], all[which(all$Dx=="22q" & all$task == "eGNG_happy"),"value"])

t.test(all[which(all$Dx=="1td" & all$task == "1GNG"),"value"], all[which(all$Dx=="1td" & all$task == "eGNG_angry"),"value"])

t.test(all[which(all$Dx=="1td" & all$task == "1GNG"),"value"], all[which(all$Dx=="1td" & all$task == "eGNG_happy"),"value"])

t.test(all[which(all$Dx=="1td" & all$task == "eGNG_angry"),"value"], all[which(all$Dx=="1td" & all$task == "eGNG_happy"),"value"])