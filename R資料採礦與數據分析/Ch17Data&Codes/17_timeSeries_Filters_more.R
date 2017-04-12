library(AER)
set.seed(1071)
options(digits = 6)
###################################################
### filter1 eval=FALSE
###################################################
gdp=read.csv("gdp.csv", header=T)
vname=c("per capita GDP")
gdp=ts(log(gdp), start=c(1961,1),freq=4)

###################################################
### decompose
###################################################
y=window(gdp,start=c(1990,1))
dd_dec=decompose(y)
par(mfrow=c(2,2))
plot(y,main="每人GDP", ylab="")
plot(dd_dec$trend,main="趨勢成分", ylab="")
plot(dd_dec$seasonal,main="季節成分", ylab="")
plot(dd_dec$random,main="隨機波動", ylab="")
par(mfrow=c(1,1))

dd_stl = stl(y, s.window = 13)

plot(dd_stl)



