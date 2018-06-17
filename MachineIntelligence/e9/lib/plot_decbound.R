make_plotpoint <- function(trainset, grid.num = 128)
{
    x_axis.min <- min(trainset[, 1])
    x_axis.max <- max(trainset[, 1])
    x_axis.ssize <- (x_axis.max - x_axis.min)/grid.num

    y_axis.min <- min(trainset[, 2])
    y_axis.max <- max(trainset[, 2])
    y_axis.ssize <- (y_axis.max - y_axis.min)/grid.num

    expand.grid(
        x = seq(x_axis.min, x_axis.max, x_axis.ssize),
        y = seq(y_axis.min, y_axis.max, y_axis.ssize)
    )
}

dbplot <- function(trainset, testset, filename)
{
    trainplotdf <- data.frame(
        x1 = trainset[, 1],
        x2 = trainset[, 2],
        y = trainset[, 3]
    )

    testplotdf <- data.frame(
        x1 = testset[, 1],
        x2 = testset[, 2],
        y = testset[, 3],
        prob = testset[, 4]
    )

    ggplot() + 
        geom_contour(data = testplotdf, aes(x = x1, y = x2, z = prob, color = as.factor(y)), bins = 1) + 
        geom_point(data = testplotdf, aes(x = x1, y = x2, color = as.factor(y)), size = 0.5) +
        geom_point(data = trainplotdf, aes(x=x1, y=x2, color = as.factor(y)), size = 2)

    ggsave(filename)
}