library(ggplot2)
library(reshape2)

script.dir <- dirname(sys.frame(1)$ofile)

setwd(script.dir)

train_set.df <- read.csv("../datasets/TrainingRidge.csv")

validate_set.df <- read.csv("../datasets/ValidationRidge.csv")

source("./lib/whitening.R")

train_x <- data.matrix(train_set.df[c(1, 2)])

informas <- sphere(train_x)

print(str(informas))

sphered_x <- informas$whitedata

# print(str(sphered_x))

deco.df <- melt(sphered_x %*% t(sphered_x))

ggplot(data = deco.df, aes(x = Var1, y = Var2, fill = value)) + geom_tile()

ggsave("./e5-1a-rev1-decor.png")

# params <- whiten_params(train_x)