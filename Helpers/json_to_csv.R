library(rjson)

data = read.table('./testData.json', header = FALSE)

# print(as.character(data$V1))

con_data = fromJSON(as.character(data$V1))

# print(con_data)

con_data.frame = data.frame(PM25 = con_data)

write.csv(con_data.frame, "./PM25.csv", row.names = FALSE, quote = FALSE)

# print(con_data)

# print(data)