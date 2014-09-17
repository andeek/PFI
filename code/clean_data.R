##Hello Maggie!
## Hi Andee...

library(XLConnect)
library(plyr)

# Load workbook
wb <- loadWorkbook("data/Thomspon Farm Data.xlsx")

# Query available worksheets
sheet_names <- getSheets(wb)

# Pull in sheets
sheet_list <- lapply(sheet_names[-1], function(x){
  readWorksheet(wb, x)
})
names(sheet_list) <- sheet_names[-1]

# Remove average rows and combine sheets
sheet_list_clean <- llply(sheet_list, function(x){
  y <- x[-c(1, grep("Avg.", sheet_list[[1]][,1]), grep("Adv.", sheet_list[[1]][,1])),]
  names(y) <- c("Variable", paste0("Thompson", 1:5), paste0("Boone", 1:2))
  y
})

dat <- ldply(sheet_list_clean, rbind)

write.csv(dat, "data/PFI_clean.csv", row.names=FALSE)
