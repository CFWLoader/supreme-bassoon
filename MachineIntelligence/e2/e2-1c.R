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

x0 = vector(length=nrow(dataset))

x0[] = 1

xmat = matrix(c(x0, dataset$x.1, dataset$x.2), ncol = 3)

print(head(xmat))

y = dataset$y

# According to e2-1b. Best angle is 90°.
w1 = 1 / sqrt(1 + tan(pi * 20 / 180)**2)

w2 = w1 * tan(pi * 20 / 180)

theta_vec = c()

corr_vec = c()

# print(xmat[1,])

# print(c(-3, w1, w2))

for(theta in seq(-3, 3, 0.1))
{
    w = c(theta, w1, w2)

    corr = test_correctness(w, xmat, y)

    theta_vec = c(theta_vec, theta)

    corr_vec = c(corr_vec, corr)
}

result = data.frame(
    theta = theta_vec,
    correcness = corr_vec
)

print(result)