library(forecast)
library(ggplot2)
library(stats)

script.dir <- dirname(sys.frame(1)$ofile)

setwd(script.dir)

# x <- runif(50)

fitma <- auto.arima(x, max.q =1, max.p=0, stationary=TRUE, seasonal=FALSE)

# print(fitma)

plt.df <- data.frame(
    x = c(1:length(x)),
    y = x,
    grp_id = 1
)

resi <- x - mean(x)

sigma <- var(resi)

resi.t <- resi[c(-length(resi))]

print(sigma)

resi.t <- c(0, resi.t)

cal.df <- data.frame(
    x = x,
    y = resi,
    y2 = resi.t
)

lm.form <- lm(x ~ y + y2, data = cal.df)

print(coef(lm.form))

ggplot(plt.df, aes(x = x, y = y)) + geom_point() + geom_line()

ggsave("./ma_model.png")

# print(fitma)