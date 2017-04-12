
# Optimal lag selection
load("taiwan3v.RData")
attach(taiwan3v)
data=ts(taiwan3v, start=c(1961,1),freq=4)
names(taiwan3v)
library(timeSeries)
data=as.timeSeries(data)

y=data[,3]

library(vars)
lag=VARselect(y, lag.max = 10, type = c("const"))
lag$selection
lag$selection[2]

#type = c("const", "trend", "both", "none"),

    

