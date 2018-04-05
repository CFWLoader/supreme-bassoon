library(ggplot2)

# Set working dir to this file's path.
script.dir = dirname(sys.frame(1)$ofile)

setwd(script.dir)

source('./perceptron.R')

dataset = read.csv("../datasets/applesOranges.csv")

x0 = vector(length = nrow(dataset))

x0[] = 1

xmat = matrix(c(x0, dataset$x.1, dataset$x.2), ncol = 3)

y = dataset$y

angle_vec = c()

w1_vec = c()

w2_vec = c()

theta_vec = c()

corr_vec = c()

for(theta in seq(-3, 3, 0.05))
{
    for(angle in seq(0, 80, 10))
    {
        w1 = 1 / sqrt(1 + tan(angle * pi / 180)**2)

        w2 = w1 * tan(angle * pi / 180)

        corr = correctness(perceptron(c(theta, w1, w2), xmat), y)

        angle_vec = c(angle_vec, angle)

        w1_vec = c(w1_vec, w1)

        w2_vec = c(w2_vec, w2)

        theta_vec = c(theta, theta_vec)

        corr_vec = c(corr_vec, corr)
    }

    corr = correctness(perceptron(c(theta, 0, 1), xmat), y)

    angle_vec = c(angle_vec, 90)

    w1_vec = c(w1_vec, 0)

    w2_vec = c(w2_vec, 1)
    
    theta_vec = c(theta, theta_vec)

    corr_vec = c(corr_vec, corr)

    for(angle in seq(100, 180, 10))
    {
        w1 = - 1 / sqrt(1 + tan(angle * pi / 180)**2)

        w2 = w1 * tan(angle * pi / 180)

        corr = correctness(perceptron(c(theta, w1, w2), xmat), y)

        angle_vec = c(angle_vec, angle)

        w1_vec = c(w1_vec, w1)

        w2_vec = c(w2_vec, w2)

        theta_vec = c(theta, theta_vec)

        corr_vec = c(corr_vec, corr)
    }
}

result = data.frame(
    angle = angle_vec,
    theta = theta_vec,
    w1 = w1_vec,
    w2 = w2_vec,
    correctness = corr_vec
)

# print(result)

max_corr = 0

row_idx = 0

for(idx in c(1:nrow(result)))
{
    if(result$correctness[idx] > max_corr)
    {
        max_corr = result$correctness[idx]

        row_idx = idx
    }
}

# print(result[row_idx,])

angle = result$angle[row_idx]

w1 = sin(pi * angle / 180 + pi / 2)

w2 = cos(pi * angle / 180 + pi / 2)

theta = result$theta[row_idx]

line_y = w2 / w1 * dataset$x.1 + theta

ggplot(dataset, aes(x = x.1, y = x.2, color = y)) + geom_point() + geom_line(aes(y = line_y))

ggsave('./e2-1e.png')