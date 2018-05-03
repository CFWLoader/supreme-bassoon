# Demo from statistic.
script.dir = dirname(sys.frame(1)$ofile)

setwd(script.dir)

broadband1 <- read.csv("../broadband_1_m1.csv")

bbm1 <- as.numeric(broadband1$Market_1)

alpha <- 0.7193099903799602

smoothed_value <- 11581.837327068964

prd_vls <- rep(length = length(bbm1), 0)

prd_vls[length(bbm1)] <- smoothed_value

for(idx in c(length(bbm1):2))
{
    prd_vls[idx - 1] <- (prd_vls[idx] - alpha * bbm1[idx - 1]) / (1 - alpha)
}

print(prd_vls)