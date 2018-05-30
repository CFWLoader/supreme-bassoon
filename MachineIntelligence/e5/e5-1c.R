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

fold_ready.df = train_set.df

k_fold <- 10

pack_size <- floor(nrow(whiten_train.df) / k_fold)

folded_pack <- list()

for(k in c(1:k_fold))
{
    start_idx <- 1 + (k - 1) * pack_size
    end_idx <- k * pack_size
    fold_t <- fold_ready.df[c(-start_idx : -end_idx), ]
    fold_val <- fold_ready.df[c(start_idx : end_idx), ]
    folded_pack[[k]] <- list(train = fold_t, valid = fold_val)
}

print(head(folded_pack[[2]]$valid))

# monomial_lim <- 10

# train.mono.df <- monomial2dim(x1, x2, monomial_lim)

# retrieve_weight(train.mono.df, train_set.df$obs, -4)

# mse.df <- NULL

# for(lam in seq(-4, 4, 0.1))
# {
#     weight <- retrieve_weight(train.mono.df, train_set.df$obs, 10**lam)
#     y_prd <- t(weight) %*% expand_val_x 
#     mse <- mean((y_prd - validate_set.df$dens)**2)
#     mse.df <- rbind(mse.df,
#         data.frame(
#             lambda = lam,
#             mse.val = mse
#         )
#     )
# }

# ggplot(mse.df, aes(x = lambda, y = mse.val)) + geom_line()

# ggsave("./e5-1c-mse.png")