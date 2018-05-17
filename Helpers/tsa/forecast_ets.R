library(forecast)

script.dir <- dirname(sys.frame(1)$ofile)

setwd(script.dir)

cata.men.data <- read.csv("../../tsa_demo/dataset/cata_men_modeler.csv")

men.obs <- as.numeric(cata.men.data$men)

men.mod.nn <- as.numeric(cata.men.data$X.TS.men)

result = ets(men.obs, model = 'ANN')

print(result$par[1])