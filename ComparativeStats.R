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

###lme with participant as a random effect, also with Dx together (and effect of Dx) and separate