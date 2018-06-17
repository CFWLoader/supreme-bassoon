library(stats)
library(proxy)
library(ggplot2)

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

source("./lib/gen_data.R")
source("./lib/parzenwin.R")
source("./lib/plot_decbound.R")

philize <- function(xmat, centers, sigmak = 0.5)
{
    distmat <- dist(centers, xmat, method = pr_DB$get_entry("Euclidean"))
    densmat <- exp(-distmat**2/(2*sigmak))
    # densrs <- rowSums(densmat)
    # normdens <- densmat / densrs
    rbind(rep(1, length = ncol(densmat)), densmat)
}

retrieve_weight <- function(xmat, centers, yt, sigmak = 0.5)
{
    ymat <- matrix(yt, nrow = 1)
    phimat <- philize(xmat, centers, sigmak)
    ginv(phimat %*% t(phimat)) %*% phimat %*% t(ymat)
}

samsize <- 60

trainset <- genclass(samsize, cls = 0)
trainset <- rbind(trainset, genclass(samsize, mu1 = c(0, 0), mu2 = c(1, 1),  cls = 1))

trainset_x <- data.matrix(trainset[c(1, 2)])

testset <- make_plotpoint(trainset)

for(kval in c(2:6))
{
    for(sigmaval in c(0.01, seq(0.1, 0.6, 0.1)))
    {
        kcenters <- data.matrix(kmeans(trainset_x, kval)$centers)
        weights <- retrieve_weight(trainset_x, kcenters, trainset$y, sigmaval)
        phiedtest <- philize(testset, kcenters, sigmaval)
        prd <- t(weights) %*% phiedtest
        prdlbl <- rep(1, length = length(prd))
        diffidx <- which(prd < 0)
        if(length(diffidx) > 0)
        {
            prdlbl[diffidx] <- 0
            test.pltdf <- data.frame(x1 = testset[, 1], x2 = testset[, 2], y = prdlbl, prob = 1)
            dbplot(trainset, test.pltdf, sprintf("e7-4a-k%d-%2f.png", kval, sigmaval))
        }
    }
}