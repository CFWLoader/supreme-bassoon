script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

source("./lib/gen_data.R")
source("./lib/parzenwin.R")

# sample.df <- genclass(sample.size = 5)
sample.df <- gensam(sample.size = 120)

test <- matrix(runif(10), ncol = 2, byrow = TRUE)

clss <- parzenknn(sample.df[c(1, 2)], test, as.factor(sample.df$y), 9)

print(clss)