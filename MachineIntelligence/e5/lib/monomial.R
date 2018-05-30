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