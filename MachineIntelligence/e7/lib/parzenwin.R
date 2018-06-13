library(proxy)

parzenwin <- function (train_df, test_df, cl, sigmak = 0.5)
{
    cls.vec <- rep(0, length = nrow(test_df))
    prob.vec <- rep(0, length = nrow(test_df))
    clslvl <- levels(cl)
    distmat <- dist(test_df, train_df, method = pr_DB$get_entry("Euclidean"))**2
    for(idx in c(1:nrow(test_df)))
    {
        dens.val <- exp(-distmat[idx, ]/(2 * sigmak))
        dens.val <- dens.val / sum(dens.val)
        cls.val <- NULL
        cls.prob <- 0
        for(lvl in clslvl)
        {
            probi = sum(dens.val[which(cl == lvl)])
            if(probi > cls.prob)
            {
                cls.prob = probi
                cls.val = lvl
            }
        }
        cls.vec[idx] <- cls.val
        prob.vec[idx] <- cls.prob
    }
    data.frame(
        class = as.factor(cls.vec),
        prob = prob.vec
    )
}