#comment

crops<-read.csv("GitHub/PFI/data/PFI_clean.csv")

yieldperacres<-subset(crops,item=="Yield_Per_Acre_Bu_per_pound")

booneYield<-subset(yieldperacres,farmer=="Boone")

thompsonYield<-subset(yieldperacres,farmer=="Thompson")
library(plyr)
ThompsonAve<-ddply(thompsonYield,.(year,crop),transform,averageYield=ave(value))


cornThompson<-subset(ThompsonAve,crop=="Corn")
cornBoone<-subset(booneYield,crop=="Corn")

#StateLevelData

stateYield<-read.csv("GitHub/PFI/data/IowaYields.csv")
districtYield<-read.csv("GitHub/PFI/data/AgDistrictYields.csv")
countyYield<-read.csv("GitHub/PFI/data/BooneYields.csv")

stateYield<-subset(stateYield,Period=="YEAR")
districtYield<-subset(districtYield,Period=="YEAR")
countyYield<-subset(countyYield,Period=="YEAR")

cornState<-subset(stateYield,Commodity=="CORN")
cornDistrict<-subset(districtYield,Commodity=="CORN")
cornCounty<-subset(countyYield,Commodity=="CORN")

sbState<-subset(stateYield,Commodity=="SOYBEANS")
sbDistrict<-subset(districtYield,Commodity=="SOYBEANS")
sbCounty<-subset(countyYield,Commodity=="SOYBEANS")

hayState<-subset(stateYield,Commodity=="HAY")
hayDistrict<-subset(districtYield,Commodity=="HAY")
hayCounty<-subset(countyYield,Commodity=="HAY")

oatState<-subset(stateYield,Commodity=="OATS")
oatDistrict<-subset(districtYield,Commodity=="OATS")
oatCounty<-subset(countyYield,Commodity=="OATS")

plot(cornThompson$year,cornThompson$averageYield,type="l")
lines(cornBoone$year,cornBoone$value,col="red")
lines(cornState$Year,cornState$Value,col="blue")
lines(cornDistrict$Year,cornDistrict$Value,col="green")
lines(cornCounty$Year,cornCounty$Value,col="yellow")

soyThompson<-subset(ThompsonAve,crop=="SB")
soyBoone<-subset(booneYield,crop=="SB")




plot(soyThompson$year,soyThompson$averageYield,type="l")
lines(soyBoone$year,soyBoone$value,col="red")
lines(sbState$Year,sbState$Value,col="blue")
lines(sbDistrict$Year,sbDistrict$Value,col="green")
lines(sbCounty$Year,sbCounty$Value,col="yellow")

hayThompson<-subset(ThompsonAve,crop=="Hay")
hayThompson$averageYield<-hayThompson$averageYield/2000
plot(hayThompson$year,hayThompson$averageYield,type="l",col="black",ylim=c(2,8))
lines(hayDistrict$Year,hayDistrict$Value,col="green")
lines(hayState$Year,hayState$Value,col="blue")
lines(hayCounty$Year,hayCounty$Value,col="yellow")

oatsThompson<-subset(ThompsonAve,crop=="Oats")
plot(oatsThompson$year,oatsThompson$averageYield,type="l")
lines(oatState$Year,oatState$Value,col="blue")
lines(oatDistrict$Year,oatDistrict$Value,col="green")
lines(oatCounty$Year,oatCounty$Value,col="yellow")

cornThompsonField<-subset(thompsonYield,crop=="Corn")
library(ggplot2)
qplot(year,value,data=subset(thompsonYield,crop=="Corn"),col=as.factor(field_id),geom="Line",main="Corn")
qplot(year,value,data=subset(thompsonYield,crop=="Hay"),col=as.factor(field_id),geom="Line",main="Hay")
qplot(year,value,data=subset(thompsonYield,crop=="SB"),col=as.factor(field_id),geom="Line",main="SB")
qplot(year,value,data=subset(thompsonYield,crop=="Oats"),col=as.factor(field_id),geom="Line",main="Oats")



##past years results

yieldperacres
districtLevelYield<-districtYield[c(2,15,19)]
names(districtLevelYield)<-c("year","crop","distYield")
districtLevelYield$crop<-as.character(districtLevelYield$crop)
districtLevelYield$crop[districtLevelYield$crop=="CORN"]<-"Corn"
districtLevelYield$crop[districtLevelYield$crop=="HAY"]<-"Hay"
districtLevelYield$crop[districtLevelYield$crop=="OATS"]<-"Oats"
districtLevelYield$crop[districtLevelYield$crop=="SOYBEANS"]<-"SB"
yieldperacres$value[yieldperacres$crop=="Hay"]<-yieldperacres$value[yieldperacres$crop=="Hay"]/2000

previousCrop<-merge(yieldperacres,districtLevelYield,by=c("year","crop"))
previousCrop$yearBefore<-previousCrop$year-1

together<-merge(previousCrop,previousCrop[c(1,2,3,4)],by.x=c("yearBefore","farmer","field_id"),by.y=c("year","farmer","field_id"))
together$cropOrder<-paste(together$crop.y,together$crop.x,sep="-")
together$diffFromAverage<-together$value-together$distYield
qplot(year,diffFromAverage,data=subset(together,farmer=="Thompson"&crop.x=="Corn"),col=as.factor(cropOrder),geom="Line",main="Corn")#MAY SHOW SOMETHING
qplot(year,diffFromAverage,data=subset(together,farmer=="Thompson"&crop.x=="Oats"),col=as.factor(cropOrder),geom="Line",main="Oats")
qplot(year,diffFromAverage,data=subset(together,farmer=="Thompson"&crop.x=="Hay"),col=as.factor(cropOrder),geom="Line",main="Hay")
qplot(year,diffFromAverage,data=subset(together,farmer=="Thompson"&crop.x=="SB"),col=as.factor(cropOrder),geom="Line",main="SB")


qplot(year,value/distYield,data=subset(together,farmer=="Thompson"&crop.y=="Corn"),col=as.factor(cropOrder),geom="Line",main="Corn")#MAY SHOW SOMETHING
qplot(year,diffFromAverage,data=subset(together,farmer=="Thompson"&crop.y=="Oats"),col=as.factor(cropOrder),geom="Line",main="Oats")
qplot(year,diffFromAverage,data=subset(together,farmer=="Thompson"&crop.y=="Hay"),col=as.factor(cropOrder),geom="Line",main="Hay")
qplot(year,diffFromAverage,data=subset(together,farmer=="Thompson"&crop.y=="SB"),col=as.factor(cropOrder),geom="Line",main="SB")



qplot(year,value,data=subset(together,farmer=="Thompson"&crop.x=="Corn"),col=as.factor(cropOrder),geom="Line",main="Corn")  
qplot(year,value,data=subset(together,farmer=="Thompson"&crop.x=="Oats"),col=as.factor(cropOrder),geom="Line",main="Oats")
qplot(year,value,data=subset(together,farmer=="Thompson"&crop.x=="Hay"),col=as.factor(cropOrder),geom="Line",main="Hay")
qplot(year,value,data=subset(together,farmer=="Thompson"&crop.x=="SB"),col=as.factor(cropOrder),geom="Line",main="SB")


qplot(year,value,data=subset(together,farmer=="Thompson"&crop.y=="Corn"),col=as.factor(cropOrder),geom="Line",main="Corn")
qplot(year,value,data=subset(together,farmer=="Thompson"&crop.y=="Oats"),col=as.factor(cropOrder),geom="Line",main="Oats")
qplot(year,value,data=subset(together,farmer=="Thompson"&crop.y=="Hay"),col=as.factor(cropOrder),geom="Line",main="Hay")
qplot(year,value,data=subset(together,farmer=="Thompson"&crop.y=="SB"),col=as.factor(cropOrder),geom="Line",main="SB")
