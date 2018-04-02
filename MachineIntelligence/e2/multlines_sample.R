library(ggplot2)

slope = 1

x = seq(-3, 3, 0.1)

# print(x)

y = slope * x

y2 =  x**2 + -3

y3 = 0.3 * x

# print(y)

data = data.frame(x = x,y = y, y2 = y2)

# print(head(data))

p = ggplot(data, aes(x = x)) + geom_line(aes(y = y), color = "red") + geom_line(aes(y = y2), color = "blue") + geom_line(aes(y = y3), color = "green")

ggsave("./sample1.png")

# for(angle in seq(0, 180, 10))
# {
#     print(tan(angle))
# }