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

numPlayer = 100                 # 参与模拟的人数
initWealth = 5000               # 参与人员初始财富值
maxIterations = 1700            # 模拟的最大迭代数

wealthArr = rep.int(initWealth, times = numPlayer)
plotRanks(wealthArr, "./simPlots/SimIter0.png")

for(iter in 1:1700)
{
    print(iter)
}