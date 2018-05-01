library(ggplot2)

source("./lib/bp_regress.R")

# Set working dir to this file's path.
script.dir = dirname(sys.frame(1)$ofile)

setwd(script.dir)

training_set = read.csv("../datasets/RegressionData.txt", header = FALSE, sep = " ")

ones_vec = rep(1, times = nrow(training_set));

# ones_vec[] = 1

x_mat = matrix(c(training_set$V1, ones_vec), ncol = 2)

y_t = as.numeric(training_set$V2)

transfer_fun <- tanh

weights = create_mlp_random(1, 1, c(3))

# Mock weights.
# weights = list()
# weights[[1]] = matrix(c(-0.3656297,-0.3661961,-0.17760791, 0.3747940,-0.4960355,-0.04454495), nrow = 2, byrow = TRUE)
# weights[[2]] = matrix(c(-0.4412941376,-0.3838144105,0.0008371437, -0.4455131863), ncol = 1)

# print(weights)

transfer_funs = list()

# transfer_funs[[3]] = c(function(x){return(x)})

# transfer_funs[[2]] = c(transfer_fun, transfer_fun, transfer_fun, transfer_fun)

transfer_funs[[2]] = c(function(x){return(x)})

transfer_funs[[1]] = c(transfer_fun, transfer_fun, transfer_fun)

t = 1

learning_rate = 0.5

err = c()

while(t <= 3000)
{
    layer_outputs = forward_propagation(x_mat, weights, transfer_funs)

    gradients = back_propagation_gradients_f1h(x_mat, y_t, layer_outputs, weights)

    err = c(err, 0.5 * sum((y_t - layer_outputs[[2]])**2))

    weights[[1]] = weights[[1]] - (learning_rate * gradients[[1]])
    weights[[2]] = weights[[2]] - (learning_rate * gradients[[2]])

    # print(gradients)
    t = t + 1
}

err.dframe = data.frame(
    iteration = c(1:3000),
    error_rate = err
)

ggplot(err.dframe, aes(x = iteration, y = error_rate)) + geom_point(color = "blue")

ggsave("./e3-2a.png")