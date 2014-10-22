##### Libraries #####
library(ggplot2)
library(reshape2)
library(plyr)
library(gridExtra)

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
years2 <- years2[!is.na(years2[,3]),]
years2$practice<-as.factor(sub("[0-9].*", "", years2$field))
dat$practice<-sub("[0-9].*", "", dat$field_id)

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


dat<-dat[!is.na(dat[,3]),]

income_crop<-ddply(years2, .(year, practice, crop), summarize,
      mean_income = mean(Crop_Income))
income<-ddply(income_crop, .(year, practice), summarize,
              mean_income=mean(mean_income))
expense_crop<-ddply(dat[dat$item_type=="Expense",], .(year, field_id, crop), summarize,
      expense = sum(value))
expense_crop$field_id<-as.factor(sub("[0-9].*", "", expense_crop$field_id))

expense_crop2<-ddply(expense_crop, .(year, field_id, crop), summarize,
                    expense=mean(expense))

expense<-ddply(expense_crop2, .(year, field_id), summarize,
               mean_expense=mean(expense))

add_income<-ddply(years2, .(year, practice, crop), summarize,
              extra_income=mean(Pasture_per_Stubble + Residue_Income + Straw_Income))

income_crop$extra<-add_income$extra_income
income2<-ddply(income_crop, .(year, practice), summarize,
              mean_totalincome=mean(mean_income+extra))

names(expense)[2]<-"practice"
names(expense_crop2)[2]<-"practice"

df<-merge(income, expense)
df$rawprofit <- df$mean_income - df$mean_expense
df$profit_extra <- income2$mean_totalincome - df$mean_expense

theme_set(theme_bw(base_family="serif"))
p1<-qplot(data=df, x=year, y=rawprofit, group=practice, colour=practice, geom="line", ylab="Income/Acre", xlab="Year", main="Average Profit/Acre/Year Using Crop Income") + theme(legend.position="bottom")

p2<-qplot(data=df, x=year, y=profit_extra, group=practice, colour=practice, geom="line", ylab="Income/Acre", xlab="Year", main="Average Profit/Acre/Year Using All Income") + theme(legend.position="bottom")

grid.arrange(p1,p2,ncol=2)
df
df2<-merge(income_crop, expense_crop2)
df2<-df2[df2$crop=="Corn" | df2$crop=="SB",]
df2$profitall <- df2$mean_income - df2$expense + df2$extra
df2$profitcrop <- df2$mean_income - df2$expense
df2$allincome <- df2$mean_income + df2$extra

p3<-qplot(data=df2, x=year, y=profitcrop, colour=practice, group=practice, ylim=c(-250,900), geom="line",ylab="Income/Acre", xlab="Year", main="Average Profit/Acre/Year Using Crop Income") + facet_wrap(~crop)

p4<-qplot(data=df2, x=year, y=profitall, colour=practice, group=practice, ylim=c(-250,900), geom="line",ylab="Income/Acre", xlab="Year", main="Average Profit/Acre/Year Using All Income") + facet_wrap(~crop)

grid.arrange(p3,p4,ncol=1)


p5<-qplot(data=df2, x=year, y=mean_income, colour=practice, group=practice, ylim=c(150,1600), geom="line",ylab="Income/Acre", xlab="Year", main="Average Income/Acre/Year Using Crop Income") + facet_wrap(~crop)
p6<-qplot(data=df2, x=year, y=allincome, colour=practice, group=practice, ylim=c(150,1600), geom="line",ylab="Income/Acre", xlab="Year", main="Average Income/Acre/Year Using All Income") + facet_wrap(~crop)

grid.arrange(p5,p6,ncol=1)

qplot(data=df2, x=year, y=expense, colour=practice, group=practice, geom="line",ylab="Income/Acre", xlab="Year", main="Average Income/Acre/Year Using All Income") + facet_wrap(~crop)





expense_vars<-dat[dat$item_type=="Expense",]
expense_vars

test<-ddply(expense_vars, .(year, crop, practice, item), summarize,
      mean_expense=mean(value))

test2<-ddply(test, .(practice, item), summarize,
             mean_expense=mean(mean_expense))

qplot(data=test2, x=reorder(item, mean_expense, sum), y=mean_expense, fill=practice, geom="bar", stat="identity", position="stack") + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))





test<-test[!is.na(test$mean_income),]
income.adj <- ddply(test, .(year, practice), summarize,
                    overallmean = mean(mean_income))

qplot(data=income.adj, x=year, y=overallmean, geom="line", colour=practice) + geom_line(aes(x=year, y=mean_income), data=test2[test2$practice=="Thompson",], inherit.aes=F)

test2<-ddply(years2, .(year, practice), summarize,
            overallmean = mean(Crop_Income, na.rm=T))

qplot(data=test2, x=year, y=overallmean, geom="line", colour=practice) + theme(legend.position="bottom")

diff <- income.adj$overallmean[income.adj$practice=="Boone"] - income.adj$overallmean[income.adj$practice=="Thompson"]
diff2 <- test2$overallmean[test2$practice=="Boone"] - test2$overallmean[test2$practice=="Thompson"]
qplot(x=c(1988:2012), y=diff2) + geom_smooth()

fit.lm <- lm(data=income.adj, overallmean ~ (year + I(year^2))*practice)
income.adj$fit <- fit.lm$fitted
income.adj$resid <- fit.lm$resid
qplot(data=income.adj, x=year, y=fit, geom="line", group=practice, colour=practice) + geom_point(aes(y=overallmean))

