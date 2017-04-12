library(rattle)
weather=read.csv("weather.csv") 

weatherDS<-new.env()
evalq({
data=weather
nobs=nrow(data)
vars= -grep('^(Date|Locat|Risk)',names(weather))
set.seed(42)
train=sample(nobs, 0.7*nobs)
form=formula(RainTomorrow ~ .)
},weatherDS)

library(rpart)
weatherRPART<-new.env(parent=weatherDS)
evalq({
model=rpart(formula=form,data=data[train,vars])
},weatherRPART)

library(pmml)
export <-pmml(weatherRPART$model)
r=c(1:4,7,12,35,36,69,71,137:139)
cat(paste(strsplit(toString(export),"\n")[[1]][r], collapse="\n"))
