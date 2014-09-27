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

# Why are there so many 0 values for Residue_Income?
# Why is the Yield_Per_Acre_Bu / # so high for Thompson5?
# Which variable should we be most interested in?

# -----------------------------------------------------
# Yield_Per_Acre_Bu_Per_Pound
inc_mean <- c(inc[6,3], inc[12,3], inc[18,3],
              inc[24,3], inc[30,3], inc[36,3],
              inc[42,3])
inc_s <- c(inc[6,4], inc[12,4], inc[18,4],
           inc[24, 4], inc[30,4], inc[36,4],
           inc[42,4])
n = 25

b1_inc <- pfi$value2[which(pfi$field_id=="Boone1" & 
                             pfi$item=="Yield_Per_Acre_Bu_per_pound")]
b2_inc <- pfi$value2[which(pfi$field_id=="Boone2" &
                             pfi$item=="Yield_Per_Acre_Bu_per_pound")]
t1_inc <- pfi$value2[which(pfi$field_id=="Thompson1" &
                             pfi$item=="Yield_Per_Acre_Bu_per_pound")]
t2_inc <- pfi$value2[which(pfi$field_id=="Thompson2" &
                             pfi$item=="Yield_Per_Acre_Bu_per_pound")]
t3_inc <- pfi$value2[which(pfi$field_id=="Thompson3" &
                             pfi$item=="Yield_Per_Acre_Bu_per_pound")]
t4_inc <- pfi$value2[which(pfi$field_id=="Thompson4" &
                             pfi$item=="Yield_Per_Acre_Bu_per_pound")]
t5_inc <- pfi$value2[which(pfi$field_id=="Thompson5" &
                             pfi$item=="Yield_Per_Acre_Bu_per_pound")]
# Check assumptions for normality
qplot(b1_inc, geom="histogram", binwidth=5)
qqnorm(b1_inc)
qqline(b1_inc)
qplot(b2_inc, geom="histogram", binwidth=5)
qqnorm(b2_inc)
qqline(b2_inc)
qplot(t1_inc, geom="histogram", binwidth=10)
qqnorm(t1_inc)
qqline(t1_inc)
qplot(t2_inc, geom="histogram", binwidth=5)
qqnorm(t2_inc)
qqline(t2_inc)
qplot(t3_inc, geom="histogram", binwidth=10)
qqnorm(t3_inc)
qqline(t3_inc)
qplot(t4_inc, geom="histogram", binwidth=10)
qqnorm(t4_inc)
qqline(t4_inc)
qplot(t5_inc, geom="histogram", binwidth=1000)
qqnorm(t5_inc)
qqline(t5_inc)

# Conduct t-tests for differences in means
