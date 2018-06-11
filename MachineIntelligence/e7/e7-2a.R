library(MASS)
library(class)
library(ggplot2)

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

source("./lib/gen_data.R")

train_set <- gensam()[c("x1", "x2", "y")]

colnames(train_set) <- c("x1", "x2", "cls")

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

cls.val <- knn(train_set[c(1, 2)], test_set, cl = as.factor(train_set$cls), k = 1, prob = TRUE)

cls.prob <- attr(cls.val, "prob")

test.df <- data.frame(
    x1 = test_set$x, x2 = test_set$y, y = cls.val, prob = cls.prob
)

ggplot(test.df, aes(x = x1, y = x2, fill = y)) + geom_tile() # + geom_point(data = train_set, aes(x = x1, y = x2, color = as.factor(cls)))

ggsave("./e7-2a.png")