library(ggplot2)
# Demo from statistic.
# options(digits = 10)
script.dir = dirname(sys.frame(1)$ofile)

setwd(script.dir)

broadband1 <- read.csv("../broadband_1_m1.csv")

broadband1baseline <- read.csv("../broadband_1_m1_bl.csv")

bbm1 <- as.numeric(broadband1$Market_1)

# bbm1bl <- as.numeric(broadband1baseline$Market_1)[c(1:(length(bbm1) + 1))]

# bbm1bl <- bbm1bl[c(-2)]

bbm1bl <- as.numeric(broadband1baseline$Market_1)[c(1:length(bbm1))]

data_len = length(bbm1)

alpha <- 0.9998605444732013

time_slot = c(1:data_len)

plot_dataframe = data.frame(x = time_slot, y = bbm1, grp_id = rep(length = data_len, 1))

tmpdf = data.frame(x = time_slot, y = bbm1bl, grp_id = rep(length = data_len, 2))

plot_dataframe = rbind(plot_dataframe, tmpdf)

# Using forward calculation.
init_level <- 3750.013388664384

prd_vls <- rep(length = length(bbm1), 0)

prd_vls[1] <- init_level

# prd_vls[2] <- init_level

for(idx in c(2:length(bbm1)))
{
    # prd_vls[idx] <- alpha * bbm1[idx] + (1 - alpha) * prd_vls[idx - 1]
    prd_vls[idx] <- alpha * bbm1[idx - 1] + (1 - alpha) * prd_vls[idx - 1]    
}

res_tbl <- data.frame(
    source = bbm1,
    modeler_prd = bbm1bl,
    my_prd = prd_vls
)

print(prd_vls)

# print(res_tbl)

print(all.equal(bbm1bl, prd_vls, tolerance = 1e-7))

# tmpdf = data.frame(x = time_slot, y = prd_vls, grp_id = rep(length = data_len, 3))

# plot_dataframe = rbind(plot_dataframe, tmpdf)

# Backward calculation
# smoothed_value <- 11549.014923199755

# prd_vls <- rep(length = length(bbm1), 0)

# prd_vls[data_len] <- smoothed_value

# # print(paste(data_len, prd_vls[data_len], "Xt=", bbm1[data_len]))

# for(idx in c(data_len:2))
# {
#     prd_vls[idx - 1] <- alpha * bbm1[idx - 1] + (1 - alpha) * prd_vls[idx]
#     # prd_vls[idx - 1] <- (abs(prd_vls[idx] - alpha * bbm1[idx]) / (1 - alpha))
#     # print(paste(idx - 1, " " ,prd_vls[idx - 1], " X[", idx, "]=", bbm1[idx], "  S[", idx, "]=", prd_vls[idx], sep=""))
# }

# # print(paste("A=", alpha, "1-A=", 1-alpha))

# print(prd_vls)

# tmpdf = data.frame(x = time_slot, y = prd_vls, grp_id = rep(length = data_len, 4))

# plot_dataframe = rbind(plot_dataframe, tmpdf)

# print(paste("MSE=", sum((prd_vls - bbm1)**2) / data_len))

# print(paste("MAE=", sum(abs(prd_vls - bbm1)) / data_len))

# print(paste("MAPE=", 100 * sum(abs((prd_vls - bbm1) / bbm1)) / data_len))

# plot_var <- ggplot(plot_dataframe, aes(x = x, y = y, group = grp_id, color = as.factor(grp_id))) + geom_line() + geom_point() + labs(title = "Market 1", x = "Period", y = "Sales", color = "Value Type") 

# plot_var <- plot_var + scale_color_manual(labels = c("Observations", "Modeler Sim", "R Sim(F)"), 
#     values = c("red", "blue", "darkgreen"))

# ggsave("./Market1.png")