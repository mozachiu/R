library(timeSeries)  #library(xts)
data=read.csv("returns47.csv", header=TRUE)
ret=ts(data, start=c(1995,1),freq=12)
returns47=as.timeSeries(ret)

save(returns47, file="returns47.RData")	# using save() to save file into R data format, both files have the same name
load("returns47.RData")
attach(returns47)
names(returns47)
head(returns47)	
tail(returns47)

# Read daily data, the first column is date

data=read.csv("index_stock.csv", header=TRUE)
index_stock=as.timeSeries(data)
index_stock
save(index_stock, file="index_stock.RData")	# using save() to save file into R data format, both files have the same name
load("index_stock.RData")
attach(index_stock)


#Read Annual data

dat=read.csv("Capitalization.csv", header=TRUE)
year=2003:2008
year=as.character(year)
Cap=cbind(year,dat)
Cap
save(Cap, file="Cap.RData")
load("Cap.RData")
Cap
as.timeSeries(Cap)


library(FRBData)
data=c("TB")
GetInterestRates(id=data,lastObs=100)


