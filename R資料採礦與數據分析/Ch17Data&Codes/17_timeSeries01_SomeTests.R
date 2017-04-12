
# BDStests
library(tseries)
x1=rnorm(1000)
bds.test(x1)
x2=c(rnorm(500),runif(500))
bds.test(x2)

# Variance ratio tests
library(vrtest)
data(exrates)
y = exrates$ca 	# read Canadian exchange rate
nob = length(y)
r = log(y[2:nob])-log(y[1:(nob-1)]) # log return calculation
q = c(2,5,10)
VR.plot(r,q)
Wald(r,q)  # Chi-square
Lo.Mac(r,q)
Chow.Denning(r,q)
Boot.test(r,q,nboot=500,wild="Normal")

Auto.VR(r)
AutoBoot.test(r,nboot=500,wild="Normal")

Ave.Ex(r)

Spec.shape(r)


DL.test(r)

Wright(r,kvec)
Wright.crit(nob,k=2,nit=100)

Joint.Wright(r,q)
JWright.crit(nob,q,nit=100)

Subsample.test(r,q)

# Unit root tests
library(urca)
load("taiwan3v.RData")
attach(taiwan3v)
data=ts(taiwan3v, start=c(1961,1),freq=4)
names(taiwan3v)
library(timeSeries)
data=as.timeSeries(data)

y=data[,3]
y.df=ur.df(y, type=c("trend"),selectlags = "AIC")
summary(y.df)
plot(y.df)

y.pp=ur.pp(y, type="Z-tau", model="trend", lags="long")
summary(y.pp)
show(y.pp)
plot(y.pp)


y.ers= ur.ers(y, type="DF-GLS", model="const", lag.max=4)
summary(y.ers)
plot(y.ers)

y.kpss = ur.kpss(y, type="tau", lags="long") # "mu" or "tau"
summary(y.kpss)
plot(y.kpss)

y.za = ur.za(y, model="intercept", lag=8) # "mu" or "tau"
summary(y.za)
plot(y.za)


# ARMA ESTIMATION
y.arima = arima(y, order = c(1,0,1))
summary(y.arima)
# ARMA DIAGNOSTICS
tsdiag(y.arima)
print(Box.test(y.arima$residuals, lag=12, type="Ljung-Box")) 	## Time series structure in errors
print(Box.test(y.arima$residuals^2, lag=12, type="Ljung-Box"))	## Sniff for ARCH
plot(density(y.arima$residuals), col="blue", xlim=c(-8,8),main=paste("Residuals of ARIMA(1,0,1)")) 	## Eyeball distribution of residuals


# Automatic model selection
library(forecast)
yhat=auto.arima(y,ic="aic")
summary(yhat)
plot(forecast(yhat,h=20))

library(lmtest)
x=data[,2]
reg1=lm(y~x)
dwtest(reg1)
bgtest(reg1,order=4)
Box.test(reg1$residuals, lag=4,type="Ljung-Box")

reg2=arima(y,xreg=x,include.mean = TRUE, order=c(2,0,0),method = c("CSS-ML"))
print(reg2)
Box.test(residuals(reg2),lag=2,type="Ljung-Box")
reg3=auto.arima(y,xreg=x,ic="aic")
reg3


    

