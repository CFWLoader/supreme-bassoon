library(STAR)
# library(ExtDist)

script.dir = dirname(sys.frame(1)$ofile)

setwd(script.dir)

aqi.data.frame = read.csv("../../csv_data/AQI.csv")

# print(head(aqi.data.frame$AQI))

print(weibullMLE(as.numeric(aqi.data.frame$AQI)))

# print(eWeibull(X = as.numeric(aqi.data.frame$AQI), method = "numerical.MLE"))