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

monomial_lim <- 9

monomials.df <- monomial2dim(x1, x2, monomial_lim)
valid.mono.df <- monomial2dim(x1.val, x2.val, monomial_lim)

y_t <- data.matrix(train_set.df$obs)
phi_mat <- data.matrix(monomials.df)

pltdf.list <- list()

for(i in c(1:4))
{
    plt.df <- data.frame(
        x1 = x1.val,
        x2 = x2.val,
        trans = c(t(valid.mono.df[i, ]))
    )

    pltdf.list[[i]] <- ggplot(data = plt.df, aes(x = x1, y = x2, color = trans)) + geom_point() + scale_color_gradientn(colors = rainbow(50))
}

ggsave("./e5-1b-mono2.png")

# y_t <- data.matrix(validate_set.df$dens)
# phi_mat <- data.matrix(valid.mono.df)

# phi_mat.tinv <- ginv(phi_mat %*% t(phi_mat))

# expand_val_x <- data.matrix(valid.mono.df)

# # weight <- solve(phi_mat %*% t(phi_mat)) %*% phi_mat %*% t(y_t)
# weight <- phi_mat.tinv %*% phi_mat %*% y_t

# y_prd <- t(weight) %*% expand_val_x 

# valid_prd.df <- data.frame(
#     x1 = x1.val,
#     x2 = x2.val,
#     yp = t(y_prd)
# )
