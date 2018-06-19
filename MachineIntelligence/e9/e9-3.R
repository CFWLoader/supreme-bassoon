library(e1071)
library(ggplot2)

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

source("./lib/gen_data.R")
source("./lib/plot_decbound.R")

samsize <- 40

trainset <- genclass(samsize, c(0, 1), c(1, 0), cls = 0)
trainset <- rbind(trainset, genclass(samsize, c(0, 0), c(1, 1), cls = 1))

trainx <- data.matrix(trainset[, c(1, 2)])
trainy <- as.factor(trainset[, 3])

cost.vals <- c()
for(idx in seq(-6, 10, 2)) cost.vals <- c(cost.vals, 2**idx)

gamma.vals <- c()
for(idx in seq(-5, 9, 2)) gamma.vals <- c(gamma.vals, 2**idx)

combis <- expand.grid(cost = cost.vals, gamma = gamma.vals)

acc.vec <- c()

for(row in c(1:nrow(combis)))
{
    csvm <- svm(trainx, trainy, type = "C-classification", cost = combis$cost[row], gamma = combis$gamma[row], cross = 4)
    acc.vec <- c(acc.vec, mean(csvm$accuracies))
}

plt.df <- data.frame(lcost = log(cost.vals), lgamma = log(gamma.vals), z = acc.vec)

ggplot(plt.df, aes(x = lcost, y = lgamma, fill = z)) + geom_tile() + labs(x = "Log(Cost)", y = "Log(gamma)") + scale_fill_gradientn(colors = rainbow(7))

ggsave("./e9-3a.png")

optm.pars <- combis[which(max(acc.vec) == acc.vec), ]

optm.cost <- optm.pars$cost[1]
optm.gamma <- optm.pars$gamma[1]

testx <- make_plotpoint(trainset)
optm.csvm <- svm(trainx, trainy, type = "C-classification", cost = optm.cost, gamma = optm.gamma)
testy <- predict(optm.csvm, testx)

pltobj <- dbplot(trainset, data.frame(x1 = testx[, 1], x2 = testx[, 2], y = testy))
ggsave("./e9-3b.png")