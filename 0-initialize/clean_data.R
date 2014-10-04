library(XLConnect)
library(plyr)
library(reshape2)

# Load workbook
wb <- loadWorkbook("data/Thomspon Farm Data.xlsx")

# Query available worksheets
sheet_names <- getSheets(wb)

# Pull in sheets
sheet_list <- lapply(sheet_names[-1], function(x){
  readWorksheet(wb, x)
})
names(sheet_list) <- sheet_names[-1]

# Remove average, total rows and combine sheets
sheet_list_clean <- llply(sheet_list, function(x){
  y <- x[-c(1, grep("Avg.", sheet_list[[1]][,1]), grep("Adv.", sheet_list[[1]][,1]),  grep("Total", sheet_list[[1]][,1])),]
  names(y) <- c("Variable", paste0("Thompson", 1:5), paste0("Boone", 1:2))
  y
})

dat <- ldply(sheet_list_clean, rbind)

# Map column names to types of variables
# There is information stored in "Labor Return" Column names, although not sure what it means
dat$Variable[grep("Labor Return", dat$Variable)] <- "Labor Return"
var_map <- read.csv("data/var_map.csv", header=TRUE)
dat <- merge(dat, var_map[,c("Column", "Var_Type")], by.x="Variable", by.y="Column", all.x=TRUE)

# Turn into valid variable names
dat$Variable <- gsub(",", "", gsub(" ", "_", gsub("^\\s+|\\s+$", "", gsub("\\$", "dollar", gsub("#", "pound", gsub("\\.", "", gsub("/", " per ", gsub("&", "and", dat$Variable))))))))

# Reshape to a usable form
crop.field <- melt(subset(dat, Variable == "Crop"), id.vars=c(".id", "Variable", "Var_Type"))
dat.m <- melt(subset(dat, Variable != "Crop"), id.vars=c(".id", "Variable","Var_Type"))
tmp <- merge(dat.m, crop.field, by=c('.id', 'variable'))
dat.m <- tmp[,c('.id', 'variable', 'value.y', 'Variable.x', 'Var_Type.x', 'value.x')]
names(dat.m) <- c("year", "field_id", "crop", "item", "item_type", "value")

# Data types
dat.m$crop <- as.factor(dat.m$crop)
dat.m$year <- as.numeric(dat.m$year)
dat.m$value <- as.numeric(dat.m$value)

write.csv(dat.m, "data/PFI_clean.csv", row.names=FALSE)
