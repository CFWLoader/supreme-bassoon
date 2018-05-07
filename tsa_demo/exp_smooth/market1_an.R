library(ggplot2)

script.dir = dirname(sys.frame(1)$ofile)

setwd(script.dir)

broadband1 <- read.csv("../broadband_1_m1.csv")

broadband1baseline <- read.csv("../broadband_1_m1_an_bl.csv")

bbm1 <- as.numeric(broadband1$Market_1)

bbm1bl <- as.numeric(broadband1baseline$Market_1)[c(1:length(bbm1))]

data.len <- length(bbm1)

alpha <- 0.9999972781761034

al_sv <- 11549.000469382156

gamm <- 0.30032013865552887

gam_sv <- 13.66031875889665

al_init_l <- 3635.858152488188

gam_init_l <- 114.14177693746852

# Forward calculation.
sv.vec <- c(al_init_l)

trend.vec <- c(gam_init_l)

x.prd.vec <- c(sv.vec[1] + trend.vec[1])

for(prd in c(2:length(bbm1)))
{
    sv <- alpha * bbm1[prd - 1] + (1 - alpha) * (sv.vec[prd - 1] + trend.vec[prd - 1])
    # sv <- alpha * bbm1[prd] + (1 - alpha) * (sv.vec[prd - 1] + trend.vec[prd - 1])    

    # print(paste("ITR=", prd, "  sv=", sv))

    sv.vec <- c(sv.vec, sv)

    trend <- gamm * (sv.vec[prd] - sv.vec[prd - 1]) + (1 - gamm) * trend.vec[prd - 1]

    trend.vec <- c(trend.vec, trend)

    x.prd.vec <- c(x.prd.vec, sv + trend)
}

# print(sv.vec[data.len])

# print(al_sv)

# print(trend.vec[data.len])

# print(gam_sv)

# print(x.prd.vec)

# print(all.equal(bbm1bl, x.prd.vec))

# Backward calculation.
sv.bkw.vec <- vector(length = data.len)

trend.bkw.vec <- vector(length = data.len)

x.bkw.vec1 <- vector(length = data.len)

# sv.bkw.vec[data.len] <- al_sv

# trend.bkw.vec[data.len] <- gam_sv

sv.bkw.vec[data.len] <- sv.vec[data.len]

trend.bkw.vec[data.len] <- trend.vec[data.len]

x.bkw.vec1[data.len] <- sv.bkw.vec[data.len] + trend.bkw.vec[data.len]

for(prd in c(data.len:2))
{
    sv.bkw <- alpha * bbm1[prd] + (1 - alpha) * (sv.bkw.vec[prd] + trend.bkw.vec[prd])

    sv.bkw.vec[prd - 1] <- sv.bkw

    trend.bkw <- gamm * (sv.vec[prd - 1] - sv.vec[prd]) + (1 - gamm) * trend.bkw.vec[prd]

    trend.bkw.vec[prd - 1] <- trend.bkw

    x.bkw.vec1[prd - 1] <- sv.bkw + trend.bkw
}

# Back 2.
sv.bkw.vec2 <- c(sv.vec[data.len])

trend.bkw.vec2 <- c(trend.vec[data.len])

x.bkw.vec2 <- c(sv.bkw.vec2[1] + trend.bkw.vec2[1])

bbm1.bkw <- rev(bbm1)

for(prd in c(2:length(bbm1)))
{
    sv.bkw2 <- alpha * bbm1.bkw[prd - 1] + (1 - alpha) * (sv.bkw.vec2[prd - 1] + trend.bkw.vec2[prd - 1])
    # sv <- alpha * bbm1[prd] + (1 - alpha) * (sv.vec[prd - 1] + trend.vec[prd - 1])    

    # print(paste("ITR=", prd, "  sv=", sv))

    sv.bkw.vec2 <- c(sv.bkw.vec2, sv.bkw2)

    trend.bkw2 <- gamm * (sv.bkw.vec2[prd] - sv.bkw.vec2[prd - 1]) + (1 - gamm) * trend.bkw.vec2[prd - 1]

    trend.bkw.vec2 <- c(trend.bkw.vec2, trend.bkw2)

    x.bkw.vec2 <- c(x.bkw.vec2, sv.bkw2 + trend.bkw2)
}

# print(rev(x.bkw.vec2))
plot.df <- NULL

plot.df <- rbind(plot.df, data.frame(x = c(1:data.len), y = x.prd.vec, grp = "R.FW"))

plot.df <- rbind(plot.df, data.frame(x = c(1:data.len), y = x.bkw.vec1, grp = "R.BW1"))

plot.df <- rbind(plot.df, data.frame(x = c(1:data.len), y = rev(x.bkw.vec2), grp = "R.BW2"))

plot.df <- rbind(plot.df, data.frame(x = c(1:data.len), y = bbm1, grp = "ORG"))

plot.obj <- ggplot(plot.df, aes(x = x, y = y, group = as.factor(grp), color = as.factor(grp), shape = as.factor(grp))) + 
    geom_line()

ggsave("./Market1AN.png")