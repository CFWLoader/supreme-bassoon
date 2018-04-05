perceptron <- function(w, x, activation = function(x){return(x)})
{
    vals <- activation(x %*% w)

    # print(vals)

    clss <- c()

    for(idx in c(1:nrow(vals)))
    {
        if(vals[idx] > 0)
        {
            clss <- c(clss, 1)
        }
        else
        {
            clss <- c(clss, 0)
        }
    }
    
    return(matrix(clss, ncol = 1))
}

correctness <- function(y1, y2)
{
    return(as.integer(summary((as.factor(y1 == y2)))[2]) / length(y1))
}