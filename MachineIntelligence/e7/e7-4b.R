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
    rbind(rep(1, length = ncol(densmat)), densmat)
}

retrieve_weight <- function(xmat, centers, yt, sigmak = 0.5)
{
    ymat <- matrix(yt, nrow = 1)
    phimat <- philize(xmat, centers, sigmak)
    ginv(phimat %*% t(phimat)) %*% phimat %*% t(ymat)
}

samsize <- 60

for(sigg in seq(0.1, 0.5, 0.1)){
    trainset <- genclass(samsize, sigma = diag(2) * sigg, cls = 0)
    trainset <- rbind(trainset, genclass(samsize, mu1 = c(0, 0), mu2 = c(1, 1), sigma = diag(2) * sigg, cls = 1))

    trainset_x <- data.matrix(trainset[c(1, 2)])

    testset <- make_plotpoint(trainset)

    for(sigmaval in c(0.45))
    {
        kcenters <- matrix(c(0, 0, 1, 1), nrow = 2, byrow = TRUE)
        weights <- retrieve_weight(trainset_x, kcenters, trainset$y, sigmaval)
        phiedtest <- philize(testset, kcenters, sigmaval)
        prd <- t(weights) %*% phiedtest
        prdlbl <- rep(1, length = length(prd))
        diffidx <- which(prd < 0)
        prdlbl[diffidx] <- 0
        test.pltdf <- data.frame(x1 = testset[, 1], x2 = testset[, 2], y = prdlbl, prob = 1)
        dbplot(trainset, test.pltdf, sprintf("e7-4b-sk%2f-sig%f.png", sigmaval, sigg))
        tphi.pltdf <- data.frame(x1 = phiedtest[2, ], x2 = phiedtest[3, ], y = prdlbl)
        ggplot(tphi.pltdf, aes(x = x1, y = x2, color = as.factor(y))) + geom_point()
        ggsave(sprintf("e7-4b-phi-sk%2f-sig%f.png", sigmaval,sigg))
    }
}