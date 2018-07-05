library(ggplot2)
library(latex2exp)

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

vec.expr <- "$a=(1, 1)$"
x0vec.expr <- "$x=(1, 0)$"
y0vec.expr <- "$y=(0, 1)$"

ggplot() + geom_hline(yintercept = 0) + geom_vline(xintercept = 0) + xlim(-1, 2) + ylim(-1, 2) +
    geom_segment(data = vecs, aes(x = 0, y = 0, xend = x1, yend = x2, color = datatype), arrow = arrow()) +
    geom_segment(data = projline, aes(x = xs, xend = xe, y = ys, yend = ye), linetype = "dashed") +
    annotate("text", x = 1.2, y = 1.1, label = TeX(vec.expr, output = "character"), parse = TRUE) + 
    annotate("text", x = 1.1, y = 0.1, label = TeX(x0vec.expr, output = "character"), parse = TRUE) +
    annotate("text", x = 0.2, y = 1.1, label = TeX(y0vec.expr, output = "character"), parse = TRUE)

ggsave("tranmat1.png")

vecs2 <- rbind(vecs, data.frame(
    x1 = c(sqrt(3)/2, -1/2),
    x2 = c(1/2, sqrt(3)/2),
    datatype = as.factor(c("Basis2", "Basis2"))
))

xvec.expr <- "$x'=(\\frac{\\sqrt{3}}{2}, \\frac{1}{2})$"
yvec.expr <- "$y'=(-\\frac{1}{2}, \\frac{\\sqrt{3}}{2})$"

ggplot() + geom_hline(yintercept = 0) + geom_vline(xintercept = 0) + xlim(-1, 2) + ylim(-1, 2) +
    geom_segment(data = vecs2, aes(x = 0, y = 0, xend = x1, yend = x2, color = datatype), arrow = arrow()) +
    annotate("text", x = 1.1, y = 1.1, label = TeX(vec.expr, output = "character"), parse = TRUE) + 
    annotate("text", x = 1.1, y = 0.1, label = TeX(x0vec.expr, output = "character"), parse = TRUE) +
    annotate("text", x = 0.2, y = 1.1, label = TeX(y0vec.expr, output = "character"), parse = TRUE) +
    annotate("text", x = 1.1, y = 0.5, label = TeX(xvec.expr, output = "character"), parse = TRUE) +
    annotate("text", x = -0.5, y = 1, label = TeX(yvec.expr, output = "character"), parse = TRUE)
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
    geom_segment(data = projline2, aes(x = xs, xend = xe, y = ys, yend = ye), linetype = "dashed") +
    annotate("text", x = 1.1, y = 1.1, label = TeX(vec.expr, output = "character"), parse = TRUE) + 
    annotate("text", x = 1.1, y = 0.5, label = TeX(xvec.expr, output = "character"), parse = TRUE) +
    annotate("text", x = -0.5, y = 1, label = TeX(yvec.expr, output = "character"), parse = TRUE)

ggsave("tranmat3.png")



ggplot() + xlim(-1, 2) + ylim(-1, 2) +
    geom_segment(data = vecs2[c(-1, -2),], aes(x = 0, y = 0, xend = x1, yend = x2, color = datatype), arrow = arrow()) +
    geom_segment(data = projline2, aes(x = xs, xend = xe, y = ys, yend = ye), linetype = "dashed") +
    annotate("text", x = 1.1, y = 1.1, label = TeX(vec.expr, output = "character"), parse = TRUE) + 
    annotate("text", x = 1.1, y = 0.5, label = TeX(xvec.expr, output = "character"), parse = TRUE) +
    annotate("text", x = -0.5, y = 1, label = TeX(yvec.expr, output = "character"), parse = TRUE)

ggsave("tranmat4.png")

vecs3 <- rbind(data.frame(
    x1 = c(1, 0, (1 + sqrt(3)) / 2),
    x2 = c(0, 1, (sqrt(3) - 1) / 2),
    datatype = as.factor(c("Basis2", "Basis2", "Vector"))
))

projline3 <- data.frame(
    xs = c((1 + sqrt(3)) / 2, 0),
    xe = c((1 + sqrt(3)) / 2, (1 + sqrt(3)) / 2),
    ys = c(0, (sqrt(3) - 1) / 2),
    ye = c((sqrt(3) - 1) / 2, (sqrt(3) - 1) / 2)
)

vec.expr <- "$a=(\\frac{1-\\sqrt{3}}{2}, \\frac{\\sqrt{3} - 1}{2})$"
xvec.expr <- "x=(1, 0)"
yvec.expr <- "y=(0, 1)"

ggplot() + geom_hline(yintercept = 0) + geom_vline(xintercept = 0) + xlim(-1, 2) + ylim(-1, 2) +
    geom_segment(data = vecs3, aes(x = 0, y = 0, xend = x1, yend = x2, color = datatype), arrow = arrow()) +
    geom_segment(data = projline3, aes(x = xs, xend = xe, y = ys, yend = ye), linetype = "dashed") +
    annotate("text", x = (1 + sqrt(3)) / 2, y = (sqrt(3) - 1) / 2 + 0.2, label = TeX(vec.expr, output = "character"), parse = TRUE) + 
    annotate("text", x = 1.1, y = -0.1, label = xvec.expr) +
    annotate("text", x = 0.1, y = 1.1, label = yvec.expr)

ggsave("tranmat5.png")