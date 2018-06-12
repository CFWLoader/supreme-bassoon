parzenknn <- function (train, test, cl, k = 1, sigmak = 0.5)
{
    clsmat <- matrix(nrow = nrow(test), ncol = 2)
    for(idx in c(1:nrow(test)))
    {
        dist.vec <- test[idx, ] - train
        dist.val <- exp(-rowSums(dist.vec * dist.vec)/(2 * sigmak))
        dist.val <- dist.val / sum(dist.val)
        clsrank <- cl[order(dist.val)]
        topkcls <- clsrank[c(1:k)]
        fretbl <- table(topkcls)
        fretbl <- fretbl / sum(fretbl)
        fretbl <- fretbl[order(fretbl, decreasing = TRUE)]
        clsinfo <- fretbl[1]
        clsmat[idx, 1] <- attr(clsinfo, "names")
        clsmat[idx, 2] <- clsinfo
    }
    data.frame(
        class = clsmat[, 1],
        prob = clsmat[, 2]
    )
}