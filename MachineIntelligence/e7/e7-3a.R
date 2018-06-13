library(ggplot2)

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

source("./lib/gen_data.R")
source("./lib/parzenwin.R")

train_set <- gensam(10)

test_set <- data.frame(
    x1 = c(0),
    x2 = c(0)
)

# grid.num <- 10

# x_axis.min <- min(train_set$x1)
# x_axis.max <- max(train_set$x1)
# x_axis.ssize <- (x_axis.max - x_axis.min)/grid.num

# y_axis.min <- min(train_set$x2)
# y_axis.max <- max(train_set$x2)
# y_axis.ssize <- (y_axis.max - y_axis.min)/grid.num

# test_set <- expand.grid(
#     x = seq(x_axis.min, x_axis.max, x_axis.ssize),
#     y = seq(y_axis.min, y_axis.max, y_axis.ssize)
# )

ggplot(train_set, aes(x = x1, y = x2, color = as.factor(y))) + geom_point()

ggsave("e7-3a-train.png")

cls.val <- parzenwin(train_set[c(1, 2)], test_set, as.factor(train_set$y), 0.5)

# test.df <- data.frame(
#     x1 = test_set$x, x2 = test_set$y, y = cls.val$class, prob = cls.val$prob
# )

# ggplot() + 
    #geom_tile(data = test.df, aes(x = x1, y = x2, color = as.factor(y), fill = prob)) + labs(title = paste("DB(Sigma=", sigmak, ")", sep = ""))
# ggplot(test.df, aes(x = x1, y = x2, color = as.factor(y))) + geom_point()

# ggsave(sprintf("./e7-2a-s%d.png", 33))

# for(sigmak in c(0.5, 0.1, 0.01))
# {
#     # print(sprintf("Sigma^2=%f", sigmak))
#     cls.val <- parzenwin(train_set[c(1, 2)], test_set, as.factor(train_set$y), sigmak)

#     test.df <- data.frame(
#         x1 = test_set$x, x2 = test_set$y, y = cls.val$class, prob = cls.val$prob
#     )

#     ggplot() + geom_point(data = test.df, aes(x = x1, y = x2, color = as.factor(y))) + labs(title = paste("DB(Sigma=", sigmak, ")", sep = ""))
#         # geom_tile(data = test.df, aes(x = x1, y = x2, color = as.factor(y), fill = prob)) + labs(title = paste("DB(Sigma=", sigmak, ")", sep = ""))

#     ggsave(sprintf("./e7-2a-s%f.png", sigmak))
# }