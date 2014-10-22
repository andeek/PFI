#pull in data
dat <- read.csv("data/PFI_clean.csv")
var <- read.csv("data/var_map.csv")

#libraries
library(dplyr)
library(ggplot2)

dat[complete.cases(dat),] %>% 
  filter(item_type == "Expense") %>%
  group_by(farmer, year, crop, field_id) %>%
  summarise(total = sum(value)) %>%
  group_by(farmer, year, crop) %>%
  summarise(avg_total = mean(total)) %>%
  ggplot() +
  geom_line(aes(x=year, y=avg_total, colour=crop)) +
  facet_wrap(~farmer) +
  ggtitle('Average expenses over time by crop')

dat %>% filter(item == 'Herbicides') %>%
  group_by(year, farmer) %>%
  summarise(avg=mean(value)) %>%
  ggplot() +
  geom_line(aes(x=year,  y=avg, colour=farmer, group=farmer))


#look at crop before
temp <- dat[complete.cases(dat),] %>% 
  filter(item_type == "Expense") %>%
  mutate(year_before = year - 1) %>%
  left_join(dat[complete.cases(dat) & dat$item_type=="Expense",], by=c("farmer" = "farmer", "year_before" = "year", "field_id" = "field_id")) %>%
  mutate(two_crops = paste(crop.y, crop.x, sep="-")) %>%
  group_by(farmer, year, two_crops, field_id) %>%
  summarise(total = sum(value.x)) %>%
  group_by(farmer, year, two_crops) %>%
  summarise(avg_total = mean(total))

temp <- cbind(temp, colsplit(temp$two_crops, "-", c('crop1', "crop2")))

temp[complete.cases(temp),] %>% filter(farmer=="Thompson") %>%
  ggplot(aes(x=crop1, y=crop2, z=avg_total)) +
  stat_bin2d() +
  scale_fill_gradient(low="#e5f5e0", high="#31a354") +
  ggtitle('Occurrence of sequential crops')

dat_before <- dat[complete.cases(dat),] %>% 
  filter(item_type == "Expense") %>%
  mutate(year_before = year - 1) %>%
  left_join(dat[complete.cases(dat) & dat$item_type=="Expense",], by=c("farmer" = "farmer", "year_before" = "year", "field_id" = "field_id")) %>%
  mutate(two_crops = paste(crop.y, crop.x, sep="-")) %>%
  group_by(farmer, year, two_crops, field_id) %>%
  summarise(total = sum(value.x)) %>%
  group_by(farmer, two_crops) %>%
  summarise(avg_total = mean(total))

dat_before <- cbind(dat_before, colsplit(dat_before$two_crops, "-", c('crop1', "crop2")))

dat_before[complete.cases(dat_before),] %>% filter(farmer=="Thompson") %>%
ggplot(aes(x=crop1, y=crop2, z=avg_total)) +
  stat_summary2d() +
  scale_fill_gradient(low="#e5f5e0", high="#31a354") +
  ggtitle('Expenses by sequential crops')

## Looks like Corn > SB and Corn > Oat is expensive, why?






  
