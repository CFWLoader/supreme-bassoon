library(MASS)
library(class)
library(ggplot2)

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

source("./lib/gen_data.R")
source("./lib/plot_decbound.R")

train_set <- gensam()

test_set <- make_plotpoint()

for(k.val in c(3))
{
    cls.val <- knn(train_set[c(1, 2)], test_set, cl = as.factor(train_set$y), k = k.val, prob = TRUE)

    cls.prob <- attr(cls.val, "prob")

    test.df <- data.frame(
        x1 = test_set$x, x2 = test_set$y, y = cls.val, prob = cls.prob
    )

    dbplot(train_set, test.df, paste("./e7-4a-k", k.val, ".png", sep = ""))
}