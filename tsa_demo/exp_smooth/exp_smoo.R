obs_past <- c(112,118,132,129,121,135,148,148,136,119,104,118,115,126,141,135,125,149,170,170,158,133,114,140)
obs_prd <- c(145, 150, 178, 163, 172, 178, 199, 199, 184, 162, 146, 166)
prd_se <- c(7.3, 8.3, 9.3, 10.3, 11.3, 12.3, 13.3, 14.3, 15.3, 16.3, 17.3, 18.3)
alpha <- 0.233984
smoothed_value <- 139.8

# init_level <- (obs_past[1] + obs_past[2] + obs_past[3]) / 3

# prd_past <- rep(length = length(obs_past), 0)

# prd_past[1] <- alpha * obs_past[1] + (1 - alpha) * init_level

for(idx in c(1:(length(obs_past) - 1)))
{
    prd_past[idx + 1] <- alpha * obs_past[idx + 1] + (1 - alpha) * prd_past[idx]
}

print(prd_past)

# prd_len <- length(obs_prd)

# prd_vls <- rep(length = prd_len, 0)

# prd_vls[1] <- alpha * obs_prd[1] + (1 - alpha) * smoothed_value

# for(idx in c(2:prd_len))
# {
#     prd_vls[idx] <- alpha * prd_vls[idx - 1] + (1 - alpha) * obs_prd[idx - 1]
# }

# print(prd_vls)