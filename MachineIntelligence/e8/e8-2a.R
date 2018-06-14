library(MASS)
library(ggplot2)
library(latex2exp)

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

gensam <- function(sample.size)
{
    if(sample.size == 2)
    {
        cx1 <- mvrnorm(1, mu = c(0, 1), Sigma = diag(2) * 2)
        cx2 <- mvrnorm(1, mu = c(1, 0), Sigma = diag(2) * 2)
        return(data.frame(x1 = c(cx1[1], cx2[1]), x2 = c(cx1[2], cx2[2]), y = c(1, -1)))
    }
    train_x <- mvrnorm(sample.size / 2, mu = c(0, 1), Sigma = diag(2) * 2)
    trainset <- data.frame(x1 = train_x[, 1], x2 = train_x[, 2], y = 1)
    train_x <- mvrnorm(sample.size / 2, mu = c(1, 0), Sigma = diag(2) * 2)
    rbind(trainset, data.frame(x1 = train_x[, 1], x2 = train_x[, 2], y = -1))
}

testset <- gensam(1000)

testx <- data.matrix(testset[, c(1, 2)])
testy <- data.matrix(testset[, 3])

trainsizes <- c(2, 4, 6, 8, 10, 20, 40, 100)
steps <- c(1:50)

trainstat.df <- NULL
teststat.df <- NULL

for(trainsize in trainsizes)
{
    train.acc.vec <- c()
    test.acc.vec <- c()
    for(step in steps)
    {
        trainset <- gensam(trainsize)
        xmat <- data.matrix(trainset[, c(1, 2)])
        ymat <- data.matrix(trainset[, 3])
        weight <- ginv(t(xmat) %*% xmat) %*% t(xmat) %*% ymat
        train.prd <- sign(xmat %*% weight)
        test.prd <- sign(testx %*% weight)
        train.acc.vec <- c(train.acc.vec, sum(train.prd == ymat) / nrow(ymat))
        test.acc.vec <- c(test.acc.vec, sum(test.prd == testy) / nrow(testy))
    }
    trainstat.df <- rbind(trainstat.df, data.frame(n = trainsize, mean = mean(train.acc.vec), std = sqrt(var(train.acc.vec)), grp = as.factor("train")))
    teststat.df <- rbind(teststat.df, data.frame(n = trainsize, mean = mean(test.acc.vec), std = sqrt(var(test.acc.vec)), grp = as.factor("test")))
}

# ggplot(trainstat.df, aes(x = n)) + geom_errorbar(aes(min = mean - std, max = mean + std)) + geom_point(aes(y = mean)) + 
#     labs(title = "ACC vs N", x = "N", y = "ACC")
# ggsave("./e8-2a-train.png")

# ggplot(teststat.df, aes(x = n)) + geom_errorbar(aes(min = mean - std, max = mean + std)) + geom_point(aes(y = mean)) + 
#     labs(title = "ACC vs N", x = "N", y = "ACC")
# ggsave("./e8-2a-test.png")

allstat.df <- rbind(teststat.df, trainstat.df)

ggplot(allstat.df, aes(x = n)) + geom_errorbar(aes(min = mean - std, max = mean + std, group = grp, color = grp)) + geom_point(aes(y = mean, color = grp)) + 
    labs(title = TeX("ACC vs $\\mathbf{N}$($N_{test}=1000$)"), x = "N", y = "ACC", color = "Data Type")
ggsave("./e8-2a-all.png")