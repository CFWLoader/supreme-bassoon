library(reshape2)
library(ggplot2)

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

source("./lib/loadmaze.R")

file_path <- "../datasets/mazes.txt"

mazes <- loadmaze(file_path)

for(mazeno in 1:4)
{
    melt.maze <- melt(mazes[[mazeno]])
    names(melt.maze) <- c("x", "y", "type")
    ggplot(melt.maze, aes(x = x, y = y, fill = type)) + geom_tile() + scale_fill_manual(values = c("white", "black", "green"))
    ggsave(sprintf("e12-1a-maze%d.png", mazeno))
}