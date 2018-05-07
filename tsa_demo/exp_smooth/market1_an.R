script.dir = dirname(sys.frame(1)$ofile)

setwd(script.dir)

broadband1 <- read.csv("../broadband_1_m1.csv")

broadband1baseline <- read.csv("../broadband_1_m1_an_bl.csv")

bbm1 <- as.numeric(broadband1$Market_1)

bbm1bl <- as.numeric(broadband1baseline$Market_1)[c(1:length(bbm1))]

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
    # sv <- alpha * bbm1[prd - 1] + (1 - alpha) * (sv.vec[prd - 1] + trend.vec[prd - 1])
    sv <- alpha * bbm1[prd] + (1 - alpha) * (sv.vec[prd - 1] + trend.vec[prd - 1])    

    # print(paste("ITR=", prd, "  sv=", sv))

    sv.vec <- c(sv.vec, sv)

    trend <- gamm * (sv.vec[prd] - sv.vec[prd - 1]) + (1 - gamm) * trend.vec[prd - 1]

    trend.vec <- c(trend.vec, trend)

    x.prd.vec <- c(x.prd.vec, sv + trend)
}

print(x.prd.vec)