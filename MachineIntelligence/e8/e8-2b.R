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
testx <- cbind(testx, matrix(rep(1, length = nrow(testx)), ncol = 1))
testy <- data.matrix(testset[, 3])

trainsizes <- c(2, 4, 6, 8, 10, 20, 40, 100)
steps <- c(1:50)

w1.df <- NULL
w2.df <- NULL
w0.df <- NULL

for(trainsize in trainsizes)
{
    w1.vec <- c()
    w2.vec <- c()
    w0.vec <- c()
    for(step in steps)
    {
        trainset <- gensam(trainsize)
        xmat <- data.matrix(trainset[, c(1, 2)])
        xmat <- cbind(xmat, matrix(rep(1, length = nrow(xmat)), ncol = 1))
        ymat <- data.matrix(trainset[, 3])
        weight <- ginv(t(xmat) %*% xmat) %*% t(xmat) %*% ymat
        w1.vec <- c(w1.vec, weight[1])
        w2.vec <- c(w2.vec, weight[2])
        w0.vec <- c(w0.vec, weight[3])
    }
    w1.df <- rbind(w1.df, data.frame(n = trainsize, mean = mean(w1.vec), std = sqrt(var(w1.vec)), grp = as.factor("W1")))
    w2.df <- rbind(w2.df, data.frame(n = trainsize, mean = mean(w2.vec), std = sqrt(var(w2.vec)), grp = as.factor("W2")))
    w0.df <- rbind(w0.df, data.frame(n = trainsize, mean = mean(w0.vec), std = sqrt(var(w0.vec)), grp = as.factor("W0")))
}

weightstat.df <- rbind(w1.df, w2.df, w0.df)

ggplot(weightstat.df, aes(x = n)) + geom_errorbar(aes(min = mean - std, max = mean + std, group = grp, color = grp)) + geom_point(aes(y = mean, color = grp)) + 
    labs(title = TeX("Weight vs $\\mathbf{N}$($N_{test}=1000$)"), x = "N", y = "Weight", color = "Weight")
ggsave("./e8-2b.png")