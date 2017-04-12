crime <- read.csv("crime.csv")
subset(crime, Murder > 15)

plot(crime[,-1], pch=c(".", "+")[(crime$State=="DC")+1],cex = 1.5)

fBasics::basicStats(crime[,-1])

rge <- sapply(crime[,-1], function(x) diff(range(x)))
crime_s0 <- sweep(crime[,-1], 2, rge, FUN = "/")
crime_s<-data.frame(crime[,1], crime_s0)
colnames(crime_s)=names(crime)
head(crime_s)

 Formula <- as.formula(paste("~-1",paste(names(crime_s)[-1],collapse="+"),sep="+"))

 .cluster <- RcmdrMisc::KMeans(model.matrix(Formula,crime_s),
            centers=6, iter.max=10, num.seeds=10)

 biplot(princomp(model.matrix(Formula, crime_s)), xlabs = as.character(.cluster$cluster))


crime_pca <- prcomp(crime_s[,-1])
plot(crime_pca$x[, 1:2],pch = kmeans(crime_s[,-1], centers = 2)$cluster)
