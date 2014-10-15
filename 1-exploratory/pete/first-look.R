pfi <- read.csv(file.choose())
library(dplyr)
library(ggplot2)

head(pfi)
levels(pfi$field_id)
summary(pfi$field_id)

levels(pfi$item)
levels(pfi$item_type)

pfi$value2 <- as.numeric(as.character(pfi$value))

#######################################################
# Income data
inc <- pfi %>%
  filter(item_type=="Income") %>%
  group_by(field_id, item) %>%
  summarize(mean = mean(value2),
            s = sd(value2),
            n = length(value2))
inc
inc2 <- pfi %>%
  select(field_id, year, item, value2) %>%
  filter(item=="Crop_Income") %>%
  group_by(field_id) %>%
  arrange(year)
qplot(year, value2, data=inc2, facets=~field_id) + ylab("Crop Income") +
  stat_smooth(method=loess)
inc3 <- pfi %>%
  select(field_id, year, item, value2) %>%
  filter(item=="Yield_Per_Acre_Bu_per_pound", field_id != "Thompson5") %>%
  group_by(field_id) %>%
  arrange(year)
inc3
qplot(year, value2, data=inc3, facets=~field_id) + 
  ylab("Yield per acre bu per pound") + stat_smooth(method=loess)
# Why are there so many 0 values for Residue_Income?
# Why is the Yield_Per_Acre_Bu / # so high for Thompson5?
# Which variable should we be most interested in?

# Expense data
exp <- pfi %>%
  filter(item_type=="Expense") %>%
  group_by(field_id, item) %>%
  summarize(mean = mean(value2),
            s = sd(value2),
            n = length(value2))
exp

# Cost data
cost <- pfi %>%
  filter(item_type=="Cost") %>%
  group_by(field_id, item) %>%
  summarize(mean = mean(value2),
            s = sd(value2),
            n = length(value2))
cost

# Crop data
crop <- pfi %>%
  filter(item_type=="Crop") %>%
  group_by(field_id) %>%
  summarize(crop_types = unique(value))
crop

# Labor data
labor <- pfi %>%
  filter(item_type=="Labor") %>%
  group_by(field_id, item) %>%
  summarize(mean = mean(value2),
            s = sd(value2),
            n = length(value2))
labor

