library(rjson)

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

# data = read.table("./testData.json", header = FALSE)

jsdata <- fromJSON(file="./testData.json")

# print(con_data)

con_data.frame = data.frame(COL1 = jsdata)

write.csv(con_data.frame, "./testData.csv", row.names = FALSE, quote = FALSE)

# print(con_data)

# print(data)