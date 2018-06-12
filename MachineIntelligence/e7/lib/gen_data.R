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

genclass <- function(sample.size = 60, mu1 = c(0, 1), mu2 = c(1, 0), sigma = diag(2) * 0.1, cls = 1)
{
    summand.left <- mvrnorm(sample.size, mu = mu1, Sigma = sigma)
    summand.right <- mvrnorm(sample.size, mu = mu2, Sigma = sigma)

    x <- rand_choose(summand.left, summand.right)

    dataset <- data.frame(
        x1 = x[, 1], x2 = x[, 2], y = cls
    )

    dataset
}

gensam <- function(sample.size = 120)
{
    mu1 <- c(0, 1)
    mu2 <- c(1, 0)
    mu3 <- c(0, 0)
    mu4 <- c(1, 1)
    sigma <- diag(2) * 0.1

    dataset <- genclass(sample.size / 2, mu1, mu2, sigma, 1)

    dataset <- rbind(dataset, genclass(sample.size / 2, mu3, mu4, sigma, 2))

    # for(i in c(1:sample.size))
    # {
    #     if(dataset$p.y0_1[i] < dataset$p.y0_2[i])
    #     {
    #         dataset$y[i] = 0
    #     }
    #     else
    #     {
    #         dataset$y[i] = 1
    #     }
    # }

    dataset
}