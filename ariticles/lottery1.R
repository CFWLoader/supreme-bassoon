candies <- c(6, 37, 378, 22, 13, 22, 123456)

canmin <- min(candies)
canmax <- max(candies)

stats_diff <- rep(0, times = length(diffs))

for(cnt in 1:1)
{
    selectnum <- runif(1, max = canmax, min = canmin)
    diffs <- abs(candies - selectnum)
    minval <- diffs[1]
    targetidx <- candies[1]
    for(idx in 1:length(diffs)){
        if(diffs[idx] < minval)
        {
            minval <- diffs[idx]
            targetidx <- idx
        }
    }
    stats_diff[targetidx] = stats_diff[targetidx] + 1
}

luckylad <- stats_diff == max(stats_diff)
print(candies[luckylad])