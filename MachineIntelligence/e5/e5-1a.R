library(ggplot2)

script.dir <- dirname(sys.frame(1)$ofile)

setwd(script.dir)

train_set.df <- read.csv("../datasets/TrainingRidge.csv")

validate_set.df <- read.csv("../datasets/ValidationRidge.csv")

# source("./lib/preprocess.R")

center_data.matrix <- function(mat)
{
    cols = ncol(mat)
    rows = nrow(mat)
    ret.mat <- matrix(nrow = rows, ncol = cols)
    for(row in c(1:rows))
    {
        mean.val <- mean(mat[row, ])
        ret.mat[row, ] <- mat[row, ] - mean.val
    }
    return(ret.mat)
}

train_x <- t(data.matrix(train_set.df[c(1, 2)]))

sample.size <- nrow(train_x)

centered_x <- center_data.matrix(train_x)

# print(head(centered_x))

# centered_x <- scale(train_x, scale = FALSE)         # Use scale() to center the data.

x_cov <- (centered_x %*% t(centered_x)) / sample.size

x_cov.eigen <- eigen(x_cov)

x_cov.eigenvalue <- x_cov.eigen$values

x_cov.eigenvectors <- x_cov.eigen$vectors

# library(matrixcalc)
# print(is.positive.semi.definite(x_cov))

# print(x_cov.eigenvectors[, 1])

# valid.idx <- 65
# xxx1 <- x_cov %*% x_cov.eigenvectors[, valid.idx]
# xxx2 <- matrix(x_cov.eigenvalue[valid.idx] * x_cov.eigenvectors[, valid.idx], ncol = 1)
# print(all.equal(xxx1, xxx2))

# x_tilde <- t(x_cov.eigenvectors) %*% centered_x

eigenvalue.rootmat <- matrix(rep(0, sample.size**2), nrow = sample.size, ncol = sample.size)

diag(eigenvalue.rootmat) <- x_cov.eigenvalue**(-1/2)

# print(eigenvalue.diag)

# print(all.equal(eigenvalue.diag, x_tilde %*% t(x_tilde)))

# print(str(x_tilde))

# eigenvalue.diag <- (x_tilde %*% t(x_tilde)) / sample.size

# print(str(x_cov.eigenvalue)

# for(i in c(1:sample.size))
# {
#     if(eigenvalue.diag[i, i] <= 0)
#     {
#         print(paste(i, eigenvalue.diag[i, i]))
#     }
# }

# print(str(eigenvalue.diag))

shpered_x <- eigenvalue.rootmat %*% t(x_cov.eigenvectors) %*% centered_x

# print(shpered_x)

train_x <- t(train_x)
centered_x <- t(centered_x)
shpered_x <- t(shpered_x)

origin.df <- data.frame(
    x1 = train_x[, 1],
    x2 = train_x[, 2],
    y = train_set.df$obs,
    grp_id = 1
)

origin.df <- rbind(origin.df, data.frame(
    x1 = mean(train_x[, 1]),
    x2 = mean(train_x[, 2]),
    y = 0,
    grp_id = 2
))

ggplot(origin.df, aes(x = x1, y = x2, color = y, shape = as.factor(grp_id))) + geom_point() + scale_color_gradientn(colors = rainbow(50))

ggsave("./e5-1a-origin.png")

centered.df <- data.frame(
    x1 = centered_x[, 1],
    x2 = centered_x[, 2],
    y = train_set.df$obs,
    grp_id = 1
)

centered.df <- rbind(centered.df, data.frame(
    x1 = mean(centered_x[, 1]),
    x2 = mean(centered_x[, 2]),
    y = 0,
    grp_id = 2
))

ggplot(centered.df, aes(x = x1, y = x2, color = y, shape = as.factor(grp_id))) + geom_point() + scale_color_gradientn(colors = rainbow(50))

ggsave("./e5-1a-centered.png")

shpered.df <- data.frame(
    x1 = shpered_x[, 1],
    x2 = shpered_x[, 2],
    y = train_set.df$obs,
    grp_id = 1
)

shpered.df <- rbind(shpered.df, data.frame(
    x1 = mean(shpered_x[, 1]),
    x2 = mean(shpered_x[, 2]),
    y = 0,
    grp_id = 2
))

ggplot(shpered.df, aes(x = x1, y = x2, color = y, shape = as.factor(grp_id))) + geom_point() + scale_color_gradientn(colors = rainbow(50)) # + xlim(-1, 1) + ylim(-1, 1)

ggsave("./e5-1a-shpered.png")

ggplot(validate_set.df, aes(x = x1, y = x2, color = dens)) + geom_point() + scale_color_gradientn(colors = rainbow(50)) # + xlim(-1, 1) + ylim(-1, 1)

ggsave("./e5-1a-validate.png")

valid_x <- t(data.matrix(validate_set.df[c(1, 2)]))

centered_val_x <- center_data.matrix(valid_x)

sphered_val_x <- eigenvalue.rootmat %*% t(x_cov.eigenvectors) %*% centered_val_x

sphered_val.df <- data.frame(
    x1 = sphered_val_x[1, ],
    x2 = sphered_val_x[2, ],
    y = validate_set.df$dens
)

ggplot(sphered_val.df, aes(x = x1, y = x2, color = y)) + geom_point() + scale_color_gradientn(colors = rainbow(50)) # + xlim(-1, 1) + ylim(-1, 1)

ggsave("./e5-1a-validate-shpered.png")