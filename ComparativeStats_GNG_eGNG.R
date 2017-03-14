setwd("~/Documents/ERP Analyses/data/measures_170314")

#cold GNG

GNG_22q<-read.table("GNG_22q_N2_170314.txt", header=T)
GNG_TD<-read.table("GNG_TD_N2_170314.txt", header=T)

t.test(GNG_22q$value, GNG_TD$value)

out<-data.frame(
	task<-c("GNG","GNG"), 
	Dx<-c("22q","TD"), 
	means<-c(mean(GNG_22q$value),mean(GNG_TD$value)), 
	ses<-c((sd(GNG_22q$value)/sqrt(dim(GNG_22q)[1])), (sd(GNG_TD$value)/sqrt(dim(GNG_TD)[1]))), 
	ns<-c(dim(GNG_22q)[1], dim(GNG_TD)[1])
	)		

colnames(out)<-c("task", "Dx", "mean", "se", "n")

write.csv(out, "GNG_out_170314.csv", row.names=F)

#eGNG angry

eGNG_angry_22q<-read.table("eGNG_Angry_22q_N2_170314.txt", header=T)
eGNG_angry_TD<-read.table("eGNG_Angry_TD_N2_170314.txt", header=T)


t.test(eGNG_angry_22q$value, eGNG_angry_TD$value)

out<-data.frame(
	task<-c("eGNG_angry","eGNG_angry"), 
	Dx<-c("22q","TD"), 
	means<-c(mean(eGNG_angry_22q$value),mean(eGNG_angry_TD$value)), 
	ses<-c((sd(eGNG_angry_22q$value)/sqrt(dim(eGNG_angry_22q)[1])), (sd(eGNG_angry_TD$value)/sqrt(dim(eGNG_angry_TD)[1]))), 
	ns<-c(dim(eGNG_angry_22q)[1], dim(eGNG_angry_TD)[1])
	)		

colnames(out)<-c("task", "Dx", "mean", "se", "n")

write.csv(out, "eGNG_angry_out_170314.csv", row.names=F)

#eGNG happy

eGNG_happy_22q<-read.table("eGNG_Happy_22q_N2_170314.txt", header=T)
eGNG_happy_TD<-read.table("eGNG_Happy_TD_N2_170314.txt", header=T)


t.test(eGNG_happy_22q$value, eGNG_happy_TD$value)

out<-data.frame(
	task<-c("eGNG_happy","eGNG_happy"), 
	Dx<-c("22q","TD"), 
	means<-c(mean(eGNG_happy_22q$value),mean(eGNG_happy_TD$value)), 
	ses<-c((sd(eGNG_happy_22q$value)/sqrt(dim(eGNG_happy_22q)[1])), (sd(eGNG_happy_TD$value)/sqrt(dim(eGNG_happy_TD)[1]))), 
	ns<-c(dim(eGNG_happy_22q)[1], dim(eGNG_happy_TD)[1])
	)		

colnames(out)<-c("task", "Dx", "mean", "se", "n")

write.csv(out, "eGNG_happy_out_170314.csv", row.names=F)

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
	return(substr(rawr, start = (nchar(rawr)-2), stop = nchar(rawr)))
}

all$cabil<-unlist(lapply(all$ERPset, cabilid))
all$cabil<-as.factor(all$cabil)

library(nlme)

fit<-lme(value~task*Dx, random = ~1|cabil, data=all)

# Linear mixed-effects model fit by REML
 # Data: all 
       # AIC      BIC    logLik
  # 270.6914 292.9244 -127.3457

# Random effects:
 # Formula: ~1 | cabil
        # (Intercept)  Residual
# StdDev:   0.4339031 0.5425971

# Fixed effects: value ~ task * Dx 
                          # Value Std.Error DF   t-value p-value
# (Intercept)           0.6927443 0.1698425 71  4.078745  0.0001
# taskeGNG_angry       -0.3264280 0.1936130 71 -1.685982  0.0962
# taskeGNG_happy       -0.2271505 0.1900072 71 -1.195484  0.2359
# Dx22q                -0.3121645 0.2168807 48 -1.439337  0.1565
# taskeGNG_angry:Dx22q  0.7350967 0.2500766 71  2.939487  0.0044
# taskeGNG_happy:Dx22q  0.5003235 0.2480543 71  2.016991  0.0475
 # Correlation: 
                     # (Intr) tskGNG_n tskGNG_h Dx22q  tskGNG_n:D22
# taskeGNG_angry       -0.592                                      
# taskeGNG_happy       -0.612  0.524                               
# Dx22q                -0.783  0.463    0.479                      
# taskeGNG_angry:Dx22q  0.458 -0.774   -0.406   -0.577             
# taskeGNG_happy:Dx22q  0.469 -0.401   -0.766   -0.584  0.514      

# Standardized Within-Group Residuals:
       # Min         Q1        Med         Q3        Max 
# -1.7081565 -0.4802811 -0.1886394  0.2707260  3.5541797 

# Number of Observations: 125
# Number of Groups: 50 

t.test(all[which(all$Dx=="22q" & all$task == "1GNG"),"value"], all[which(all$Dx=="22q" & all$task == "eGNG_angry"),"value"])

t.test(all[which(all$Dx=="22q" & all$task == "1GNG"),"value"], all[which(all$Dx=="22q" & all$task == "eGNG_happy"),"value"])

t.test(all[which(all$Dx=="22q" & all$task == "eGNG_angry"),"value"], all[which(all$Dx=="22q" & all$task == "eGNG_happy"),"value"])

t.test(all[which(all$Dx=="1td" & all$task == "1GNG"),"value"], all[which(all$Dx=="1td" & all$task == "eGNG_angry"),"value"])

t.test(all[which(all$Dx=="1td" & all$task == "1GNG"),"value"], all[which(all$Dx=="1td" & all$task == "eGNG_happy"),"value"])

t.test(all[which(all$Dx=="1td" & all$task == "eGNG_angry"),"value"], all[which(all$Dx=="1td" & all$task == "eGNG_happy"),"value"])