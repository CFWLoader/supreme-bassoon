library(ggplot2)

# Set working dir to this file's path.
script.dir = dirname(sys.frame(1)$ofile)

setwd(script.dir)

dataset = read.csv("../datasets/applesOranges.csv")

for(angle in seq(0, 80, 10))
{
    # print(tan(angle))

    w1 = 1 / sqrt(1 + tan(angle * pi / 180)**2)

    w2 = 0

    print(paste(angle, w1))
}

w1 = 0, w2 = 1