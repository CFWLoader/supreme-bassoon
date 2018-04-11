library(rjson)

# Set working dir to this file's path.
script.dir = dirname(sys.frame(1)$ofile)

setwd(script.dir)

dataset = read.csv("./airfoil_self_noise.csv")

attack_angle = as.numeric(dataset[, c(2)])

jsoned = toJSON(attack_angle)

write.table(jsoned, file = "./att_agl.json", row.names = FALSE, col.names = FALSE, quote = FALSE)

png("att_agl.png")

hist(attack_angle, main = "Attack Angle")

dev.off()

# print(head(attack_angle))