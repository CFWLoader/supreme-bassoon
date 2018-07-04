library(ggplot2)

vecs <- data.frame(
    x1 = c(0, 1, 1),
    x2 = c(1, 0, 1),
    datatype = as.factor(c("Basis1", "Basis1", "Vector"))
)

projline <- data.frame(
    xs = c(0, 1),
    xe = c(1, 1),
    ys = c(1, 0),
    ye = c(1, 1)
)

ggplot() + geom_hline(yintercept = 0) + geom_vline(xintercept = 0) + xlim(-1, 2) + ylim(-1, 2) +
    geom_segment(data = vecs, aes(x = 0, y = 0, xend = x1, yend = x2, color = datatype), arrow = arrow()) +
    geom_segment(data = projline, aes(x = xs, xend = xe, y = ys, yend = ye), linetype = "dashed")

ggsave("tranmat1.png")

vecs2 <- rbind(vecs, data.frame(
    x1 = c(sqrt(3)/2, -1/2),
    x2 = c(1/2, sqrt(3)/2),
    datatype = as.factor(c("Basis2", "Basis2"))
))

ggplot() + geom_hline(yintercept = 0) + geom_vline(xintercept = 0) + xlim(-1, 2) + ylim(-1, 2) +
    geom_segment(data = vecs2, aes(x = 0, y = 0, xend = x1, yend = x2, color = datatype), arrow = arrow())
    # geom_segment(data = projline, aes(x = xs, xend = xe, y = ys, yend = ye), linetype = "dashed")

ggsave("tranmat2.png")

projline2 <- data.frame(
    xs = c(sqrt(3)/2, 1, 1),
    xe = c(sqrt(3), (3 + sqrt(3))/4, (1 - sqrt(3))/4),
    ys = c(1/2, 1, 1),
    ye = c(1, (1 + sqrt(3)) / 4, (3 - sqrt(3))/4)
)

ggplot() + geom_hline(yintercept = 0) + geom_vline(xintercept = 0) + xlim(-1, 2) + ylim(-1, 2) +
    geom_segment(data = vecs2[c(-1, -2),], aes(x = 0, y = 0, xend = x1, yend = x2, color = datatype), arrow = arrow()) +
    geom_segment(data = projline2, aes(x = xs, xend = xe, y = ys, yend = ye), linetype = "dashed")

ggsave("tranmat3.png")