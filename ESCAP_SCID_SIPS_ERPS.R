setwd('~/Documents/ERP Analyses/data/ESCAP')

SIPS <- read.csv("CARPP_SIPS_adjusting.csv")

angryDT_N2PC <- read.table("angryDT_22q_N2PC_161214.txt", header=T)
angryDT_PD <- read.table("angryDT_22q_PD_161214.txt", header=T)

happyDT_N2PC <- read.table("happyDT_22q_N2PC_161214.txt", header=T)
happyDT_PD <- read.table("happyDT_22q_PD_161214.txt", header=T)

calmDT_N2PC <- read.table("calmDT_22q_N2PC_161214.txt", header=T)
calmDT_PD <- read.table("calmDT_22q_PD_161214.txt", header=T)

coldDT_N2PC <- read.table("DT_22q_N2PC_161214.txt", header=T)
coldDT_PD <- read.table("DT_22q_PD_161214.txt", header=T)

GNG <- read.table("GNG_22q_N2_161214.txt", header = T)
angryGNG <- read.table("angryGNG_22q_N2_161214.txt", header = T)
happyGNG <- read.table("happyGNG_22q_N2_161214.txt", header = T)

angryDT_N2PC_angry <- angryDT_N2PC[which(angryDT_N2PC$binlabel == "Angry_Contra-Ipsi"),]
angryDT_N2PC_happy <- angryDT_N2PC[which(angryDT_N2PC$binlabel == "Happy_Contra-Ipsi"),]

happyDT_N2PC_angry <- happyDT_N2PC[which(happyDT_N2PC$binlabel == "Angry_Contra-Ipsi"),]
happyDT_N2PC_happy <- happyDT_N2PC[which(happyDT_N2PC$binlabel == "Happy_Contra-Ipsi"),]

calmDT_N2PC_angry <- calmDT_N2PC[which(calmDT_N2PC$binlabel == "Angry_Contra-Ipsi"),]
calmDT_N2PC_happy <- calmDT_N2PC[which(calmDT_N2PC$binlabel == "Happy_Contra-Ipsi"),]

angryDT_PD_angry <- angryDT_PD[which(angryDT_PD$binlabel == "Angry_Contra-Ipsi"),]
angryDT_PD_happy <- angryDT_PD[which(angryDT_PD$binlabel == "Happy_Contra-Ipsi"),]

happyDT_PD_angry <- happyDT_PD[which(happyDT_PD$binlabel == "Angry_Contra-Ipsi"),]
happyDT_PD_happy <- happyDT_PD[which(happyDT_PD$binlabel == "Happy_Contra-Ipsi"),]

calmDT_PD_angry <- calmDT_PD[which(calmDT_PD$binlabel == "Angry_Contra-Ipsi"),]
calmDT_PD_happy <- calmDT_PD[which(calmDT_PD$binlabel == "Happy_Contra-Ipsi"),]

allERPs_short_list <- list(angryDT_N2PC_angry[,c("value","cabil")], angryDT_N2PC_happy[,c("value","cabil")], 
	happyDT_N2PC_angry[,c("value","cabil")], happyDT_N2PC_happy[,c("value","cabil")],
	calmDT_N2PC_angry[,c("value","cabil")], calmDT_N2PC_happy[,c("value","cabil")],
	angryDT_PD_angry[,c("value","cabil")], angryDT_PD_happy[,c("value","cabil")], 
	happyDT_PD_angry[,c("value","cabil")], happyDT_PD_happy[,c("value","cabil")],
	calmDT_PD_angry[,c("value","cabil")], calmDT_PD_happy[,c("value","cabil")],
	coldDT_N2PC[,c("value","cabil")], coldDT_PD[,c("value","cabil")],
	GNG[,c("value","cabil")], angryGNG[,c("value","cabil")], happyGNG[,c("value","cabil")])

allERPs<-Reduce(function(x,y) merge(x, y, all=T, by = "cabil"), allERPs_short_list)

colnames(allERPs)<-c("cabil", "angryDT_N2PC_angry","angryDT_N2PC_happy",
	"happyDT_N2PC_angry","happyDT_N2PC_happy",
	"calmDT_N2PC_angry","calmDT_N2PC_happy",
	"angryDT_PD_angry","angryDT_PD_happy",
	"happyDT_PD_angry","happyDT_PD_happy",
	"calmDT_PD_angry","calmDT_PD_happy",
	"coldDT_N2PC","coldDT_PD",
	"GNG","angryGNG","happyGNG")
	
SIPS_P<-merge(SIPS[,c("cabil","SIPS_P_TOTAL")], allERPs, by = "cabil")

ERP_cols<-colnames(SIPS_P[,c(3:17)])

for(i in ERP_cols){
	n <- SIPS_P[, c("cabil", "SIPS_P_TOTAL", i)]
	n <- na.omit(n)
	print(i)
	print(cor.test(n$SIPS_P_TOTAL, n[, i]))
}

SIPS_N<-merge(SIPS[,c("cabil","SIPS_N_TOTAL")], allERPs, by = "cabil")

ERP_cols<-colnames(SIPS_N[,c(3:17)])

for(i in ERP_cols){
	n <- SIPS_N[, c("cabil", "SIPS_N_TOTAL", i)]
	n <- na.omit(n)
	print(i)
	print(cor.test(n$SIPS_N_TOTAL, n[, i]))
}

SIPS_D<-merge(SIPS[,c("cabil","SIPS_D_TOTAL")], allERPs, by = "cabil")

ERP_cols<-colnames(SIPS_D[,c(3:17)])

for(i in ERP_cols){
	n <- SIPS_D[, c("cabil", "SIPS_D_TOTAL", i)]
	n <- na.omit(n)
	print(i)
	print(cor.test(n$SIPS_D_TOTAL, n[, i]))
}

SIPS_G<-merge(SIPS[,c("cabil","SIPS_G_TOTAL")], allERPs, by = "cabil")

ERP_cols<-colnames(SIPS_G[,c(3:17)])

for(i in ERP_cols){
	n <- SIPS_G[, c("cabil", "SIPS_G_TOTAL", i)]
	n <- na.omit(n)
	print(i)
	print(cor.test(n$SIPS_G_TOTAL, n[, i]))
}

write.csv(SIPS_P, "sips_p_erp.csv", row.names=F)
write.csv(SIPS_N, "sips_n_erp.csv", row.names=F)

###########################################################
### To Do:                                              ###
### (1) Relevant Sub-Scales                             ###
### (2) Anything Danessa needs for her bullying measure ###
###########################################################

###SIPS02 - Suspiciousness
###SIPS04-prcptl_abnrml_hallcn
###SIPS06_soc_anhdn_wthdrwl
###SIPS14 - trble_fcus_attn
###SIPS16_slp_dstbnc
###SIPS17_dysphrc_md
###SIPS18_md_dstbnc
###SIPS19_imprd_tolrnce_nrml_strss
###SIPS22_crrnt_GAF