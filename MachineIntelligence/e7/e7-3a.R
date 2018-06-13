library(ggplot2)

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

source("./lib/gen_data.R")
source("./lib/parzenwin.R")
source("./lib/plot_decbound.R")

train_set <- gensam()

test_set <- make_plotpoint(train_set)

for(sigmak in c(0.5, 0.1, 0.01))
{
    cls.val <- parzenwin(train_set[c(1, 2)], test_set, as.factor(train_set$y), sigmak)

    test.df <- data.frame(
        x1 = test_set$x, x2 = test_set$y, y = cls.val$class, prob = cls.val$prob
    )

    dbplot(train_set, test.df, sprintf("./e7-2a-s%2f.png", sigmak))

    # ggplot() + # geom_point(data = test.df, aes(x = x1, y = x2, color = as.factor(y))) + labs(title = paste("DB(Sigma=", sigmak, ")", sep = ""))
    #     geom_tile(data = test.df, aes(x = x1, y = x2, color = as.factor(y), group = as.factor(y), fill = prob)) + labs(title = paste("DB(Sigma=", sigmak, ")", sep = ""))

    # ggsave(sprintf("./e7-2a-s%2f.png", sigmak))
}