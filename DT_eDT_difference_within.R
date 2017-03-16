setwd('Documents/ERP Analyses/data/measures_170314')

cDT<-read.csv('DT_wide_diff_nooutliers.csv')
aDT<-read.csv('angry_DT_wide_diff_nooutliers.csv')
hDT<-read.csv('happy_DT_wide_diff_nooutliers.csv')

cDT_22q<-cDT[which(cDT$Dx == '22q'),]
cDT_td<-cDT[which(cDT$Dx=='1td'),]

aDT_22q<-aDT[which(aDT$Dx == '22q'),]
aDT_td<-aDT[which(aDT$Dx=='1td'),]

hDT_22q<-hDT[which(hDT$Dx == '22q'),]
hDT_td<-hDT[which(hDT$Dx=='1td'),]

t.test(cDT_22q$N2PC, aDT_22q$N2PC)
t.test(cDT_22q$N2PC, hDT_22q$N2PC)
t.test(hDT_22q$N2PC, aDT_22q$N2PC)

t.test(cDT_td$N2PC, aDT_td$N2PC)
t.test(cDT_td$N2PC, hDT_td$N2PC)
t.test(hDT_td$N2PC, aDT_td$N2PC)


t.test(cDT_22q$PD, aDT_22q$PD)
t.test(cDT_22q$PD, hDT_22q$PD)
t.test(hDT_22q$PD, aDT_22q$PD)

t.test(cDT_td$PD, aDT_td$PD)
t.test(cDT_td$PD, hDT_td$PD)
t.test(hDT_td$PD, aDT_td$PD)


t.test(cDT_22q$difference, aDT_22q$difference)
t.test(cDT_22q$difference, hDT_22q$difference)
t.test(hDT_22q$difference, aDT_22q$difference)

t.test(cDT_td$difference, aDT_td$difference)
t.test(cDT_td$difference, hDT_td$difference)
t.test(hDT_td$difference, aDT_td$difference)