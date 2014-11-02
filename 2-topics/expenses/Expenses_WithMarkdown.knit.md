---
title: "Expenses"
author: "Colin"
date: "Saturday, October 25, 2014"
output: pdf_document
---

#### Libraries 


```r
library(ggplot2)
library(dplyr)
library(tidyr)

##### Read in Data #####
#pfi <- read.csv("C:/Users/Colin LB/Documents/GitHub/PFI/data/PFI_clean.csv")
#let's try to work with relative paths so that code works for everyone.
pfi <- read.csv("../../data/PFI_clean.csv")
#Let's remove Land_Change since that's assumed the same for both farms.
##### Exploring #####
pfi[complete.cases(pfi),] %>% 
  filter(item_type == "Expense") %>%
  filter(crop %in% c("Corn")) %>%
  filter(item !="Land_Change") %>%
  filter(value > .01) %>%
  group_by(farmer, year, crop,field_id,item) %>%
  summarise(total = sum(value)) %>%
  group_by(farmer, year,item) %>%
  summarise(avg_total = mean(total)) %>%
  ggplot() +
  geom_line(aes(x=year, y=avg_total, colour=item)) +
  facet_wrap(~farmer) +
  ggtitle('Expenses over time for Corn Averaged Over Plots by Item')
```

![](./Expenses_WithMarkdown_files/figure-latex/unnamed-chunk-1-1.pdf) 

Let's just pull out the costs that seem "large"


```r
  pfi[complete.cases(pfi),] %>% 
  filter(item_type == "Expense") %>%
  filter(crop %in% c("Corn")) %>%
  filter(item %in% c("Purch_Pert","Seed","Herbicides")) %>%
  group_by(farmer, year, crop, field_id,item) %>%
  summarise(total = sum(value)) %>%
  group_by(farmer,year,item) %>%
  summarise(avg_total = mean(total)) %>%
  ggplot() +
  geom_line(aes(x=year, y=avg_total,color=item)) +
  facet_wrap(~farmer) +
  ggtitle('Expenses over time for Corn Averaged over Plots by Item')
```

![](./Expenses_WithMarkdown_files/figure-latex/unnamed-chunk-2-1.pdf) 
Let's plot the Difference In Expenses now

```r
  pfi[complete.cases(pfi),] %>% 
  filter(item_type == "Expense") %>%
  filter(crop %in% c("Corn")) %>%
  filter(item %in% c("Purch_Pert","Seed","Herbicides")) %>%
  group_by(farmer, year, crop, field_id,item) %>%
  summarise(total = sum(value)) %>%
  group_by(farmer,year,item) %>%
  summarise(avg_total = mean(total)) %>%
  spread(farmer,avg_total) %>%
  mutate(difference = Boone-Thompson) %>%
  ggplot() +
  geom_line(aes(x=year,y=difference,color=item)) +
  ggtitle('Difference (Boone-Thompson) in Average Expenses for Corn')
```

![](./Expenses_WithMarkdown_files/figure-latex/unnamed-chunk-3-1.pdf) 

Did we confirm what Purch_Pert is?  Let's look just at SB now.


```r
pfi[complete.cases(pfi),] %>% 
  filter(item_type == "Expense") %>%
  filter(crop %in% c("SB")) %>%
  filter(item !="Land_Change") %>%
  filter(value > .01) %>%
  group_by(farmer, year, crop,field_id,item) %>%
  summarise(total = sum(value)) %>%
  group_by(farmer, year,item) %>%
  summarise(avg_total = mean(total)) %>%
  ggplot() +
  geom_line(aes(x=year, y=avg_total, colour=item)) +
  facet_wrap(~farmer) +
  ggtitle('Expenses over time for SB Averaged Over Plots by Item')
```

![](./Expenses_WithMarkdown_files/figure-latex/unnamed-chunk-4-1.pdf) 

Let's look at the "large" expenses for SB


```r
pfi[complete.cases(pfi),] %>% 
  filter(item_type == "Expense") %>%
  filter(crop %in% c("SB")) %>%
  filter(item %in% c("Purch_Pert","Seed","Herbicides")) %>%
  group_by(farmer, year, crop, field_id,item) %>%
  summarise(total = sum(value)) %>%
  group_by(farmer,year,item) %>%
  ggplot() +
  geom_line(aes(x=year, y=total,color=item)) +
  facet_wrap(~farmer) +
  ggtitle('Expenses over time for SB')
```

![](./Expenses_WithMarkdown_files/figure-latex/unnamed-chunk-5-1.pdf) 

####Let's try and see all the expenses Thompson records as 0 vs. what Boone pays.


```r
q<-pfi[complete.cases(pfi),] %>% 
  filter(item_type == "Expense") %>%
  filter(crop %in% c("Corn")) %>%
  filter(item !="Land_Change") %>%
  filter(value==0 &farmer=="Thompson",field_id==1) %>%
  group_by(item)
  
unique(q$item)
```

```
##  [1] Drying_Cost     Bale_Hay        Stubble_Costs   Hedge_per_PL   
##  [5] Corn_RSL        Straw_Costs     Herbicides      Windrow_Oats   
##  [9] Mow_per_Windrow Rake            Spring_Tillage  Cover_Crop     
## [13] Fall_Tillage    Chop_StksCc     Spray_per_Walk  Apply_NH4      
## [17] Purch_Pert      Crop_Ins        Interest       
## 41 Levels: Apply_NH4 Bale_Hay Chop_StksCc ... Yield_Per_Acre_Bu_per_pound
```


```r
boone_extra_expense<-pfi[complete.cases(pfi),] %>% 
  filter(item_type == "Expense") %>%
  filter(farmer=="Boone") %>%
  filter(crop %in% c("Corn")) %>%
  filter(item %in% c("Apply_NH4","Hedge_per_PL","Corn_RSL","Herbicides","Spring_Tillage","Chop_StksCc","Spray_per_Walk","Purch_pert","Fall_Tillage")) %>%
  filter(value>.01) %>%
  group_by(year,item) %>%
  summarise(total = sum(value)) %>%
  ggplot() +
  geom_line(aes(x=year, y=total,linetype=item)) +
  ggtitle('Boone Extra Expenses for Corn')

boone_extra_expense
```

![](./Expenses_WithMarkdown_files/figure-latex/unnamed-chunk-7-1.pdf) 




