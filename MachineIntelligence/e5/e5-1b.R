library(ggplot2)
library(MASS)

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

source("./lib/whitening.R")
source("./lib/monomial.R")

train_set.df <- read.csv("../datasets/TrainingRidge.csv")
validate_set.df <- read.csv("../datasets/ValidationRidge.csv")

packtmp <- sphere(data.matrix(train_set.df[c(1, 2)]))

sphere.params <- packtmp$params

train_x <- packtmp$whitedata

packtmp <- sphere(data.matrix(validate_set.df[c(1, 2)]), sphere.params)

val_x <- packtmp$whitedata

x1 <- train_x[, 1]
x2 <- train_x[, 2]
x1.val <- val_x[, 1]
x2.val <- val_x[, 2]

monomial_lim <- 3

valid.mono.df <- monomial2dim(x1.val, x2.val, monomial_lim)
expand_val_x <- data.matrix(valid.mono.df)

trained <- train_expand_param2dim(x1, x2, train_set.df$obs, monomial_lim)

y_prd <- t(trained$weight) %*% expand_val_x 

# y_prd <- t(weight) %*% expand_val_x 

valid_prd.df <- data.frame(
    x1 = x1.val,
    x2 = x2.val,
    yp = t(y_prd)
)

ggplot(valid_prd.df, aes(x = x1, y = x2, color = yp)) + geom_point() + scale_color_gradientn(colors = rainbow(50)) # + xlim(-1, 1) + ylim(-1, 1)

ggsave("./e5-1b-val-predict-m10.png")

monomial_lim <- 10

valid.mono.df <- monomial2dim(x1.val, x2.val, monomial_lim)
expand_val_x <- data.matrix(valid.mono.df)

trained <- train_expand_param2dim(x1, x2, train_set.df$obs, monomial_lim)

y_prd <- t(trained$weight) %*% expand_val_x 

valid_prd.df <- data.frame(
    x1 = x1.val,
    x2 = x2.val,
    yp = t(y_prd)
)

ggplot(valid_prd.df, aes(x = x1, y = x2, color = yp)) + geom_point() + scale_color_gradientn(colors = rainbow(50)) # + xlim(-1, 1) + ylim(-1, 1)

ggsave("./e5-1b-val-predict-m55.png")