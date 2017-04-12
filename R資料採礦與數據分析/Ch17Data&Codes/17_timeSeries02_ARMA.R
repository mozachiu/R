# Goals: ARMA modeling - estimation, diagnostics, forecasting.

# 1. SETUP DATA
load("index_stock.RData")
attach(index_stock)
y=index_stock[,5]
par(mfrow=c(2,1))
plot.ts(y, type="l", col="blue", ylab="%", lwd=2, main="plot.ts()")
grid()
plot(y, type="l", col="blue", ylab="%", lwd=2, main="plot()")
grid()
par(mfrow=c(1,1))

plot(index_stock[,5:8],main="")
plot(index_stock[,1:8],main="")


# 2. Descriptive statistics about y

	## 2-0. Summary statistics
mean(y)
sd(y)
summary(y)
plot(density(y), col="blue", main="(Unconditional) Density of index returns")

	## 2-1. ACf and PACF
par(mfrow=c(2,1))

acf(y, main="ACF of index returns")
pacf(y,main="PACF of index returns")

par(mfrow=c(1,1))

	## 2-2. Histogram Plot
hist(y, col = 3, probability = TRUE,main = "Histogram Plot of index returns")
curve(dnorm(x), min(y), max(y), add = TRUE, lwd = 2)
hist(y, col = 2, main = "Histogram Plot")

	## 2-3. Distribution Plot
par(mfrow=c(2,2))

plot(density(y), main = "Kernel Density Estimate")
qqnorm(y, pch =19)
qqnorm(y, pch =19, main = "Normal Q-Q with qqline");qqline(y)
boxplot(y, col = "green", main = "Box-Plot")

par(mfrow=c(1,1))

# 3. ARMA ESTIMATION
m.ar2 = arima(y, order = c(2,0,0))
print(m.ar2)                       # Print it out

# 4. Automatic model selection
library(forecast)
auto.arima(y)

# 5. ARMA DIAGNOSTICS
tsdiag(m.ar2)

print(Box.test(m.ar2$residuals, lag=12, type="Ljung-Box")) 	## Time series structure in errors
print(Box.test(m.ar2$residuals^2, lag=12, type="Ljung-Box"))	## Sniff for ARCH
plot(density(m.ar2$residuals), col="blue", xlim=c(-8,8),main=paste("Residuals of AR(2)")) 	## Eyeball distribution of residuals




