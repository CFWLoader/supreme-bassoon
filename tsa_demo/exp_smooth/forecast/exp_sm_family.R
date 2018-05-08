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