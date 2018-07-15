
script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

source("./lib/loadmaze.R")
source("./lib/analyticvalue.R")