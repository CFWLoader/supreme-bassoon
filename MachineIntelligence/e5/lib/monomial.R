library(MASS)

monomial2dim <- function(x1, x2, monomial_lim)
{
    ret.df <- NULL
    for(k in c(0 : monomial_lim))
    {
        for(a in c(0 : k))
        {
            b <- k - a
            tmp.df <- data.frame(data = x1**a * x2**b)
            ret.df <- rbind(ret.df, data.frame(
                data = t(tmp.df),
                row.names = c(paste("x1^", a, "*x2^", b, sep = ""))
            ))
        }
    }
    return(ret.df)
}

train_expand_param2dim <- function(x1, x2, yt, to_dim, monomials.df)
{
    if(missing(monomials.df))
    {
        monomials.df <- monomial2dim(x1, x2, to_dim)
    }
    phi_mat <- data.matrix(monomials.df)
    phi_mat.tinv <- ginv(phi_mat %*% t(phi_mat))
    weight <- phi_mat.tinv %*% phi_mat %*% yt
    return(
        list(
            weight = weight,
            monomials = monomials.df
        )
    )
}

retrieve_weight <- function(monomials, yt, lambda = 0)
{
    phi_mat <- data.matrix(monomials)
    phi_mat.tinv <- phi_mat %*% t(phi_mat)
    eye_mat <- diag(nrow = nrow(phi_mat.tinv)) * lambda
    phi_mat.tinv <- ginv(phi_mat.tinv + eye_mat)
    weight <- phi_mat.tinv %*% phi_mat %*% yt
    return(weight)
}