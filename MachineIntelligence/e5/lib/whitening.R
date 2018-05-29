center_data <- function(data)
{
    cols = ncol(data)
    ret.data <- matrix(nrow = nrow(data), ncol = cols)
    for(col in c(1:cols))
    {
        mean.val <- mean(data[, col])
        ret.data[, col] <- data[, col] - mean.val
    }
    return(ret.mat)
}

whiten_params <- function(data, centered = FALSE)
{
    if(!centered)
    {
        centered_data = center_data(data)
    }
    else {
        centered_data = data
    }

    data.len <- length(data)

    cov_mat <- t(centered_data) %*% centered_data / data.len

    eigen.
}