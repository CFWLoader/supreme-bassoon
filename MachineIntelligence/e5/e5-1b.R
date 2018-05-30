library(ggplot2)
library(MASS)

script.dir <- dirname(sys.frame(1)$ofile)

setwd(script.dir)

train_set.df <- read.csv("../datasets/TrainingRidge.csv")

validate_set.df <- read.csv("../datasets/ValidationRidge.csv")

source("./lib/whitening.R")

packtmp <- sphere(data.matrix(train_set.df[c(1, 2)]))

sphere.params <- packtmp$params

train_x <- packtmp$whitedata

packtmp <- sphere(data.matrix(validate_set.df[c(1, 2)]), sphere.params)

val_x <- packtmp$whitedata

x1 <- train_x[, 1]

x2 <- train_x[, 2]

x1.val <- val_x[, 1]

x2.val <- val_x[, 2]

monomials.df <- NULL

valid.mono.df <- NULL

monomial_lim <- 3

for(k in c(0 : monomial_lim))
{
    for(a in c(0 : k))
    {
        b <- k - a
        tmp.df <- data.frame(data = x1**a * x2**b)
        monomials.df <- rbind(monomials.df, data.frame(
            data = t(tmp.df),
            row.names = c(paste("x1^", a, "*x2^", b, sep = ""))
        ))
        tmp.df <- data.frame(data = x1.val**a * x2.val**b)
        valid.mono.df <- rbind(valid.mono.df, data.frame(
            data = t(tmp.df),
            row.names = c(paste("x1^", a, "*x2^", b, sep = ""))
        ))
    }
}

y_t <- data.matrix(train_set.df$obs)

phi_mat <- data.matrix(monomials.df)

phi_mat.tinv <- ginv(phi_mat %*% t(phi_mat))

expand_val_x <- data.matrix(valid.mono.df)

# weight <- solve(phi_mat %*% t(phi_mat)) %*% phi_mat %*% t(y_t)
weight <- phi_mat.tinv %*% phi_mat %*% y_t

y_prd <- t(weight) %*% expand_val_x 

valid_prd.df <- data.frame(
    x1 = x1.val,
    x2 = x2.val,
    yp = t(y_prd)
)

ggplot(valid_prd.df, aes(x = x1, y = x2, color = yp)) + geom_point() + scale_color_gradientn(colors = rainbow(50)) # + xlim(-1, 1) + ylim(-1, 1)

ggsave("./e5-1b-val-predict.png")