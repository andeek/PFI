pfi <- read.csv(file.choose())
library(plyr)
library(dplyr)
library(ggplot2)


head(pfi)
levels(pfi$field_id)
summary(pfi$field_id)

levels(pfi$item)
levels(pfi$item_type)

pfi$value2 <- as.numeric(as.character(pfi$value))

#time series of crop income
b1_cropinc <- cbind(pfi$year[which(pfi$field_id=="Boone1" & pfi$item=="Crop_Income")],pfi$value2[which(pfi$field_id=="Boone1" & 
              pfi$item=="Crop_Income")])
colnames(b1_cropinc) <- c("year","cropinc")

b2_cropinc <- cbind(pfi$year[which(pfi$field_id=="Boone2" & pfi$item=="Crop_Income")],pfi$value2[which(pfi$field_id=="Boone2" & 
                                                                                                         pfi$item=="Crop_Income")])
colnames(b2_cropinc) <- c("year","cropinc")

t1_cropinc <- cbind(pfi$year[which(pfi$field_id=="Thompson1" & pfi$item=="Crop_Income")],pfi$value2[which(pfi$field_id=="Thompson1" & 
                                                                                                         pfi$item=="Crop_Income")])
colnames(t1_cropinc) <- c("year","cropinc")

t2_cropinc <- cbind(pfi$year[which(pfi$field_id=="Thompson2" & pfi$item=="Crop_Income")],pfi$value2[which(pfi$field_id=="Thompson2" & 
                                                                                                            pfi$item=="Crop_Income")])
colnames(t2_cropinc) <- c("year","cropinc")

t3_cropinc <- cbind(pfi$year[which(pfi$field_id=="Thompson3" & pfi$item=="Crop_Income")],pfi$value2[which(pfi$field_id=="Thompson3" & 
                                                                                                            pfi$item=="Crop_Income")])
colnames(t3_cropinc) <- c("year","cropinc")

t4_cropinc <- cbind(pfi$year[which(pfi$field_id=="Thompson4" & pfi$item=="Crop_Income")],pfi$value2[which(pfi$field_id=="Thompson4" & 
                                                                                                            pfi$item=="Crop_Income")])
colnames(t4_cropinc) <- c("year","cropinc")

t5_cropinc <- cbind(pfi$year[which(pfi$field_id=="Thompson5" & pfi$item=="Crop_Income")],pfi$value2[which(pfi$field_id=="Thompson5" & 
                                                                                                            pfi$item=="Crop_Income")])
colnames(t5_cropinc) <- c("year","cropinc")

#time series of crop income, red is neighbor, black is Thompson
#It doesn't look like he's doing much better than his neighbor

ggplot(data.frame(b1_cropinc),aes(year,cropinc),col="red")+geom_point(col="red")+
geom_line(col="red")+geom_point(data=data.frame(b2_cropinc),aes(year,cropinc),col="red")+
  geom_line(data=data.frame(b2_cropinc),aes(year,cropinc),col="red")+geom_point(data=data.frame(t1_cropinc),aes(year,cropinc),col="black")+
  geom_line(data=data.frame(t1_cropinc),aes(year,cropinc),col="black")+geom_point(data=data.frame(t2_cropinc),aes(year,cropinc),col="black")+
  geom_line(data=data.frame(t2_cropinc),aes(year,cropinc),col="black")+geom_point(data=data.frame(t3_cropinc),aes(year,cropinc),col="black")+
  geom_line(data=data.frame(t3_cropinc),aes(year,cropinc),col="black")+geom_point(data=data.frame(t4_cropinc),aes(year,cropinc),col="black")+
  geom_line(data=data.frame(t4_cropinc),aes(year,cropinc),col="black")+geom_point(data=data.frame(t5_cropinc),aes(year,cropinc),col="black")+
  geom_line(data=data.frame(t5_cropinc),aes(year,cropinc),col="black")

#Time Series for Crop Yield Per Acre

b1_yield <- cbind(pfi$year[which(pfi$field_id=="Boone1" & pfi$item=="Yield_Per_Acre_Bu_per_pound")],pfi$value2[which(pfi$field_id=="Boone1" & 
                                                                                                         pfi$item=="Yield_Per_Acre_Bu_per_pound")])
colnames(b1_yield) <- c("year","yield")

b2_yield <- cbind(pfi$year[which(pfi$field_id=="Boone2" & pfi$item=="Yield_Per_Acre_Bu_per_pound")],pfi$value2[which(pfi$field_id=="Boone2" & 
                                                                                                                       pfi$item=="Yield_Per_Acre_Bu_per_pound")])
colnames(b2_yield) <- c("year","yield")

t1_yield <- cbind(pfi$year[which(pfi$field_id=="Thompson1" & pfi$item=="Yield_Per_Acre_Bu_per_pound")],pfi$value2[which(pfi$field_id=="Thompson1" & 
                                                                                                                       pfi$item=="Yield_Per_Acre_Bu_per_pound")])
colnames(t1_yield) <- c("year","yield")

t2_yield <- cbind(pfi$year[which(pfi$field_id=="Thompson2" & pfi$item=="Yield_Per_Acre_Bu_per_pound")],pfi$value2[which(pfi$field_id=="Thompson2" & 
                                                                                                                          pfi$item=="Yield_Per_Acre_Bu_per_pound")])
colnames(t2_yield) <- c("year","yield")

t3_yield <- cbind(pfi$year[which(pfi$field_id=="Thompson3" & pfi$item=="Yield_Per_Acre_Bu_per_pound")],pfi$value2[which(pfi$field_id=="Thompson3" & 
                                                                                                                          pfi$item=="Yield_Per_Acre_Bu_per_pound")])
colnames(t3_yield) <- c("year","yield")

t4_yield <- cbind(pfi$year[which(pfi$field_id=="Thompson4" & pfi$item=="Yield_Per_Acre_Bu_per_pound")],pfi$value2[which(pfi$field_id=="Thompson4" & 
                                                                                                                          pfi$item=="Yield_Per_Acre_Bu_per_pound")])
colnames(t4_yield) <- c("year","yield")

t5_yield <- cbind(pfi$year[which(pfi$field_id=="Thompson5" & pfi$item=="Yield_Per_Acre_Bu_per_pound")],pfi$value2[which(pfi$field_id=="Thompson5" & 
                                                                                                                          pfi$item=="Yield_Per_Acre_Bu_per_pound")])
colnames(t5_yield) <- c("year","yield")


ggplot(data.frame(b1_yield),aes(year,yield),col="red")+geom_point(col="red")+
  geom_line(col="red")+geom_point(data=data.frame(b2_yield),aes(year,yield),col="red")+
  geom_line(data=data.frame(b2_yield),aes(year,yield),col="red")+geom_point(data=data.frame(t1_yield),aes(year,yield),col="black")+
  geom_line(data=data.frame(t1_yield),aes(year,yield),col="black")+geom_point(data=data.frame(t2_yield),aes(year,yield),col="black")+
  geom_line(data=data.frame(t2_yield),aes(year,yield),col="black")+geom_point(data=data.frame(t3_yield),aes(year,yield),col="black")+
  geom_line(data=data.frame(t3_yield),aes(year,yield),col="black")+geom_point(data=data.frame(t4_yield),aes(year,yield),col="black")+
  geom_line(data=data.frame(t4_yield),aes(year,yield),col="black")

#Thompson5 was left off as it's values are on another scale and mess up the graph.
#No obvious patterns seem to exist when comparing yields for Thompson vs. Boone.



