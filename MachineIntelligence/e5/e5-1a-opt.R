library(ggplot2)

script.dir <- dirname(sys.frame(1)$ofile)

setwd(script.dir)

train_set.df <- read.csv("../datasets/TrainingRidge.csv")

validate_set.df <- read.csv("../datasets/ValidationRidge.csv")

source("./lib/whitening.R")

train_x <- t(data.matrix(train_set.df[c(1, 2)]))

train_x.white <- whiten(train_x)
val_x.white <- whiten(t(data.matrix(validate_set.df[c(1, 2)])))

# str(train_x.white)

ggplot(train_set.df, aes(x = x1, y = x2, fill = obs)) + geom_tile() + scale_fill_gradientn(colors = rainbow(50))
ggsave("e5-1a-train.png")

ggplot(validate_set.df, aes(x = x1, y = x2, fill = dens)) + geom_tile() + scale_fill_gradientn(colors = rainbow(50))
ggsave("e5-1a-val.png")