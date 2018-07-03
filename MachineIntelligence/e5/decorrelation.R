library(MASS)
library(ggplot2)

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)

cov.param <- matrix(c(1, 0.9, 0.9, 3), nrow = 2, byrow = TRUE)

xdata <- mvrnorm(1000, c(1.5, 4), cov.param)

xdata.df <- as.data.frame(xdata, col.names = c("x1", "x2"))
colnames(xdata.df) <- c("x1", "x2")

ggplot(xdata.df, aes(x = x1, y = x2)) + geom_point() + geom_hline(yintercept = 0) + geom_vline(xintercept = 0)
ggsave("decor1.png")

xcentered <- scale(xdata, scale = FALSE)

xcentered.df <- as.data.frame(xcentered, col.names = c("x1", "x2"))
colnames(xcentered.df) <- c("x1", "x2")

ggplot(xcentered.df, aes(x = x1, y = x2)) + geom_point() + geom_hline(yintercept = 0) + geom_vline(xintercept = 0)
ggsave("decor2.png")

# Calculate covariance and do eigen decomposition.
cov.mat <- cov(xcentered)
eigenpack <- eigen(cov.mat)
evalmat.sqrt.n <- diag(1/sqrt(eigenpack$values))
evecmat <- eigenpack$vectors

evecs.df <- as.data.frame(t(evecmat))
colnames(evecs.df) <- c("x1", "x2")
maxlim <- max(xcentered)

ggplot() + geom_point(data = xcentered.df, aes(x = x1, y = x2, color = "Data")) + 
    geom_segment(data = evecs.df, aes(x = 0, y = 0, xend = x1, yend = x2, color = "Eigenvector"), arrow = arrow()) +
    geom_hline(yintercept = 0) + geom_vline(xintercept = 0) + xlim(-maxlim, maxlim) + ylim(-maxlim, maxlim) + 
    scale_color_manual(values = c("grey", "red"))
ggsave("decor3.png")

# Project data into eigen space.
xproj <- xcentered %*% evecmat

xproj.df <- as.data.frame(xproj, col.names = c("x1", "x2"))
colnames(xproj.df) <- c("x1", "x2")
maxlim <- max(xproj)

ggplot(xproj.df, aes(x = x1, y = x2)) + geom_point() + geom_hline(yintercept = 0) + geom_vline(xintercept = 0) + xlim(-maxlim, maxlim) + ylim(-maxlim, maxlim)
ggsave("decor4.png")

# Scale projected points in each dimensions(Sphering).
xwhiten <- xproj %*% evalmat.sqrt.n

xwhiten.df <- as.data.frame(xwhiten, col.names = c("x1", "x2"))
colnames(xwhiten.df) <- c("x1", "x2")
maxlim <- max(xwhiten)

ggplot(xwhiten.df, aes(x = x1, y = x2)) + geom_point() + geom_hline(yintercept = 0) + geom_vline(xintercept = 0) + xlim(-maxlim, maxlim) + ylim(-maxlim, maxlim)
ggsave("decor5.png")