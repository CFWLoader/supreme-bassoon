library(ggplot2)

source("./lib/gen_data.R")

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

sample.data <- gensam()

ggplot(sample.data, aes(x = x1, y = x2, color = as.factor(y))) + geom_point()

ggsave("./e7-1a.png")