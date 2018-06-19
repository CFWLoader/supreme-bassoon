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

testx <- make_plotpoint(trainset)

cost.vals <- c()
for(idx in seq(-6, 10, 2)) cost.vals <- c(cost.vals, 2**idx)

gamma.vals <- c()
for(idx in seq(-5, 9, 2)) gamma.vals <- c(gamma.vals, 2**idx)

csvm <- svm(trainx, trainy, type = "C-classification")
# testy <- predict(csvm, testx)