library(ggplot2)

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

# bsddata <- read.csv("${data file path?}")

len <- 1000
lnSum <- -588.1445084464773
lnOneMinusSum <- -1092.6313364051173

beta.llf <- function(a, b) {	
	len * lgamma(a + b) - len * lgamma(a) - len * lgamma(b) + (a - 1) * lnSum + (b - 1) * lnOneMinusSum
}

alpha.range <- seq(2.8, 2.9, 0.001)
beta.range <- seq(1.8, 1.9, 0.001)

ab.combi <- expand.grid(
	alpha = alpha.range,
	beta = beta.range
)

llfval.vec <- NULL

for(row.idx in seq(1,nrow(ab.combi))){
	llfval.vec <- c(llfval.vec, beta.llf(ab.combi$alpha[row.idx], ab.combi$beta[row.idx]))
}

plt.df <- cbind(ab.combi, data.frame(llf = llfval.vec))

ggplot(plt.df) + geom_tile(aes(x = alpha, y = beta, fill = llf)) + scale_fill_gradientn(colors = rainbow(7))

ggsave("bsd_llf_plt.png")