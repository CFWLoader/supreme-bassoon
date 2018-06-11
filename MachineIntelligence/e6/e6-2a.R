gensam <- function(sample.size = 10000, num_props = 30, val_portion = 0.2)
{
    all.x <- array(dim = c(sample.size, num_props))

    all.y <- array(dim = c(sample.size, 1))

    for(i in (1 : sample.size))
    {
        all.x[i, ] <- array(round(runif(num_props, 0, 9)))
        if(sum(all.x[i, ]) >= 100)
        {
            all.y[i, 1] <- 1
        }
        else
        {
            all.y[i, 1] <- 0
        }
    }

    split_point <- (1 - val_portion) * sample.size

    list(
        train = list(
            x = all.x[c(1 : split_point), ],
            y = all.y[c(1 : split_point)]
        ),
        test = list(
            x = all.x[c((split_point + 1) : sample.size), ],
            y = all.y[c((split_point + 1) : sample.size)]
        )
    )
}