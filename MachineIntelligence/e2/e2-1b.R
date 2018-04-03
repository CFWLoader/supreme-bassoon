# library(ggplot2)

# Set working dir to this file's path.
script.dir = dirname(sys.frame(1)$ofile)

setwd(script.dir)

test_correctness = function(w, x, y)
{
    count = 0

    for(idx in c(1:nrow(x)))
    {
        val = w %*% x[idx,]

        if(val < 0)
        {
            val = 0
        }
        else
        {
            val = 1
        }

        if(val == y[idx])
        {
            count = count + 1
        }
    }

    return(count / length(x))
}

dataset = read.csv("../datasets/applesOranges.csv")

# print(head(dataset))

xmat = matrix(c(dataset$x.1, dataset$x.2), ncol = 2)

y = as.factor(dataset$y)

# print(test_correctness(c(0.5, 0.5), xmat, y))

# print(head(xmat))

# print(head(y))

angle_vec = c()

w1_vec = c()

w2_vec = c()

corr_vec = c()

ploter = ggplot(dataset, aes(x = x.1, y = x.2, color=y)) + geom_point()

for(angle in seq(0, 80, 10))
{
    # print(tan(angle))

    w1 = 1 / sqrt(1 + tan(angle * pi / 180)**2)

    w2 = w1 * tan(angle * pi / 180)

    corr = test_correctness(c(w1, w2), xmat, y)

    angle_vec = c(angle_vec, angle)

    w1_vec = c(w1_vec, w1)

    w2_vec = c(w2_vec, w2)

    corr_vec = c(corr_vec, corr)

    # line_y = c(line_y, dataset$x.1 * w2 / w1)

    # print(paste(w2 / w1, tan(angle * pi / 180)))

    # ploter = ploter + geom_line(aes(y = line_y[angle / 10]))
}

corr = test_correctness(c(0, 1), xmat, y)

ploter = ploter + geom_vline(xintercept = 0)

angle_vec = c(angle_vec, 90)

w1_vec = c(w1_vec, 0)

w2_vec = c(w2_vec, 1)

corr_vec = c(corr_vec, corr)

for(angle in seq(100, 180, 10))
{
    w1 = - 1 / sqrt(1 + tan(angle * pi / 180)**2)

    w2 = w1 * tan(angle * pi / 180)

    corr = test_correctness(c(w1, w2), xmat, y)

    angle_vec = c(angle_vec, angle)

    w1_vec = c(w1_vec, w1)

    w2_vec = c(w2_vec, w2)

    corr_vec = c(corr_vec, corr)

    if(angle == 120)
    {
        line_y = dataset$x.1 * w2 / w1

        ploter = ploter + geom_line(aes(y = line_y))
    }
}

result = data.frame(
    angle = angle_vec,
    w1 = w1_vec,
    w2 = w2_vec,
    correctness = corr_vec
)

print(result)

# line_x = seq(-2, 1, 0.05)

# line_y = w2 / w1 * dataset$x.1

# ggplot(dataset, aes(x = x.1, y = x.2, color=y)) + geom_point() + geom_line(aes(y = line_y))

ggsave("./applesOrangesLines.png")