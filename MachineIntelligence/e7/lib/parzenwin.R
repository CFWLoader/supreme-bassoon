parzenwin <- function (train_df, test_df, cl, sigmak = 0.5)
{
    cls.vec <- rep(0, length = nrow(test_df))
    prob.vec <- rep(0, length = nrow(test_df))
    clslvl <- levels(cl)
    train <- data.matrix(train_df)
    test <- data.matrix(test_df)
    for(idx in c(1:nrow(test)))
    {
        dist.vec <- test[idx, ] - train
        eudist.val <- rowSums(dist.vec * dist.vec)
        dens.val <- exp(-eudist.val/(2 * sigmak))
        dens.val <- dens.val / sum(dens.val)
        print(sum(dens.val))
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
        print(sprintf("Prob=%f, CLS=%s", cls.prob, cls.val))
        for(pidx in c(1:nrow(train)))
        {
            print(sprintf("Point(%f, %f), dist=%f, dens=%f, cls=%s", train[pidx, 1], train[pidx, 2], eudist.val[pidx], dens.val[pidx], cl[pidx]))
        }
    }
    data.frame(
        class = as.factor(cls.vec),
        prob = prob.vec
    )
}