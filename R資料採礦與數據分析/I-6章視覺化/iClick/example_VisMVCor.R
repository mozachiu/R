load("iClick.VisMVCor.RData")

#dat=read.csv("returnsDaily24.csv") 
dat=read.csv("weather.csv")
dat=read.csv("Cars93.csv")

head(dat)
iClick.VisMVCor(dat)

 load("iClick.VisMVCor.RData")
 save("iClick.VisMVCor","oneClickMenuMvAsset","oneClickMenuMvAsset.env","panel.corrgram","panel.corrgram.2",file="iClick.VisMVCor.RData")