library(rjson)
library(Rfast)

data = read.table('./beta5k.json', header = FALSE)

con_data = fromJSON(as.character(data$V1))

# print(con_data)

print(beta.mle(con_data))