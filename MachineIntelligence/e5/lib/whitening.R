center_data <- function(data)
{
    cols = ncol(data)
    ret.data <- matrix(nrow = nrow(data), ncol = cols)
    for(col in c(1:cols))
    {
        mean.val <- mean(data[, col])
        ret.data[, col] <- data[, col] - mean.val
    }
    return(ret.data)
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

    data.len <- nrow(data)

    cov_mat <- t(centered_data) %*% centered_data / data.len

    eigen.pack <- eigen(cov_mat)

    eigenvalues <- eigen.pack$values

    eigenvectors <- eigen.pack$vectors

    eigenlen <- length(eigenvalues)

    eigenvalue.diag <- matrix(rep(0, eigenlen**2), nrow = eigenlen, ncol = eigenlen)

    eigenvalue.rootmat <- matrix(rep(0, eigenlen**2), nrow = eigenlen, ncol = eigenlen)

    diag(eigenvalue.diag) <- eigenvalues

    diag(eigenvalue.rootmat) <- eigenvalues**(-1/2)

    # print(eigenvectors)

    eigen_trans <- eigenvalue.rootmat %*% t(eigenvectors)

    ret.vals <- list(covar = cov_mat, eigenvalues = eigenvalues, eigenvectors = eigenvectors, 
        eigenvalues.matrix = eigenvalue.diag, eigenvalues.rootmat = eigenvalue.rootmat, centered_data = centered_data, 
        eigen.transmat = eigen_trans)

    return(ret.vals)
}

whiten <- function(data, whiten.params, centered = FALSE)
{
    if(!centered)
    {
        white_data <- center_data(data)
    }
    else
    {
        white_data <- data
    }

    if(missing(whiten.params))
    {
        infos <- whiten_params(white_data, TRUE)
        whiten.params <- infos$eigen.transmat
    }
    else
    {
        infos <- list()
    }

    ret.vals <- list(eigen.info = c(infos), whitedata = white_data %*% t(whiten.params), params = whiten.params)
    
    return(ret.vals)
}

sphere <- whiten