library(rjson)

arr = runif(500000, 1, 2333)

# print(arr)

write.table(toJSON(arr), './big_array.json', row.names = FALSE, col.names = FALSE, quote = FALSE)