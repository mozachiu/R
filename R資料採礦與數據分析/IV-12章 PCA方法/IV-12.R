## PCA  #
## Case 1.
heptathlon<-read.csv ("heptathlon.csv")
head(heptathlon)
hurdles1=with(max(hurdles)-hurdles,data=heptathlon)
run200m1=with(max(run200m)-run200m,data=heptathlon)
run800m1=with(max(run800m)-run800m,data=heptathlon)
heptathlon$hurdles1=hurdles1
heptathlon$run200m1=run200m1
heptathlon$run800m1=run800m1
head(heptathlon)

noUse25=c("Names","run200m","run800m","hurdles","score")
id25=which(names(heptathlon) %in% noUse25)
pairs(heptathlon[,-id25])

heptathlon24=heptathlon[-25,-1]
rownames(heptathlon24)=heptathlon[-25,1]
head(heptathlon24)
noUse24=c("run200m","run800m","hurdles","score")
id24=which(names(heptathlon24) %in% noUse24)

.PC= princomp(heptathlon24[,-id24] ,cor=TRUE)


biplot(.PC, col=c("black", "red"))
unclass(loadings(.PC))
.PC$sd^2
summary(.PC)

summary(.PC, loadings=TRUE)
.PC$scores

## Case 2. Pollution
tmp=read.csv("USairpollution.csv")
head(tmp)
USairpollution=tmp[,-c(1:3)]
USairpollution$negtemp=-tmp$temp
rownames(USairpollution)=tmp[,1]
head(USairpollution)
.PC= princomp(USairpollution[, !sapply(USairpollution, is.factor)] ,cor=TRUE)
biplot(.PC, col=c("black", "red"))
library(MVA)
pairs(.PC$scores[,1:3], ylim = c(-6, 4), xlim = c(-6, 4),
      panel = function(x,y, ...) {
          text(x, y, abbreviate(rownames(USairpollution)),cex = 0.6)
          bvbox(cbind(x,y), add = TRUE)
      })


unclass(loadings(.PC))
.PC$sd^2
summary(.PC)

summary(.PC, loadings=TRUE)
.PC$scores


