exp_sm_family.nn <- function(alpha, init_level, observed, forecast.steps = 0)
{
    data.len <- length(observed)

    forecast.vec <- c(init_level)

    st <- 0

    for(idx in c(2:data.len))
    {
        st <- alpha * observed[idx - 1] + (1 - alpha) * (forecast.vec[idx - 1])

        forecast.vec <- c(forecast.vec, st)
    }

    if(forecast.steps == 0)
    {
        return(forecast.vec)
    }

    idx <- 1

    st <- alpha * observed[data.len] + (1 - alpha) * forecast.vec[data.len]

    while(idx <= forecast.steps)
    {
        forecast.vec <- c(forecast.vec, st)

        idx = idx + 1
    }

    return(forecast.vec)
}

exp_sm_family.nn.backward <- function(alpha, last_level, observed)
{
    data.len <- length(men.obs)

    backward.vec <- rep(length = data.len, 0)

    backward.vec[data.len] <- (last_level - alpha * observed[data.len]) / (1 - alpha)

    for(idx in c(data.len:2))
    {
        st_1 <- (backward.vec[idx] - alpha * observed[idx - 1]) / (1 - alpha)
        backward.vec[idx - 1] <- st_1
    }

    return(backward.vec)
}

exp_sm_family.na <- function(alpha, init_level, delta, season.init_levels, observed, season.period = length(season.init_levels), forecast.steps = 0)
{
    data.len <- length(observed)

    sm.vec <- c(init_level)

    seas.vec <- rep(season.init_levels)

    forecast.vec <- c(sm.vec[1] + seas.vec[1])

    iter.end = 2 * season.period + 1

    for(prd in c(2:iter.end))
    {
        if(prd - 1 <= season.period)
        {
            sm.val <- alpha * (observed[prd - 1] - seas.vec[prd - 1]) + (1 - alpha) * sm.vec[prd - 1]
            seas.val <- seas.vec[prd]
        }
        else{
            sm.val <- alpha * (observed[prd - 1] - seas.vec[prd - 1 - season.period]) + (1 - alpha) * sm.vec[prd - 1]
            seas.val <- delta * (observed[prd - 1] - sm.val) + (1 - delta) * seas.vec[prd - 1 - season.period]
        }

        sm.vec <- c(sm.vec, sm.val)

        if(prd >= season.period)
        {
            seas.vec <- c(seas.vec, seas.val)
            forecast.vec <- c(forecast.vec, sm.val + seas.vec[prd - season.period])
        }
        else
        {
            forecast.vec <- c(forecast.vec, sm.val + seas.val)
        }
    }

    print(seas.vec)

    return(forecast.vec)
}