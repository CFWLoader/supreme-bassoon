library(ggplot2)

# Set working dir to this file's path.
script.dir = dirname(sys.frame(1)$ofile)

setwd(script.dir)

source('./perceptron.R')

dataset = read.csv("../datasets/applesOranges.csv")

# print(head(dataset))

xmat = matrix(c(dataset$x.1, dataset$x.2), ncol = 2)

y = dataset$y

# print(test_correctness(c(0.5, 0.5), xmat, y))

# print(head(xmat))

# print(head(y))

angle_vec = c()

w1_vec = c()

w2_vec = c()

corr_vec = c()

ploter = ggplot(dataset, aes(x = x.1, y = x.2, color=y)) + geom_point()

for(angle in seq(0, 180, 10))
{
    # print(tan(angle))

    w1 = sin(angle * pi / 180)

    w2 = cos(angle * pi / 180)

    corr = correctness(perceptron(c(w1, w2), xmat), y)

    angle_vec = c(angle_vec, angle)

    w1_vec = c(w1_vec, w1)

    w2_vec = c(w2_vec, w2)

    corr_vec = c(corr_vec, corr)

}

result = data.frame(
    angle = angle_vec,
    w1 = w1_vec,
    w2 = w2_vec,
    correctness = corr_vec
)

print(result)

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

angle = result$angle[row_idx]

w1 = sin(pi * angle / 180 + pi / 2)

w2 = cos(pi * angle / 180 + pi / 2)

# print(result$angle[row_idx])

line_y = w2 / w1 * dataset$x.1

ploter = ploter + geom_line(aes(y = line_y))

# ggplot(dataset, aes(x = x.1, y = x.2, color=y)) + geom_point() + geom_line(aes(y = line_y))

ggsave("./applesOrangesLines.png")

ploter = ggplot(result, aes(x = angle, y = correctness)) + geom_line()

ggsave("./e2-1b_cor-angle.png")