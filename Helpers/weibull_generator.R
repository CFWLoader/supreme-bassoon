library(rjson)

shape = 5
scale = 2
dist = rweibull(5000, shape, scale)
jsoned <- toJSON(dist)
write.table(jsoned, './weib_dist1.json', row.names = FALSE, col.names = FALSE, quote = FALSE)
png(file = "./weib_dist1.png")
hist(dist, main = paste("Weibull Distribution(Shape=", shape, ", Scale=", scale, ")"))
dev.off()