obs_past <- c(112,118,132,129,121,135,148,148,136,119,104,118,115,126,141,135,125,149,170,170,158,133,114,140)
obs_prd <- c(145, 150, 178, 163, 172, 178, 199, 199, 184, 162, 146, 166)
prd_se <- c(7.3, 8.3, 9.3, 10.3, 11.3, 12.3, 13.3, 14.3, 15.3, 16.3, 17.3, 18.3)


# Demo from statistic.
# script.dir = dirname(sys.frame(1)$ofile)

# setwd(script.dir)

# broadband1 <- read.csv("./broadband_1_m1.csv")

# bbm1 <- as.numeric(broadband1$Market_1)

# alpha <- 0.7193099903799602

# smoothed_value <- 11581.837327068964

# prd_vls <- rep(length = length(bbm1), 0)

# prd_vls[length(bbm1)] <- smoothed_value

# for(idx in c(length(bbm1):2))
# {
#     prd_vls[idx - 1] <- (prd_vls[idx] - alpha * bbm1[idx]) / (1 - alpha)
# }

# print(prd_vls)