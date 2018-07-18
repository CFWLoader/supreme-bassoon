
script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

source("./lib/loadmaze.R")
source("./lib/tranmodel.R")
source("./lib/analyticvalue.R")

file_path <- "../datasets/mazes.txt"

mazes <- loadmaze(file_path)

actions <- c("up", "left", "right", "down")

tranmodel <- gen_tranmodel(mazes[[1]], actions)

rewards <- generate_rewards(actions, tranmodel$states)

policies <- generate_uniform_policy(actions, tranmodel$states)

str(rewards)

str(policies)