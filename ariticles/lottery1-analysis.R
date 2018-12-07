library(ggplot2)

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

candies <- c(6, 37, 378, 22, 1500, 13, 22, 123456)

# candies <- seq(6, 123456, 13000)

canmin <- min(candies)
canmax <- max(candies)

candies <- c(candies, ceiling(canmin / 2 + canmax / 2))

stats_diff <- rep(0, times = length(candies))

for(cnt in 1:10000)
{
    selectnum <- ceiling(runif(1, max = canmax, min = canmin))
    # print(ceiling(selectnum))
    diffsvec <- abs(candies - selectnum)
    minval <- diffsvec[1]
    targetidx <- candies[1]
    for(idx in 1:length(diffsvec)){
        if(diffsvec[idx] < minval)
        {
            minval <- diffsvec[idx]
            targetidx <- idx
        }
    }
    stats_diff[targetidx] = stats_diff[targetidx] + 1
}

plot.df <- data.frame(x = candies, y = stats_diff)

ggplot(plot.df) + geom_bar(aes(x = factor(x), y = y), stat="identity")
ggsave("./lottery1-stats.png")