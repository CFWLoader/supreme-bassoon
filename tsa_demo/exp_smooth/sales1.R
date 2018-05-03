alpha <- 0.5

sales_true <- c(10,15,8,20,10,16,18,20,22,24,20,26,27,29,29)

sales_prd <- rep(length = length(sales_true), 0)

level_val <- (sales_true[1] + sales_true[2] + sales_true[3]) / 3

sales_prd[1] <- (alpha * sales_true[1] + (1 - alpha) * level_val)

for(idx in c(1:(length(sales_true) - 1)))
{
    sales_prd[idx + 1] <- (alpha * sales_true[idx + 1] + (1 - alpha) * sales_prd[idx])
}

print(sales_prd)