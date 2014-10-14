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

rev_exp_compare <- ddply(subset(dat, item_type %in% c("Revenue", "Expense")), 
      .(year, substring(field_id, 1, nchar(as.character(field_id)) - 1), item_type),
      summarise,
      avg = mean(value))
names(rev_exp_compare)[2] <- "farmer"

ggplot(data=rev_exp_compare) +
  geom_line(aes(year, avg, group=farmer, colour=farmer)) + 
  facet_wrap(~item_type, scales="free_y")

return_compare <- ddply(subset(dat, item %in% c("LaborandMR_dollar_per_A", "Labor_Return")),
                        .(year, substring(field_id, 1, nchar(as.character(field_id)) - 1), item),
                        summarise,
                        avg=mean(value))
names(return_compare)[2] <- "farmer"
                        
ggplot(data=return_compare) +
  geom_line(aes(year, avg, group=farmer, colour=farmer)) +
  facet_wrap(~item, scales="free_y")


## Moving average -- 5 year
library(dplyr)
ma <- function(x,n=5){stats::filter(x,rep(1/n,n), sides=2)}

return_compare_filter <- return_compare %>% group_by(farmer, item) %>%
  mutate(ma_avg = ma(avg))

ggplot(data=return_compare_filter) +
  geom_line(aes(year, ma_avg, group=farmer, colour=farmer)) +
  geom_line(aes(year, avg, group=farmer, colour=farmer), lty=2) +
  facet_wrap(~item, scales="free_y")

## It seems like there is a stark difference in the rate of return post 2000. 
## Explore what that difference might be
dat$post_2000 <- dat$year >= 2000
dat$farmer <- with(dat, substring(field_id, 1, nchar(as.character(field_id)) - 1))

rev_exp_by_crop <- dat %>% filter(item_type %in% c("Revenue", "Expense")) %>%
  group_by(farmer, crop, item_type, year, post_2000) %>%
  summarise(avg = mean(value))

ggplot(rev_exp_by_crop) +
  geom_bar(aes(as.character(year), avg, fill=crop), position="fill", stat="identity") +
  facet_grid(farmer~item_type)
ggplot(rev_exp_by_crop) +
  geom_bar(aes(as.character(year), avg, fill=crop), position="stack", stat="identity") +
  facet_grid(farmer~item_type)

