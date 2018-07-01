library(ggplot2)

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

# plt.df <- data.frame(x1 = c(1, -1, 3.33), x2 = c(1, 0.5, 1.5))
plt.df <- data.frame(xs = c(0), ys = c(0), xe = c(1), ye= c(1), grp = as.factor("var"))
plt.df <- rbind(plt.df, data.frame(xs = c(0, 0), ys = c(0, 0), xe = c(1, 0), ye= c(0, 1), grp = as.factor("nvec1")))

ggplot(plt.df) + geom_segment(aes(x = xs, y = ys, xend = xe, yend = ye, color = grp), arrow = arrow()) +
    geom_hline(yintercept = 0, linetype="dashed") + geom_vline(xintercept = 0, linetype="dashed") + xlim(-0.5, 2) + ylim(-0.5, 2) + scale_color_manual(values = c("black", "blue"))

ggsave("./pltvec.png")