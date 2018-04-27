library(ParetoPosStable)

script.dir = dirname(sys.frame(1)$ofile)

setwd(script.dir)

aqi.data.frame = read.csv("../../csv_data/AQI.csv")

aqi.data = as.numeric(aqi.data.frame$AQI)

print(min(aqi.data))

# print(head(aqi.data.frame$AQI))

# print(pareto.fit(as.numeric(aqi.data.frame$AQI)))