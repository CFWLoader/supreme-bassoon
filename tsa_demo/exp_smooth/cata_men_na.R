script.dir <- dirname(sys.frame(1)$ofile)

setwd(script.dir)

source("./forecast/exp_sm_family.R")

cata.men.data <- read.csv("../dataset/cata_men_na.csv")

men.obs <- as.numeric(cata.men.data$men)

men.mod.na <- as.numeric(cata.men.data$X.TS.men)

alpha <- 0.19822038738944808

init_level <- 12565.140054368056

delta <- 2.0867458053701084E-6

season.period <- 12

season.init_levels <- c(
    -909.4665438279646, -2491.286564054095, 
    -2191.407836509213, -2925.6844237629093, 
    -2382.7264032860817, -2296.117872040105, 
    -2403.6969513739855, -38.35279206716034, 
    -1265.8765817869282, 2179.3454438387575,
    1684.035992735031, 13041.014699282507
)

res <- exp_sm_family.na(alpha, init_level, delta, season.init_levels, men.obs)

print(res)

# print(all.equal(men.mod.na, res))