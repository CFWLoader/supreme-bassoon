library(ggplot2)

script.dir <- dirname(sys.frame(1)$ofile)

setwd(script.dir)

train_set.df <- read.csv("../datasets/TrainingRidge.csv")

validate_set.df <- read.csv("../datasets/ValidationRidge.csv")

source("./lib/preprocess.R")

train_x <- data.matrix(train_set.df[c(1, 2)])

sample.size <- nrow(train_x)

# centered_x <- center_data.matrix(train_x)

# print(head(centered_x))

centered_x <- scale(train_x, scale = FALSE)         # Use scale() to center the data.

x_cov <- (centered_x %*% t(centered_x)) / sample.size

x_cov.eigen <- eigen(x_cov)

x_cov.eigenvalue <- x_cov.eigen$values

x_cov.eigenvectors <- x_cov.eigen$vectors

x_tilde <- t(x_cov.eigenvectors) %*% centered_x

# print(str(x_tilde))

eigenvalue.diag <- (x_tilde %*% t(x_tilde)) / sample.size

# print(str(x_cov.eigenvalue))

# eigenvalue.diag <- matrix(rep(0, sample.size**2), nrow = sample.size, ncol = sample.size)

# diag(eigenvalue.diag) <- x_cov.eigenvalue

# print(length(x_cov.eigenvalue))

# for(i in c(1:sample.size))
# {
#     if(is.nan(sqrt(eigenvalue.diag[i, i])))
#     {
#         print(paste(i, eigenvalue.diag[i, i]))
#     }
# }

# print(str(eigenvalue.diag))

shpered_x <- eigenvalue.diag %*% t(x_cov.eigenvectors) %*% centered_x

# print(shpered_x)

# print(str(x_cov))

# print(str(validate_set.df))

origin.df <- data.frame(
    x1 = train_x[, 1],
    x2 = train_x[, 2]
)

ggplot(origin.df, aes(x = x1, y = x2)) + geom_point()

ggsave("./e5-1a-origin.png")

centered.df <- data.frame(
    x1 = centered_x[, 1],
    x2 = centered_x[, 2]
)

ggplot(centered.df, aes(x = x1, y = x2)) + geom_point()

ggsave("./e5-1a-centered.png")

shpered.df <- data.frame(
    x1 = shpered_x[, 1],
    x2 = shpered_x[, 2]
)

ggplot(shpered.df, aes(x = x1, y = x2)) + geom_point()

ggsave("./e5-1a-shpered.png")