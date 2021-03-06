# Set working dir to this file's path.
script.dir = dirname(sys.frame(1)$ofile)

setwd(script.dir)

dataset = read.csv("../datasets/applesOranges.csv")

x0 = vector(length=nrow(dataset))

x0[] = 1

xmat = matrix(c(x0, dataset$x.1, dataset$x.2), ncol = 3)

# print(head(xmat))

y = dataset$y

source('./perceptron.R')

# According to e2-1b. Best angle is 20°.
w1 = cos(pi * 20 / 180)

w2 = sin(pi * 20 / 180)

theta_vec = c()

corr_vec = c()

# print(xmat[1,])

# print(c(-3, w1, w2))

for(theta in seq(-3, 3, 0.05))
{
    w = c(theta, w1, w2)

    corr = correctness(perceptron(w, xmat), y)

    theta_vec = c(theta_vec, theta)

    corr_vec = c(corr_vec, corr)
}

result = data.frame(
    theta = theta_vec,
    correctness = corr_vec
)

# print(result)
mk_idx = 0

max_val = 0

for(idx in c(1:nrow(result)))
{
    if(max_val < result$correctness[idx])
    {
        max_val = result$correctness[idx]

        mk_idx = idx
    }
}

print(result[mk_idx,])