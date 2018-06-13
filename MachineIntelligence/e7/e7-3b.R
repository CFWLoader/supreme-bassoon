library(ggplot2)
library(MASS)
library(class)

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

source("./lib/gen_data.R")
source("./lib/parzenwin.R")
source("./lib/plot_decbound.R")

train_set <- gensam()

tx3 <- mvrnorm(60, mu = c(0.5, 0.5), Sigma = diag(2) * 0.05)

train_set <- rbind(train_set, data.frame(
    x1 = tx3[, 1], x2 = tx3[, 2], y = 3
))

test_set <- make_plotpoint(train_set)

for(k.val in seq(1, 5, 2))
{
    cls.val <- knn(train_set[c(1, 2)], test_set, cl = as.factor(train_set$y), k = k.val, prob = TRUE)

    cls.prob <- attr(cls.val, "prob")

    test.df <- data.frame(
        x1 = test_set$x, x2 = test_set$y, y = cls.val, prob = cls.prob
    )

    dbplot(train_set, test.df, sprintf("./e7-3b-k%d.png", k.val))
}

for(sigmak in c(0.5, 0.1, 0.01))
{
    cls.val <- parzenwin(train_set[c(1, 2)], test_set, as.factor(train_set$y), sigmak)

    test.df <- data.frame(
        x1 = test_set$x, x2 = test_set$y, y = cls.val$class, prob = cls.val$prob
    )

    dbplot(train_set, test.df, sprintf("./e7-3b-s%2f.png", sigmak))
}