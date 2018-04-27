library(ParetoPosStable)
library(EnvStats)

script.dir = dirname(sys.frame(1)$ofile)

setwd(script.dir)

# aqi.data.frame = read.csv("../../csv_data/AQI.csv")

# aqi.data = as.numeric(aqi.data.frame$AQI)

# print(min(aqi.data))

# print(head(aqi.data.frame$AQI))

# print(pareto.fit(as.numeric(aqi.data.frame$AQI)))

test_data <- c(1, 2, 3, 7, 10, 11)

ft_val <- pareto.fit(test_data)

alpha <- ft_val[[1]]$lambda

loc <- ft_val[[1]]$sigma

print(ppareto(4, loc, alpha))

print(ppareto(5.66, loc, alpha))