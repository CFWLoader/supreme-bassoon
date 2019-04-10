# 产生交易额的随机模型测试
# 设想使用对数正态分布，在此做实验猜想
library(ggplot2)

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

initWealth = 50000
numPlayer = 10000

# 设想使得对数正态分布模型的对数标准差为与财富初始值有关，然而波动太大，固定为1.6比较合理的样子
# 同时为避免迭代中分配不均过快，应取初始值0.001取对数作为随机模型的参数，避免大量产生过大的值
# print(log(initWealth * 0.0001))

genSeq = as.integer(rlnorm(10000, meanlog = log(initWealth * 0.001), sdlog = 1.6))

print(quantile(genSeq))

# ggplot(data.frame(x = genSeq), aes(x = x)) + geom_histogram(binwidth = 100)
# ggsave("./lognorm_test.png")