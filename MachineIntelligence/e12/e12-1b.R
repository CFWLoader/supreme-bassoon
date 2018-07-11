library(reshape2)
library(ggplot2)

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

source("./lib/loadmaze.R")
source("./lib/tranmodel.R")

file_path <- "../datasets/mazes.txt"

mazes <- loadmaze(file_path)

actions <- c("up", "left", "right", "down")

tranmodel <- gen_tranmodel(mazes[[1]], actions)

# str(tranmodel)

transitions <- tranmodel$transition.model

print(length(which(transitions == 1)))