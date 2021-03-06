library(ggplot2)

# Set working dir to this file's path.
script.dir = dirname(sys.frame(1)$ofile)

setwd(script.dir)

source('./perceptron.R')

dataset = read.csv("../datasets/applesOranges.csv")

w1 = sin(20 * pi / 180)

w2 = cos(20 * pi / 180)

theta = -0.15

line_y = - (w1 / w2) * dataset$x.1 - theta

# ploter = ploter + geom_line(aes(y = line_y))

ggplot(dataset, aes(x = x.1, y = x.2, color=as.factor(y))) + geom_point() + geom_line(aes(y = line_y, color = as.factor(2))) + scale_color_manual(values = c("red", "blue", "black"))

ggsave("./e2-1d.png")