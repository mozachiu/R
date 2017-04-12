library(AER)
set.seed(1071)
options(digits = 6)
###################################################
### filter1 eval=FALSE
###################################################

load("taiwan3v.RData")
attach(taiwan3v)
vname=c("saving-GDP ratio","investment-GDP ratio","Economic growth")
k=3
y=ts(taiwan3v[,k], start=c(1961,1),freq=4)
show(y)
plot(y, ylab="", main=vname[k])
f= filter(y, c(1/2, rep(1, 11), 1/2)/12)
lines(f, col = 2)

###################################################
### rollapply
###################################################
rlp_mean=rollapply(y, 12, mean)
plot.ts(rlp_mean,main="Rolling average", ylab="")
rlp_sd=rollapply(y, 12, sd)
plot.ts(rlp_sd,main="Rolling standard deviation", ylab="")

###################################################
### decompose
###################################################
dd_dec=decompose(y)
dd_stl = stl(y, s.window = 13)
plot(dd_dec)
plot(dd_stl)

###################################################
### decompose-components/seat-mean-sd
###################################################
plot(dd_dec$trend, ylab = "trend")
lines(dd_stl$time.series[,"trend"], lty = 2, lwd = 2)
plot(rollapply(y, 12, sd))


###################################################
### Holt-Winters
###################################################
dd_past = window(y, end = c(2004, 4))
dd_hw = HoltWinters(dd_past)
dd_pred = predict(dd_hw, n.ahead = 24)
plot(dd_hw, dd_pred,ylim = range(y))
lines(y,col=1)
legend("bottomright",legend=c("time Series", "Holt-Winters & Predicted"),col=1:2,lty=rep(1,2),ncol=1)



###################################################
### mFilter
###################################################
library(mFilter)
y.hp = mFilter(y,filter="HP") # Hodrick-Prescott filter
y.bk = mFilter(y,filter="BK") # Baxter-King filter
y.cf = mFilter(y,filter="CF") # Christiano-Fitzgerald filter
y.bw = mFilter(y,filter="BW") # Butterworth filter
y.tr = mFilter(y,filter="TR") # Trigonometric regression filter
plot(y, main=" saving-GDP Ratio & Estimated Trend", col=1, ylab="")
lines(y.hp$trend,col=2)
lines(y.bk$trend,col=3)
lines(y.cf$trend,col=4)
lines(y.bw$trend,col=5)
lines(y.tr$trend,col=6)
legend("bottom",legend=c("time Series", "HP","BK","CF","BW","TR"),col=1:6,lty=rep(1,6),ncol=2)




