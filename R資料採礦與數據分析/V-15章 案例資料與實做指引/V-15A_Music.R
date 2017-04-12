dat <- read.csv("musicDownload_raw.csv")
dat[1:19,]
length(dat$user)   ## 289,955 records in the file
dat$user <- factor(dat$user)
levels(dat$user)   ## 15,000 users
levels(dat$artist) ##  1,004 artists

library(arules) ## a-rules package for association rules
## Computational environment for mining association rules and 
## frequent item sets 

## we need to manipulate the data a bit for arules
playlist0 <- split(x=dat[,"artist"],f=dat$user) ## split into a list of users
playlist <- lapply(playlist0,unique)     ## remove artist duplicates

save(playlist,file="playlist.RData")

USER=unique(dat$user)

newData=NULL
for (j in USER){
cmd=paste("playlist$'",j,"'",sep="")
artists=eval(parse(text = cmd))
tmp=data.frame(j,artists)
colnames(tmp)=c("userID","Items")
newData=rbind(newData,tmp)

}


## the first two listeners (1 and 3) listen to the following bands 

playlist <- as(playlist,"transactions") 