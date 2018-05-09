# library(smooth)

script.dir <- dirname(sys.frame(1)$ofile)

setwd(script.dir)

source("../exp_smooth/forecast/exp_sm_family.R")

cata.men.data <- read.csv("../dataset/cata_men_modeler.csv")

men.obs <- as.numeric(cata.men.data$men)

men.mod.nn <- as.numeric(cata.men.data$X.TS.men)

data.len <- length(men.obs)

sm.val <- 23372.916853970666

alpha <- 0.10510979401860768

init_level <- 11453.646871104995

alpha.0 <- 0.1

prd.int <- exp_sm_family.nn(alpha, init_level, men.obs)

# sm.tp1.0 <- men.obs[data.len]

# prd.int <- exp_sm_family.nn.backward(alpha.0, sm.tp1.0, men.obs)

print(sum((prd.int - men.obs)**2) / data.len)

# print(es(men.obs, model = "ANN"))
# print(es(men.obs, model = "ANN", silent = "none"))