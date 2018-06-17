library(e1071)
library(ggplot2)

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

source("./lib/gen_data.R")

samsize <- 40

trainset <- genclass(samsize, c(0, 1), c(1, 0), cls = 0)
trainset <- rbind(trainset, genclass(samsize, c(0, 0), c(1, 1), cls = 1))

ggplot(trainset, aes(x = x1, y = x2, color = as.factor(y))) + geom_point()

ggsave("./e9-2a.png")