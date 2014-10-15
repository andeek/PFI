##### Libraries #####
library(ggplot2)
library(reshape2)

##### Read in Data #####
dat <- read.csv("data/PFI_clean.csv")
var <- read.csv("data/var_map.csv")

##### First Looks #####
years <- split(dat, dat$year)
fields <- split(dat, dat$field_id)

byyear <- lapply(years, function(u) acast(u, field_id~item, value.var="value"))

byfield <- lapply(fields, function(u) acast(u, year~item, value.var="value"))

years2 <- data.frame(year=rep(unique(dat$year), each=9), field=rep(levels(dat$field_id), 25), do.call(rbind, byyear))
fields2 <- data.frame(year=rep(unique(dat$year), 9), field=rep(levels(dat$field_id), each=25), do.call(rbind, byfield))
years2$crop <- as.factor(unique(data.frame(dat$year,dat$field_id, dat$crop))[,3])

test <- prcomp(full_expenses[,-c(1:2)])
summary(test)
byyear[[1]]

#### Plots ####
head(dat)
qplot(data=years2, x=year, y=Crop_Income, geom="line", group=field, colour=field, size=I(1)) + theme_bw() + theme(legend.position="bottom")
qplot(data=years2, x=crop, y=Crop_Income, geom="boxplot", fill=crop) + theme_bw() + theme(legend.position="none") 
qplot(data=years2, x=year, y=Crop_Income, colour=field) + facet_wrap(~crop) + theme_bw() + theme(legend.position="bottom")

dat[dat$field_id=="Thompson1",]$crop 
dat[dat$field_id=="Thompson2",]$crop
dat[dat$field_id=="Thompson3",]$crop 
dat[dat$field_id=="Thompson4",]$crop
dat[dat$field_id=="Thompson5",]$crop ### erm what?

years2$practice<-sub("[0-9].*", "", years2$field)

test<-ddply(years2, .(year, practice, crop), summarize,
      mean_income = mean(Crop_Income))
test<-test[!is.na(test$mean_income),]
income.adj <- ddply(test, .(year, practice), summarize,
                    overallmean = mean(mean_income))

qplot(data=income.adj, x=year, y=overallmean, geom="line", colour=practice) + geom_line(aes(x=year, y=mean_income), data=test2[test2$practice=="Thompson",], inherit.aes=F)

test2<-ddply(years2, .(year, practice), summarize,
            overallmean = mean(Crop_Income, na.rm=T))

qplot(data=test2, x=year, y=overallmean, geom="line", colour=practice)

diff <- income.adj$overallmean[income.adj$practice=="Boone"] - income.adj$overallmean[income.adj$practice=="Thompson"]
diff2 <- test2$overallmean[test2$practice=="Boone"] - test2$overallmean[test2$practice=="Thompson"]
qplot(x=c(1988:2012), y=diff2) + geom_smooth()

fit.lm <- lm(data=income.adj, overallmean ~ (year + I(year^2))*practice)
income.adj$fit <- fit.lm$fitted
income.adj$resid <- fit.lm$resid
qplot(data=income.adj, x=year, y=fit, geom="line", group=practice, colour=practice) + geom_point(aes(y=overallmean))

