source("./lib/monomial.R")

kfold_validate <- function(fold_ready.df, k_fold, monomial_lim, lamstart = -4, lamend = 4, lamstep = 0.1)
{
    pack_size <- floor(nrow(fold_ready.df) / k_fold)

    folded_pack <- list()

    for(k in c(1:k_fold))
    {
        start_idx <- 1 + (k - 1) * pack_size
        end_idx <- k * pack_size
        fold_t <- fold_ready.df[c(-start_idx : -end_idx), ]
        fold_val <- fold_ready.df[c(start_idx : end_idx), ]
        folded_pack[[k]] <- list(train = fold_t, valid = fold_val)
        folded_pack[[k]]$train_exp <- monomial2dim(fold_t$x1, fold_t$x2, monomial_lim)
        folded_pack[[k]]$valid_exp <- monomial2dim(fold_val$x1, fold_val$x2, monomial_lim)
        folded_pack[[k]]$valid_exp.mat <- data.matrix(folded_pack[[k]]$valid_exp)
    }

    mse.df <- NULL

    for(lam in seq(lamstart, lamend, lamstep))
    {
        resi.vec <- c()
        for(k in c(1:k_fold))
        {
            weight <- retrieve_weight(folded_pack[[k]]$train_exp, folded_pack[[k]]$train$y, 10**lam)
            y_prd <- t(weight) %*% folded_pack[[k]]$valid_exp.mat
            residuals <- folded_pack[[k]]$valid$y - y_prd
            resi.vec <- c(resi.vec, mean(residuals**2))
        }
        mse.df <- rbind(mse.df,
            data.frame(
                lambda = lam,
                mse.val = mean(resi.vec),
                std = sqrt(var(resi.vec))
            )
        )
    }

    return(mse.df)
}

setwd(recor.dir)