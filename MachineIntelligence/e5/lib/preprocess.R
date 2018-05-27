center_data.matrix <- function(mat)
{
    cols = ncol(mat)
    ret.mat <- matrix(nrow = nrow(mat), ncol = cols)
    for(col in c(1:cols))
    {
        mean.val <- mean(mat[, col])
        ret.mat[, col] <- mat[, col] - mean.val
    }
    return(ret.mat)
}