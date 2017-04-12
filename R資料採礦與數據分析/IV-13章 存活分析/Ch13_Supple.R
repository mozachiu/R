## ¹Ï15.2-4
dat=read.csv("heroin.csv")
.Survfit <- survfit(Surv(time, status) ~ clinic, conf.type="log",conf.int=0.95, type="kaplan-meier", error="greenwood", data=dat)
.Survfit
plot(.Survfit, col=1:2, lty=1:2, mark.time=TRUE)
legend("bottomleft", legend=c("Clinic 1","Clinic 2"), title="clinic", col=1:2, lty=1:2, bty="n")
quantile(.Survfit, probs=c(.25,.5,.75))


## ¹Ï15.2-7
out1=coxph(formula = Surv(time, status) ~ prison + dose + strata(clinic), data = dat)
summary(out1)


