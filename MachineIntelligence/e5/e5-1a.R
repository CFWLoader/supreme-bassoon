script.dir <- dirname(sys.frame(1)$ofile)

setwd(script.dir)

train_set.df <- read.csv("../datasets/TrainingRidge.csv")

validate_set.df <- read.csv("../datasets/ValidationRidge.csv")

source("./lib/preprocess.R")

train_x <- data.matrix(train_set.df[c(1, 2)])

print(head(center_data.matrix(train_x)))

# print(str(validate_set.df))