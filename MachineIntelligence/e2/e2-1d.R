library(ggplot2)

# Set working dir to this file's path.
script.dir = dirname(sys.frame(1)$ofile)

setwd(script.dir)

source('./perceptron.R')

dataset = read.csv("../datasets/applesOranges.csv")

w1 = 1 / sqrt(1 + tan(pi * 20 / 180)**2)

w2 = w1 * tan(pi * 20 / 180)

theta = -0.15

line_y = w2 / w1 * dataset$x.1 + theta

ploter = ploter + geom_line(aes(y = line_y))

ggplot(dataset, aes(x = x.1, y = x.2, color=y)) + geom_point() + geom_line(aes(y = line_y))

ggsave("./e2-1d.png")