library(ggplot2)

script.dir <- dirname(sys.frame(1)$ofile)

setwd(script.dir)

# Initialize sample.
x.true <- c(-1, 0.3, 2)
y.true <- c(-.1, .5, .5)

# Initialize constants.
x.mat <- matrix(c(c(1, 1, 1), x.true), nrow = 2, byrow = TRUE)
y.true.mat <- matrix(y.true, nrow = 1)
h.mat <- x.mat %*% t(x.mat)
b <- - x.mat %*% t(y.true.mat)

# Initial weights.
w.init <- matrix(c(-.45, 0.2), nrow = 2)

quadratic_error.gradient <- function(w.var)
{
    return (h.mat %*% w.var + b)
}

gradient_descent <- function(w0, gradient.fun, learn_rate = 0.1, iteration.max = 100)
{
    w.vec <- NULL
    w.val <- w0
    for(iter in c(1:iteration.max))
    {
        w.next <- w.val - learn_rate * gradient.fun(w.val)
        w.vec <- c(w.vec, w.val)
        w.val <- w.next
    }
    return (matrix(w.vec, ncol = length(w0), byrow = TRUE))
}

linear_search <- function(w0, gradient.fun, iteration.max = 100)
{
    w.vec <- NULL
    w.val <- w0
    for(iter in c(1:iteration.max))
    {
        grad <- gradient.fun(w.val)
        grad.t <- t(grad)
        step_size <- (grad.t %*% grad) / (grad.t %*% h.mat %*% grad)
        # When algo converged, step_size will become NaN.
        if(is.nan(step_size[1,1]))
        {
            step_size[1, 1] <- 0
        }
        w.next <- w.val - step_size[1, 1] * grad
        w.vec <- c(w.vec, w.val)
        w.val <- w.next
    }
    return (matrix(w.vec, ncol = length(w0), byrow = TRUE))
}

conjugate_gradient <- function(w0, gradient.fun, iteration.max = 100)
{
    
}

plot_weight <- function(weight.mat, filename.suffix, plot.title = "Plot")
{
    plot.df <- data.frame(weight.mat)
    for(idx in c(1:ncol(weight.mat)))
    {
        colnames(plot.df)[idx] <- paste("w", idx - 1, sep = "")
    }
    # print(head(plot.df))
    ggplot(data = plot.df, aes(x = w0, y = w1)) + geom_point() + ggtitle(paste(plot.title, "(w0 vs w1)"))
    ggsave(paste("./e4-2a_w0vsw1-", filename.suffix, ".png"))
    plot.df <- cbind(plot.df, data.frame(iter = c(1:nrow(weight.mat))))
    ggplot(data = plot.df) + geom_point(aes(x = iter, y = w0, color = "w0")) + geom_point(aes(x = iter, y = w1, color = "w1")) + xlab("Iteration") + ylab("Weight") + ggtitle(paste(plot.title, "(Weight vs Iteration)"))
    ggsave(paste("./e4-2a_wvsi-", filename.suffix, ".png"))
}

gd <- gradient_descent(w.init, quadratic_error.gradient)

plot_weight(gd, 'a', "Gradient Descent")

lin_srh <- linear_search(w.init, quadratic_error.gradient)

plot_weight(lin_srh, "b", "Linear Search")