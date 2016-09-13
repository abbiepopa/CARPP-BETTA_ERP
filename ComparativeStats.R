setwd("~/Documents/ERP Analyses/data")

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