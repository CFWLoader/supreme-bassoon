library(e1071)
library(ggplot2)

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

source("./lib/gen_data.R")
source("./lib/plot_decbound.R")

samsize <- 40

trainset <- genclass(samsize, c(0, 1), c(1, 0), cls = 0)
trainset <- rbind(trainset, genclass(samsize, c(0, 0), c(1, 1), cls = 1))

# ggplot(trainset, aes(x = x1, y = x2, color = as.factor(y))) + geom_point()
# ggsave("./e9-2a.png")

trainx <- data.matrix(trainset[, c(1, 2)])
trainy <- as.factor(trainset[, 3])

testx <- make_plotpoint(trainset)

csvm <- svm(trainx, trainy, type = "C-classification")
testy <- predict(csvm, testx)
# trainy.prd <- predict(cvsm, trainx)

# print(length(which(trainy.prd == trainy))/length(trainy))

pltobj <- dbplot(trainset, data.frame(x1 = testx[, 1], x2 = testx[, 2], y = testy))

ggsave("./e9-2a.png")