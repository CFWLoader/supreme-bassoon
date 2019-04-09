library(ggplot2)

plotRanks <- function(playerWealth, filePath, sortRanks = TRUE){
    plotColumn = playerWealth
    if(sortRanks){
        plotColumn = sort(playerWealth)
    }
    plot.df <- data.frame(x = seq(1, length(playerWealth), 1), y = plotColumn)
    ggplot(plot.df, aes(x = x, y = y)) + geom_bar(stat = "identity")
    ggsave(filePath)
}

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

numPlayer = 1000                 # 参与模拟的人数
initWealth = 50000               # 参与人员初始财富值
maxIterations = 17000            # 模拟的最大迭代数

wealthArr = rep.int(initWealth, times = numPlayer)
plotRanks(wealthArr, "./simPlots/SimIter0.png")

for(iter in 1:maxIterations)
{
    # 一轮迭代中财富交换次数可以有什么模拟方法？目前暂且假定会发生{人数/4}次交易，即影响一半人左右
    # （因为考虑产生随机数可能发生自己与自己重叠）。
    wealthExchangeTimes = numPlayer / 4
    for(exchangeCnt in 1 : wealthExchangeTimes){
        payerId = runif(1, min = 1, max = numPlayer)
        payeeId = runif(1, min = 1, max = numPlayer)
        if(payerId != payeeId)
        {
            wealthArr[payeeId] = wealthArr[payeeId] + 1000
            wealthArr[payerId] = wealthArr[payerId] - 1000
        }
    }
    if(iter %% 1000 == 0){
    iterFilePath = sprintf("./simPlots/SimIter%d.png", iter)
    plotRanks(wealthArr, iterFilePath)
    }
}