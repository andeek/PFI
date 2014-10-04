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

#time series with all plots

plot(b1_cropinc,col="black")
points(b2_cropinc,col="black")
points(t1_cropinc,col="red")
points(t2_cropinc,col="red")
points(t3_cropinc,col="red")
points(t4_cropinc,col="red")
points(t5_cropinc,col="red")
