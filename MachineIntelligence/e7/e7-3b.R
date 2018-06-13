library(ggplot2)
library(MASS)
library(class)

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

source("./lib/gen_data.R")
source("./lib/parzenwin.R")

train_set <- gensam()

tx3 <- mvrnorm(60, mu = c(0.5, 0.5), Sigma = diag(2) * 0.05)

train_set <- rbind(train_set, data.frame(
    x1 = tx3[, 1], x2 = tx3[, 2], y = 3
))

# ggplot(train_set, aes(x = x1, y = x2, color = as.factor(y))) + geom_point()

# ggsave("./e7-3b-train.png")

grid.num <- 128

x_axis.min <- min(train_set$x1)
x_axis.max <- max(train_set$x1)
x_axis.ssize <- (x_axis.max - x_axis.min)/grid.num

y_axis.min <- min(train_set$x2)
y_axis.max <- max(train_set$x2)
y_axis.ssize <- (y_axis.max - y_axis.min)/grid.num

test_set <- expand.grid(
    x = seq(x_axis.min, x_axis.max, x_axis.ssize),
    y = seq(y_axis.min, y_axis.max, y_axis.ssize)
)

for(k.val in seq(1, 5, 2))
{
    cls.val <- knn(train_set[c(1, 2)], test_set, cl = as.factor(train_set$y), k = k.val, prob = TRUE)

    cls.prob <- attr(cls.val, "prob")

    test.df <- data.frame(
        x1 = test_set$x, x2 = test_set$y, y = cls.val, prob = cls.prob
    )

    ggplot() + 
        geom_tile(data = test.df, aes(x = x1, y = x2, color = as.factor(y), fill = cls.prob)) + labs(title = paste("DB(k=", k.val, ")", sep = ""))

    ggsave(paste("./e7-3b-k", k.val, ".png", sep = ""))
}

for(sigmak in c(0.5, 0.1, 0.01))
{
    cls.val <- parzenwin(train_set[c(1, 2)], test_set, as.factor(train_set$y), sigmak)

    test.df <- data.frame(
        x1 = test_set$x, x2 = test_set$y, y = cls.val$class, prob = cls.val$prob
    )

    ggplot() + # geom_point(data = test.df, aes(x = x1, y = x2, color = as.factor(y))) + labs(title = paste("DB(Sigma=", sigmak, ")", sep = ""))
        geom_tile(data = test.df, aes(x = x1, y = x2, color = as.factor(y), group = as.factor(y), fill = prob)) + labs(title = paste("DB(Sigma=", sigmak, ")", sep = ""))

    ggsave(sprintf("./e7-3b-s%2f.png", sigmak))
}