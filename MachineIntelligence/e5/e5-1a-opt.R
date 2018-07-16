library(ggplot2)

script.dir <- dirname(sys.frame(1)$ofile)

setwd(script.dir)

train_set.df <- read.csv("../datasets/TrainingRidge.csv")

validate_set.df <- read.csv("../datasets/ValidationRidge.csv")

source("./lib/whitening.R")

train_x <- data.matrix(train_set.df[c(1, 2)])

train_x.white <- whiten(train_x)
val_x.white <- whiten(data.matrix(validate_set.df[c(1, 2)]), train_x.white$params)

ggplot(train_set.df, aes(x = x1, y = x2, fill = obs)) + scale_color_gradientn(colors = rainbow(50)) + geom_point(aes(color = obs))
ggsave("e5-1a-train.png")

ggplot(validate_set.df, aes(x = x1, y = x2, fill = dens)) +  scale_color_gradientn(colors = rainbow(50)) + geom_point(aes(color = dens))
ggsave("e5-1a-val.png")

train_set.whitendf <- data.frame(
    x1 = train_x.white$whitedata[, 1],
    x2 = train_x.white$whitedata[, 2],
    obs = train_set.df$obs
)

ggplot(train_set.whitendf, aes(x = x1, y = x2)) + geom_point(aes(color = obs)) + scale_color_gradientn(colors = rainbow(50))#geom_tile()# + scale_fill_gradientn(colors = rainbow(50))
ggsave("e5-1a-train-whiten.png")

# str(train_set.whitendf)

validate_set.whitendf <- data.frame(
    x1 = val_x.white$whitedata[, 1],
    x2 = val_x.white$whitedata[, 2],
    obs = validate_set.df$dens
)

ggplot(validate_set.whitendf, aes(x = x1, y = x2)) + geom_point(aes(color = obs)) + scale_color_gradientn(colors = rainbow(50))
    #geom_tile() + scale_fill_gradientn(colors = rainbow(50))
ggsave("e5-1a-val-whiten.png")