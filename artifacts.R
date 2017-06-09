setwd('~/Documents/CARPP-BETTA_ERP')
library(openxlsx)
d<-read.xlsx('artifacts.xlsx')

row.names(d) <- d$X1

d <- d[2:10]

d<-as.matrix(d)

t.test(d['Ax',],d['HC',])

t.test(d['22q',],d['TD',])

library(psych)
describe(d)

library(reshape)

d1<- melt(d)

colnames(d1) <- c('dx', 'task', 'value')

summary(lm(value~task, data = d1))

t.test(c(d[,'IAPS.negative'], d[,'IAPS.positive']), c(d[,'GNG'], d[,'faces.happy'], d[,'faces.angry']))