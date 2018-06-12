library(MASS)
library(class)
library(dplyr)
library(ggplot2)

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

train <- rbind(iris3[1:25,1:2,1], iris3[1:25,1:2,2], iris3[1:25,1:2,3])
cl <- factor(c(rep("s",25), rep("c",25), rep("v",25)))

test <- expand.grid(x = seq(min(train[,1] - 1), max(train[,1] + 1), by=0.1), y = seq(min(train[,2] - 1), max(train[,2] + 1), by = 0.1))
classif <- knn(train, test, cl, k = 3, prob = TRUE)
prob <- attr(classif, "prob")

dataf <- bind_rows(mutate(test, prob = prob, cls="c", prob_cls = ifelse(classif == cls, 1, 0)), 
    mutate(test, prob = prob, cls="v", prob_cls = ifelse(classif == cls, 1, 0)),
    mutate(test, prob = prob, cls="s", prob_cls = ifelse(classif == cls, 1, 0)))

print(levels(as.factor(dataf$prob_cls)))

ggplot(dataf) + #geom_point(aes(x=x, y=y, col=cls), data = mutate(test, cls=classif), size=1.2) + 
    geom_contour(aes(x=x, y=y, z=prob_cls, group=cls, color=cls), bins=2, data=dataf) + 
    # geom_point(aes(x=x, y=y, col=cls), size=3, data=data.frame(x=train[,1], y=train[,2], cls=cl))

ggsave("./contour_demo.png")