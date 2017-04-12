library(BCA)
library(kernlab)

##==== SVM
dat<-read.csv("HMDA.csv")
head(dat)
# Create a kernel function using the build in rbfdot function
rbf <- rbfdot(sigma=0.1)
rbf
# train a bound constraint support vector machine
HMDAmodel <- ksvm(Results~PI_RATIO+BLACK,data=dat,type="C-bsvc",kernel=rbf,C=10,prob.model=TRUE)
HMDAmodel 
# get fitted values
fitted(HMDAmodel)
# Test on the training set with probabilities as output
Pred=predict(HMDAmodel, dat[,c(2:3)], type="probabilities")
data.frame(dat$Results,Pred)

X=cbind(dat$PI_RATIO, dat$LOAN_VALUE)
Y=dat$Results
HMDAmodel2 <- ksvm(X,Y,type="C-svc")
HMDAmodel2
plot(HMDAmodel2,data=X,slice=list())

HMDAmodel3 <- ksvm(cbind(dat$PI_RATIO,dat$LOAN_VALUE),dat$Results,data=dat,type="C-svc");HMDAmodel3
dev.new()
plot(HMDAmodel3,data=cbind(dat$PI_RATIO,dat$LOAN_VALUE))

##====Neural Network
library(nnet)
dat$Sample <- create.samples(dat, est=0.7, val=0.15)
ID=dat$Sample=="Estimation"

HMDV.nn1 <- nnet(Results~PI_RATIO+BLACK,data=dat, subset = ID, size = 2, rang = 0.01,
decay = 5e-4, maxit = 200)
Pred=predict(HMDV.nn1, dat[-ID,], type = "class")
table(dat$Results[-ID], predict(HMDV.nn1, dat[-ID,], type = "class"))
Result=dat$Results[-nrow(dat)]
data.frame(Result,Pred)



