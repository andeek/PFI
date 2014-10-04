#pull in data
dat <- read.csv("data/PFI_clean.csv")
var <- read.csv("data/var_map.csv")

#libraries
library(ggplot2)
library(plyr)
library(reshape2)


dat_2000 <- subset(dat, year == 2000)
dat_2000.sum <- ddply(dat_2000, .(field_id, crop, item_type), summarise, avg=mean(value), total=sum(value))

qplot(item_type, total, data=dat_2000.sum[-c(grep("Unit", dat_2000.sum$item_type), grep("Derived", dat_2000.sum$item_type)),], colour=substring(field_id, 1, nchar(as.character(field_id)) - 1)) + 
  facet_wrap(~crop) +
  scale_colour_discrete("Crop System")
