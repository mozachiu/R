 load("iClick.dailyTS.RData")
 assetPrice=read.csv("mediaTek.csv")
 head(assetPrice)
 DAT=assetPrice[,c(1,5)]

 iClick.dailyTS(DAT,color4="r2b",color5="jet")


head(read.csv("IBM.csv"))
C4=c("r2b","r2g","w2b");C5=c("default","heat","jet","increment")


save("calendarHeat","cutAndStack","iClick.dailyTS","oneClickCalendarPlot","seriesPlotX",file="iClick.dailyTS.RData")