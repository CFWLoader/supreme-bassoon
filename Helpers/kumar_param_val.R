library(VGAM)

script.dir = dirname(sys.frame(1)$ofile)

setwd(script.dir)

beta.data.frame = read.csv("../../csv_data/BetaSynData1K.csv")

# print(head(beta.data.frame))

fit.detail = vglm(PM25~1, kumar, data = beta.data.frame, trace = TRUE)

print(summary(fit.detail))