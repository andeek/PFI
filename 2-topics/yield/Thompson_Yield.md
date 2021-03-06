<hr>

### Load data and packages

    pfi <- read.csv("/Users/marianwaitwalsh/GitHub/PFI/data/PFI_clean.csv")
    library(dplyr)

    ## 
    ## Attaching package: 'dplyr'
    ## 
    ## The following object is masked from 'package:stats':
    ## 
    ##     filter
    ## 
    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

    library(tidyr)
    library(reshape2)
    library(ggplot2)

### Organize the data

    yields <- pfi %>%
      filter(item_type %in% c("Expense"), farmer == "Thompson") %>% 
      spread(item, value) %>% 
      select(-c(5))

    yields <- yields %>% mutate(year_before = year - 1) %>%
      left_join(select(yields, 1:4), 
                by=c("field_id" = "field_id", "year_before" = "year")) %>%
      select(-c(2,38))

    # Get crop yields
    value <- pfi %>% 
      filter(item_type %in% c("Unit Quantity"), farmer == "Thompson") %>%
      select(c(1,3,7))

    # Add crop yields to yields df
    yields <- yields %>% 
      left_join(value, by = c("field_id" = "field_id", "year" = "year")) %>%
      rename(crop = crop.x, prev_crop = crop.y, yield = value) %>%
      select(-3)

    # Reorder variables
    yields <- yields[,c(2,1,3,36,37,4:35)]

### Seperate out yields by crop

    corn <- yields %>% filter(crop == "Corn") %>%
      select(-3)
    sb <- yields %>% filter(crop == "SB") %>%
      select(-3)
    oats <- yields %>% filter(crop == "Oats") %>%
      select(-3)
    hay <- yields %>% filter(crop == "Hay") %>%
      select(-3)
