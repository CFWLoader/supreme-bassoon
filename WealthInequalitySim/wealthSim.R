library(ggplot2)

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

plotRanks <- function(playerWealth, filePath){
    plot.df <- data.frame(x = seq(1, length(playerWealth), 1), y = playerWealth)
    ggplot(plot.df, aes(x = x, y = y)) + geom_bar(stat = "identity")
    ggsave(filePath)
}

searchBisectPoint <- function(sortedArr, bisectCriterion, sumDirection = "LR"){
    startIdx = if(sumDirection == "LR") 1 else length(sortedArr)
    endIdx = if(sumDirection == "LR") length(sortedArr) else 1
    incSym = if(sumDirection == "LR") 1 else -1
    sumVal = 0
    loggedIdx = 1
    for(idx in seq(startIdx, endIdx, incSym)){
        nextSumVal = sumVal + sortedArr[idx]
        if(nextSumVal > bisectCriterion){
            loggedIdx = idx - incSym
            break
        }
        sumVal = nextSumVal
        loggedIdx = idx
    }
    return(loggedIdx)
}

numPlayer <- 1000                 # 参与模拟的人数
initWealth <- 50000               # 参与人员初始财富值
maxIterations <- 17000            # 模拟的最大迭代数
bisectTotalWealth <- numPlayer * initWealth / 2

wealthArr = rep.int(initWealth, times = numPlayer)
# plotRanks(wealthArr, "./simPlots/SimIter0.png")

bisQuantiles <- c()

for(iter in 1:maxIterations)
{
    # 一轮迭代中财富交换次数可以有什么模拟方法？目前暂且假定会发生{人数/4}次交易，即影响一半人左右
    # （因为考虑产生随机数可能发生自己与自己重叠）。
    wealthExchangeTimes <- numPlayer / 4
    for(exchangeCnt in 1 : wealthExchangeTimes){
        payerId <- runif(1, min = 1, max = numPlayer)
        payeeId <- runif(1, min = 1, max = numPlayer)
        if(payerId != payeeId)
        {
            # 交易额产生方式
            # dealSum = rnorm(1, mean = initWealth / 4, sd = initWealth * 0.01)
            dealSum <- as.integer(rlnorm(1, meanlog = log(initWealth * 0.001), sdlog = 1.6))
            # if(wealthArr[payerId] < initWealth * -0.01 || wealthArr[payerId] - dealSum < initWealth * -0.01){
            #     next
            # }
            wealthArr[payeeId] <- wealthArr[payeeId] + dealSum
            wealthArr[payerId] <- wealthArr[payerId] - dealSum
        }
    }
    sortedRanks <- sort(wealthArr)
    bisPoint <- searchBisectPoint(sortedRanks, bisectTotalWealth)
    bisQuantiles <- c(bisQuantiles, bisPoint)
    # if(iter %% 1000 == 0){
    #     iterFilePath <- sprintf("./simPlots/SimIter%d.png", iter)
    #     plotRanks(sortedRanks, iterFilePath)
    # }
}

bisdata1.df <- data.frame(iteration = seq(1, maxIterations, 1), bisectQuantile = bisQuantiles, simId = 1)

wealthArr = rep.int(initWealth, times = numPlayer)

bisQuantiles2 <- c()

for(iter in 1:maxIterations)
{
    # 一轮迭代中财富交换次数可以有什么模拟方法？目前暂且假定会发生{人数/4}次交易，即影响一半人左右
    # （因为考虑产生随机数可能发生自己与自己重叠）。
    wealthExchangeTimes <- numPlayer / 4
    for(exchangeCnt in 1 : wealthExchangeTimes){
        payerId <- runif(1, min = 1, max = numPlayer)
        payeeId <- runif(1, min = 1, max = numPlayer)
        if(payerId != payeeId)
        {
            # 交易额产生方式
            # dealSum = rnorm(1, mean = initWealth / 4, sd = initWealth * 0.01)
            dealSum <- as.integer(rlnorm(1, meanlog = log(initWealth * 0.001), sdlog = 1.6))
            # 加入弱势保护
            if(wealthArr[payerId] < initWealth * -0.01 || wealthArr[payerId] - dealSum < initWealth * -0.01){
                next
            }
            wealthArr[payeeId] <- wealthArr[payeeId] + dealSum
            wealthArr[payerId] <- wealthArr[payerId] - dealSum
        }
    }
    sortedRanks <- sort(wealthArr)
    bisPoint <- searchBisectPoint(sortedRanks, bisectTotalWealth)
    bisQuantiles2 <- c(bisQuantiles2, bisPoint)
    # if(iter %% 1000 == 0){
    #     iterFilePath <- sprintf("./simPlots/SimIter%d.png", iter)
    #     plotRanks(sortedRanks, iterFilePath)
    # }
}

bisdata2.df <- data.frame(iteration = seq(1, maxIterations, 1), bisectQuantile = bisQuantiles2, simId = 2)

bisplt.df <- rbind(bisdata1.df, bisdata2.df)

ggplot(bisplt.df) + geom_line(aes(x= iteration, y = bisectQuantile, color = factor(simId))) + 
    xlab("迭代数") + ylab("均分总财富点") + ggtitle("财富分配模拟") + theme(plot.title = element_text(hjust = 0.5)) +
    scale_color_manual(values=c("blue", "red"), 
                       name="模拟类型",
                       breaks=c(1, 2),
                       labels=c("无保护", "弱势保护"))

ggsave("./simPlots/quatiles.png")