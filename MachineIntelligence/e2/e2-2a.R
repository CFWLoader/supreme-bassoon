library(ggplot2)
library(reshape2)

# Set working dir to this file's path.
script.dir = dirname(sys.frame(1)$ofile)

setwd(script.dir)

mlp = function(x, w, a, b, activation = tanh)
{
    # Assume x, w, a, b all are vector, not matrix.
    result = vector(length = length(x))

    result[] = 0

    for(idx in c(1:length(x)))
    {
        for(f_idx in c(1:length(w)))
        {
            result[idx] = result[idx] + w[f_idx] * activation(a[f_idx] * (x[idx] - b[f_idx]))
        }
    }

    return(result)
}

# Input.
input_x = seq(-2, 2, 0.05)

dataset = NULL

tag_vec = vector(length = length(input_x))

for(mlp_count in c(1:50))
{
    w = rnorm(10)

    a = rnorm(10, 0, 2)

    b = runif(10, -2, 2)

    tag_vec[] = mlp_count

    y_out = mlp(input_x, w, a, b)

    dataset = rbind(dataset, data.frame(x = input_x, y = y_out, group_id = tag_vec))

}

ggplot(dataset, aes(x = x, y = y, group = group_id)) + geom_line()

ggsave("./e2-2a.png")

# question b.
dataset = NULL

tag_vec = vector(length = length(input_x))

for(mlp_count in c(1:50))
{
    w = rnorm(10)

    a = rnorm(10, 0, 0.5)

    b = runif(10, -2, 2)

    tag_vec[] = mlp_count

    y_out = mlp(input_x, w, a, b)

    dataset = rbind(dataset, data.frame(x = input_x, y = y_out, group_id = tag_vec))
}

ggplot(dataset, aes(x = x, y = y, group = group_id)) + geom_line()

ggsave("./e2-2b.png")