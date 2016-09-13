setwd("~/Documents/ERP Analyses/data")

#cold GNG

GNG_22q<-read.table("GNG_measures_22q.txt", header=T)
GNG_TD<-read.table("GNG_measures_TD.txt", header=T)

t.test(GNG_22q$bin3_AverageAnteriorSites, GNG_TD$bin3_AverageAnteriorSites)

out<-data.frame(
	task<-c("GNG","GNG"), 
	Dx<-c("22q","TD"), 
	means<-c(mean(GNG_22q$bin3_AverageAnteriorSites),mean(GNG_TD$bin3_AverageAnteriorSites)), 
	ses<-c((sd(GNG_22q$bin3_AverageAnteriorSites)/sqrt(dim(GNG_22q)[1])), (sd(GNG_TD$bin3_AverageAnteriorSites)/sqrt(dim(GNG_TD)[1]))), 
	ns<-c(dim(GNG_22q)[1], dim(GNG_TD)[1])
	)		

colnames(out)<-c("task", "Dx", "mean", "se", "n")

write.csv(out, "GNG_out.csv", row.names=F)

#eGNG angry

eGNG_angry_22q<-read.table("eGNG_angry_measures_22q.txt", header=T)
eGNG_angry_TD<-read.table("eGNG_angry_measures_TD.txt", header=T)


t.test(eGNG_angry_22q$bin3_AverageAnteriorSites, eGNG_angry_TD$bin3_AverageAnteriorSites)

out<-data.frame(
	task<-c("eGNG_angry","eGNG_angry"), 
	Dx<-c("22q","TD"), 
	means<-c(mean(eGNG_angry_22q$bin3_AverageAnteriorSites),mean(eGNG_angry_TD$bin3_AverageAnteriorSites)), 
	ses<-c((sd(eGNG_angry_22q$bin3_AverageAnteriorSites)/sqrt(dim(eGNG_angry_22q)[1])), (sd(eGNG_angry_TD$bin3_AverageAnteriorSites)/sqrt(dim(eGNG_angry_TD)[1]))), 
	ns<-c(dim(eGNG_angry_22q)[1], dim(eGNG_angry_TD)[1])
	)		

colnames(out)<-c("task", "Dx", "mean", "se", "n")

write.csv(out, "eGNG_angry_out.csv", row.names=F)

#eGNG happy

eGNG_happy_22q<-read.table("eGNG_happy_measures_22q.txt", header=T)
eGNG_happy_TD<-read.table("eGNG_happy_measures_TD.txt", header=T)


t.test(eGNG_happy_22q$bin3_AverageAnteriorSites, eGNG_happy_TD$bin3_AverageAnteriorSites)

out<-data.frame(
	task<-c("eGNG_happy","eGNG_happy"), 
	Dx<-c("22q","TD"), 
	means<-c(mean(eGNG_happy_22q$bin3_AverageAnteriorSites),mean(eGNG_happy_TD$bin3_AverageAnteriorSites)), 
	ses<-c((sd(eGNG_happy_22q$bin3_AverageAnteriorSites)/sqrt(dim(eGNG_happy_22q)[1])), (sd(eGNG_happy_TD$bin3_AverageAnteriorSites)/sqrt(dim(eGNG_happy_TD)[1]))), 
	ns<-c(dim(eGNG_happy_22q)[1], dim(eGNG_happy_TD)[1])
	)		

colnames(out)<-c("task", "Dx", "mean", "se", "n")

write.csv(out, "eGNG_happy_out.csv", row.names=F)

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

fit<-lme(bin3_AverageAnteriorSites~task*Dx, random = ~1|cabil, data=all)

#nice!
# Linear mixed-effects model fit by REML
 # Data: all 
       # AIC      BIC   logLik
  # 206.2204 224.9708 -95.1102

# Random effects:
 # Formula: ~1 | cabil
        # (Intercept)  Residual
# StdDev:   0.4837415 0.6314876

# Fixed effects: bin3_AverageAnteriorSites ~ task * Dx 
                          # Value Std.Error DF   t-value p-value
# (Intercept)           0.9675766 0.2764350 46  3.500196  0.0010
# taskeGNG_angry       -0.4471154 0.3153225 46 -1.417962  0.1629
# taskeGNG_happy       -0.2272143 0.3092875 46 -0.734638  0.4663
# Dx22q                -0.5868148 0.3276092 31 -1.791204  0.0830
# taskeGNG_angry:Dx22q  0.9604487 0.3782242 46  2.539363  0.0146
# taskeGNG_happy:Dx22q  0.6207322 0.3743426 46  1.658193  0.1041
 # Correlation: 
                     # (Intr) tskGNG_n tskGNG_h Dx22q  tskGNG_n:D22
# taskeGNG_angry       -0.613                                      
# taskeGNG_happy       -0.601  0.529                               
# Dx22q                -0.844  0.518    0.507                      
# taskeGNG_angry:Dx22q  0.511 -0.834   -0.441   -0.601             
# taskeGNG_happy:Dx22q  0.496 -0.437   -0.826   -0.587  0.521      

# Standardized Within-Group Residuals:
       # Min         Q1        Med         Q3        Max 
# -1.3529778 -0.5444016 -0.1836715  0.3128958  2.9559955 

# Number of Observations: 83
# Number of Groups: 33 

#anxious kids have larger N2, could be when in an anxious state bigger N2
#also note trend for smaller N2 in 22q to begin with

#test of happy versus angry
# taskeGNG_happy:Dx22q -0.3398726 0.3666871 47 -0.9268736  0.3587
