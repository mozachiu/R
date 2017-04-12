library(arules)
library(arulesViz)


dat0=read.csv("dvdtrans.csv")
dat=split(as.factor(dat0[,"Item"]),as.factor(dat0[,"ID"]))
newdata=as(dat,"itemMatrix")
image(newdata)
itemFrequencyPlot(newdata)
DVD=apriori(newdata, parameter=list(support=0.1,confidence=0.1))
summary(DVD)
summary(interestMeasure(DVD, c("support","confidence", "lift")))

plot(DVD,measure=c("confidence","lift"),shading="support",control=list(jitter=6))
plot(DVD,measure=c("confidence","lift"),shading="order",control=list(jitter=6))


plot(DVD,method="grouped")
DVDx<-subset(DVD,subset= rhs %in% "Patriot" & lift>1)
inspect(head(sort(DVDx,by="support",n=5)))

par(mfrow=c(1,2))
plot(sort(DVD,by="lift"),method="graph",control=list(type="items"))
plot(DVD,method="graph",control=list(type="items"))
par(mfrow=c(1,1))

## sample
small <- sample(newdata, 5)
large <- sample(newdata, 9)
## cluster a small sample
d_jaccard <- dissimilarity(small)
hc <- hclust(d_jaccard)
l <- cutree(hc, k=4)
## predict labels for a larger sample
labels <- predict(small, large, l)
## plot the profile of the 1. cluster
itemFrequencyPlot(large[labels==2, itemFrequency(large) > 0.1])
