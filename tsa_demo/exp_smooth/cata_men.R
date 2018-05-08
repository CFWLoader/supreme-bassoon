script.dir <- dirname(sys.frame(1)$ofile)

setwd(script.dir)

source("./forecast/exp_sm_family.R")

cata.men.data <- read.csv("../dataset/cata_men_modeler.csv")

men.obs <- as.numeric(cata.men.data$men)

men.mod.nn <- as.numeric(cata.men.data$X.TS.men)

sm.val <- 23372.916853970666

alpha <- 0.10510979401860768

init_level <- 11453.646871104995

men.my.nn <- exp_sm_family.nn(alpha, init_level, men.obs)

men.bkw.nn <- exp_sm_family.nn.backward(alpha, sm.val, men.obs)

print(all.equal(men.mod.nn, men.bkw.nn))