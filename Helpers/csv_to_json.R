library(rjson)

script.dir <- dirname(sys.frame(1)$ofile)

setwd(script.dir)

input.df <- read.csv("../tsa_demo/dataset/cata_men_na.csv")

# print(str(input.df))

# print(head(input.df$men))

target.column <- as.numeric(input.df$X.TS.men)

write.table(toJSON(target.column), './cata_men_na.json', row.names = FALSE, col.names = FALSE, quote = FALSE)