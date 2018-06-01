library(ggplot2)
library(MASS)

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

source("./lib/whitening.R")
source("./lib/monomial.R")

train_set.df <- read.csv("../datasets/TrainingRidge.csv")

packtmp <- sphere(data.matrix(train_set.df[c(1, 2)]))
sphere.params <- packtmp$params
train_x <- packtmp$whitedata

whiten_train.df <- data.frame(
    x1 = train_x[, 1],
    x2 = train_x[, 2],
    y = train_set.df$obs
)

fold_ready.df = whiten_train.df

k_fold <- 10

monomial_lim <- 9

pack_size <- floor(nrow(whiten_train.df) / k_fold)

folded_pack <- list()

for(k in c(1:k_fold))
{
    start_idx <- 1 + (k - 1) * pack_size
    end_idx <- k * pack_size
    fold_t <- fold_ready.df[c(-start_idx : -end_idx), ]
    fold_val <- fold_ready.df[c(start_idx : end_idx), ]
    folded_pack[[k]] <- list(train = fold_t, valid = fold_val)
    folded_pack[[k]]$train_exp <- monomial2dim(fold_t$x1, fold_t$x2, monomial_lim)
    folded_pack[[k]]$valid_exp <- monomial2dim(fold_val$x1, fold_val$x2, monomial_lim)
    folded_pack[[k]]$valid_exp.mat <- data.matrix(folded_pack[[k]]$valid_exp)
}

mse.df <- NULL

for(lam in seq(-4, 4, 0.1))
{
    resi.vec <- c()
    for(k in c(1:k_fold))
    {
        weight <- retrieve_weight(folded_pack[[k]]$train_exp, folded_pack[[k]]$train$y, 10**lam)
        y_prd <- t(weight) %*% folded_pack[[k]]$valid_exp.mat
        residuals <- folded_pack[[k]]$valid$y - y_prd
        resi.vec <- c(resi.vec, mean(residuals**2))
    }
    mse.df <- rbind(mse.df,
        data.frame(
            lambda = lam,
            mse.val = mean(resi.vec),
            std = sqrt(var(resi.vec))
        )
    )
}

ggplot(mse.df, aes(x = lambda, y = mse.val)) + geom_line() + geom_errorbar(aes(min = mse.val - std, max = mse.val + std))

ggsave("./e5-1c-mse.png")