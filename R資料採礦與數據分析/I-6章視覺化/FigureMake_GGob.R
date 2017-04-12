library(DescribeDisplay)
d<-dd_load("Figure6.2-7.R")
plot(d)
print(ggplot2::ggplot(d))