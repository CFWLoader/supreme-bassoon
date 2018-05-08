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

# print(men.my.nn)

# print(all.equal(men.mod.nn, men.my.nn))

data.len <- length(men.obs)

men.bkw.nn <- rep(length = data.len, 0)

men.bkw.nn[data.len] <- (sm.val - alpha * men.obs[data.len]) / (1 - alpha)

# print(men.bkw.nn[data.len])

for(idx in c(data.len:2))
{
    st_1 <- (men.bkw.nn[idx] - alpha * men.obs[idx - 1]) / (1 - alpha)
    men.bkw.nn[idx - 1] <- st_1
}

# print(men.bkw.nn)

print(all.equal(men.mod.nn, men.bkw.nn))