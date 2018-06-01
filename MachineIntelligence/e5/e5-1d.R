# Best Lambda_T is 10 for training set.
library(ggplot2)
library(MASS)
library(reshape2)

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

source("./lib/kfold.R")

train_set.df <- read.csv("../datasets/TrainingRidge.csv")
valid_set.df <- read.csv("../datasets/ValidationRidge.csv")

colnames(train_set.df) <- c("x1", "x2", "y")
colnames(valid_set.df) <- c("x1", "x2", "y")

train_set.params <- sphere(data.matrix(train_set.df[c(1, 2)]))
train_x <- train_set.params$whitedata

whiten_train.df <- data.frame(
    x1 = train_x[, 1],
    x2 = train_x[, 2],
    y = train_set.df$y
)

valid_set.params <- sphere(data.matrix(valid_set.df[c(1, 2)]))
valid_x <- valid_set.params$whitedata

whiten_valid.df <- data.frame(
    x1 = valid_x[, 1],
    x2 = valid_x[, 2],
    y = valid_set.df$y
)

fold_ready.df <- whiten_train.df

k_fold <- 10

monomial_lim <- 9

train_monos <- data.matrix(monomial2dim(whiten_train.df$x1, whiten_train.df$x2, monomial_lim))
valid_monos <- data.matrix(monomial2dim(whiten_valid.df$x1, whiten_valid.df$x2, monomial_lim))

# mse.df <- kfold_validate(fold_ready.df, k_fold, monomial_lim)

# train_mse.min <- min(mse.df$mse.val)

# min.idx <- which(mse.df$mse.val == train_mse.min)

# lambda_t <- 10**mse.df$lam[min.idx]

# print(paste("Lambda_T*=", 10**mse.df$lam[min.idx], sep = ""))

# valid_mse.df <- kfold_validate(whiten_valid.df, k_fold, monomial_lim)

# valid_mse.min <- min(valid_mse.df$mse.val)

# lambda_g <- 10**mse.df$lam[min.idx]

# min.idx <- which(valid_mse.df$mse.val == valid_mse.min)

# print(paste("Lambda_G*=", 10**mse.df$lam[min.idx], sep = ""))

# ggplot(valid_mse.df, aes(x = lambda, y = mse.val)) + geom_point() + geom_errorbar(aes(min = mse.val - std, max = mse.val + std))

# ggsave("./e5-1d-valid-mse.png")

lambda_t <- 5.01187233627272
lambda_g <- 0.0158489319246111

weight_t <- retrieve_weight(train_monos, train_set.df$y, lambda_t)
weight_g <- retrieve_weight(valid_monos, valid_set.df$y, lambda_g)

print("On trainig set:")

pyt <- t(weight_t) %*% train_monos
print(paste("WT-MSE=", mean((train_set.df$y - pyt)**2) , sep = ""))

pyg <- t(weight_g) %*% train_monos
print(paste("WG-MSE=", mean((train_set.df$y - pyg)**2) , sep = ""))

print("On validate set:")

pyt <- t(weight_t) %*% valid_monos
print(paste("WT-MSE=", mean((valid_set.df$y - pyt)**2) , sep = ""))

pyg <- t(weight_g) %*% valid_monos
print(paste("WG-MSE=", mean((valid_set.df$y - pyg)**2) , sep = ""))

plt.df <- data.frame(
    x1 = valid_set.df$x1,
    x2 = valid_set.df$x2,
    yp = c(pyg)
)

plt.melt.df <- melt(plt.df, id = c("x1", "x2"))

ggplot(plt.melt.df, aes(x = x1, y = x2, fill = value)) + geom_tile() + scale_fill_gradientn(colors = rainbow(50))

ggsave("./e5-1d-valid.png")