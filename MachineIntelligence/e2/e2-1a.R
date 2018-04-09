library(ggplot2)

# Set working dir to this file's path.
script.dir = dirname(sys.frame(1)$ofile)

setwd(script.dir)

dataset = read.csv("../datasets/applesOranges.csv")

ggplot(dataset, aes(x = x.1, y = x.2, color = as.factor(y))) + geom_point()

ggsave("./applesOranges.png")