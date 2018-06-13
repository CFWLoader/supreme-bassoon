library(MASS)
library(class)
library(ggplot2)

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

source("./lib/gen_data.R")
source("./lib/plot_decbound.R")

train_set <- gensam()

colnames(train_set) <- c("x1", "x2", "cls")

test_set <- make_plotpoint(train_set)

for(k.val in seq(1, 5, 2))
{
    cls.val <- knn(train_set[c(1, 2)], test_set, cl = as.factor(train_set$cls), k = k.val, prob = TRUE)

    cls.prob <- attr(cls.val, "prob")

    test.df <- data.frame(
        x1 = test_set$x, x2 = test_set$y, y = cls.val, prob = cls.prob
    )

    dbplot(train_set, test.df, sprintf("./e7-2a-k%d.png", k.val))

    # ggplot() + 
    #     # geom_contour(data = test.df, aes(x = x1, y = x2, z = cls.prob, group = as.factor(y), color = as.factor(y)), bins = 1) + 
    #     geom_tile(data = test.df, aes(x = x1, y = x2, color = as.factor(y), fill = cls.prob)) + labs(title = paste("DB(k=", k.val, ")", sep = ""))
    #     # geom_point(data = train_set, aes(x = x1, y = x2, color = as.factor(cls)))

    # ggsave(paste("./e7-2a-k", k.val, ".png", sep = ""))
}