library(ggplot2)

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

candies <- c(6, 37, 378, 22, 13, 22, 123456)

canmin <- min(candies)
canmax <- max(candies)

stats_diff <- rep(0, times = length(candies))

for(cnt in 1:10000)
{
    selectnum <- runif(1, max = canmax, min = canmin)
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

luckylad <- stats_diff == max(stats_diff)
print(candies[luckylad])

plot.df <- data.frame(x = candies, y = stats_diff)

ggplot(plot.df) + geom_bar(aes(x = factor(x), y = y), stat="identity")
ggsave("./lottery1-stats.png")