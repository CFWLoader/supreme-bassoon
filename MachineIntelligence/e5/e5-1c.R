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

monomial_lim <- 10

valid.mono.df <- monomial2dim(x1.val, x2.val, monomial_lim)
train.mono.df <- monomial2dim(x1, x2, monomial_lim)
expand_val_x <- data.matrix(valid.mono.df)

# retrieve_weight(train.mono.df, train_set.df$obs, -4)

mse.df <- NULL

for(lam in seq(-4, 4, 0.1))
{
    weight <- retrieve_weight(train.mono.df, train_set.df$obs, 10**lam)
    y_prd <- t(weight) %*% expand_val_x 
    mse <- mean((y_prd - validate_set.df$dens)**2)
    mse.df <- rbind(mse.df,
        data.frame(
            lambda = lam,
            mse.val = mse
        )
    )
}

ggplot(mse.df, aes(x = lambda, y = mse.val)) + geom_line()

ggsave("./e5-1c-mse.png")