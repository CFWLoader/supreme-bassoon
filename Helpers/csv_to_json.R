library(rjson)

script.dir <- dirname(sys.frame(1)$ofile)

setwd(script.dir)

input.df <- read.csv("../../va_data/catalog_seasfac_cus.csv")

# print(str(input.df))

# print(head(input.df$men))

target.column <- as.numeric(input.df$men)

write.table(toJSON(target.column), './cata_men.json', row.names = FALSE, col.names = FALSE, quote = FALSE)