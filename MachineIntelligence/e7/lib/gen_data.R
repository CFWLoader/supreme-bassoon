library(MASS)

rand_choose <- function(l, r)
{
    data.size <- nrow(l)
    prop.size <- ncol(l)
    ret.val <- matrix(rep(0, length = data.size * prop.size), ncol = prop.size)
    for(i in c(round(1:data.size)))
    {
        if(runif(1) > 0.5)
        {
            ret.val[i, ] <- l[i, ]
        }
        else 
        {
            ret.val[i, ] <- r[i, ]
        }
    }
    ret.val
}

gensam <- function(sample.size = 120)
{
    mu1 <- c(0, 1)
    mu2 <- c(1, 0)
    mu3 <- c(0, 0)
    mu4 <- c(1, 1)
    sigma <- diag(2) * 0.1**2

    summand.left <- mvrnorm(sample.size / 2, mu = mu1, Sigma = sigma)
    summand.right <- mvrnorm(sample.size / 2, mu = mu2, Sigma = sigma)

    x <- rand_choose(summand.left, summand.right)

    p.y0 <- 0.5 * (summand.left + summand.right)

    dataset <- data.frame(
        x1 = x[, 1], x2 = x[, 2], p.y0_1 = p.y0[, 1], p.y0_2 = p.y0[, 2], y = 0
    )

    summand.left <- mvrnorm(sample.size / 2, mu = mu3, Sigma = sigma)
    summand.right <- mvrnorm(sample.size / 2, mu = mu4, Sigma = sigma)

    x <- rand_choose(summand.left, summand.right)

    p.y0 <- 1 - 0.5 * (summand.left + summand.right)

    dataset <- rbind(dataset, data.frame(
        x1 = x[, 1], x2 = x[, 2], p.y0_1 = p.y0[, 1], p.y0_2 = p.y0[, 2], y = 0
    ))

    for(i in c(1:sample.size))
    {
        if(dataset$p.y0_1[i] > 0.5 && dataset$p.y0_2[i] > 0.5)
        {
            dataset$y[i] = 1
        }
        else
        {
            dataset$y[i] = 0
        }
    }

    dataset
}