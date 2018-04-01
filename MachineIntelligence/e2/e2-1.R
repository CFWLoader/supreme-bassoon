# Set working dir to this file's path.
script.dir <- dirname(sys.frame(1)$ofile)

setwd(script.dir)

dataset <- read.csv("../datasets/applesOranges.csv")

class1 = data.frame()

class2 = data.frame()

for(idx in c(1:length(dataset)))
{
    if(dataset$y[idx] == 0)
    {
        class1 = rbind(class1, dataset[idx,])
    }
    else
    {
        class2 = rbind(class2, dataset[idx,])
    }
}

# print(class1)

# print(class2)

# print(head(dataset))

png("./applesOranges.png")

plot(x = dataset$x.1, y = dataset$x.2)

dev.off()